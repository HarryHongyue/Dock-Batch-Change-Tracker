import 'package:drift/drift.dart';

class Settings extends Table {
  @override
  String get tableName => 'settings';

  TextColumn get id => text()();
  TextColumn get warehouseId => text().nullable()();
  TextColumn get settingKey => text()();
  TextColumn get settingValue => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'UNIQUE (warehouse_id, setting_key)',
      ];
}
