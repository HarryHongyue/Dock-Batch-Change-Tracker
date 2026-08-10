import 'package:drift/drift.dart';

import '../database.dart';
import '../models/daily_record_model.dart';

class DailyRecordRepository {
  final AppDatabase db;

  DailyRecordRepository(this.db);

  Future<List<DailyRecordModel>> getByWarehouseId(String warehouseId) async {
    final rows = await (db.select(db.dailyRecords)
          ..where((t) => t.warehouseId.equals(warehouseId))
          ..orderBy([(t) => OrderingTerm.desc(t.recordDate)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<DailyRecordModel?> getById(String id) async {
    final row =
        await (db.select(db.dailyRecords)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> insert(DailyRecordModel model) =>
      db.into(db.dailyRecords).insert(_companion(model));

  Future<void> update(DailyRecordModel model) =>
      db.update(db.dailyRecords).replace(_companion(model, touch: true));

  DailyRecordModel _toModel(DailyRecord r) => DailyRecordModel(
        id: r.id,
        warehouseId: r.warehouseId,
        recordDate: r.recordDate,
        openingSnapshotId: r.openingSnapshotId,
        closingSnapshotId: r.closingSnapshotId,
        note: r.note,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
      );

  DailyRecordsCompanion _companion(DailyRecordModel m, {bool touch = false}) =>
      DailyRecordsCompanion(
        id: Value(m.id),
        warehouseId: Value(m.warehouseId),
        recordDate: Value(m.recordDate),
        openingSnapshotId: Value(m.openingSnapshotId),
        closingSnapshotId: Value(m.closingSnapshotId),
        note: Value(m.note),
        createdAt: Value(m.createdAt ?? DateTime.now()),
        updatedAt:
            Value(touch ? DateTime.now() : (m.updatedAt ?? DateTime.now())),
      );
}
