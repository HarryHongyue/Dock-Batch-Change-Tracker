import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/change_event_model.dart';
import '../../i18n/app_localizations.dart';
import '../../providers/session_providers.dart';
import '../../providers/warehouse_providers.dart';
import '../../utils.dart';

class TimelinePage extends ConsumerWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final currentIdAsync = ref.watch(currentWarehouseProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.history)),
      body: currentIdAsync.when(
        data: (currentId) {
          if (currentId == null || currentId.isEmpty) {
            return Center(child: Text(l.noData));
          }
          return _TimelineBody(warehouseId: currentId);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.loadFailed)),
      ),
    );
  }
}

class _TimelineBody extends ConsumerWidget {
  final String warehouseId;

  const _TimelineBody({required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final eventsAsync = ref.watch(warehouseEventsProvider(warehouseId));

    return eventsAsync.when(
      data: (events) => _buildList(context, l, events),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(l.loadFailed)),
    );
  }

  Widget _buildList(BuildContext context, AppLocalizations l, List<ChangeEventModel> events) {
    if (events.isEmpty) {
      return Center(child: Text(l.noData));
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final e = events[index];
        return ListTile(
          title: Text(l.eventDisplay(e)),
          subtitle: Text(formatShortDateTime(e.eventTime)),
        );
      },
    );
  }
}
