import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/dock_repository.dart';
import '../../data/services/dock_operation_service.dart';
import '../../i18n/app_localizations.dart';
import '../../providers/batch_providers.dart';
import '../../providers/database_provider.dart';
import '../../providers/dock_providers.dart';
import '../widgets/top_message.dart';

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
    final l = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    dock.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: l.dockRenamed,
                  onPressed: () => _renameDock(context, ref),
                ),
              ],
            ),
            if (batch != null)
              Text('${l.currentBatch}: ${batch!.batchCode}')
            else
              Text(l.noBatch),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ActionChip(
                  icon: Icons.move_up,
                  label: l.move,
                  onTap: () => _move(context, ref, l),
                ),
                _ActionChip(
                  icon: Icons.edit,
                  label: l.modifyBatch,
                  onTap: () => _modifyBatch(context, ref, l),
                ),
                _ActionChip(
                  icon: Icons.pause,
                  label: l.pause,
                  onTap: () => _pause(context, ref, l),
                ),
                _ActionChip(
                  icon: Icons.play_arrow,
                  label: l.resume,
                  onTap: () => _resume(context, ref, l),
                ),
                _ActionChip(
                  icon: Icons.history,
                  label: l.history,
                  onTap: () {
                    context.pop();
                    context.push('/dock/${dock.id}');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _move(BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final target = await _selectDock(context, ref, exclude: dock.id);
    if (target == null || !context.mounted) return;
    try {
      final db = await ref.read(databaseProvider.future);
      final ops = DockOperationService(db);
      await ops.moveBatchDirect(
        warehouseId: warehouseId,
        sourceDockId: dock.id,
        targetDockId: target.id,
      );
      if (!context.mounted) return;
      TopMessage.show(context, l.moveSuccess);
      context.pop();
      ref.invalidate(dockListProvider(warehouseId));
      ref.invalidate(batchListProvider(warehouseId));
    } catch (e) {
      if (context.mounted) {
        TopMessage.show(context, '${l.moveFailed}: $e', error: true);
      }
    }
  }

  Future<void> _modifyBatch(BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final code = await _inputDialog(context, l.modifyBatch, l.batchCode);
    if (code == null || code.isEmpty || !context.mounted) return;
    try {
      final db = await ref.read(databaseProvider.future);
      final ops = DockOperationService(db);
      final newBatch = await ops.modifyBatchDirect(
        warehouseId: warehouseId,
        dockId: dock.id,
        batchCode: code,
      );
      if (!context.mounted) return;
      TopMessage.show(
        context,
        '${l.modifySuccess} ${newBatch.batchCode}',
      );
      context.pop();
      ref.invalidate(dockListProvider(warehouseId));
      ref.invalidate(batchListProvider(warehouseId));
    } catch (e) {
      if (context.mounted) {
        TopMessage.show(context, '${l.modifyFailed}: $e', error: true);
      }
    }
  }

  Future<void> _pause(BuildContext context, WidgetRef ref, AppLocalizations l) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final ops = DockOperationService(db);
      await ops.changeDockStatusDirect(
        warehouseId: warehouseId,
        dockId: dock.id,
        newStatus: DockStatus.paused,
      );
      if (!context.mounted) return;
      TopMessage.show(context, l.dockPausedSnackbar);
      context.pop();
      ref.invalidate(dockListProvider(warehouseId));
    } catch (e) {
      if (context.mounted) {
        TopMessage.show(context, '${l.pauseFailed}: $e', error: true);
      }
    }
  }

  Future<void> _resume(BuildContext context, WidgetRef ref, AppLocalizations l) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final ops = DockOperationService(db);
      await ops.changeDockStatusDirect(
        warehouseId: warehouseId,
        dockId: dock.id,
        newStatus: DockStatus.active,
      );
      if (!context.mounted) return;
      TopMessage.show(context, l.dockResumedSnackbar);
      context.pop();
      ref.invalidate(dockListProvider(warehouseId));
    } catch (e) {
      if (context.mounted) {
        TopMessage.show(context, '${l.resumeFailed}: $e', error: true);
      }
    }
  }

  Future<void> _renameDock(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final name = await _inputDialog(context, l.dockRenamed, l.dockName);
    if (name == null || name.isEmpty || !context.mounted) return;
    try {
      final db = await ref.read(databaseProvider.future);
      await DockRepository(db).update(
        dock.copyWith(name: name.trim(), updatedAt: DateTime.now()),
      );
      if (!context.mounted) return;
      TopMessage.show(context, l.dockRenamed);
      context.pop();
      ref.invalidate(dockListProvider(warehouseId));
    } catch (e) {
      if (context.mounted) {
        TopMessage.show(context, '${l.error}: $e', error: true);
      }
    }
  }

  Future<DockModel?> _selectDock(
      BuildContext context, WidgetRef ref, {required String exclude}) async {
    final l = AppLocalizations.of(context);
    final docks = await ref.read(dockListProvider(warehouseId).future);
    final batches = await ref.read(batchListProvider(warehouseId).future);
    final batchMap = {for (final b in batches) b.id: b};
    final choices = docks.where((d) => d.id != exclude).toList();
    if (!context.mounted) return null;
    return showDialog<DockModel>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l.selectTargetDock),
        children: choices
            .map((d) {
              final b = d.currentBatchId != null ? batchMap[d.currentBatchId] : null;
              final suffix = b != null
                  ? '${l.currentBatch}: ${b.batchCode}'
                  : l.noBatch;
              return SimpleDialogOption(
                onPressed: () => Navigator.pop(context, d),
                child: Text('${d.name}（$suffix）'),
              );
            })
            .toList(),
      ),
    );
  }

  Future<String?> _inputDialog(
      BuildContext context, String title, String label) {
    final l = AppLocalizations.of(context);
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
          OverflowBar(
            alignment: MainAxisAlignment.end,
            spacing: 8,
            children: [
              _NeumorphicButton(
                label: l.cancel,
                onTap: () => Navigator.pop(context),
              ),
              _NeumorphicButton(
                label: l.ok,
                filled: true,
                onTap: () => Navigator.pop(context, controller.text.trim()),
              ),
            ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF15182A) : const Color(0xFFF5F7FF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? const Color(0xFF4A5278).withOpacity(0.35)
                  : Colors.white.withOpacity(0.85),
              offset: const Offset(-5, -5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.45)
                  : Colors.black.withOpacity(0.12),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26, color: colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _NeumorphicButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _NeumorphicButton({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final background = filled
        ? colorScheme.primary
        : (isDark ? const Color(0xFF15182A) : const Color(0xFFF5F7FF));
    final foreground = filled ? colorScheme.onPrimary : colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? const Color(0xFF4A5278).withOpacity(0.35)
                  : Colors.white.withOpacity(0.85),
              offset: const Offset(-5, -5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.45)
                  : Colors.black.withOpacity(0.12),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
