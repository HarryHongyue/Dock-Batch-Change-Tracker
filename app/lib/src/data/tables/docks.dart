import 'package:drift/drift.dart';
import '../models/enums.dart';

class Docks extends Table {
  @override
  String get tableName => 'docks';

  TextColumn get id => text()();
  TextColumn get warehouseId => text()();
  TextColumn get name => text()();
  IntColumn get displayOrder =>
      integer().withDefault(const Constant(0))();
  IntColumn get colorValue =>
      integer().withDefault(const Constant(0))();
  TextColumn get currentStatus =>
      text().map(const DockStatusConverter()).withDefault(
            const Constant('empty'),
          )();
  TextColumn get currentBatchId => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
