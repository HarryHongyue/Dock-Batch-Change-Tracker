import 'package:flutter_test/flutter_test.dart';

import 'package:dock_batch_change_tracker/src/data/database.dart';
import 'package:dock_batch_change_tracker/src/data/models/batch_model.dart';
import 'package:dock_batch_change_tracker/src/data/models/dock_model.dart';
import 'package:dock_batch_change_tracker/src/data/models/warehouse_model.dart';
import 'package:dock_batch_change_tracker/src/data/repositories/batch_repository.dart';
import 'package:dock_batch_change_tracker/src/data/repositories/change_event_repository.dart';
import 'package:dock_batch_change_tracker/src/data/repositories/change_session_repository.dart';
import 'package:dock_batch_change_tracker/src/data/repositories/dock_repository.dart';
import 'package:dock_batch_change_tracker/src/data/repositories/warehouse_repository.dart';
import 'package:dock_batch_change_tracker/src/data/services/database_service.dart';
import 'package:dock_batch_change_tracker/src/data/services/dock_operation_service.dart';
import 'package:dock_batch_change_tracker/src/data/services/export_service.dart';
import 'package:dock_batch_change_tracker/src/utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DatabaseService service;
  late AppDatabase db;
  late WarehouseRepository warehouses;
  late DockRepository docks;
  late BatchRepository batches;
  late DockOperationService ops;
  late ExportService exportService;
  late WarehouseModel warehouse;
  late List<DockModel> dockList;

  setUp(() async {
    service = DatabaseService();
    db = await service.open(inMemory: true);
    warehouses = WarehouseRepository(db);
    docks = DockRepository(db);
    batches = BatchRepository(db);
    ops = DockOperationService(db);
    exportService = ExportService(db);

    warehouse = await _createWarehouse(warehouses);
    dockList = await _createDocks(docks, warehouse.id, 10);
  });

  tearDown(() async {
    await service.close();
  });

  group('仓库与道口', () {
    test('创建仓库', () async {
      final list = await warehouses.getAll();
      expect(list.length, 1);
      expect(list.first.name, 'Test Warehouse');
    });

    test('创建10个道口', () async {
      final list = await docks.getByWarehouseId(warehouse.id);
      expect(list.length, 10);
      expect(list.first.name, '1号道口');
    });

    test('创建长批次编号', () async {
      const longCode = 'NL-EU-CARGO-20260724-2401-A';
      final batch = await _createBatchAndAssign(
          warehouse.id, dockList[0].id, longCode, batches, docks);
      final found = await batches.getByBatchCode(warehouse.id, longCode);
      expect(found, isNotNull);
      expect(found!.batchCode, longCode);
      expect(batch.id, found.id);
    });
  });

  group('批次操作', () {
    test('批次从3号移动到2号', () async {
      await _createBatchAndAssign(
          warehouse.id, dockList[2].id, '2101', batches, docks);

      final session = await ops.startChangeSession(
        warehouseId: warehouse.id,
        title: '移动测试',
      );

      await ops.moveBatch(
        sessionId: session.id,
        warehouseId: warehouse.id,
        sourceDockId: dockList[2].id,
        targetDockId: dockList[1].id,
      );

      final updatedSource = await docks.getById(dockList[2].id);
      final updatedTarget = await docks.getById(dockList[1].id);

      expect(updatedSource?.currentBatchId, isNull);
      expect(updatedTarget?.currentBatchId, isNotNull);
    });


    test('多事件会话并自动生成前后快照', () async {
      final d3 = dockList[2];
      final d4 = dockList[3];

      await _createBatchAndAssign(
          warehouse.id, d3.id, '3001', batches, docks);
      await _createBatchAndAssign(
          warehouse.id, d4.id, '3002', batches, docks);

      final session = await ops.startChangeSession(
        warehouseId: warehouse.id,
        title: '多事件测试',
      );

      await ops.moveBatch(
        sessionId: session.id,
        warehouseId: warehouse.id,
        sourceDockId: d3.id,
        targetDockId: dockList[1].id,
      );

      await ops.createAndAssignBatch(
        sessionId: session.id,
        warehouseId: warehouse.id,
        targetDockId: d3.id,
        batchCode: '3100',
      );

      await ops.commitSession(sessionId: session.id);

      final updated = await ChangeSessionRepository(db).getById(session.id);
      expect(updated?.beforeSnapshotId, isNotNull);
      expect(updated?.afterSnapshotId, isNotNull);

      final events =
          await ChangeEventRepository(db).getBySessionId(session.id);
      expect(events.length, 2);
    });

    test('撤销未保存操作', () async {
      await _createBatchAndAssign(
          warehouse.id, dockList[0].id, '2101', batches, docks);

      final session = await ops.startChangeSession(
        warehouseId: warehouse.id,
        title: '撤销测试',
      );

      await ops.moveBatch(
        sessionId: session.id,
        warehouseId: warehouse.id,
        sourceDockId: dockList[0].id,
        targetDockId: dockList[1].id,
      );

      await ops.undoLastEvent(sessionId: session.id);

      final d1After = await docks.getById(dockList[0].id);
      expect(d1After?.currentBatchId, isNotNull);
    });

    test('批次完成', () async {
      final batch = await _createBatchAndAssign(
          warehouse.id, dockList[0].id, '2101', batches, docks);

      final session = await ops.startChangeSession(
        warehouseId: warehouse.id,
        title: '完成测试',
      );

      await ops.completeBatch(
        sessionId: session.id,
        warehouseId: warehouse.id,
        batchId: batch.id,
        dockId: dockList[0].id,
      );

      await ops.commitSession(sessionId: session.id);

      final updated = await batches.getById(batch.id);
      expect(updated?.status, BatchStatus.completed);
    });
  });

  group('导入导出', () {
    test('JSON 导出和恢复', () async {
      await _createBatchAndAssign(
          warehouse.id, dockList[0].id, '2101', batches, docks);

      final path = await exportService.exportJson();
      final count = await exportService.importJson(path);
      expect(count, greaterThan(0));
    });

    test('CSV 导出', () async {
      final paths = await exportService.exportCsv();
      expect(paths.length, 3);
    });
  });
}

Future<WarehouseModel> _createWarehouse(
    WarehouseRepository repo) async {
  final model = WarehouseModel(
    id: generateId(),
    name: 'Test Warehouse',
  );
  await repo.insert(model);
  return model;
}

Future<List<DockModel>> _createDocks(
    DockRepository repo, String warehouseId, int count) async {
  final list = <DockModel>[];
  for (var i = 0; i < count; i++) {
    final dock = DockModel(
      id: generateId(),
      warehouseId: warehouseId,
      name: '${i + 1}号道口',
      displayOrder: i,
      currentStatus: DockStatus.empty,
    );
    await repo.insert(dock);
    list.add(dock);
  }
  return list;
}

Future<BatchModel> _createBatchAndAssign(
  String warehouseId,
  String dockId,
  String code,
  BatchRepository batches,
  DockRepository docks,
) async {
  final batch = BatchModel(
    id: generateId(),
    warehouseId: warehouseId,
    batchCode: code,
    status: BatchStatus.active,
    startedAt: DateTime.now(),
  );
  await batches.insert(batch);
  await docks.updateStatusAndBatch(
    dockId,
    status: DockStatus.active,
    batchId: batch.id,
  );
  return batch;
}
