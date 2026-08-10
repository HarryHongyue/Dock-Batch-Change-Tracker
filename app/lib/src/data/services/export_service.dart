import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants.dart';
import '../database.dart';
import '../models/batch_model.dart';
import '../models/change_event_model.dart';
import '../models/change_session_model.dart';
import '../models/daily_record_model.dart';
import '../models/dock_model.dart';
import '../models/settings_model.dart';
import '../models/snapshot_model.dart';
import '../models/warehouse_model.dart';
import '../repositories/batch_repository.dart';
import '../repositories/change_event_repository.dart';
import '../repositories/change_session_repository.dart';
import '../repositories/daily_record_repository.dart';
import '../repositories/dock_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/snapshot_repository.dart';
import '../repositories/warehouse_repository.dart';

class ExportService {
  final AppDatabase db;

  ExportService(this.db);

  Future<String> exportJson() async {
    final data = await _buildFullJson();
    final dir = await _tempDir();
    final fileName =
        'dockflow_backup_${_fileTs()}.json';
    final path = p.join(dir.path, fileName);
    final file = File(path);
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(data));
    return path;
  }

  Future<List<String>> exportCsv() async {
    final dir = await _tempDir();
    final timestamp = _fileTs();
    final paths = <String>[];

    paths.add(await _writeDockCsv(p.join(dir.path, 'dockflow_docks_$timestamp.csv')));
    paths.add(await _writeBatchCsv(p.join(dir.path, 'dockflow_batches_$timestamp.csv')));
    paths.add(await _writeEventCsv(p.join(dir.path, 'dockflow_events_$timestamp.csv')));

    return paths;
  }

  Future<void> shareFiles(List<String> paths) async {
    final files = paths.map((e) => XFile(e)).toList();
    await Share.shareXFiles(files, text: '${AppConstants.appName} 导出');
  }

  Future<int> importJson(String path) async {
    final file = File(path);
    final text = await file.readAsString();
    final json = jsonDecode(text) as Map<String, dynamic>;

    final version = json['version'] as String?;
    if (version != null && !_isCompatible(version)) {
      throw UnsupportedError('不兼容的备份版本: $version');
    }

    return db.transaction(() async {
      final count = await _importFromJson(json);
      return count;
    });
  }

  Future<Map<String, dynamic>> _buildFullJson() async {
    final warehouses = await WarehouseRepository(db).getAll(includeArchived: true);
    final docks = await DockRepository(db).getAll(includeArchived: true);
    final batches = await BatchRepository(db).getByWarehouseId('');
    final sessions = await ChangeSessionRepository(db).getByWarehouseId('');
    final events = <ChangeEventModel>[];
    final snapshots = <SnapshotModel>[];
    final dailyRecords = <DailyRecordModel>[];
    final settings = await SettingsRepository(db).getAll();

    for (final w in warehouses) {
      batches.addAll(await BatchRepository(db).getByWarehouseId(w.id, includeArchived: true));
      sessions.addAll(await ChangeSessionRepository(db).getByWarehouseId(w.id));
      snapshots.addAll(await SnapshotRepository(db).getByWarehouseId(w.id));
      dailyRecords.addAll(await DailyRecordRepository(db).getByWarehouseId(w.id));
    }

    for (final s in sessions) {
      events.addAll(await ChangeEventRepository(db).getBySessionId(s.id));
    }

    return {
      'version': AppConstants.exportVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'warehouses': warehouses.map((e) => e.toJson()).toList(),
      'docks': docks.map((e) => e.toJson()).toList(),
      'batches': batches.map((e) => e.toJson()).toList(),
      'changeSessions': sessions.map((e) => e.toJson()).toList(),
      'changeEvents': events.map((e) => e.toJson()).toList(),
      'snapshots': snapshots.map((e) => e.toJson()).toList(),
      'dailyRecords': dailyRecords.map((e) => e.toJson()).toList(),
      'settings': settings.map((e) => e.toJson()).toList(),
    };
  }

  Future<int> _importFromJson(Map<String, dynamic> json) async {
    var count = 0;

    for (final item in json['warehouses'] ?? []) {
      final m = WarehouseModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.warehouses).insert(
        WarehousesCompanion(
          id: Value(m.id),
          name: Value(m.name),
          description: Value(m.description),
          createdAt: Value(m.createdAt ?? DateTime.now()),
          updatedAt: Value(m.updatedAt ?? DateTime.now()),
          isArchived: Value(m.isArchived),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['docks'] ?? []) {
      final m = DockModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.docks).insert(
        DocksCompanion(
          id: Value(m.id),
          warehouseId: Value(m.warehouseId),
          name: Value(m.name),
          displayOrder: Value(m.displayOrder),
          colorValue: Value(m.colorValue),
          currentStatus: Value(m.currentStatus),
          currentBatchId: Value(m.currentBatchId),
          note: Value(m.note),
          createdAt: Value(m.createdAt ?? DateTime.now()),
          updatedAt: Value(m.updatedAt ?? DateTime.now()),
          isArchived: Value(m.isArchived),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['batches'] ?? []) {
      final m = BatchModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.batches).insert(
        BatchesCompanion(
          id: Value(m.id),
          warehouseId: Value(m.warehouseId),
          batchCode: Value(m.batchCode),
          displayName: Value(m.displayName),
          description: Value(m.description),
          status: Value(m.status),
          createdAt: Value(m.createdAt ?? DateTime.now()),
          startedAt: Value(m.startedAt ?? DateTime.now()),
          completedAt: Value(m.completedAt),
          updatedAt: Value(m.updatedAt ?? DateTime.now()),
          isArchived: Value(m.isArchived),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['changeSessions'] ?? []) {
      final m = ChangeSessionModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.changeSessions).insert(
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
          updatedAt: Value(m.updatedAt ?? DateTime.now()),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['changeEvents'] ?? []) {
      final m = ChangeEventModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.changeEvents).insert(
        ChangeEventsCompanion(
          id: Value(m.id),
          sessionId: Value(m.sessionId),
          warehouseId: Value(m.warehouseId),
          eventType: Value(m.eventType),
          batchId: Value(m.batchId),
          sourceDockId: Value(m.sourceDockId),
          targetDockId: Value(m.targetDockId),
          previousDockStatus: Value(m.previousDockStatus),
          newDockStatus: Value(m.newDockStatus),
          previousBatchId: Value(m.previousBatchId),
          newBatchId: Value(m.newBatchId),
          note: Value(m.note),
          eventOrder: Value(m.eventOrder),
          eventTime: Value(m.eventTime ?? DateTime.now()),
          createdAt: Value(m.createdAt ?? DateTime.now()),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['snapshots'] ?? []) {
      final m = SnapshotModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.snapshots).insert(
        SnapshotsCompanion(
          id: Value(m.id),
          warehouseId: Value(m.warehouseId),
          sessionId: Value(m.sessionId),
          snapshotType: Value(m.snapshotType),
          snapshotTime: Value(m.snapshotTime ?? DateTime.now()),
          snapshotJson: Value(m.snapshotJson),
          createdAt: Value(m.createdAt ?? DateTime.now()),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['dailyRecords'] ?? []) {
      final m = DailyRecordModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.dailyRecords).insert(
        DailyRecordsCompanion(
          id: Value(m.id),
          warehouseId: Value(m.warehouseId),
          recordDate: Value(m.recordDate),
          openingSnapshotId: Value(m.openingSnapshotId),
          closingSnapshotId: Value(m.closingSnapshotId),
          note: Value(m.note),
          createdAt: Value(m.createdAt ?? DateTime.now()),
          updatedAt: Value(m.updatedAt ?? DateTime.now()),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    for (final item in json['settings'] ?? []) {
      final m = SettingsModel.fromJson(item as Map<String, dynamic>);
      await db.into(db.settings).insert(
        SettingsCompanion(
          id: Value(m.id),
          warehouseId: Value(m.warehouseId),
          settingKey: Value(m.key),
          settingValue: Value(m.value),
          createdAt: Value(m.createdAt ?? DateTime.now()),
          updatedAt: Value(m.updatedAt ?? DateTime.now()),
        ),
        mode: InsertMode.insertOrReplace,
      );
      count++;
    }

    return count;
  }

  Future<String> _writeDockCsv(String path) async {
    final docks = await DockRepository(db).getAll(includeArchived: true);
    final rows = [
      ['id', 'warehouseId', 'name', 'displayOrder', 'currentStatus', 'currentBatchId', 'note', 'updatedAt'],
      ...docks.map((d) => [
            d.id,
            d.warehouseId,
            d.name,
            d.displayOrder.toString(),
            d.currentStatus.name,
            d.currentBatchId ?? '',
            d.note ?? '',
            d.updatedAt?.toIso8601String() ?? '',
          ])
    ];
    return _writeCsv(path, rows);
  }

  Future<String> _writeBatchCsv(String path) async {
    final batches = await BatchRepository(db).getAll();
    final rows = [
      ['id', 'warehouseId', 'batchCode', 'displayName', 'status', 'startedAt', 'completedAt', 'updatedAt'],
      ...batches.map((b) => [
            b.id,
            b.warehouseId,
            b.batchCode,
            b.displayName ?? '',
            b.status.name,
            b.startedAt?.toIso8601String() ?? '',
            b.completedAt?.toIso8601String() ?? '',
            b.updatedAt?.toIso8601String() ?? '',
          ])
    ];
    return _writeCsv(path, rows);
  }

  Future<String> _writeEventCsv(String path) async {
    final all = <ChangeEventModel>[];
    final sessions = await ChangeSessionRepository(db).getByWarehouseId('');
    for (final s in sessions) {
      all.addAll(await ChangeEventRepository(db).getBySessionId(s.id));
    }
    final rows = [
      ['id', 'sessionId', 'eventType', 'batchId', 'sourceDockId', 'targetDockId', 'previousBatchId', 'newBatchId', 'eventOrder', 'eventTime', 'note'],
      ...all.map((e) => [
            e.id,
            e.sessionId,
            e.eventType.name,
            e.batchId ?? '',
            e.sourceDockId ?? '',
            e.targetDockId ?? '',
            e.previousBatchId ?? '',
            e.newBatchId ?? '',
            e.eventOrder.toString(),
            e.eventTime?.toIso8601String() ?? '',
            e.note ?? '',
          ])
    ];
    return _writeCsv(path, rows);
  }

  Future<String> _writeCsv(String path, List<List<dynamic>> rows) async {
    final csv = const ListToCsvConverter().convert(rows);
    final file = File(path);
    await file.writeAsString(csv);
    return path;
  }

  Future<Directory> _tempDir() async {
    try {
      return await getTemporaryDirectory();
    } on MissingPluginException {
      return Directory.systemTemp;
    }
  }

  String _fileTs() =>
      DateTime.now().toIso8601String().replaceAll(RegExp(r'[:.]'), '-');

  bool _isCompatible(String version) {
    return version.startsWith(AppConstants.exportVersion.split('.').first);
  }
}
