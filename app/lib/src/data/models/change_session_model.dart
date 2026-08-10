import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'change_session_model.freezed.dart';
part 'change_session_model.g.dart';

@freezed
class ChangeSessionModel with _$ChangeSessionModel {
  const factory ChangeSessionModel({
    required String id,
    required String warehouseId,
    DateTime? startedAt,
    DateTime? completedAt,
    @Default(ChangeSessionStatus.draft) ChangeSessionStatus status,
    String? title,
    String? note,
    String? beforeSnapshotId,
    String? afterSnapshotId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChangeSessionModel;

  factory ChangeSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeSessionModelFromJson(json);
}
