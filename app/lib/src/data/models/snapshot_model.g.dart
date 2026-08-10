// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snapshot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnapshotModelImpl _$$SnapshotModelImplFromJson(Map<String, dynamic> json) =>
    _$SnapshotModelImpl(
      id: json['id'] as String,
      warehouseId: json['warehouseId'] as String,
      sessionId: json['sessionId'] as String?,
      snapshotType:
          $enumDecodeNullable(_$SnapshotTypeEnumMap, json['snapshotType']) ??
              SnapshotType.manual,
      snapshotTime: json['snapshotTime'] == null
          ? null
          : DateTime.parse(json['snapshotTime'] as String),
      snapshotJson: json['snapshotJson'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SnapshotModelImplToJson(_$SnapshotModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouseId': instance.warehouseId,
      'sessionId': instance.sessionId,
      'snapshotType': _$SnapshotTypeEnumMap[instance.snapshotType]!,
      'snapshotTime': instance.snapshotTime?.toIso8601String(),
      'snapshotJson': instance.snapshotJson,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SnapshotTypeEnumMap = {
  SnapshotType.manual: 'manual',
  SnapshotType.beforeChange: 'beforeChange',
  SnapshotType.afterChange: 'afterChange',
  SnapshotType.daily: 'daily',
  SnapshotType.automatic: 'automatic',
};
