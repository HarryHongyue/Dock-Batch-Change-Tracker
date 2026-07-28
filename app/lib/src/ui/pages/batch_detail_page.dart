import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/batch_providers.dart';
import '../../providers/dock_providers.dart';
import '../../utils.dart';

class BatchDetailPage extends ConsumerWidget {
  final String batchId;

  const BatchDetailPage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchAsync = ref.watch(batchDetailProvider(batchId));
    final currentDockAsync = ref.watch(dockForBatchProvider(batchId));

    return Scaffold(
      appBar: AppBar(title: const Text('批次详情')),
      body: batchAsync.when(
        data: (batch) {
          if (batch == null) {
            return const Center(child: Text('批次不存在'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(batch.batchCode,
                  style: Theme.of(context).textTheme.headlineSmall),
              if (batch.displayName != null) Text('简称: ${batch.displayName}'),
              const SizedBox(height: 8),
              Text('状态: ${batch.status.name}'),
              Text('创建: ${formatDateTime(batch.createdAt)}'),
              Text('开始: ${formatDateTime(batch.startedAt)}'),
              Text('完成: ${formatDateTime(batch.completedAt)}'),
              const Divider(),
              currentDockAsync.when(
                data: (dock) =>
                    Text('当前道口: ${dock?.name ?? '无'}', style: Theme.of(context).textTheme.titleMedium),
                loading: () => const Text('正在定位道口…'),
                error: (e, _) => Text('道口加载失败: $e'),
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
