// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseModel _$WarehouseModelFromJson(Map<String, dynamic> json) {
  return _WarehouseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;

  /// Serializes this WarehouseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WarehouseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WarehouseModelCopyWith<WarehouseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseModelCopyWith<$Res> {
  factory $WarehouseModelCopyWith(
          WarehouseModel value, $Res Function(WarehouseModel) then) =
      _$WarehouseModelCopyWithImpl<$Res, WarehouseModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool isArchived});
}

/// @nodoc
class _$WarehouseModelCopyWithImpl<$Res, $Val extends WarehouseModel>
    implements $WarehouseModelCopyWith<$Res> {
  _$WarehouseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WarehouseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WarehouseModelImplCopyWith<$Res>
    implements $WarehouseModelCopyWith<$Res> {
  factory _$$WarehouseModelImplCopyWith(_$WarehouseModelImpl value,
          $Res Function(_$WarehouseModelImpl) then) =
      __$$WarehouseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool isArchived});
}

/// @nodoc
class __$$WarehouseModelImplCopyWithImpl<$Res>
    extends _$WarehouseModelCopyWithImpl<$Res, _$WarehouseModelImpl>
    implements _$$WarehouseModelImplCopyWith<$Res> {
  __$$WarehouseModelImplCopyWithImpl(
      _$WarehouseModelImpl _value, $Res Function(_$WarehouseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WarehouseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_$WarehouseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
class _$WarehouseModelImpl implements _WarehouseModel {
  const _$WarehouseModelImpl(
      {required this.id,
      required this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.isArchived = false});

  factory _$WarehouseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WarehouseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isArchived;

  @override
  String toString() {
    return 'WarehouseModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
      runtimeType, id, name, description, createdAt, updatedAt, isArchived);

  /// Create a copy of WarehouseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseModelImplCopyWith<_$WarehouseModelImpl> get copyWith =>
      __$$WarehouseModelImplCopyWithImpl<_$WarehouseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseModel implements WarehouseModel {
  const factory _WarehouseModel(
      {required final String id,
      required final String name,
      final String? description,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final bool isArchived}) = _$WarehouseModelImpl;

  factory _WarehouseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isArchived;

  /// Create a copy of WarehouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WarehouseModelImplCopyWith<_$WarehouseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
