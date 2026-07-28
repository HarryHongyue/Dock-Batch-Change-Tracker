import 'package:drift/drift.dart';

import 'models/enums.dart';
import 'tables/warehouses.dart';
import 'tables/docks.dart';
import 'tables/batches.dart';
import 'tables/change_sessions.dart';
import 'tables/change_events.dart';
import 'tables/snapshots.dart';
import 'tables/daily_records.dart';
import 'tables/settings.dart';

export 'models/enums.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Warehouses,
    Docks,
    Batches,
    ChangeSessions,
    ChangeEvents,
    Snapshots,
    DailyRecords,
    Settings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // 后续版本逐步添加迁移脚本
        },
      );
}


