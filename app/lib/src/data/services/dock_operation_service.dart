import 'dart:convert';

import 'package:drift/drift.dart';

import '../../utils.dart';
import '../database.dart';
import '../models/batch_model.dart';
import '../models/change_event_model.dart';
import '../models/change_session_model.dart';
import '../models/dock_model.dart';
import '../models/snapshot_model.dart';
import '../repositories/batch_repository.dart';
import '../repositories/change_event_repository.dart';
import '../repositories/change_session_repository.dart';
import '../repositories/dock_repository.dart';
import '../repositories/snapshot_repository.dart';
import 'snapshot_service.dart';

class DockOperationService {
  final AppDatabase db;
  final DockRepository _docks;
  final BatchRepository _batches;
  final ChangeSessionRepository _sessions;
  final ChangeEventRepository _events;
  final SnapshotRepository _snapshots;
  final SnapshotService _snapshotService;

  DockOperationService(this.db)
      : _docks = DockRepository(db),
        _batches = BatchRepository(db),
        _sessions = ChangeSessionRepository(db),
        _events = ChangeEventRepository(db),
        _snapshots = SnapshotRepository(db),
        _snapshotService = SnapshotService(db);

  Future<ChangeSessionModel> startChangeSession({
    required String warehouseId,
    String? title,
    String? note,
  }) {
    return db.transaction(() async {
      final beforeSnapshot = await _snapshotService.capture(
        warehouseId: warehouseId,
        type: SnapshotType.beforeChange,
      );
      final session = ChangeSessionModel(
        id: generateId(),
        warehouseId: warehouseId,
        title: title ?? '道口调整',
        note: note,
        status: ChangeSessionStatus.draft,
        beforeSnapshotId: beforeSnapshot.id,
      );
      await _sessions.insert(session);
      return session;
    });
  }

  Future<ChangeSessionModel?> getActiveSession(String warehouseId) =>
      _sessions.getActiveSession(warehouseId);

  Future<ChangeEventModel> addEvent(ChangeEventModel event) {
    return db.transaction(() async {
      final session = await _sessions.getById(event.sessionId);
      if (session == null || session.status != ChangeSessionStatus.draft) {
        throw StateError('只能向草稿变更会话添加事件');
      }
      final nextOrder = await _events.nextOrder(event.sessionId);
      final model = event.copyWith(eventOrder: nextOrder);
      await _events.insert(model);
      await _rebuildState(session.id);
      return model;
    });
  }

