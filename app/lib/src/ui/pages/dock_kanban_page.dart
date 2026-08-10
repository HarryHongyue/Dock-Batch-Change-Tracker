import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/dock_repository.dart';
import '../../i18n/app_localizations.dart';
import '../../providers/batch_providers.dart';
import '../../providers/database_provider.dart';
import '../../providers/dock_providers.dart';
import '../../utils.dart';
import '../widgets/dock_card.dart';
import '../widgets/top_message.dart';
// ignore_for_file: use_build_context_synchronously

import 'quick_actions_sheet.dart';

class DockKanbanPage extends ConsumerStatefulWidget {
  final String warehouseId;

  const DockKanbanPage({super.key, required this.warehouseId});

  @override
  ConsumerState<DockKanbanPage> createState() => _DockKanbanPageState();
}

class _DockKanbanPageState extends ConsumerState<DockKanbanPage>
    with TickerProviderStateMixin {
  bool _grid = false;
  bool _compact = false;
  bool _managing = false;
  final Set<String> _selected = {};
  late final AnimationController _wiggle;

  @override
  void initState() {
    super.initState();
    _wiggle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _wiggle.dispose();
    super.dispose();
  }

  void _setManaging(bool value) {
    setState(() {
      _managing = value;
      if (_managing) {
        _wiggle.repeat(reverse: true);
      } else {
        _wiggle.stop();
        _wiggle.reset();
        _selected.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final docksAsync = ref.watch(dockListProvider(widget.warehouseId));
    final batchesAsync = ref.watch(batchListProvider(widget.warehouseId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.dockKanban),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(_managing ? Icons.done : Icons.edit),
            onPressed: () => _setManaging(!_managing),
          ),
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
      floatingActionButton: _managing
          ? null
          : FloatingActionButton.small(
              onPressed: () => _showAddMenu(context, l),
              child: const Icon(Icons.add),
            ),
      bottomNavigationBar: _managing
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: _selected.isEmpty ? null : _deleteSelected,
                  icon: const Icon(Icons.delete),
                  label: Text(l.deleteSelectedDocks),
                ),
              ),
            )
          : null,
      body: docksAsync.when(
        data: (docks) => batchesAsync.when(
          data: (batches) => _buildBody(context, l, docks, batches),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(l.loadFailed)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.loadFailed)),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l,
    List<DockModel> docks,
    List<BatchModel> batches,
  ) {
    final batchMap = {for (final b in batches) b.id: b};

    if (_grid && docks.length <= 8) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: docks.length,
        itemBuilder: (context, index) {
          final dock = docks[index];
          return _buildCard(context, l, dock, batchMap[dock.currentBatchId]);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: docks.length,
      itemBuilder: (context, index) {
        final dock = docks[index];
        return _buildCard(context, l, dock, batchMap[dock.currentBatchId]);
      },
    );
  }

  Widget _buildCard(
    BuildContext context,
    AppLocalizations l,
    DockModel dock,
    BatchModel? batch,
  ) {
    final card = DockCard(
      dock: dock,
      batch: batch,
      compact: _compact,
      isGrid: _grid,
      isSelected: _selected.contains(dock.id),
      onTap: _managing
          ? () => _toggleSelection(dock.id)
          : () => _onDockTap(dock, batch),
      onLongPress: _managing ? null : () => _onDockTap(dock, batch),
    );

    final wiggled = AnimatedBuilder(
      animation: _wiggle,
      builder: (context, child) {
        return Transform.rotate(
          angle: _managing ? _wiggle.value * 0.07 - 0.035 : 0.0,
          child: child,
        );
      },
      child: card,
    );

    if (!_managing) return wiggled;

    return Dismissible(
      key: ValueKey(dock.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _deleteOne(dock),
      background: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '删除',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      child: wiggled,
    );
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
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

  Future<void> _deleteOne(DockModel dock) async {
    final db = await ref.read(databaseProvider.future);
    await DockRepository(db).deleteOrArchive(dock.id);
    ref.invalidate(dockListProvider(widget.warehouseId));
    if (mounted) {
      TopMessage.show(context, '${dock.name} ${AppLocalizations.of(context).delete}');
    }
  }

  Future<void> _deleteSelected() async {
    final db = await ref.read(databaseProvider.future);
    for (final id in _selected) {
      await DockRepository(db).deleteOrArchive(id);
    }
    _selected.clear();
    _setManaging(false);
    ref.invalidate(dockListProvider(widget.warehouseId));
    if (mounted) {
      TopMessage.show(context, AppLocalizations.of(context).success);
    }
  }

  void _showAddMenu(BuildContext context, AppLocalizations l) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(l.addOneDock),
              onTap: () {
                Navigator.pop(context);
                _showAddOneDialog(context, l);
              },
            ),
            ListTile(
              leading: const Icon(Icons.queue),
              title: Text(l.addManyDocks),
              onTap: () {
                Navigator.pop(context);
                _showAddManyDialog(context, l);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddOneDialog(BuildContext context, AppLocalizations l) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.addOneDock),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: l.dockName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l.confirm),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty || !mounted) return;
    await _createDocks([name]);
  }

  Future<void> _showAddManyDialog(BuildContext context, AppLocalizations l) async {
    final controller = TextEditingController();
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.addManyDocks),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: l.inputDockCount),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l.confirm),
          ),
        ],
      ),
    );
    if (value == null || value.isEmpty || !mounted) return;
    final count = int.tryParse(value);
    if (count == null) {
      TopMessage.show(context, l.pleaseInputNumber, error: true);
      return;
    }
    if (count < 0) {
      TopMessage.show(context, l.countCannotBeNegative, error: true);
      return;
    }
    final db = await ref.read(databaseProvider.future);
    final existing = await DockRepository(db).getByWarehouseId(widget.warehouseId);
    final base = existing.length;
    final names = List.generate(count, (i) => '${base + i + 1}号道口');
    await _createDocks(names);
  }

  Future<void> _createDocks(List<String> names) async {
    final db = await ref.read(databaseProvider.future);
    final existing = await DockRepository(db).getByWarehouseId(widget.warehouseId);
    var order = existing.length;
    for (final name in names) {
      final dock = DockModel(
        id: generateId(),
        warehouseId: widget.warehouseId,
        name: name,
        displayOrder: order,
        currentStatus: DockStatus.empty,
      );
      await DockRepository(db).insert(dock);
      order = order + 1;
    }
    ref.invalidate(dockListProvider(widget.warehouseId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).success)),
      );
    }
  }
}
