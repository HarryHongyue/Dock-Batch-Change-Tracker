import 'dart:convert';

import '../../utils.dart';
import '../database.dart';
import '../models/batch_model.dart';
import '../models/dock_model.dart';
import '../models/snapshot_model.dart';
import '../repositories/batch_repository.dart';
import '../repositories/dock_repository.dart';
import '../repositories/snapshot_repository.dart';

class SnapshotService {
  final AppDatabase db;
  final SnapshotRepository _snapshots;
  final DockRepository _docks;
  final BatchRepository _batches;

  SnapshotService(this.db)
      : _snapshots = SnapshotRepository(db),
        _docks = DockRepository(db),
        _batches = BatchRepository(db);

  Future<SnapshotModel> capture({
    required String warehouseId,
    SnapshotType type = SnapshotType.manual,
    String? sessionId,
    String? note,
  }) {
    return db.transaction(() async {
      final docks = await _docks.getByWarehouseId(warehouseId);
      final batches = await _batches.getByWarehouseId(warehouseId);
      final content = SnapshotContent(
        docks: docks,
        batches: batches,
        note: note,
      );
      final snapshot = SnapshotModel(
        id: generateId(),
        warehouseId: warehouseId,
        sessionId: sessionId,
        snapshotType: type,
        snapshotTime: DateTime.now(),
        snapshotJson: jsonEncode(content.toJson()),
      );
      await _snapshots.insert(snapshot);
      return snapshot;
    });
  }

  Future<SnapshotModel?> getById(String id) => _snapshots.getById(id);

  Future<List<SnapshotModel>> getByWarehouseId(String warehouseId) =>
      _snapshots.getByWarehouseId(warehouseId);

  SnapshotDiff compare(SnapshotModel before, SnapshotModel after) {
    final beforeContent = SnapshotContent.fromJson(
        jsonDecode(before.snapshotJson) as Map<String, dynamic>);
    final afterContent = SnapshotContent.fromJson(
        jsonDecode(after.snapshotJson) as Map<String, dynamic>);

    final beforeDocks = _mapById<DockModel>(beforeContent.docks, (d) => d.id);
    final afterDocks = _mapById<DockModel>(afterContent.docks, (d) => d.id);

    final beforeBatches = _mapById<BatchModel>(beforeContent.batches, (b) => b.id);
    final afterBatches = _mapById<BatchModel>(afterContent.batches, (b) => b.id);

    final movedBatches = <String, String?>{};
    for (final after in afterBatches.values) {
      final before = beforeBatches[after.id];
      final beforeDockId = _findDockIdForBatch(beforeDocks, before?.id);
      final afterDockId = _findDockIdForBatch(afterDocks, after.id);
      if (beforeDockId != afterDockId) {
        movedBatches[after.id] = '$beforeDockId → $afterDockId';
      }
    }

    final statusChanges = <String, String>{};
    for (final after in afterDocks.values) {
      final before = beforeDocks[after.id];
      if (before != null && before.currentStatus != after.currentStatus) {
        statusChanges[after.name] =
            '${before.currentStatus.name} → ${after.currentStatus.name}';
      }
    }

    final completedBatches = afterBatches.values
        .where((b) =>
            b.status == BatchStatus.completed &&
            (beforeBatches[b.id]?.status != BatchStatus.completed))
        .map((b) => b.batchCode)
        .toList();

    final newBatches = afterBatches.values
        .where((b) => !beforeBatches.containsKey(b.id))
        .map((b) => b.batchCode)
        .toList();

    return SnapshotDiff(
      newBatches: newBatches,
      completedBatches: completedBatches,
      movedBatches: movedBatches,
      statusChanges: statusChanges,
      beforeTime: before.snapshotTime,
      afterTime: after.snapshotTime,
    );
  }

  Map<String, T> _mapById<T>(List<T> list, String Function(T) keyOf) =>
      {for (final item in list) keyOf(item): item};

  String? _findDockIdForBatch(Map<String, DockModel> docks, String? batchId) {
    if (batchId == null || batchId.isEmpty) return null;
    final dock = docks.values.cast<DockModel?>().firstWhere(
          (d) => d?.currentBatchId == batchId,
          orElse: () => null,
        );
    return dock?.id;
  }
}

class SnapshotContent {
  final List<DockModel> docks;
  final List<BatchModel> batches;
  final String? note;

  SnapshotContent({
    required this.docks,
    required this.batches,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'docks': docks.map((e) => e.toJson()).toList(),
        'batches': batches.map((e) => e.toJson()).toList(),
        'note': note,
      };

  factory SnapshotContent.fromJson(Map<String, dynamic> json) =>
      SnapshotContent(
        docks: (json['docks'] as List<dynamic>?)
                ?.map((e) => DockModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        batches: (json['batches'] as List<dynamic>?)
                ?.map((e) => BatchModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        note: json['note'] as String?,
      );
}

class SnapshotDiff {
  final List<String> newBatches;
  final List<String> completedBatches;
  final Map<String, String?> movedBatches;
  final Map<String, String> statusChanges;
  final DateTime? beforeTime;
  final DateTime? afterTime;

  SnapshotDiff({
    required this.newBatches,
    required this.completedBatches,
    required this.movedBatches,
    required this.statusChanges,
    this.beforeTime,
    this.afterTime,
  });
}
