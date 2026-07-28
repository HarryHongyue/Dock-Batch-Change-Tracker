import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/dock_model.dart';
import '../data/repositories/dock_repository.dart';
import 'database_provider.dart';

final dockListProvider = FutureProvider.autoDispose
    .family<List<DockModel>, String>((ref, warehouseId) async {
  final db = await ref.watch(databaseProvider.future);
  return DockRepository(db).getByWarehouseId(warehouseId);
});

final dockDetailProvider = FutureProvider.autoDispose
    .family<DockModel?, String>((ref, dockId) async {
  final db = await ref.watch(databaseProvider.future);
  return DockRepository(db).getById(dockId);
});

final dockForBatchProvider = FutureProvider.autoDispose
    .family<DockModel?, String>((ref, batchId) async {
  final db = await ref.watch(databaseProvider.future);
  return DockRepository(db).getByBatchId(batchId);
});
