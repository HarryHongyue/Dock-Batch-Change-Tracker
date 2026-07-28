// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangeSessionModelImpl _$$ChangeSessionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeSessionModelImpl(
      id: json['id'] as String,
      warehouseId: json['warehouseId'] as String,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      status:
          $enumDecodeNullable(_$ChangeSessionStatusEnumMap, json['status']) ??
              ChangeSessionStatus.draft,
      title: json['title'] as String?,
      note: json['note'] as String?,
      beforeSnapshotId: json['beforeSnapshotId'] as String?,
      afterSnapshotId: json['afterSnapshotId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChangeSessionModelImplToJson(
        _$ChangeSessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouseId': instance.warehouseId,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'status': _$ChangeSessionStatusEnumMap[instance.status]!,
      'title': instance.title,
      'note': instance.note,
      'beforeSnapshotId': instance.beforeSnapshotId,
      'afterSnapshotId': instance.afterSnapshotId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ChangeSessionStatusEnumMap = {
  ChangeSessionStatus.draft: 'draft',
  ChangeSessionStatus.completed: 'completed',
  ChangeSessionStatus.cancelled: 'cancelled',
  ChangeSessionStatus.corrected: 'corrected',
};
