import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/services/dock_operation_service.dart';
import '../../providers/batch_providers.dart';
import '../../providers/database_provider.dart';
import '../../providers/dock_providers.dart';
import '../../providers/session_providers.dart';

class QuickActionsSheet extends ConsumerWidget {
  final String warehouseId;
  final DockModel dock;
  final BatchModel? batch;

  const QuickActionsSheet({
    super.key,
    required this.warehouseId,
    required this.dock,
    this.batch,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSessionAsync = ref.watch(activeSessionProvider(warehouseId));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dock.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (batch != null)
              Text('当前批次: ${batch!.batchCode}')
            else
              const Text('当前无批次'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ActionChip(
                  icon: Icons.move_up,
                  label: '移动',
                  onTap: () => _move(context, ref),
                ),
                _ActionChip(
                  icon: Icons.swap_horiz,
                  label: '交换',
                  onTap: () => _swap(context, ref),
                ),
                _ActionChip(
                  icon: Icons.add,
                  label: '新增批次',
                  onTap: () => _createBatch(context, ref),
                ),
                _ActionChip(
                  icon: Icons.check,
                  label: '完成',
                  onTap: () => _complete(context, ref),
                ),
                _ActionChip(
                  icon: Icons.pause,
                  label: '暂停道口',
                  onTap: () => _pause(context, ref),
                ),
                _ActionChip(
                  icon: Icons.play_arrow,
                  label: '恢复道口',
                  onTap: () => _resume(context, ref),
                ),
                _ActionChip(
                  icon: Icons.history,
                  label: '历史',
                  onTap: () {
                    context.pop();
                    context.push('/dock/${dock.id}');
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (activeSessionAsync.valueOrNull != null)
              ListTile(
                leading: const Icon(Icons.edit_note),
                title: const Text('进入变更模式'),
                onTap: () {
                  context.pop();
                  context.push('/change?warehouseId=$warehouseId');
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _withSession(BuildContext context, WidgetRef ref,
      Future<void> Function(DockOperationService, String) action) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final ops = DockOperationService(db);
      var sessionId = ref.read(activeSessionProvider(warehouseId)).valueOrNull?.id;
      sessionId ??= (await ops.startChangeSession(
        warehouseId: warehouseId,
        title: '快速操作',
      )).id;
      await action(ops, sessionId);
      await ops.commitSession(sessionId: sessionId);
      if (context.mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('操作已保存')),
        );
        ref.invalidate(dockListProvider(warehouseId));
        ref.invalidate(batchListProvider(warehouseId));
        ref.invalidate(activeSessionProvider(warehouseId));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败: $e')),
        );
      }
    }
  }

  Future<void> _move(BuildContext context, WidgetRef ref) async {
    final target = await _selectDock(context, ref, exclude: dock.id);
    if (target == null || !context.mounted) return;
    await _withSession(context, ref, (ops, sessionId) async {
      await ops.moveBatch(
        sessionId: sessionId,
        warehouseId: warehouseId,
        sourceDockId: dock.id,
        targetDockId: target.id,
      );
    });
  }

  Future<void> _swap(BuildContext context, WidgetRef ref) async {
    final target = await _selectDock(context, ref, exclude: dock.id);
    if (target == null || !context.mounted) return;
    await _withSession(context, ref, (ops, sessionId) async {
      await ops.swapBatches(
        sessionId: sessionId,
        warehouseId: warehouseId,
        sourceDockId: dock.id,
        targetDockId: target.id,
      );
    });
  }

  Future<void> _createBatch(BuildContext context, WidgetRef ref) async {
    final code = await _inputDialog(context, '新增批次', '批次编号');
    if (code == null || code.isEmpty || !context.mounted) return;
    await _withSession(context, ref, (ops, sessionId) async {
      await ops.createAndAssignBatch(
        sessionId: sessionId,
        warehouseId: warehouseId,
        targetDockId: dock.id,
        batchCode: code,
      );
    });
  }

  Future<void> _complete(BuildContext context, WidgetRef ref) async {
    if (batch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('当前道口没有批次')),
      );
      return;
    }
    await _withSession(context, ref, (ops, sessionId) async {
      await ops.completeBatch(
        sessionId: sessionId,
        warehouseId: warehouseId,
        batchId: batch!.id,
        dockId: dock.id,
      );
    });
  }

  Future<void> _pause(BuildContext context, WidgetRef ref) async {
    await _withSession(context, ref, (ops, sessionId) async {
      await ops.pauseDock(
        sessionId: sessionId,
        warehouseId: warehouseId,
        dockId: dock.id,
      );
    });
  }

  Future<void> _resume(BuildContext context, WidgetRef ref) async {
    await _withSession(context, ref, (ops, sessionId) async {
      await ops.resumeDock(
        sessionId: sessionId,
        warehouseId: warehouseId,
        dockId: dock.id,
      );
    });
  }

  Future<DockModel?> _selectDock(
      BuildContext context, WidgetRef ref, {required String exclude}) async {
    final docks = await ref.read(dockListProvider(warehouseId).future);
    final choices = docks.where((d) => d.id != exclude).toList();
    if (!context.mounted) return null;
    return showDialog<DockModel>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('选择目标道口'),
        children: choices
            .map((d) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, d),
                  child: Text('${d.name} (${d.currentBatchId != null ? '有批次' : '空闲'})'),
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

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
