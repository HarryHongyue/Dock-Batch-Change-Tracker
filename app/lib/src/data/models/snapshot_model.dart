import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'snapshot_model.freezed.dart';
part 'snapshot_model.g.dart';

@freezed
class SnapshotModel with _$SnapshotModel {
  const factory SnapshotModel({
    required String id,
    required String warehouseId,
    String? sessionId,
    @Default(SnapshotType.manual) SnapshotType snapshotType,
    DateTime? snapshotTime,
    required String snapshotJson,
    DateTime? createdAt,
  }) = _SnapshotModel;

  factory SnapshotModel.fromJson(Map<String, dynamic> json) =>
      _$SnapshotModelFromJson(json);
}
