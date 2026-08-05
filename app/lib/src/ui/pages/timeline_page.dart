import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/change_event_model.dart';
import '../../providers/session_providers.dart';
import '../../providers/warehouse_providers.dart';
import '../../utils.dart';

class TimelinePage extends ConsumerWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIdAsync = ref.watch(currentWarehouseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('时间线')),
      body: currentIdAsync.when(
        data: (currentId) {
          if (currentId == null || currentId.isEmpty) {
            return const Center(child: Text('请先选择仓库'));
          }
          return _TimelineBody(warehouseId: currentId);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: ' + e.toString())),
      ),
    );
  }
}

class _TimelineBody extends ConsumerWidget {
  final String warehouseId;

  const _TimelineBody({required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(warehouseEventsProvider(warehouseId));

    return eventsAsync.when(
      data: (events) => _buildList(context, events),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: ' + e.toString())),
    );
  }

  Widget _buildList(BuildContext context, List<ChangeEventModel> events) {
    if (events.isEmpty) {
      return const Center(child: Text('暂无记录'));
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final e = events[index];
        return ListTile(
          title: Text(e.note ?? e.eventType.name),
          subtitle: Text(formatShortDateTime(e.eventTime)),
        );
      },
    );
  }
}
