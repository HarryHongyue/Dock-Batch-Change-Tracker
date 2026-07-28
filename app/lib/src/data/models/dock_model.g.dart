// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DockModelImpl _$$DockModelImplFromJson(Map<String, dynamic> json) =>
    _$DockModelImpl(
      id: json['id'] as String,
      warehouseId: json['warehouseId'] as String,
      name: json['name'] as String,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      colorValue: (json['colorValue'] as num?)?.toInt() ?? 0,
      currentStatus:
          $enumDecodeNullable(_$DockStatusEnumMap, json['currentStatus']) ??
              DockStatus.empty,
      currentBatchId: json['currentBatchId'] as String?,
      note: json['note'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isArchived: json['isArchived'] as bool? ?? false,
    );

Map<String, dynamic> _$$DockModelImplToJson(_$DockModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouseId': instance.warehouseId,
      'name': instance.name,
      'displayOrder': instance.displayOrder,
      'colorValue': instance.colorValue,
      'currentStatus': _$DockStatusEnumMap[instance.currentStatus]!,
      'currentBatchId': instance.currentBatchId,
      'note': instance.note,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isArchived': instance.isArchived,
    };

const _$DockStatusEnumMap = {
  DockStatus.active: 'active',
  DockStatus.paused: 'paused',
  DockStatus.empty: 'empty',
  DockStatus.closed: 'closed',
  DockStatus.blocked: 'blocked',
  DockStatus.maintenance: 'maintenance',
};
