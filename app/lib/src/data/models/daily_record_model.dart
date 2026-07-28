import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_record_model.freezed.dart';
part 'daily_record_model.g.dart';

@freezed
class DailyRecordModel with _$DailyRecordModel {
  const factory DailyRecordModel({
    required String id,
    required String warehouseId,
    required DateTime recordDate,
    String? openingSnapshotId,
    String? closingSnapshotId,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DailyRecordModel;

  factory DailyRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DailyRecordModelFromJson(json);
}
