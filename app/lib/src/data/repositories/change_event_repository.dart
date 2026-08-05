import 'package:drift/drift.dart';

import '../database.dart';
import '../models/change_event_model.dart';

class ChangeEventRepository {
  final AppDatabase db;

  ChangeEventRepository(this.db);

  Future<List<ChangeEventModel>> getBySessionId(String sessionId) async {
    final rows = await (db.select(db.changeEvents)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.eventOrder)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<List<ChangeEventModel>> getByWarehouseId(String warehouseId) async {
    final rows = await (db.select(db.changeEvents)
          ..where((t) => t.warehouseId.equals(warehouseId))
          ..orderBy([(t) => OrderingTerm.desc(t.eventTime)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<List<ChangeEventModel>> getByDockId(String dockId) async {
    final rows = await (db.select(db.changeEvents)
          ..where((t) =>
              t.sourceDockId.equals(dockId) | t.targetDockId.equals(dockId))
          ..orderBy([(t) => OrderingTerm.desc(t.eventTime)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<ChangeEventModel?> getById(String id) async {
    final row =
        await (db.select(db.changeEvents)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<int> nextOrder(String sessionId) async {
    final last = await (db.select(db.changeEvents)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.desc(t.eventOrder)])
          ..limit(1))
        .getSingleOrNull();
    return (last?.eventOrder ?? 0) + 1;
  }

  Future<void> insert(ChangeEventModel model) =>
      db.into(db.changeEvents).insert(_companion(model));

  Future<void> delete(String id) =>
      (db.delete(db.changeEvents)..where((t) => t.id.equals(id))).go();

  Future<void> deleteBySessionId(String sessionId) =>
      (db.delete(db.changeEvents)..where((t) => t.sessionId.equals(sessionId)))
          .go();

  ChangeEventModel _toModel(ChangeEvent r) => ChangeEventModel(
        id: r.id,
        sessionId: r.sessionId,
        warehouseId: r.warehouseId,
        eventType: r.eventType,
        batchId: r.batchId,
        sourceDockId: r.sourceDockId,
        targetDockId: r.targetDockId,
        previousDockStatus: r.previousDockStatus,
        newDockStatus: r.newDockStatus,
        previousBatchId: r.previousBatchId,
        newBatchId: r.newBatchId,
        note: r.note,
        eventOrder: r.eventOrder,
        eventTime: r.eventTime,
        createdAt: r.createdAt,
      );

  ChangeEventsCompanion _companion(ChangeEventModel m) => ChangeEventsCompanion(
        id: Value(m.id),
        sessionId: Value(m.sessionId),
        warehouseId: Value(m.warehouseId),
        eventType: Value(m.eventType),
        batchId: Value(m.batchId),
        sourceDockId: Value(m.sourceDockId),
        targetDockId: Value(m.targetDockId),
        previousDockStatus: Value(m.previousDockStatus),
        newDockStatus: Value(m.newDockStatus),
        previousBatchId: Value(m.previousBatchId),
        newBatchId: Value(m.newBatchId),
        note: Value(m.note),
        eventOrder: Value(m.eventOrder),
        eventTime: Value(m.eventTime ?? DateTime.now()),
        createdAt: Value(m.createdAt ?? DateTime.now()),
      );
}
