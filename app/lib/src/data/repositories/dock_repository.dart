import 'package:drift/drift.dart';

import '../database.dart';
import '../models/dock_model.dart';

class DockRepository {
  final AppDatabase db;

  DockRepository(this.db);

  Future<List<DockModel>> getAll({bool includeArchived = false}) async {
    final query = db.select(db.docks)
      ..where((t) => Constant(includeArchived) | t.isArchived.equals(false));
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  Future<List<DockModel>> getByWarehouseId(String warehouseId,
      {bool includeArchived = false}) async {
    final query = db.select(db.docks)
      ..where((t) =>
          t.warehouseId.equals(warehouseId) &
          (Constant(includeArchived) | t.isArchived.equals(false)))
      ..orderBy([(t) => OrderingTerm(expression: t.displayOrder)]);
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  Future<DockModel?> getById(String id) async {
    final row = await (db.select(db.docks)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<DockModel?> getByBatchId(String batchId) async {
    final row = await (db.select(db.docks)
          ..where((t) => t.currentBatchId.equals(batchId))
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> insert(DockModel model) => db.into(db.docks).insert(_companion(model));

  Future<void> update(DockModel model) =>
      db.update(db.docks).replace(_companion(model, touch: true));

  Future<void> updateStatusAndBatch(
    String id, {
    required DockStatus status,
    String? batchId,
  }) {
    return (db.update(db.docks)..where((t) => t.id.equals(id))).write(
      DocksCompanion(
        currentStatus: Value(status),
        currentBatchId: Value(batchId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteOrArchive(String id) =>
      (db.update(db.docks)..where((t) => t.id.equals(id))).write(
        DocksCompanion(
          isArchived: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  DockModel _toModel(Dock r) => DockModel(
        id: r.id,
        warehouseId: r.warehouseId,
        name: r.name,
        displayOrder: r.displayOrder,
        colorValue: r.colorValue,
        currentStatus: r.currentStatus,
        currentBatchId: r.currentBatchId,
        note: r.note,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
        isArchived: r.isArchived,
      );

  DocksCompanion _companion(DockModel m, {bool touch = false}) => DocksCompanion(
        id: Value(m.id),
        warehouseId: Value(m.warehouseId),
        name: Value(m.name),
        displayOrder: Value(m.displayOrder),
        colorValue: Value(m.colorValue),
        currentStatus: Value(m.currentStatus),
        currentBatchId: Value(m.currentBatchId),
        note: Value(m.note),
        createdAt: Value(m.createdAt ?? DateTime.now()),
        updatedAt: Value(touch ? DateTime.now() : (m.updatedAt ?? DateTime.now())),
        isArchived: Value(m.isArchived),
      );
}
