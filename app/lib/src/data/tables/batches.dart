import 'package:drift/drift.dart';
import '../models/enums.dart';

class Batches extends Table {
  @override
  String get tableName => 'batches';

  TextColumn get id => text()();
  TextColumn get warehouseId => text()();
  TextColumn get batchCode => text()();
  TextColumn get displayName => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get status =>
      text().map(const BatchStatusConverter()).withDefault(
            const Constant('waiting'),
          )();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get startedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
