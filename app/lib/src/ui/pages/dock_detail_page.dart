import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/enums.dart';
import '../../providers/batch_providers.dart';
import '../../providers/dock_providers.dart';
import '../../utils.dart';

class DockDetailPage extends ConsumerWidget {
  final String dockId;

  const DockDetailPage({super.key, required this.dockId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dockAsync = ref.watch(dockDetailProvider(dockId));
    final batchAsync = ref.watch(batchForDockProvider(dockId));

    return Scaffold(
      appBar: AppBar(title: const Text('道口详情')),
      body: dockAsync.when(
        data: (dock) {
          if (dock == null) {
            return const Center(child: Text('道口不存在'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(dock.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('状态: ${dock.currentStatus == DockStatus.paused ? 'B' : dock.currentStatus.name}'),
              Text('更新: ${formatDateTime(dock.updatedAt)}'),
              const Divider(),
              batchAsync.when(
                data: (batch) => batch != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('当前批次: ${batch.batchCode}',
                              style: Theme.of(context).textTheme.titleMedium),
                          if (batch.displayName != null)
                            Text('简称: ${batch.displayName}'),
                          Text('状态: ${batch.status.name}'),
                          Text('开始: ${formatDateTime(batch.startedAt)}'),
                        ],
                      )
                    : const Text('当前无批次'),
                loading: () => const Text('正在加载批次…'),
                error: (e, _) => Text('批次加载失败: $e'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: $e')),
      ),
    );
  }
}
