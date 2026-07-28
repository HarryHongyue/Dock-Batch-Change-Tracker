import '../../utils.dart';
import '../database.dart';
import '../models/batch_model.dart';
import '../models/dock_model.dart';
import '../models/warehouse_model.dart';
import '../repositories/batch_repository.dart';
import '../repositories/dock_repository.dart';
import '../repositories/warehouse_repository.dart';
import 'dock_operation_service.dart';

class SeedService {
  final AppDatabase db;
  final DockOperationService _ops;
  final WarehouseRepository _warehouses;
  final DockRepository _docks;
  final BatchRepository _batches;

  SeedService(this.db)
      : _ops = DockOperationService(db),
        _warehouses = WarehouseRepository(db),
        _docks = DockRepository(db),
        _batches = BatchRepository(db);

  Future<void> seed() async {
        final warehouse = WarehouseModel(
          id: generateId(),
          name: 'Maastricht Warehouse',
          description: 'Seed warehouse',
        );
        await _warehouses.insert(warehouse);

        final dockData = [
          ('1号道口', DockStatus.active, '1701'),
          ('2号道口', DockStatus.paused, null),
          ('3号道口', DockStatus.active, '2101'),
          ('4号道口', DockStatus.active, '2302'),
          ('5号道口', DockStatus.active, '2303'),
          ('6号道口', DockStatus.active, '2301'),
        ];

        final dockMap = <String, String>{};
        for (var i = 0; i < dockData.length; i++) {
          final entry = dockData[i];
          final dockId = generateId();
          final dock = DockModel(
            id: dockId,
            warehouseId: warehouse.id,
            name: entry.$1,
            displayOrder: i,
            currentStatus: entry.$2,
            currentBatchId: null,
          );
          await _docks.insert(dock);
          dockMap[entry.$1] = dockId;

          if (entry.$3 != null) {
            final batch = BatchModel(
              id: generateId(),
              warehouseId: warehouse.id,
              batchCode: entry.$3!,
              status: BatchStatus.active,
              startedAt: DateTime.now(),
            );
            await _batches.insert(batch);
            await _docks.updateStatusAndBatch(
              dockId,
              status: entry.$2,
              batchId: batch.id,
            );
          }
        }

        // Example change session
        final session = await _ops.startChangeSession(
          warehouseId: warehouse.id,
          title: '道口重新分配',
          note: 'Seed session',
        );

        await _ops.moveBatch(
          sessionId: session.id,
          warehouseId: warehouse.id,
          sourceDockId: dockMap['3号道口']!,
          targetDockId: dockMap['2号道口']!,
        );

        await _ops.moveBatch(
          sessionId: session.id,
          warehouseId: warehouse.id,
          sourceDockId: dockMap['4号道口']!,
          targetDockId: dockMap['3号道口']!,
        );

        await _ops.createAndAssignBatch(
          sessionId: session.id,
          warehouseId: warehouse.id,
          targetDockId: dockMap['4号道口']!,
          batchCode: '2401',
        );

        // find 2101 batch id
        final batch2101 = await _batches.getByBatchCode(warehouse.id, '2101');
        if (batch2101 != null) {
          final dock2 = await _docks.getById(dockMap['2号道口']!);
          if (dock2 != null && dock2.currentBatchId == batch2101.id) {
            await _ops.completeBatch(
              sessionId: session.id,
              warehouseId: warehouse.id,
              batchId: batch2101.id,
              dockId: dock2.id,
            );
          }
        }

        await _ops.changeDockStatus(
          sessionId: session.id,
          warehouseId: warehouse.id,
          dockId: dockMap['2号道口']!,
          newStatus: DockStatus.paused,
        );

        await _ops.commitSession(sessionId: session.id);
      }
}
