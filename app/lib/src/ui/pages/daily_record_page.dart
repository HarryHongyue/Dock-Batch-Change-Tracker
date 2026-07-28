import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/enums.dart';
import '../../data/services/snapshot_service.dart';
import '../../providers/database_provider.dart';
import '../../providers/warehouse_providers.dart';

class DailyRecordPage extends ConsumerWidget {
  const DailyRecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIdAsync = ref.watch(currentWarehouseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('每日记录'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () async {
              final id = ref.read(currentWarehouseProvider).valueOrNull;
              if (id == null || !context.mounted) return;
              final db = await ref.read(databaseProvider.future);
              await SnapshotService(db).capture(
                warehouseId: id,
                type: SnapshotType.daily,
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('当日快照已保存')),
                );
              }
            },
          ),
        ],
      ),
      body: currentIdAsync.when(
        data: (id) => id == null
            ? const Center(child: Text('请先选择仓库'))
            : const Center(child: Text('每日记录功能占位')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: $e')),
      ),
    );
  }
}
