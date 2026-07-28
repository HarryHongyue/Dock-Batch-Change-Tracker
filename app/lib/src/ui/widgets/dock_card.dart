import 'dart:ui';

import 'package:flutter/material.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/models/enums.dart';
import '../../utils.dart';
class DockCard extends StatelessWidget {
  final DockModel dock;
  final BatchModel? batch;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool compact;
  final bool isGrid;

  const DockCard({
    super.key,
    required this.dock,
    this.batch,
    this.onTap,
    this.onLongPress,
    this.compact = false,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isCompact = compact || isGrid;

    final statusColor = _statusColor(colorScheme);
    final statusLabel = _statusLabel(dock.currentStatus);

    final batchCode = batch?.batchCode ?? '';
    final display = batchCode.isEmpty
        ? '-'
        : displayBatchCode(batchCode, maxLength: isCompact ? 10 : 18);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _backgroundColor(colorScheme),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: statusColor.withOpacity(0.35),
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        dock.name,
                        style: (isCompact
                                ? theme.textTheme.labelLarge
                                : theme.textTheme.titleMedium)
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _StatusChip(
                      label: statusLabel,
                      color: statusColor,
                      isCompact: isCompact,
                    ),
                  ],
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    display,
                    style: (isCompact
                            ? theme.textTheme.titleMedium
                            : theme.textTheme.titleLarge)
                        ?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                if (batch != null && !isCompact)
                  Text(
                    '进入: ${formatTime(batch!.startedAt)}',
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(ColorScheme scheme) {
    switch (dock.currentStatus) {
      case DockStatus.active:
        return const Color(0xFF38BDF8);
      case DockStatus.paused:
        return scheme.tertiary;
      case DockStatus.empty:
        return scheme.outline;
      case DockStatus.closed:
        return scheme.error;
      case DockStatus.blocked:
        return const Color(0xFFF59E0B);
      case DockStatus.maintenance:
        return scheme.secondary;
    }
  }

  Color _backgroundColor(ColorScheme scheme) {
    final base = dock.currentStatus == DockStatus.paused
        ? scheme.tertiaryContainer
        : scheme.surfaceContainer;
    return base.withOpacity(0.45);
  }

  String _statusLabel(DockStatus s) {
    if (s == DockStatus.paused) return '暂停';
    switch (s) {
      case DockStatus.active:
        return '作业';
      case DockStatus.empty:
        return '空闲';
      case DockStatus.closed:
        return '关闭';
      case DockStatus.blocked:
        return '阻塞';
      case DockStatus.maintenance:
        return '维护';
      default:
        return s.name;
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isCompact;

  const _StatusChip({
    required this.label,
    required this.color,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 12,
        vertical: isCompact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.45),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: isCompact ? 11 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
