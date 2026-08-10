// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snapshot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnapshotModel _$SnapshotModelFromJson(Map<String, dynamic> json) {
  return _SnapshotModel.fromJson(json);
}

/// @nodoc
mixin _$SnapshotModel {
  String get id => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  SnapshotType get snapshotType => throw _privateConstructorUsedError;
  DateTime? get snapshotTime => throw _privateConstructorUsedError;
  String get snapshotJson => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SnapshotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnapshotModelCopyWith<SnapshotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnapshotModelCopyWith<$Res> {
  factory $SnapshotModelCopyWith(
          SnapshotModel value, $Res Function(SnapshotModel) then) =
      _$SnapshotModelCopyWithImpl<$Res, SnapshotModel>;
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      String? sessionId,
      SnapshotType snapshotType,
      DateTime? snapshotTime,
      String snapshotJson,
      DateTime? createdAt});
}

/// @nodoc
class _$SnapshotModelCopyWithImpl<$Res, $Val extends SnapshotModel>
    implements $SnapshotModelCopyWith<$Res> {
  _$SnapshotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? sessionId = freezed,
    Object? snapshotType = null,
    Object? snapshotTime = freezed,
    Object? snapshotJson = null,
    Object? createdAt = freezed,
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
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      snapshotType: null == snapshotType
          ? _value.snapshotType
          : snapshotType // ignore: cast_nullable_to_non_nullable
              as SnapshotType,
      snapshotTime: freezed == snapshotTime
          ? _value.snapshotTime
          : snapshotTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      snapshotJson: null == snapshotJson
          ? _value.snapshotJson
          : snapshotJson // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnapshotModelImplCopyWith<$Res>
    implements $SnapshotModelCopyWith<$Res> {
  factory _$$SnapshotModelImplCopyWith(
          _$SnapshotModelImpl value, $Res Function(_$SnapshotModelImpl) then) =
      __$$SnapshotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      String? sessionId,
      SnapshotType snapshotType,
      DateTime? snapshotTime,
      String snapshotJson,
      DateTime? createdAt});
}

/// @nodoc
class __$$SnapshotModelImplCopyWithImpl<$Res>
    extends _$SnapshotModelCopyWithImpl<$Res, _$SnapshotModelImpl>
    implements _$$SnapshotModelImplCopyWith<$Res> {
  __$$SnapshotModelImplCopyWithImpl(
      _$SnapshotModelImpl _value, $Res Function(_$SnapshotModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? sessionId = freezed,
    Object? snapshotType = null,
    Object? snapshotTime = freezed,
    Object? snapshotJson = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$SnapshotModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      snapshotType: null == snapshotType
          ? _value.snapshotType
          : snapshotType // ignore: cast_nullable_to_non_nullable
              as SnapshotType,
      snapshotTime: freezed == snapshotTime
          ? _value.snapshotTime
          : snapshotTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      snapshotJson: null == snapshotJson
          ? _value.snapshotJson
          : snapshotJson // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnapshotModelImpl implements _SnapshotModel {
  const _$SnapshotModelImpl(
      {required this.id,
      required this.warehouseId,
      this.sessionId,
      this.snapshotType = SnapshotType.manual,
      this.snapshotTime,
      required this.snapshotJson,
      this.createdAt});

  factory _$SnapshotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnapshotModelImplFromJson(json);

  @override
  final String id;
  @override
  final String warehouseId;
  @override
  final String? sessionId;
  @override
  @JsonKey()
  final SnapshotType snapshotType;
  @override
  final DateTime? snapshotTime;
  @override
  final String snapshotJson;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SnapshotModel(id: $id, warehouseId: $warehouseId, sessionId: $sessionId, snapshotType: $snapshotType, snapshotTime: $snapshotTime, snapshotJson: $snapshotJson, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnapshotModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.snapshotType, snapshotType) ||
                other.snapshotType == snapshotType) &&
            (identical(other.snapshotTime, snapshotTime) ||
                other.snapshotTime == snapshotTime) &&
            (identical(other.snapshotJson, snapshotJson) ||
                other.snapshotJson == snapshotJson) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, warehouseId, sessionId,
      snapshotType, snapshotTime, snapshotJson, createdAt);

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnapshotModelImplCopyWith<_$SnapshotModelImpl> get copyWith =>
      __$$SnapshotModelImplCopyWithImpl<_$SnapshotModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnapshotModelImplToJson(
      this,
    );
  }
}

abstract class _SnapshotModel implements SnapshotModel {
  const factory _SnapshotModel(
      {required final String id,
      required final String warehouseId,
      final String? sessionId,
      final SnapshotType snapshotType,
      final DateTime? snapshotTime,
      required final String snapshotJson,
      final DateTime? createdAt}) = _$SnapshotModelImpl;

  factory _SnapshotModel.fromJson(Map<String, dynamic> json) =
      _$SnapshotModelImpl.fromJson;

  @override
  String get id;
  @override
  String get warehouseId;
  @override
  String? get sessionId;
  @override
  SnapshotType get snapshotType;
  @override
  DateTime? get snapshotTime;
  @override
  String get snapshotJson;
  @override
  DateTime? get createdAt;

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnapshotModelImplCopyWith<_$SnapshotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
