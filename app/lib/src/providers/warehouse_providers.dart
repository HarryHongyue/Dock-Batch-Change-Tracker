import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/warehouse_model.dart';
import '../data/repositories/warehouse_repository.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

final warehouseListProvider =
    FutureProvider.autoDispose<List<WarehouseModel>>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return WarehouseRepository(db).getAll();
});

final currentWarehouseProvider = FutureProvider<String?>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  return settings.currentWarehouseId;
});
