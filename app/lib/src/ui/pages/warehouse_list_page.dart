import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/warehouse_model.dart';
import '../../data/repositories/warehouse_repository.dart';
import '../../i18n/app_localizations.dart';
import '../../providers/database_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/warehouse_providers.dart';
import '../../utils.dart';

class WarehouseListPage extends ConsumerStatefulWidget {
  const WarehouseListPage({super.key});

  @override
  ConsumerState<WarehouseListPage> createState() => _WarehouseListPageState();
}

class _WarehouseListPageState extends ConsumerState<WarehouseListPage> {
  bool _manage = false;
  final _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final warehousesAsync = ref.watch(warehouseListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.warehouseList),
        actions: [
          IconButton(
            icon: Icon(_manage ? Icons.check : Icons.edit),
            tooltip: _manage ? l.done : l.manage,
            onPressed: () => setState(() {
              _manage = !_manage;
              _selected.clear();
            }),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: warehousesAsync.when(
        data: (warehouses) => _buildList(context, l, warehouses),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.loadFailed)),
      ),
      floatingActionButton: _manage
          ? null
          : GestureDetector(
              onTap: () => _createWarehouse(context, l),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.35),
                      offset: const Offset(-5, -5),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(5, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
      bottomNavigationBar: _manage && _selected.isNotEmpty
          ? _buildDeleteBar(context, l)
          : null,
    );
  }

  Widget _buildDeleteBar(BuildContext context, AppLocalizations l) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: FilledButton.icon(
          onPressed: () => _deleteSelected(context, l),
          icon: const Icon(Icons.delete),
          label: Text(l.deleteSelected(_selected.length)),
        ),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, AppLocalizations l, List<WarehouseModel> warehouses) {
    if (warehouses.isEmpty) {
      return Center(child: Text(l.warehouseEmptyHint));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: warehouses.length,
      itemBuilder: (context, index) {
        final w = warehouses[index];
        return _WarehouseTile(
          warehouse: w,
          manage: _manage,
          selected: _selected.contains(w.id),
          onSelect: () => _toggleSelect(w.id),
          onOpen: () => _openWarehouse(context, ref, w.id),
          onDismiss: () => _deleteWarehouse(context, l, w.id),
        );
      },
    );
  }

  void _toggleSelect(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  Future<void> _openWarehouse(
      BuildContext context, WidgetRef ref, String id) async {
    final settings = await ref.read(settingsProvider.future);
    await settings.setCurrentWarehouse(id);
    if (context.mounted) {
      context.go('/kanban?warehouseId=$id');
    }
  }

  Future<void> _deleteSelected(
      BuildContext context, AppLocalizations l) async {
    final db = await ref.read(databaseProvider.future);
    final repo = WarehouseRepository(db);
    final ids = _selected.toList();
    final count = ids.length;
    for (final id in ids) {
      await repo.deleteOrArchive(id);
    }
    setState(() => _selected.clear());
    ref.invalidate(warehouseListProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.warehousesDeleted(count))),
      );
    }
  }

  Future<void> _deleteWarehouse(
      BuildContext context, AppLocalizations l, String id) async {
    final db = await ref.read(databaseProvider.future);
    await WarehouseRepository(db).deleteOrArchive(id);
    ref.invalidate(warehouseListProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.warehouseDeleted)),
      );
    }
  }

  Future<void> _createWarehouse(BuildContext context, AppLocalizations l) async {
    final name = await _inputDialog(context, l.addWarehouse, l.warehouseName);
    if (name == null || name.isEmpty || !context.mounted) return;
    final db = await ref.read(databaseProvider.future);
    final warehouse = WarehouseModel(
      id: generateId(),
      name: name.trim(),
    );
    await WarehouseRepository(db).insert(warehouse);
    ref.invalidate(warehouseListProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.warehouseAdded)),
      );
    }
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
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          ),
        ],
      ),
    );
  }
}

class _WarehouseTile extends StatefulWidget {
  final WarehouseModel warehouse;
  final bool manage;
  final bool selected;
  final VoidCallback onSelect;
  final VoidCallback onOpen;
  final VoidCallback onDismiss;

  const _WarehouseTile({
    required this.warehouse,
    required this.manage,
    required this.selected,
    required this.onSelect,
    required this.onOpen,
    required this.onDismiss,
  });

  @override
  State<_WarehouseTile> createState() => _WarehouseTileState();
}

class _WarehouseTileState extends State<_WarehouseTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 220),
      vsync: this,
    );
    _animation = Tween<double>(begin: -0.035, end: 0.035).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.manage) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant _WarehouseTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.manage && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.manage && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tile = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.manage ? _animation.value : 0,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.manage ? widget.onSelect : widget.onOpen,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer
                .withOpacity(widget.selected ? 0.9 : 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.selected
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.2),
              width: widget.selected ? 2.5 : 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white.withOpacity(0.6),
                offset: const Offset(-4, -4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(4, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: [
              if (widget.manage)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    widget.selected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: widget.selected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.warehouse,
                    color: colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.warehouse.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '更新于: ${formatDateTime(widget.warehouse.updatedAt)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (widget.manage)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: widget.onDismiss,
                ),
            ],
          ),
        ),
      ),
    );

    if (widget.manage) return tile;
    return Dismissible(
      key: ValueKey(widget.warehouse.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDismiss(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: tile,
    );
  }
}
