// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'batch_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BatchModel _$BatchModelFromJson(Map<String, dynamic> json) {
  return _BatchModel.fromJson(json);
}

/// @nodoc
mixin _$BatchModel {
  String get id => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String get batchCode => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  BatchStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;

  /// Serializes this BatchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchModelCopyWith<BatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchModelCopyWith<$Res> {
  factory $BatchModelCopyWith(
          BatchModel value, $Res Function(BatchModel) then) =
      _$BatchModelCopyWithImpl<$Res, BatchModel>;
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      String batchCode,
      String? displayName,
      String? description,
      BatchStatus status,
      DateTime? createdAt,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? updatedAt,
      bool isArchived});
}

/// @nodoc
class _$BatchModelCopyWithImpl<$Res, $Val extends BatchModel>
    implements $BatchModelCopyWith<$Res> {
  _$BatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? batchCode = null,
    Object? displayName = freezed,
    Object? description = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
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
      batchCode: null == batchCode
          ? _value.batchCode
          : batchCode // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BatchStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$BatchModelImplCopyWith<$Res>
    implements $BatchModelCopyWith<$Res> {
  factory _$$BatchModelImplCopyWith(
          _$BatchModelImpl value, $Res Function(_$BatchModelImpl) then) =
      __$$BatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      String batchCode,
      String? displayName,
      String? description,
      BatchStatus status,
      DateTime? createdAt,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? updatedAt,
      bool isArchived});
}

/// @nodoc
class __$$BatchModelImplCopyWithImpl<$Res>
    extends _$BatchModelCopyWithImpl<$Res, _$BatchModelImpl>
    implements _$$BatchModelImplCopyWith<$Res> {
  __$$BatchModelImplCopyWithImpl(
      _$BatchModelImpl _value, $Res Function(_$BatchModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? batchCode = null,
    Object? displayName = freezed,
    Object? description = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? updatedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_$BatchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      batchCode: null == batchCode
          ? _value.batchCode
          : batchCode // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BatchStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
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
class _$BatchModelImpl implements _BatchModel {
  const _$BatchModelImpl(
      {required this.id,
      required this.warehouseId,
      required this.batchCode,
      this.displayName,
      this.description,
      this.status = BatchStatus.waiting,
      this.createdAt,
      this.startedAt,
      this.completedAt,
      this.updatedAt,
      this.isArchived = false});

  factory _$BatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchModelImplFromJson(json);

  @override
  final String id;
  @override
  final String warehouseId;
  @override
  final String batchCode;
  @override
  final String? displayName;
  @override
  final String? description;
  @override
  @JsonKey()
  final BatchStatus status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isArchived;

  @override
  String toString() {
    return 'BatchModel(id: $id, warehouseId: $warehouseId, batchCode: $batchCode, displayName: $displayName, description: $description, status: $status, createdAt: $createdAt, startedAt: $startedAt, completedAt: $completedAt, updatedAt: $updatedAt, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.batchCode, batchCode) ||
                other.batchCode == batchCode) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
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
      batchCode,
      displayName,
      description,
      status,
      createdAt,
      startedAt,
      completedAt,
      updatedAt,
      isArchived);

  /// Create a copy of BatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchModelImplCopyWith<_$BatchModelImpl> get copyWith =>
      __$$BatchModelImplCopyWithImpl<_$BatchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchModelImplToJson(
      this,
    );
  }
}

abstract class _BatchModel implements BatchModel {
  const factory _BatchModel(
      {required final String id,
      required final String warehouseId,
      required final String batchCode,
      final String? displayName,
      final String? description,
      final BatchStatus status,
      final DateTime? createdAt,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final DateTime? updatedAt,
      final bool isArchived}) = _$BatchModelImpl;

  factory _BatchModel.fromJson(Map<String, dynamic> json) =
      _$BatchModelImpl.fromJson;

  @override
  String get id;
  @override
  String get warehouseId;
  @override
  String get batchCode;
  @override
  String? get displayName;
  @override
  String? get description;
  @override
  BatchStatus get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isArchived;

  /// Create a copy of BatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchModelImplCopyWith<_$BatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
