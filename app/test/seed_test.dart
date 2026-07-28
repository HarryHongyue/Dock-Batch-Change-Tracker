import 'package:flutter_test/flutter_test.dart';

import 'package:dock_batch_change_tracker/src/data/repositories/dock_repository.dart';
import 'package:dock_batch_change_tracker/src/data/repositories/warehouse_repository.dart';
import 'package:dock_batch_change_tracker/src/data/services/database_service.dart';
import 'package:dock_batch_change_tracker/src/data/services/seed_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('载入种子测试数据', () async {
    final service = DatabaseService();
    final db = await service.open(inMemory: true);

    await SeedService(db).seed();

    final warehouses = await WarehouseRepository(db).getAll();
    final docks = await DockRepository(db).getByWarehouseId(warehouses.first.id);

    expect(warehouses.first.name, 'Maastricht Warehouse');
    expect(docks.length, 6);

    await service.close();
  });
}
