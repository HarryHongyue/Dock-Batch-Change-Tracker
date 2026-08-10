import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/snapshot_repository.dart';
import '../../data/services/snapshot_service.dart';
import '../../providers/database_provider.dart';

class SnapshotComparePage extends ConsumerWidget {
  final String? beforeId;
  final String? afterId;

  const SnapshotComparePage({super.key, this.beforeId, this.afterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('快照比较')),
      body: (beforeId == null || afterId == null)
          ? const Center(child: Text('缺少快照参数'))
          : _buildCompare(context, ref),
    );
  }

  Widget _buildCompare(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _loadDiff(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final diff = snapshot.data;
        if (diff == null) {
          return const Center(child: Text('无法加载快照'));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('新增批次',
                style: Theme.of(context).textTheme.titleMedium),
            ...diff.newBatches.map((e) => ListTile(title: Text(e))),
            const Divider(),
            Text('完成批次',
                style: Theme.of(context).textTheme.titleMedium),
            ...diff.completedBatches.map((e) => ListTile(title: Text(e))),
            const Divider(),
            Text('移动的批次',
                style: Theme.of(context).textTheme.titleMedium),
            ...diff.movedBatches.entries.map((e) => ListTile(
                  title: Text(e.key),
                  subtitle: Text(e.value ?? '-'),
                )),
            const Divider(),
            Text('道口状态变化',
                style: Theme.of(context).textTheme.titleMedium),
            ...diff.statusChanges.entries.map((e) => ListTile(
                  title: Text(e.key),
                  subtitle: Text(e.value),
                )),
          ],
        );
      },
    );
  }

  Future<SnapshotDiff?> _loadDiff(WidgetRef ref) async {
    final db = await ref.read(databaseProvider.future);
    final service = SnapshotService(db);
    final before = await SnapshotRepository(db).getById(beforeId!);
    final after = await SnapshotRepository(db).getById(afterId!);
    if (before == null || after == null) return null;
    return service.compare(before, after);
  }
}
