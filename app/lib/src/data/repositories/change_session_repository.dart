import 'package:drift/drift.dart';

import '../database.dart';
import '../models/change_session_model.dart';

class ChangeSessionRepository {
  final AppDatabase db;

  ChangeSessionRepository(this.db);

  Future<List<ChangeSessionModel>> getByWarehouseId(String warehouseId) async {
    final rows = await (db.select(db.changeSessions)
          ..where((t) => t.warehouseId.equals(warehouseId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<ChangeSessionModel?> getById(String id) async {
    final row =
        await (db.select(db.changeSessions)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<ChangeSessionModel?> getActiveSession(String warehouseId) async {
    final row = await (db.select(db.changeSessions)
          ..where((t) =>
              t.warehouseId.equals(warehouseId) &
              t.status.equals(ChangeSessionStatus.draft.name))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> insert(ChangeSessionModel model) =>
      db.into(db.changeSessions).insert(_companion(model));

  Future<void> update(ChangeSessionModel model) =>
      db.update(db.changeSessions).replace(_companion(model, touch: true));

  ChangeSessionModel _toModel(ChangeSession r) => ChangeSessionModel(
        id: r.id,
        warehouseId: r.warehouseId,
        startedAt: r.startedAt,
        completedAt: r.completedAt,
        status: r.status,
        title: r.title,
        note: r.note,
        beforeSnapshotId: r.beforeSnapshotId,
        afterSnapshotId: r.afterSnapshotId,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
      );

  ChangeSessionsCompanion _companion(ChangeSessionModel m,
          {bool touch = false}) =>
      ChangeSessionsCompanion(
        id: Value(m.id),
        warehouseId: Value(m.warehouseId),
        startedAt: Value(m.startedAt ?? DateTime.now()),
        completedAt: Value(m.completedAt),
        status: Value(m.status),
        title: Value(m.title),
        note: Value(m.note),
        beforeSnapshotId: Value(m.beforeSnapshotId),
        afterSnapshotId: Value(m.afterSnapshotId),
        createdAt: Value(m.createdAt ?? DateTime.now()),
        updatedAt:
            Value(touch ? DateTime.now() : (m.updatedAt ?? DateTime.now())),
      );
}
