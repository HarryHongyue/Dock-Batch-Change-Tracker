import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/change_event_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/models/enums.dart';
import '../../providers/dock_providers.dart';
import '../../providers/session_providers.dart';
import '../../utils.dart';

class DockDetailPage extends ConsumerWidget {
  final String dockId;

  const DockDetailPage({super.key, required this.dockId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dockAsync = ref.watch(dockDetailProvider(dockId));
    final eventsAsync = ref.watch(dockEventsProvider(dockId));

    return Scaffold(
      appBar: AppBar(title: const Text('道口历史')),
      body: dockAsync.when(
        data: (dock) {
          if (dock == null) {
            return const Center(child: Text('道口不存在'));
          }
          return eventsAsync.when(
            data: (events) => _buildList(context, dock, events),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('加载失败: ' + e.toString())),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: ' + e.toString())),
      ),
    );
  }

  Widget _buildList(BuildContext context, DockModel dock, List<ChangeEventModel> events) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(dock.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('状态: ' + (dock.currentStatus == DockStatus.paused ? 'B' : dock.currentStatus.name)),
        Text('更新: ' + formatShortDateTime(dock.updatedAt)),
        const Divider(),
        if (events.isEmpty) const Center(child: Text('暂无历史记录')),
        ...events.map((e) => _EventTile(event: e)),
      ],
    );
  }
}

class _EventTile extends StatelessWidget {
  final ChangeEventModel event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.note ?? event.eventType.name),
      subtitle: Text(formatShortDateTime(event.eventTime)),
    );
  }
}