  Future<void> undoLastEvent({required String sessionId}) {
    return db.transaction(() async {
      final last = await (db.select(db.changeEvents)
            ..where((t) => t.sessionId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm.desc(t.eventOrder)])
            ..limit(1))
          .getSingleOrNull();
      if (last == null) return;
      await _events.delete(last.id);
      await _rebuildState(sessionId);
    });
  }

  Future<void> commitSession({
    required String sessionId,
    String? note,
  }) {
    return db.transaction(() async {
      final session = await _sessions.getById(sessionId);
      if (session == null) throw StateError('变更会话不存在');

      final afterSnapshot = await _snapshotService.capture(
        warehouseId: session.warehouseId,
        type: SnapshotType.afterChange,
        sessionId: sessionId,
        note: note,
      );

      final updated = session.copyWith(
        status: ChangeSessionStatus.completed,
        completedAt: DateTime.now(),
        note: note ?? session.note,
        afterSnapshotId: afterSnapshot.id,
        updatedAt: DateTime.now(),
      );
      await _sessions.update(updated);
    });
  }

  Future<void> cancelSession({required String sessionId}) {
    return db.transaction(() async {
      final session = await _sessions.getById(sessionId);
      if (session == null) return;

      await _events.deleteBySessionId(sessionId);

      // 恢复变更前状态
      await _rebuildState(sessionId);

      final updated = session.copyWith(
        status: ChangeSessionStatus.cancelled,
        completedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _sessions.update(updated);
    });
  }

  Future<ChangeEventModel> moveBatch({
    required String sessionId,
    required String warehouseId,
    required String sourceDockId,
    required String targetDockId,
    String? batchId,
    String? note,
  }) async {
    final source = await _docks.getById(sourceDockId);
    final target = await _docks.getById(targetDockId);
    if (source == null || target == null) throw ArgumentError('道口不存在');
    if (source.warehouseId != warehouseId || target.warehouseId != warehouseId) {
      throw ArgumentError('道口不属于同一仓库');
    }
    final actualBatchId = batchId ?? source.currentBatchId;
    if (actualBatchId == null) {
      throw StateError('源道口没有批次');
    }
    if (targetDockId == sourceDockId) {
      throw StateError('源道口和目标道口相同');
    }
    if (target.currentBatchId != null && target.currentBatchId != actualBatchId) {
      throw DockOccupiedException(target.name, target.currentBatchId!);
    }

    return addEvent(
      ChangeEventModel(
        id: generateId(),
        sessionId: sessionId,
        warehouseId: warehouseId,
        eventType: EventType.batchMoved,
        batchId: actualBatchId,
        sourceDockId: sourceDockId,
        targetDockId: targetDockId,
        previousDockStatus: source.currentStatus,
        newDockStatus: target.currentStatus,
        previousBatchId: target.currentBatchId,
        newBatchId: actualBatchId,
        note: note,
      ),
    );
  }

  Future<ChangeEventModel> createAndAssignBatch({
    required String sessionId,
    required String warehouseId,
    required String targetDockId,
    required String batchCode,
    String? displayName,
    String? description,
    String? note,
  }) async {
    final target = await _docks.getById(targetDockId);
    if (target == null) throw ArgumentError('目标道口不存在');

    final batch = BatchModel(
      id: generateId(),
      warehouseId: warehouseId,
      batchCode: batchCode,
      displayName: displayName,
      description: description,
      status: BatchStatus.active,
      startedAt: DateTime.now(),
    );
    await _batches.insert(batch);

    return addEvent(
      ChangeEventModel(
        id: generateId(),
        sessionId: sessionId,
        warehouseId: warehouseId,
        eventType: EventType.batchCreated,
        newBatchId: batch.id,
        targetDockId: targetDockId,
        previousBatchId: target.currentBatchId,
        previousDockStatus: target.currentStatus,
        newDockStatus: target.currentStatus,
        note: note,
      ),
    );
  }

  Future<ChangeEventModel> completeBatch({
    required String sessionId,
    required String warehouseId,
    required String batchId,
    String? dockId,
    String? note,
  }) async {
    final batch = await _batches.getById(batchId);
    if (batch == null) throw ArgumentError('批次不存在');

    final dock = dockId != null
        ? await _docks.getById(dockId)
        : (await _findDockForBatch(warehouseId, batchId));
    if (dock == null) throw ArgumentError('无法找到批次所在道口');

    return addEvent(
      ChangeEventModel(
        id: generateId(),
        sessionId: sessionId,
        warehouseId: warehouseId,
        eventType: EventType.batchCompleted,
        batchId: batchId,
        sourceDockId: dock.id,
        previousDockStatus: dock.currentStatus,
        newDockStatus: DockStatus.empty,
        note: note,
      ),
    );
  }

  Future<ChangeEventModel> pauseDock({
    required String sessionId,
    required String warehouseId,
    required String dockId,
    String? note,
  }) async {
    return changeDockStatus(
      sessionId: sessionId,
      warehouseId: warehouseId,
      dockId: dockId,
      newStatus: DockStatus.paused,
      note: note,
    );
  }

  Future<ChangeEventModel> resumeDock({
    required String sessionId,
    required String warehouseId,
    required String dockId,
    String? note,
  }) async {
    return changeDockStatus(
      sessionId: sessionId,
      warehouseId: warehouseId,
      dockId: dockId,
      newStatus: DockStatus.active,
      note: note,
    );
  }

  Future<ChangeEventModel> changeDockStatus({
    required String sessionId,
    required String warehouseId,
    required String dockId,
    required DockStatus newStatus,
    String? note,
  }) async {
    final dock = await _docks.getById(dockId);
    if (dock == null) throw ArgumentError('道口不存在');

    final eventType = newStatus == DockStatus.paused
        ? EventType.dockPaused
        : (dock.currentStatus == DockStatus.paused && newStatus == DockStatus.active
            ? EventType.dockResumed
            : EventType.dockStatusChanged);

    return addEvent(
      ChangeEventModel(
        id: generateId(),
        sessionId: sessionId,
        warehouseId: warehouseId,
        eventType: eventType,
        targetDockId: dockId,
        previousDockStatus: dock.currentStatus,
        newDockStatus: newStatus,
        note: note,
      ),
    );
  }


  Future<void> moveBatchDirect({
    required String warehouseId,
    required String sourceDockId,
    required String targetDockId,
    String? note,
  }) async {
    final source = await _docks.getById(sourceDockId);
    final target = await _docks.getById(targetDockId);
    if (source == null || target == null) throw ArgumentError('道口不存在');
    if (source.warehouseId != warehouseId || target.warehouseId != warehouseId) {
      throw ArgumentError('道口不属于同一仓库');
    }
    final actualBatchId = source.currentBatchId;
    if (actualBatchId == null) throw StateError('源道口没有批次');
    if (targetDockId == sourceDockId) throw StateError('源道口和目标道口相同');
    if (target.currentBatchId != null && target.currentBatchId != actualBatchId) {
      throw DockOccupiedException(target.name, target.currentBatchId!);
    }

    final batch = await _batches.getById(actualBatchId);
    if (batch == null) throw ArgumentError('批次不存在');

    final now = DateTime.now();
    await _docks.update(
      source.copyWith(
        currentBatchId: null,
        currentStatus: source.currentStatus == DockStatus.active
            ? DockStatus.empty
            : source.currentStatus,
        updatedAt: now,
      ),
    );
    await _docks.update(
      target.copyWith(
        currentBatchId: actualBatchId,
        currentStatus: target.currentStatus == DockStatus.empty
            ? DockStatus.active
            : target.currentStatus,
        updatedAt: now,
      ),
    );
    await _batches.update(batch.copyWith(updatedAt: now));

    final sourceNote = note ?? ('批次 ' + batch.batchCode + ' 移动到 ' + target.name);
    await _events.insert(
      ChangeEventModel(
        id: generateId(),
        sessionId: '',
        warehouseId: warehouseId,
        eventType: EventType.batchMoved,
        batchId: actualBatchId,
        sourceDockId: sourceDockId,
        targetDockId: targetDockId,
        previousDockStatus: source.currentStatus,
        newDockStatus: DockStatus.empty,
        previousBatchId: target.currentBatchId,
        newBatchId: actualBatchId,
        note: sourceNote,
        eventTime: now,
      ),
    );
    await _events.insert(
      ChangeEventModel(
        id: generateId(),
        sessionId: '',
        warehouseId: warehouseId,
        eventType: EventType.batchMoved,
        batchId: actualBatchId,
        sourceDockId: sourceDockId,
        targetDockId: targetDockId,
        previousDockStatus: target.currentStatus,
        newDockStatus: target.currentStatus == DockStatus.empty
            ? DockStatus.active
            : target.currentStatus,
        previousBatchId: target.currentBatchId,
        newBatchId: actualBatchId,
        note: '从 ' + source.name + ' 接收批次 ' + batch.batchCode,
        eventTime: now,
      ),
    );
  }

  Future<BatchModel> modifyBatchDirect({
    required String warehouseId,
    required String dockId,
    required String batchCode,
    String? displayName,
    String? description,
    String? note,
  }) async {
    final dock = await _docks.getById(dockId);
    if (dock == null) throw ArgumentError('道口不存在');
    if (dock.warehouseId != warehouseId) throw ArgumentError('道口不属于该仓库');

    final oldBatch = dock.currentBatchId != null
        ? await _batches.getById(dock.currentBatchId!)
        : null;
    final now = DateTime.now();

    if (oldBatch != null) {
      await _batches.update(
        oldBatch.copyWith(
          isArchived: true,
          status: BatchStatus.completed,
          completedAt: now,
          updatedAt: now,
        ),
      );
    }

    final newBatch = BatchModel(
      id: generateId(),
      warehouseId: warehouseId,
      batchCode: batchCode,
      displayName: displayName,
      description: description,
      status: BatchStatus.active,
      startedAt: now,
      createdAt: now,
      updatedAt: now,
    );
    await _batches.insert(newBatch);

    await _docks.update(
      dock.copyWith(
        currentBatchId: newBatch.id,
        currentStatus: DockStatus.active,
        updatedAt: now,
      ),
    );

    await _events.insert(
      ChangeEventModel(
        id: generateId(),
        sessionId: '',
        warehouseId: warehouseId,
        eventType: EventType.batchModified,
        batchId: oldBatch?.id ?? newBatch.id,
        sourceDockId: dockId,
        targetDockId: dockId,
        previousBatchId: oldBatch?.id,
        newBatchId: newBatch.id,
        note: note ?? (oldBatch != null
            ? ('批次由 ' + oldBatch.batchCode + ' 改为 ' + newBatch.batchCode + '，旧批次已归档')
            : ('新增批次 ' + newBatch.batchCode)),
        eventTime: now,
      ),
    );

    return newBatch;
  }

  Future<void> changeDockStatusDirect({
    required String warehouseId,
    required String dockId,
    required DockStatus newStatus,
    String? note,
  }) async {
    final dock = await _docks.getById(dockId);
    if (dock == null) throw ArgumentError('道口不存在');

    final now = DateTime.now();
    await _docks.update(
      dock.copyWith(
        currentStatus: newStatus,
        updatedAt: now,
      ),
    );

    final eventType = newStatus == DockStatus.paused
        ? EventType.dockPaused
        : (dock.currentStatus == DockStatus.paused &&
                newStatus == DockStatus.active
            ? EventType.dockResumed
            : EventType.statusChanged);

    await _events.insert(
      ChangeEventModel(
        id: generateId(),
        sessionId: '',
        warehouseId: warehouseId,
        eventType: eventType,
        targetDockId: dockId,
        previousDockStatus: dock.currentStatus,
        newDockStatus: newStatus,
        note: note ?? (newStatus == DockStatus.paused
            ? (dock.name + ' 已暂停')
            : (dock.name + ' 已恢复')),
        eventTime: now,
      ),
    );
  }


  Future<ChangeSessionModel> correctEvent({
    required String warehouseId,
    required String eventId,
    String? note,
  }) async {
    final original = await _events.getById(eventId);
    if (original == null) throw ArgumentError('事件不存在');

    final session = await startChangeSession(
      warehouseId: warehouseId,
      title: '更正操作',
      note: '更正 ${original.eventType.name} $eventId',
    );

    switch (original.eventType) {
      case EventType.batchMoved:
        if (original.sourceDockId != null && original.targetDockId != null) {
          await addEvent(
            ChangeEventModel(
              id: generateId(),
              sessionId: session.id,
              warehouseId: warehouseId,
              eventType: EventType.batchMoved,
              batchId: original.batchId,
              sourceDockId: original.targetDockId!,
              targetDockId: original.sourceDockId!,
              previousDockStatus: original.newDockStatus,
              newDockStatus: original.previousDockStatus,
              previousBatchId: original.newBatchId,
              newBatchId: original.batchId,
              note: note ?? '更正移动',
            ),
          );
        }
        break;
      case EventType.batchesSwapped:
        if (original.sourceDockId != null && original.targetDockId != null) {
          await addEvent(
            ChangeEventModel(
              id: generateId(),
              sessionId: session.id,
              warehouseId: warehouseId,
              eventType: EventType.batchesSwapped,
              sourceDockId: original.targetDockId!,
              targetDockId: original.sourceDockId!,
              previousBatchId: original.newBatchId,
              newBatchId: original.previousBatchId,
              note: note ?? '更正交换',
            ),
          );
        }
        break;
      case EventType.batchCompleted:
        if (original.batchId != null) {
          // 重新激活批次并放回道口
          await addEvent(
            ChangeEventModel(
              id: generateId(),
              sessionId: session.id,
              warehouseId: warehouseId,
              eventType: EventType.correction,
              batchId: original.batchId,
              sourceDockId: original.sourceDockId,
              targetDockId: original.sourceDockId,
              previousDockStatus: DockStatus.empty,
              newDockStatus: original.previousDockStatus,
              previousBatchId: original.batchId,
              newBatchId: original.batchId,
              note: note ?? '更正完成',
            ),
          );
        }
        break;
      default:
        await addEvent(
          ChangeEventModel(
            id: generateId(),
            sessionId: session.id,
            warehouseId: warehouseId,
            eventType: EventType.correction,
            batchId: original.batchId,
            sourceDockId: original.sourceDockId,
            targetDockId: original.targetDockId,
            previousBatchId: original.previousBatchId,
            newBatchId: original.newBatchId,
            note: note ?? '更正',
          ),
        );
    }

    await commitSession(sessionId: session.id);
    return session;
  }

  Future<DockModel?> _findDockForBatch(String warehouseId, String batchId) async {
    final docks = await _docks.getByWarehouseId(warehouseId);
    return docks.cast<DockModel?>().firstWhere(
          (d) => d?.currentBatchId == batchId,
          orElse: () => null,
        );
  }

  Future<void> _rebuildState(String sessionId) async {
    final session = await _sessions.getById(sessionId);
    if (session == null) return;

    SnapshotModel? before;
    if (session.beforeSnapshotId != null) {
      before = await _snapshots.getById(session.beforeSnapshotId!);
    }
    final snapshot = before ??
        await _snapshotService.capture(
          warehouseId: session.warehouseId,
          type: SnapshotType.automatic,
        );

    final (dockStates, batchStates) = await _buildStateFromSnapshot(snapshot);

    final events = await _events.getBySessionId(sessionId);
    for (final event in events) {
      _applyEvent(dockStates, batchStates, event);
    }

    await _persistState(session.warehouseId, dockStates, batchStates);
  }

  Future<(Map<String, _DockState>, Map<String, _BatchState>)>
      _buildStateFromSnapshot(SnapshotModel snapshot) async {
    final json = jsonDecode(snapshot.snapshotJson) as Map<String, dynamic>;
    final docksList = (json['docks'] as List<dynamic>?)
            ?.map((e) => DockModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    final batchesList = (json['batches'] as List<dynamic>?)
            ?.map((e) => BatchModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final dockStates = <String, _DockState>{};
    for (final d in docksList) {
      dockStates[d.id] = _DockState.fromModel(d);
    }

    final batchStates = <String, _BatchState>{};
    for (final b in batchesList) {
      batchStates[b.id] = _BatchState.fromModel(b);
    }

    return (dockStates, batchStates);
  }

  void _applyEvent(
    Map<String, _DockState> dockStates,
    Map<String, _BatchState> batchStates,
    ChangeEventModel event,
  ) {
    final source = event.sourceDockId != null ? dockStates[event.sourceDockId!] : null;
    final target = event.targetDockId != null ? dockStates[event.targetDockId!] : null;

    switch (event.eventType) {
      case EventType.batchCreated:
      case EventType.batchAssigned:
        if (event.newBatchId != null) {
          if (!batchStates.containsKey(event.newBatchId)) {
            batchStates[event.newBatchId!] = _BatchState(
              id: event.newBatchId!,
              batchCode: event.newBatchId!,
              status: BatchStatus.active,
              startedAt: event.eventTime ?? DateTime.now(),
            );
          }
          batchStates[event.newBatchId!] =
              batchStates[event.newBatchId!]!.copyWith(status: BatchStatus.active);
        }
        if (target != null && event.newBatchId != null) {
          target.batchId = event.newBatchId;
        }
        if (source != null && event.sourceDockId == event.targetDockId) {
          // assign to same dock, nothing special
        }
        break;
      case EventType.batchMoved:
        if (source != null) {
          source.batchId = null;
          if (source.status == DockStatus.active) {
            source.status = DockStatus.empty;
          }
        }
        if (target != null && event.batchId != null) {
          target.batchId = event.batchId;
          if (target.status == DockStatus.empty) {
            target.status = DockStatus.active;
          }
        }
        break;
      case EventType.batchesSwapped:
        if (source != null && target != null) {
          final tmp = source.batchId;
          source.batchId = target.batchId;
          target.batchId = tmp;
        }
        break;
      case EventType.batchCompleted:
        if (event.batchId != null && batchStates.containsKey(event.batchId)) {
          batchStates[event.batchId!] = batchStates[event.batchId!]!.copyWith(
            status: BatchStatus.completed,
            completedAt: event.eventTime ?? DateTime.now(),
          );
        }
        if (source != null) {
          source.batchId = null;
          source.status = DockStatus.empty;
        }
        break;
      case EventType.batchPaused:
        if (event.batchId != null && batchStates.containsKey(event.batchId)) {
          batchStates[event.batchId!] =
              batchStates[event.batchId!]!.copyWith(status: BatchStatus.paused);
        }
        break;
      case EventType.batchResumed:
        if (event.batchId != null && batchStates.containsKey(event.batchId)) {
          batchStates[event.batchId!] =
              batchStates[event.batchId!]!.copyWith(status: BatchStatus.active);
        }
        break;
      case EventType.batchRemoved:
        if (source != null) {
          source.batchId = null;
        }
        if (event.batchId != null && batchStates.containsKey(event.batchId)) {
          batchStates[event.batchId!] =
              batchStates[event.batchId!]!.copyWith(status: BatchStatus.cancelled);
        }
        break;
      case EventType.dockPaused:
      case EventType.dockResumed:
      case EventType.dockStatusChanged:
        if (target != null && event.newDockStatus != null) {
          target.status = event.newDockStatus!;
        }
        break;
      case EventType.dockCreated:
      case EventType.dockRenamed:
        if (target != null && event.newBatchId != null) {
          target.name = event.newBatchId!;
        }
        break;
      case EventType.correction:
        // Correction events are already the reverse operation in most cases.
        // For a generic correction, attempt to set target to previous state.
        if (target != null && event.newDockStatus != null) {
          target.status = event.newDockStatus!;
        }
        if (target != null && event.newBatchId != null) {
          target.batchId = event.newBatchId;
        }
        if (event.batchId != null && batchStates.containsKey(event.batchId)) {
          batchStates[event.batchId!] =
              batchStates[event.batchId!]!.copyWith(status: BatchStatus.active);
        }
        break;
      case EventType.batchModified:
      case EventType.batchReceived:
      case EventType.statusChanged:
        break;
      case EventType.manualNote:
        break;
    }
  }

  Future<void> _persistState(
    String warehouseId,
    Map<String, _DockState> dockStates,
    Map<String, _BatchState> batchStates,
  ) async {
    final now = DateTime.now();
    for (final entry in dockStates.entries) {
      final existing = await _docks.getById(entry.key);
      if (existing != null) {
        await _docks.update(
          existing.copyWith(
            currentStatus: entry.value.status,
            currentBatchId: entry.value.batchId,
            updatedAt: now,
          ),
        );
      }
    }

    for (final entry in batchStates.entries) {
      final existing = await _batches.getById(entry.key);
      if (existing != null) {
        await _batches.update(
          existing.copyWith(
            status: entry.value.status,
            completedAt: entry.value.completedAt,
            updatedAt: now,
          ),
        );
      } else if (entry.value.batchCode.isNotEmpty) {
        await _batches.insert(
          BatchModel(
            id: entry.value.id,
            warehouseId: warehouseId,
            batchCode: entry.value.batchCode,
            displayName: entry.value.displayName,
            description: entry.value.description,
            status: entry.value.status,
            startedAt: entry.value.startedAt,
            completedAt: entry.value.completedAt,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    }
  }
}

class DockOccupiedException implements Exception {
  final String dockName;
  final String batchId;
  DockOccupiedException(this.dockName, this.batchId);

  @override
  String toString() => '目标道口 $dockName 已被批次 $batchId 占用';
}

class _DockState {
  String id;
  String name;
  int displayOrder;
  int colorValue;
  DockStatus status;
  String? batchId;
  String? note;

  _DockState({
    required this.id,
    required this.name,
    this.displayOrder = 0,
    this.colorValue = 0,
    this.status = DockStatus.empty,
    this.batchId,
    this.note,
  });

  factory _DockState.fromModel(DockModel m) => _DockState(
        id: m.id,
        name: m.name,
        displayOrder: m.displayOrder,
        colorValue: m.colorValue,
        status: m.currentStatus,
        batchId: m.currentBatchId,
        note: m.note,
      );
}

class _BatchState {
  String id;
  String batchCode;
  String? displayName;
  String? description;
  BatchStatus status;
  DateTime? startedAt;
  DateTime? completedAt;

  _BatchState({
    required this.id,
    required this.batchCode,
    this.displayName,
    this.description,
    this.status = BatchStatus.unknown,
    this.startedAt,
    this.completedAt,
  });

  factory _BatchState.fromModel(BatchModel m) => _BatchState(
        id: m.id,
        batchCode: m.batchCode,
        displayName: m.displayName,
        description: m.description,
        status: m.status,
        startedAt: m.startedAt,
        completedAt: m.completedAt,
      );

  _BatchState copyWith({
    BatchStatus? status,
    DateTime? completedAt,
  }) =>
      _BatchState(
        id: id,
        batchCode: batchCode,
        displayName: displayName,
        description: description,
        status: status ?? this.status,
        startedAt: startedAt,
        completedAt: completedAt ?? this.completedAt,
      );
}
