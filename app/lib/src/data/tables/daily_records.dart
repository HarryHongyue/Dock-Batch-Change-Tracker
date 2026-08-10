import 'package:drift/drift.dart';

class DailyRecords extends Table {
  @override
  String get tableName => 'daily_records';

  TextColumn get id => text()();
  TextColumn get warehouseId => text()();
  DateTimeColumn get recordDate => dateTime()();
  TextColumn get openingSnapshotId => text().nullable()();
  TextColumn get closingSnapshotId => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
