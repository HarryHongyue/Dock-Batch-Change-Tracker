import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../providers/batch_providers.dart';
import '../../providers/dock_providers.dart';
import '../../providers/session_providers.dart';
import '../widgets/dock_card.dart';
import 'quick_actions_sheet.dart';

class DockKanbanPage extends ConsumerStatefulWidget {
  final String warehouseId;

  const DockKanbanPage({super.key, required this.warehouseId});

  @override
  ConsumerState<DockKanbanPage> createState() => _DockKanbanPageState();
}

class _DockKanbanPageState extends ConsumerState<DockKanbanPage> {
  bool _grid = false;
  bool _compact = false;

  @override
  Widget build(BuildContext context) {
    final docksAsync = ref.watch(dockListProvider(widget.warehouseId));
    final batchesAsync = ref.watch(batchListProvider(widget.warehouseId));
    final activeSessionAsync =
        ref.watch(activeSessionProvider(widget.warehouseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('道口看板'),
        actions: [
          IconButton(
            icon: Icon(_grid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _grid = !_grid),
          ),
          IconButton(
            icon: Icon(_compact ? Icons.expand : Icons.compress),
            onPressed: () => setState(() => _compact = !_compact),
          ),
          IconButton(
            icon: const Icon(Icons.timeline),
            onPressed: () => context.push('/timeline'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: docksAsync.when(
        data: (docks) => batchesAsync.when(
          data: (batches) => _buildBody(context, docks, batches),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('批次加载失败: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('道口加载失败: $e')),
      ),
      floatingActionButton: activeSessionAsync.when(
        data: (session) => FloatingActionButton.small(
          heroTag: 'change_fab',
          tooltip: session == null ? '开始变更' : '继续变更',
          onPressed: () => context.push(
              '/change?warehouseId=${widget.warehouseId}'),
          child: Icon(session == null ? Icons.edit_note : Icons.edit),
        ),
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, List<DockModel> docks, List<BatchModel> batches) {
    final batchMap = {for (final b in batches) b.id: b};

    if (_grid && docks.length <= 8) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: docks.length,
        itemBuilder: (context, index) {
          final dock = docks[index];
          return DockCard(
            dock: dock,
            batch: dock.currentBatchId != null
                ? batchMap[dock.currentBatchId]
                : null,
            compact: _compact,
            isGrid: true,
            onTap: () => _onDockTap(dock, batchMap[dock.currentBatchId]),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: docks.length,
      itemBuilder: (context, index) {
        final dock = docks[index];
        return DockCard(
          dock: dock,
          batch: dock.currentBatchId != null
              ? batchMap[dock.currentBatchId]
              : null,
          compact: _compact,
          onTap: () => _onDockTap(dock, batchMap[dock.currentBatchId]),
        );
      },
    );
  }

  void _onDockTap(DockModel dock, BatchModel? batch) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => QuickActionsSheet(
        warehouseId: widget.warehouseId,
        dock: dock,
        batch: batch,
      ),
    );
  }
}
