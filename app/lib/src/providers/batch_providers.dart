import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/batch_model.dart';
import '../data/repositories/batch_repository.dart';
import '../data/repositories/dock_repository.dart';
import 'database_provider.dart';

final batchListProvider = FutureProvider.autoDispose
    .family<List<BatchModel>, String>((ref, warehouseId) async {
  final db = await ref.watch(databaseProvider.future);
  return BatchRepository(db).getByWarehouseId(warehouseId);
});

final batchDetailProvider = FutureProvider.autoDispose
    .family<BatchModel?, String>((ref, batchId) async {
  final db = await ref.watch(databaseProvider.future);
  return BatchRepository(db).getById(batchId);
});

final batchForDockProvider = FutureProvider.autoDispose
    .family<BatchModel?, String>((ref, dockId) async {
  final db = await ref.watch(databaseProvider.future);
  final dock = await DockRepository(db).getById(dockId);
  if (dock?.currentBatchId == null) return null;
  return BatchRepository(db).getById(dock!.currentBatchId!);
});

final batchSearchProvider = FutureProvider.autoDispose
    .family<List<BatchModel>, ({String warehouseId, String query})>((
  ref,
  arg,
) async {
  final db = await ref.watch(databaseProvider.future);
  final batches = await BatchRepository(db).getByWarehouseId(arg.warehouseId);
  final q = arg.query.toLowerCase();
  return batches
      .where((b) =>
          b.batchCode.toLowerCase().contains(q) ||
          (b.displayName?.toLowerCase().contains(q) ?? false))
      .toList();
});
