// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangeEventModelImpl _$$ChangeEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeEventModelImpl(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      warehouseId: json['warehouseId'] as String,
      eventType: $enumDecodeNullable(_$EventTypeEnumMap, json['eventType']) ??
          EventType.manualNote,
      batchId: json['batchId'] as String?,
      sourceDockId: json['sourceDockId'] as String?,
      targetDockId: json['targetDockId'] as String?,
      previousDockStatus:
          $enumDecodeNullable(_$DockStatusEnumMap, json['previousDockStatus']),
      newDockStatus:
          $enumDecodeNullable(_$DockStatusEnumMap, json['newDockStatus']),
      previousBatchId: json['previousBatchId'] as String?,
      newBatchId: json['newBatchId'] as String?,
      note: json['note'] as String?,
      eventOrder: (json['eventOrder'] as num?)?.toInt() ?? 0,
      eventTime: json['eventTime'] == null
          ? null
          : DateTime.parse(json['eventTime'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChangeEventModelImplToJson(
        _$ChangeEventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'warehouseId': instance.warehouseId,
      'eventType': _$EventTypeEnumMap[instance.eventType]!,
      'batchId': instance.batchId,
      'sourceDockId': instance.sourceDockId,
      'targetDockId': instance.targetDockId,
      'previousDockStatus': _$DockStatusEnumMap[instance.previousDockStatus],
      'newDockStatus': _$DockStatusEnumMap[instance.newDockStatus],
      'previousBatchId': instance.previousBatchId,
      'newBatchId': instance.newBatchId,
      'note': instance.note,
      'eventOrder': instance.eventOrder,
      'eventTime': instance.eventTime?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.batchCreated: 'batchCreated',
  EventType.batchAssigned: 'batchAssigned',
  EventType.batchMoved: 'batchMoved',
  EventType.batchesSwapped: 'batchesSwapped',
  EventType.batchCompleted: 'batchCompleted',
  EventType.batchPaused: 'batchPaused',
  EventType.batchResumed: 'batchResumed',
  EventType.batchRemoved: 'batchRemoved',
  EventType.dockPaused: 'dockPaused',
  EventType.dockResumed: 'dockResumed',
  EventType.dockStatusChanged: 'dockStatusChanged',
  EventType.dockCreated: 'dockCreated',
  EventType.dockRenamed: 'dockRenamed',
  EventType.correction: 'correction',
  EventType.manualNote: 'manualNote',
};

const _$DockStatusEnumMap = {
  DockStatus.active: 'active',
  DockStatus.paused: 'paused',
  DockStatus.empty: 'empty',
  DockStatus.closed: 'closed',
  DockStatus.blocked: 'blocked',
  DockStatus.maintenance: 'maintenance',
};
