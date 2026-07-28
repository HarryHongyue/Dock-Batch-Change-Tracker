// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BatchModelImpl _$$BatchModelImplFromJson(Map<String, dynamic> json) =>
    _$BatchModelImpl(
      id: json['id'] as String,
      warehouseId: json['warehouseId'] as String,
      batchCode: json['batchCode'] as String,
      displayName: json['displayName'] as String?,
      description: json['description'] as String?,
      status: $enumDecodeNullable(_$BatchStatusEnumMap, json['status']) ??
          BatchStatus.waiting,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isArchived: json['isArchived'] as bool? ?? false,
    );

Map<String, dynamic> _$$BatchModelImplToJson(_$BatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouseId': instance.warehouseId,
      'batchCode': instance.batchCode,
      'displayName': instance.displayName,
      'description': instance.description,
      'status': _$BatchStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isArchived': instance.isArchived,
    };

const _$BatchStatusEnumMap = {
  BatchStatus.waiting: 'waiting',
  BatchStatus.active: 'active',
  BatchStatus.paused: 'paused',
  BatchStatus.completed: 'completed',
  BatchStatus.cancelled: 'cancelled',
  BatchStatus.unknown: 'unknown',
};
