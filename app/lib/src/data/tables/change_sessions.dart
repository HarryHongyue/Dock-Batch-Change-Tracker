import 'package:drift/drift.dart';
import '../models/enums.dart';

class ChangeSessions extends Table {
  @override
  String get tableName => 'change_sessions';

  TextColumn get id => text()();
  TextColumn get warehouseId => text()();
  DateTimeColumn get startedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status =>
      text().map(const ChangeSessionStatusConverter()).withDefault(
            const Constant('draft'),
          )();
  TextColumn get title => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get beforeSnapshotId => text().nullable()();
  TextColumn get afterSnapshotId => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
