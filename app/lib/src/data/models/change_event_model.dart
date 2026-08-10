import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'change_event_model.freezed.dart';
part 'change_event_model.g.dart';

@freezed
class ChangeEventModel with _$ChangeEventModel {
  const factory ChangeEventModel({
    required String id,
    required String sessionId,
    required String warehouseId,
    @Default(EventType.manualNote) EventType eventType,
    String? batchId,
    String? sourceDockId,
    String? targetDockId,
    DockStatus? previousDockStatus,
    DockStatus? newDockStatus,
    String? previousBatchId,
    String? newBatchId,
    String? note,
    @Default(0) int eventOrder,
    DateTime? eventTime,
    DateTime? createdAt,
  }) = _ChangeEventModel;

  factory ChangeEventModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeEventModelFromJson(json);
}
