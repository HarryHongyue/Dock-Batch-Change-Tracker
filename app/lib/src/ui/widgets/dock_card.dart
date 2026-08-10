import 'package:flutter/material.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/models/enums.dart';
import '../../i18n/app_localizations.dart';
import '../../utils.dart';

class DockCard extends StatefulWidget {
  final DockModel dock;
  final BatchModel? batch;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool compact;
  final bool isGrid;
  final bool isSelected;

  const DockCard({
    super.key,
    required this.dock,
    this.batch,
    this.onTap,
    this.onLongPress,
    this.compact = false,
    this.isGrid = false,
    this.isSelected = false,
  });

  @override
  State<DockCard> createState() => _DockCardState();
}

class _DockCardState extends State<DockCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isCompact = widget.compact || widget.isGrid;
    final l = AppLocalizations.of(context);

    final statusColor = _statusColor(colorScheme);
    final statusLabel = l.dockStatusLabel(widget.dock.currentStatus);

    final batchCode = widget.batch?.batchCode ?? '';
    final display = batchCode.isEmpty
        ? '-'
        : displayBatchCode(batchCode, maxLength: isCompact ? 10 : 18);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onLongPress: widget.onLongPress,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? colorScheme.primaryContainer.withOpacity(0.45)
              : _backgroundColor(colorScheme, theme),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.isSelected
                ? colorScheme.primary
                : statusColor.withOpacity(0.35),
            width: widget.isSelected ? 2.5 : 1.2,
          ),
          boxShadow: _neumorphicShadows(context, _pressed),
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
                    widget.dock.name,
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
            if (widget.batch != null && !isCompact)
              Text(
                '进入: ${formatShortDateTime(widget.batch!.startedAt)}',
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(ColorScheme scheme) {
    switch (widget.dock.currentStatus) {
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

  Color _backgroundColor(ColorScheme scheme, ThemeData theme) {
    final base = widget.dock.currentStatus == DockStatus.paused
        ? scheme.tertiaryContainer
        : theme.scaffoldBackgroundColor;
    return base;
  }

  List<BoxShadow> _neumorphicShadows(BuildContext context, bool pressed) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final offset = pressed ? 4.0 : 8.0;
    final blur = pressed ? 8.0 : 16.0;

    if (isDark) {
      return [
        BoxShadow(
          color: const Color(0xFF4A5278).withOpacity(pressed ? 0.25 : 0.5),
          offset: Offset(-offset, -offset),
          blurRadius: blur,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(pressed ? 0.4 : 0.65),
          offset: Offset(offset, offset),
          blurRadius: blur,
        ),
      ];
    }

    return [
      BoxShadow(
        color: Colors.white.withOpacity(pressed ? 0.6 : 0.95),
        offset: Offset(-offset, -offset),
        blurRadius: blur,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(pressed ? 0.1 : 0.22),
        offset: Offset(offset, offset),
        blurRadius: blur,
      ),
    ];
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
