import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'dock_model.freezed.dart';
part 'dock_model.g.dart';

@freezed
class DockModel with _$DockModel {
  const factory DockModel({
    required String id,
    required String warehouseId,
    required String name,
    @Default(0) int displayOrder,
    @Default(0) int colorValue,
    @Default(DockStatus.empty) DockStatus currentStatus,
    String? currentBatchId,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isArchived,
  }) = _DockModel;

  factory DockModel.fromJson(Map<String, dynamic> json) =>
      _$DockModelFromJson(json);
}
