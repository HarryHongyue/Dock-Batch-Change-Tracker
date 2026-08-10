// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyRecordModel _$DailyRecordModelFromJson(Map<String, dynamic> json) {
  return _DailyRecordModel.fromJson(json);
}

/// @nodoc
mixin _$DailyRecordModel {
  String get id => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  DateTime get recordDate => throw _privateConstructorUsedError;
  String? get openingSnapshotId => throw _privateConstructorUsedError;
  String? get closingSnapshotId => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DailyRecordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyRecordModelCopyWith<DailyRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRecordModelCopyWith<$Res> {
  factory $DailyRecordModelCopyWith(
          DailyRecordModel value, $Res Function(DailyRecordModel) then) =
      _$DailyRecordModelCopyWithImpl<$Res, DailyRecordModel>;
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      DateTime recordDate,
      String? openingSnapshotId,
      String? closingSnapshotId,
      String? note,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DailyRecordModelCopyWithImpl<$Res, $Val extends DailyRecordModel>
    implements $DailyRecordModelCopyWith<$Res> {
  _$DailyRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? recordDate = null,
    Object? openingSnapshotId = freezed,
    Object? closingSnapshotId = freezed,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingSnapshotId: freezed == openingSnapshotId
          ? _value.openingSnapshotId
          : openingSnapshotId // ignore: cast_nullable_to_non_nullable
              as String?,
      closingSnapshotId: freezed == closingSnapshotId
          ? _value.closingSnapshotId
          : closingSnapshotId // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyRecordModelImplCopyWith<$Res>
    implements $DailyRecordModelCopyWith<$Res> {
  factory _$$DailyRecordModelImplCopyWith(_$DailyRecordModelImpl value,
          $Res Function(_$DailyRecordModelImpl) then) =
      __$$DailyRecordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String warehouseId,
      DateTime recordDate,
      String? openingSnapshotId,
      String? closingSnapshotId,
      String? note,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$DailyRecordModelImplCopyWithImpl<$Res>
    extends _$DailyRecordModelCopyWithImpl<$Res, _$DailyRecordModelImpl>
    implements _$$DailyRecordModelImplCopyWith<$Res> {
  __$$DailyRecordModelImplCopyWithImpl(_$DailyRecordModelImpl _value,
      $Res Function(_$DailyRecordModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? warehouseId = null,
    Object? recordDate = null,
    Object? openingSnapshotId = freezed,
    Object? closingSnapshotId = freezed,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DailyRecordModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingSnapshotId: freezed == openingSnapshotId
          ? _value.openingSnapshotId
          : openingSnapshotId // ignore: cast_nullable_to_non_nullable
              as String?,
      closingSnapshotId: freezed == closingSnapshotId
          ? _value.closingSnapshotId
          : closingSnapshotId // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyRecordModelImpl implements _DailyRecordModel {
  const _$DailyRecordModelImpl(
      {required this.id,
      required this.warehouseId,
      required this.recordDate,
      this.openingSnapshotId,
      this.closingSnapshotId,
      this.note,
      this.createdAt,
      this.updatedAt});

  factory _$DailyRecordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRecordModelImplFromJson(json);

  @override
  final String id;
  @override
  final String warehouseId;
  @override
  final DateTime recordDate;
  @override
  final String? openingSnapshotId;
  @override
  final String? closingSnapshotId;
  @override
  final String? note;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DailyRecordModel(id: $id, warehouseId: $warehouseId, recordDate: $recordDate, openingSnapshotId: $openingSnapshotId, closingSnapshotId: $closingSnapshotId, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRecordModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.recordDate, recordDate) ||
                other.recordDate == recordDate) &&
            (identical(other.openingSnapshotId, openingSnapshotId) ||
                other.openingSnapshotId == openingSnapshotId) &&
            (identical(other.closingSnapshotId, closingSnapshotId) ||
                other.closingSnapshotId == closingSnapshotId) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, warehouseId, recordDate,
      openingSnapshotId, closingSnapshotId, note, createdAt, updatedAt);

  /// Create a copy of DailyRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRecordModelImplCopyWith<_$DailyRecordModelImpl> get copyWith =>
      __$$DailyRecordModelImplCopyWithImpl<_$DailyRecordModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRecordModelImplToJson(
      this,
    );
  }
}

abstract class _DailyRecordModel implements DailyRecordModel {
  const factory _DailyRecordModel(
      {required final String id,
      required final String warehouseId,
      required final DateTime recordDate,
      final String? openingSnapshotId,
      final String? closingSnapshotId,
      final String? note,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DailyRecordModelImpl;

  factory _DailyRecordModel.fromJson(Map<String, dynamic> json) =
      _$DailyRecordModelImpl.fromJson;

  @override
  String get id;
  @override
  String get warehouseId;
  @override
  DateTime get recordDate;
  @override
  String? get openingSnapshotId;
  @override
  String? get closingSnapshotId;
  @override
  String? get note;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of DailyRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyRecordModelImplCopyWith<_$DailyRecordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
