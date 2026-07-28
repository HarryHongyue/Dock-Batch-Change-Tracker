import 'package:drift/drift.dart';

import '../database.dart';
import '../models/snapshot_model.dart';

class SnapshotRepository {
  final AppDatabase db;

  SnapshotRepository(this.db);

  Future<SnapshotModel?> getById(String id) async {
    final row =
        await (db.select(db.snapshots)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<SnapshotModel>> getByWarehouseId(String warehouseId) async {
    final rows = await (db.select(db.snapshots)
          ..where((t) => t.warehouseId.equals(warehouseId))
          ..orderBy([(t) => OrderingTerm.desc(t.snapshotTime)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<void> insert(SnapshotModel model) =>
      db.into(db.snapshots).insert(_companion(model));

  Future<void> delete(String id) =>
      (db.delete(db.snapshots)..where((t) => t.id.equals(id))).go();

  SnapshotModel _toModel(Snapshot r) => SnapshotModel(
        id: r.id,
        warehouseId: r.warehouseId,
        sessionId: r.sessionId,
        snapshotType: r.snapshotType,
        snapshotTime: r.snapshotTime,
        snapshotJson: r.snapshotJson,
        createdAt: r.createdAt,
      );

  SnapshotsCompanion _companion(SnapshotModel m) => SnapshotsCompanion(
        id: Value(m.id),
        warehouseId: Value(m.warehouseId),
        sessionId: Value(m.sessionId),
        snapshotType: Value(m.snapshotType),
        snapshotTime: Value(m.snapshotTime ?? DateTime.now()),
        snapshotJson: Value(m.snapshotJson),
        createdAt: Value(m.createdAt ?? DateTime.now()),
      );
}
