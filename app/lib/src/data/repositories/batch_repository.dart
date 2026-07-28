import 'package:drift/drift.dart';

import '../database.dart';
import '../models/batch_model.dart';

class BatchRepository {
  final AppDatabase db;

  BatchRepository(this.db);

  Future<List<BatchModel>> getAll({bool includeArchived = false}) async {
    final query = db.select(db.batches)
      ..where((t) => Constant(includeArchived) | t.isArchived.equals(false))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]);
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  Future<List<BatchModel>> getByWarehouseId(String warehouseId,
      {bool includeArchived = false}) async {
    final query = db.select(db.batches)
      ..where((t) =>
          t.warehouseId.equals(warehouseId) &
          (Constant(includeArchived) | t.isArchived.equals(false)))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]);
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  Future<BatchModel?> getById(String id) async {
    final row = await (db.select(db.batches)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<BatchModel?> getByBatchCode(String warehouseId, String code) async {
    final row = await (db.select(db.batches)
          ..where((t) =>
              t.warehouseId.equals(warehouseId) &
              t.batchCode.equals(code) &
              t.isArchived.equals(false)))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> insert(BatchModel model) =>
      db.into(db.batches).insert(_companion(model));

  Future<void> update(BatchModel model) =>
      db.update(db.batches).replace(_companion(model, touch: true));

  Future<void> deleteOrArchive(String id) =>
      (db.update(db.batches)..where((t) => t.id.equals(id))).write(
        BatchesCompanion(
          isArchived: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  BatchModel _toModel(Batche r) => BatchModel(
        id: r.id,
        warehouseId: r.warehouseId,
        batchCode: r.batchCode,
        displayName: r.displayName,
        description: r.description,
        status: r.status,
        createdAt: r.createdAt,
        startedAt: r.startedAt,
        completedAt: r.completedAt,
        updatedAt: r.updatedAt,
        isArchived: r.isArchived,
      );

  BatchesCompanion _companion(BatchModel m, {bool touch = false}) =>
      BatchesCompanion(
        id: Value(m.id),
        warehouseId: Value(m.warehouseId),
        batchCode: Value(m.batchCode),
        displayName: Value(m.displayName),
        description: Value(m.description),
        status: Value(m.status),
        createdAt: Value(m.createdAt ?? DateTime.now()),
        startedAt: Value(m.startedAt ?? DateTime.now()),
        completedAt: Value(m.completedAt),
        updatedAt:
            Value(touch ? DateTime.now() : (m.updatedAt ?? DateTime.now())),
        isArchived: Value(m.isArchived),
      );
}
