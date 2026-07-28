import 'package:drift/drift.dart';
import '../models/enums.dart';

class ChangeEvents extends Table {
  @override
  String get tableName => 'change_events';

  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get warehouseId => text()();
  TextColumn get eventType =>
      text().map(const EventTypeConverter()).withDefault(
            const Constant('manualNote'),
          )();
  TextColumn get batchId => text().nullable()();
  TextColumn get sourceDockId => text().nullable()();
  TextColumn get targetDockId => text().nullable()();
  TextColumn get previousDockStatus =>
      text().map(const DockStatusConverter()).nullable()();
  TextColumn get newDockStatus =>
      text().map(const DockStatusConverter()).nullable()();
  TextColumn get previousBatchId => text().nullable()();
  TextColumn get newBatchId => text().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get eventOrder =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get eventTime =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
