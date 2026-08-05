import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/warehouse_model.dart';
import '../../providers/settings_provider.dart';
import '../../providers/warehouse_providers.dart';
import '../../utils.dart';

class WarehouseListPage extends ConsumerWidget {
  const WarehouseListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warehousesAsync = ref.watch(warehouseListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('仓库列表'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: warehousesAsync.when(
        data: (warehouses) => _buildList(context, ref, warehouses),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: $e')),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => context.push('/onboarding'),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.35),
                offset: const Offset(-5, -5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(5, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, WidgetRef ref, List<WarehouseModel> warehouses) {
    if (warehouses.isEmpty) {
      return const Center(child: Text('暂无仓库，请点击 + 创建'));
    }
    return ListView.builder(
      itemCount: warehouses.length,
      itemBuilder: (context, index) {
        final w = warehouses[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.warehouse)),
          title: Text(w.name),
          subtitle: Text('更新于: ${formatDateTime(w.updatedAt)}'),
          onTap: () async {
            final settings = await ref.read(settingsProvider.future);
            await settings.setCurrentWarehouse(w.id);
            if (context.mounted) {
              context.go('/kanban?warehouseId=${w.id}');
            }
          },
        );
      },
    );
  }
}
