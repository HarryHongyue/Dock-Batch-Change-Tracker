import 'package:drift/drift.dart';
import '../models/enums.dart';

class Snapshots extends Table {
  @override
  String get tableName => 'snapshots';

  TextColumn get id => text()();
  TextColumn get warehouseId => text()();
  TextColumn get sessionId => text().nullable()();
  TextColumn get snapshotType =>
      text().map(const SnapshotTypeConverter()).withDefault(
            const Constant('manual'),
          )();
  DateTimeColumn get snapshotTime =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get snapshotJson => text()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
