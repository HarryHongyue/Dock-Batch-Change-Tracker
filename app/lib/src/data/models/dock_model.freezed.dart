// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dock_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DockModel _$DockModelFromJson(Map<String, dynamic> json) {
  return _DockModel.fromJson(json);
}

/// @nodoc
mixin _$DockModel {
  String get id => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  int get colorValue => throw _privateConstructorUsedError;
  DockStatus get currentStatus => throw _privateConstructorUsedError;
  String? get currentBatchId => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;

  /// Serializes this DockModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DockModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DockModelCopyWith<DockModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DockModelCopyWith<$Res> {
  factory $DockModelCopyWith(DockModel value, $Res Function(DockModel) then) =
      _$DockModelCopyWithImpl<$Res, DockModel>;
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      String name,
      int displayOrder,
      int colorValue,
      DockStatus currentStatus,
      String? currentBatchId,
      String? note,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool isArchived});
}

/// @nodoc
class _$DockModelCopyWithImpl<$Res, $Val extends DockModel>
    implements $DockModelCopyWith<$Res> {
  _$DockModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DockModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? name = null,
    Object? displayOrder = null,
    Object? colorValue = null,
    Object? currentStatus = null,
    Object? currentBatchId = freezed,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentStatus: null == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as DockStatus,
      currentBatchId: freezed == currentBatchId
          ? _value.currentBatchId
          : currentBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DockModelImplCopyWith<$Res>
    implements $DockModelCopyWith<$Res> {
  factory _$$DockModelImplCopyWith(
          _$DockModelImpl value, $Res Function(_$DockModelImpl) then) =
      __$$DockModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      String name,
      int displayOrder,
      int colorValue,
      DockStatus currentStatus,
      String? currentBatchId,
      String? note,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool isArchived});
}

/// @nodoc
class __$$DockModelImplCopyWithImpl<$Res>
    extends _$DockModelCopyWithImpl<$Res, _$DockModelImpl>
    implements _$$DockModelImplCopyWith<$Res> {
  __$$DockModelImplCopyWithImpl(
      _$DockModelImpl _value, $Res Function(_$DockModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DockModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? name = null,
    Object? displayOrder = null,
    Object? colorValue = null,
    Object? currentStatus = null,
    Object? currentBatchId = freezed,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_$DockModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentStatus: null == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as DockStatus,
      currentBatchId: freezed == currentBatchId
          ? _value.currentBatchId
          : currentBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DockModelImpl implements _DockModel {
  const _$DockModelImpl(
      {required this.id,
      required this.warehouseId,
      required this.name,
      this.displayOrder = 0,
      this.colorValue = 0,
      this.currentStatus = DockStatus.empty,
      this.currentBatchId,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.isArchived = false});

  factory _$DockModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DockModelImplFromJson(json);

  @override
  final String id;
  @override
  final String warehouseId;
  @override
  final String name;
  @override
  @JsonKey()
  final int displayOrder;
  @override
  @JsonKey()
  final int colorValue;
  @override
  @JsonKey()
  final DockStatus currentStatus;
  @override
  final String? currentBatchId;
  @override
  final String? note;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isArchived;

  @override
  String toString() {
    return 'DockModel(id: $id, warehouseId: $warehouseId, name: $name, displayOrder: $displayOrder, colorValue: $colorValue, currentStatus: $currentStatus, currentBatchId: $currentBatchId, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DockModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.currentBatchId, currentBatchId) ||
                other.currentBatchId == currentBatchId) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      warehouseId,
      name,
      displayOrder,
      colorValue,
      currentStatus,
      currentBatchId,
      note,
      createdAt,
      updatedAt,
      isArchived);

  /// Create a copy of DockModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DockModelImplCopyWith<_$DockModelImpl> get copyWith =>
      __$$DockModelImplCopyWithImpl<_$DockModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DockModelImplToJson(
      this,
    );
  }
}

abstract class _DockModel implements DockModel {
  const factory _DockModel(
      {required final String id,
      required final String warehouseId,
      required final String name,
      final int displayOrder,
      final int colorValue,
      final DockStatus currentStatus,
      final String? currentBatchId,
      final String? note,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final bool isArchived}) = _$DockModelImpl;

  factory _DockModel.fromJson(Map<String, dynamic> json) =
      _$DockModelImpl.fromJson;

  @override
  String get id;
  @override
  String get warehouseId;
  @override
  String get name;
  @override
  int get displayOrder;
  @override
  int get colorValue;
  @override
  DockStatus get currentStatus;
  @override
  String? get currentBatchId;
  @override
  String? get note;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isArchived;

  /// Create a copy of DockModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DockModelImplCopyWith<_$DockModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
