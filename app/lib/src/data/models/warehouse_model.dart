import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_model.freezed.dart';
part 'warehouse_model.g.dart';

@freezed
class WarehouseModel with _$WarehouseModel {
  const factory WarehouseModel({
    required String id,
    required String name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isArchived,
  }) = _WarehouseModel;

  factory WarehouseModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseModelFromJson(json);
}
