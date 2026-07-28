import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'batch_model.freezed.dart';
part 'batch_model.g.dart';

@freezed
class BatchModel with _$BatchModel {
  const factory BatchModel({
    required String id,
    required String warehouseId,
    required String batchCode,
    String? displayName,
    String? description,
    @Default(BatchStatus.waiting) BatchStatus status,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? updatedAt,
    @Default(false) bool isArchived,
  }) = _BatchModel;

  factory BatchModel.fromJson(Map<String, dynamic> json) =>
      _$BatchModelFromJson(json);
}
