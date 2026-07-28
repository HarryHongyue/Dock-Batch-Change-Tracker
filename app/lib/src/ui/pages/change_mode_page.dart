import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/change_event_model.dart';
import '../../data/models/change_session_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/services/dock_operation_service.dart';
import '../../providers/batch_providers.dart';
import '../../providers/database_provider.dart';
import '../../providers/dock_providers.dart';
import '../../providers/session_providers.dart';
import '../../utils.dart';

class ChangeModePage extends ConsumerStatefulWidget {
  final String warehouseId;

  const ChangeModePage({super.key, required this.warehouseId});

  @override
  ConsumerState<ChangeModePage> createState() => _ChangeModePageState();
}

class _ChangeModePageState extends ConsumerState<ChangeModePage> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(activeSessionProvider(widget.warehouseId));
    final docksAsync = ref.watch(dockListProvider(widget.warehouseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('变更模式'),
        actions: [
          if (sessionAsync.valueOrNull != null)
            TextButton(
              onPressed: _busy ? null : () => _cancel(context),
              child: const Text('取消', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: sessionAsync.when(
        data: (session) => docksAsync.when(
          data: (docks) => _buildBody(context, session, docks),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('道口加载失败: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('会话加载失败: $e')),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, ChangeSessionModel? session, List<DockModel> docks) {
    if (session == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('当前没有进行中的变更'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _busy ? null : () => _start(context),
              child: const Text('开始变更'),
            ),
          ],
        ),
      );
    }

    final eventsAsync = ref.watch(sessionEventsProvider(session.id));

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.edit_note),
          title: Text(session.title ?? '变更会话'),
          subtitle: Text('开始于 ${formatDateTime(session.startedAt)}'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ActionButton(
                label: '移动批次',
                onPressed: _busy ? null : () => _move(context, docks, session.id),
              ),
              _ActionButton(
                label: '交换批次',
                onPressed: _busy ? null : () => _swap(context, docks, session.id),
              ),
              _ActionButton(
                label: '新增批次',
                onPressed: _busy ? null : () => _create(context, docks, session.id),
              ),
              _ActionButton(
                label: '完成批次',
                onPressed: _busy ? null : () => _complete(context, docks, session.id),
              ),
              _ActionButton(
                label: '暂停道口',
                onPressed: _busy ? null : () => _pause(context, docks, session.id),
              ),
              _ActionButton(
                label: '恢复道口',
                onPressed: _busy ? null : () => _resume(context, docks, session.id),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _busy ? null : () => _undo(context, session.id),
              icon: const Icon(Icons.undo),
              label: const Text('撤销'),
            ),
            FilledButton.icon(
              onPressed: _busy ? null : () => _commit(context, session.id),
              icon: const Icon(Icons.check),
              label: const Text('完成并保存'),
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: eventsAsync.when(
            data: (events) => _buildEventList(events),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('事件加载失败: $e')),
          ),
        ),
      ],
    );
  }

  Widget _buildEventList(List<ChangeEventModel> events) {
    if (events.isEmpty) {
      return const Center(child: Text('尚未添加操作'));
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final e = events[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${e.eventOrder}')),
          title: Text(e.eventType.name),
          subtitle: Text(
              '批: ${e.batchId ?? '-'} 源: ${e.sourceDockId ?? '-'} 目标: ${e.targetDockId ?? '-'}'),
          trailing: Text(formatTime(e.eventTime)),
        );
      },
    );
  }

  Future<DockOperationService> _ops() async {
    final db = await ref.read(databaseProvider.future);
    return DockOperationService(db);
  }

  Future<void> _start(BuildContext context) async {
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.startChangeSession(
        warehouseId: widget.warehouseId,
        title: '道口重新分配',
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _move(
      BuildContext context, List<DockModel> docks, String sessionId) async {
    final source = await _selectDock(context, docks, '选择源道口');
    if (source == null || !context.mounted) return;
    final target = await _selectDock(context,
        docks.where((d) => d.id != source.id).toList(), '选择目标道口');
    if (target == null || !context.mounted) return;
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.moveBatch(
        sessionId: sessionId,
        warehouseId: widget.warehouseId,
        sourceDockId: source.id,
        targetDockId: target.id,
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _swap(
      BuildContext context, List<DockModel> docks, String sessionId) async {
    final source = await _selectDock(context, docks, '选择源道口');
    if (source == null || !context.mounted) return;
    final target = await _selectDock(context,
        docks.where((d) => d.id != source.id).toList(), '选择目标道口');
    if (target == null || !context.mounted) return;
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.swapBatches(
        sessionId: sessionId,
        warehouseId: widget.warehouseId,
        sourceDockId: source.id,
        targetDockId: target.id,
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _create(
      BuildContext context, List<DockModel> docks, String sessionId) async {
    final target = await _selectDock(context, docks, '选择目标道口');
    if (target == null || !context.mounted) return;
    final code = await _inputDialog(context, '新增批次', '批次编号');
    if (code == null || code.isEmpty || !context.mounted) return;
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.createAndAssignBatch(
        sessionId: sessionId,
        warehouseId: widget.warehouseId,
        targetDockId: target.id,
        batchCode: code,
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _complete(
      BuildContext context, List<DockModel> docks, String sessionId) async {
    final source = await _selectDock(context, docks, '选择要完成的批次所在道口');
    if (source == null || source.currentBatchId == null || !context.mounted) return;
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.completeBatch(
        sessionId: sessionId,
        warehouseId: widget.warehouseId,
        batchId: source.currentBatchId!,
        dockId: source.id,
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pause(
      BuildContext context, List<DockModel> docks, String sessionId) async {
    final target = await _selectDock(context, docks, '选择要暂停的道口');
    if (target == null || !context.mounted) return;
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.pauseDock(
        sessionId: sessionId,
        warehouseId: widget.warehouseId,
        dockId: target.id,
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resume(
      BuildContext context, List<DockModel> docks, String sessionId) async {
    final target = await _selectDock(context, docks, '选择要恢复的道口');
    if (target == null || !context.mounted) return;
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.resumeDock(
        sessionId: sessionId,
        warehouseId: widget.warehouseId,
        dockId: target.id,
      );
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _undo(BuildContext context, String sessionId) async {
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.undoLastEvent(sessionId: sessionId);
      _refresh();
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _commit(BuildContext context, String sessionId) async {
    setState(() => _busy = true);
    try {
      final ops = await _ops();
      await ops.commitSession(sessionId: sessionId);
      _refresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('变更已保存')),
        );
        context.pop();
      }
    } finally {
      if (context.mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancel(BuildContext context) async {
    final session = ref.read(activeSessionProvider(widget.warehouseId)).valueOrNull;
    if (session == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('取消变更'),
        content: const Text('未保存的操作将被撤销，确定取消？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('否'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('是'),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      setState(() => _busy = true);
      try {
        final ops = await _ops();
        await ops.cancelSession(sessionId: session.id);
        _refresh();
        if (context.mounted) context.pop();
      } finally {
        if (context.mounted) setState(() => _busy = false);
      }
    }
  }

  void _refresh() {
    ref.invalidate(activeSessionProvider(widget.warehouseId));
    ref.invalidate(sessionEventsProvider(
        ref.read(activeSessionProvider(widget.warehouseId)).valueOrNull?.id ??
            ''));
    ref.invalidate(dockListProvider(widget.warehouseId));
    ref.invalidate(batchListProvider(widget.warehouseId));
  }

  Future<DockModel?> _selectDock(
      BuildContext context, List<DockModel> docks, String title) {
    return showDialog<DockModel>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(title),
        children: docks
            .map((d) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, d),
                  child: Text(d.name),
                ))
            .toList(),
      ),
    );
  }

  Future<String?> _inputDialog(
      BuildContext context, String title, String label) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ActionButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
