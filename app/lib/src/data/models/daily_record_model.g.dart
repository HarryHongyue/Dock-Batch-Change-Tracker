// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRecordModelImpl _$$DailyRecordModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyRecordModelImpl(
      id: json['id'] as String,
      warehouseId: json['warehouseId'] as String,
      recordDate: DateTime.parse(json['recordDate'] as String),
      openingSnapshotId: json['openingSnapshotId'] as String?,
      closingSnapshotId: json['closingSnapshotId'] as String?,
      note: json['note'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DailyRecordModelImplToJson(
        _$DailyRecordModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouseId': instance.warehouseId,
      'recordDate': instance.recordDate.toIso8601String(),
      'openingSnapshotId': instance.openingSnapshotId,
      'closingSnapshotId': instance.closingSnapshotId,
      'note': instance.note,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
