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

  const DockCard({
    super.key,
    required this.dock,
    this.batch,
    this.onTap,
    this.onLongPress,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final statusColor = _statusColor(colorScheme);
    final statusLabel = _statusLabel(dock.currentStatus);

    final batchCode = batch?.batchCode ?? '';
    final display = batchCode.isEmpty ? '-' : displayBatchCode(batchCode, maxLength: compact ? 14 : 20);

    return Card(
      elevation: 2,
      color: _backgroundColor(colorScheme),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dock.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Chip(
                    visualDensity: VisualDensity.compact,
                    backgroundColor: statusColor,
                    label: Text(
                      statusLabel,
                      style: TextStyle(
                        color: _contrastText(statusColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (compact)
                Text(
                  display,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                )
              else
                Text(
                  display,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              if (batch != null && !compact)
                Text(
                  '进入: ${formatTime(batch!.startedAt)}',
                  style: theme.textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(ColorScheme scheme) {
    switch (dock.currentStatus) {
      case DockStatus.active:
        return scheme.primary;
      case DockStatus.paused:
        return scheme.tertiary;
      case DockStatus.empty:
        return scheme.outline;
      case DockStatus.closed:
        return scheme.error;
      case DockStatus.blocked:
        return scheme.errorContainer;
      case DockStatus.maintenance:
        return scheme.secondary;
    }
  }

  Color _backgroundColor(ColorScheme scheme) {
    if (dock.currentStatus == DockStatus.paused) {
      return scheme.tertiaryContainer.withOpacity(0.15);
    }
    return scheme.surface;
  }

  Color _contrastText(Color color) =>
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  String _statusLabel(DockStatus s) {
    if (s == DockStatus.paused) return 'B';
    return s.name;
  }
}
