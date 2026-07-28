import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/change_event_model.dart';
import '../../data/models/change_session_model.dart';
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
        error: (e, _) => Center(child: Text('加载失败: $e')),
      ),
    );
  }
}

class _TimelineBody extends ConsumerWidget {
  final String warehouseId;

  const _TimelineBody({required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionListProvider(warehouseId));

    return sessionsAsync.when(
      data: (sessions) => _buildList(context, ref, sessions),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: $e')),
    );
  }

  Widget _buildList(BuildContext context, WidgetRef ref,
      List<ChangeSessionModel> sessions) {
    if (sessions.isEmpty) {
      return const Center(child: Text('暂无变更记录'));
    }
    final grouped = <String, List<ChangeSessionModel>>{};
    for (final s in sessions) {
      final key = formatDate(s.createdAt);
      grouped.putIfAbsent(key, () => []).add(s);
    }

    return ListView.builder(
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final date = grouped.keys.elementAt(index);
        final list = grouped[date]!;
        return ExpansionTile(
          title: Text(date),
          children: list
              .map((s) => _SessionTile(warehouseId: warehouseId, session: s))
              .toList(),
        );
      },
    );
  }
}

class _SessionTile extends ConsumerWidget {
  final String warehouseId;
  final ChangeSessionModel session;

  const _SessionTile({required this.warehouseId, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(sessionEventsProvider(session.id));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(session.title ?? '变更'),
        subtitle: Text(
            '${formatTime(session.startedAt)} - ${session.status.name} ${session.note ?? ''}'),
        children: eventsAsync.when(
          data: (events) => events.map((e) => _EventTile(event: e)).toList(),
          loading: () => [const ListTile(title: Text('加载中…'))],
          error: (e, _) => [ListTile(title: Text('加载失败: $e'))],
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final ChangeEventModel event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        radius: 14,
        child: Text('${event.eventOrder}', style: const TextStyle(fontSize: 10)),
      ),
      title: Text(event.eventType.name),
      subtitle: Text(
          '批: ${event.batchId ?? '-'} 源: ${event.sourceDockId ?? '-'} 目标: ${event.targetDockId ?? '-'}'),
      trailing: Text(formatTime(event.eventTime)),
    );
  }
}
