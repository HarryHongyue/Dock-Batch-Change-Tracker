// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangeEventModel _$ChangeEventModelFromJson(Map<String, dynamic> json) {
  return _ChangeEventModel.fromJson(json);
}

/// @nodoc
mixin _$ChangeEventModel {
  String get id => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  String? get batchId => throw _privateConstructorUsedError;
  String? get sourceDockId => throw _privateConstructorUsedError;
  String? get targetDockId => throw _privateConstructorUsedError;
  DockStatus? get previousDockStatus => throw _privateConstructorUsedError;
  DockStatus? get newDockStatus => throw _privateConstructorUsedError;
  String? get previousBatchId => throw _privateConstructorUsedError;
  String? get newBatchId => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int get eventOrder => throw _privateConstructorUsedError;
  DateTime? get eventTime => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChangeEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeEventModelCopyWith<ChangeEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeEventModelCopyWith<$Res> {
  factory $ChangeEventModelCopyWith(
          ChangeEventModel value, $Res Function(ChangeEventModel) then) =
      _$ChangeEventModelCopyWithImpl<$Res, ChangeEventModel>;
  @useResult
  $Res call(
      {String id,
      String sessionId,
      String warehouseId,
      EventType eventType,
      String? batchId,
      String? sourceDockId,
      String? targetDockId,
      DockStatus? previousDockStatus,
      DockStatus? newDockStatus,
      String? previousBatchId,
      String? newBatchId,
      String? note,
      int eventOrder,
      DateTime? eventTime,
      DateTime? createdAt});
}

/// @nodoc
class _$ChangeEventModelCopyWithImpl<$Res, $Val extends ChangeEventModel>
    implements $ChangeEventModelCopyWith<$Res> {
  _$ChangeEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? warehouseId = null,
    Object? eventType = null,
    Object? batchId = freezed,
    Object? sourceDockId = freezed,
    Object? targetDockId = freezed,
    Object? previousDockStatus = freezed,
    Object? newDockStatus = freezed,
    Object? previousBatchId = freezed,
    Object? newBatchId = freezed,
    Object? note = freezed,
    Object? eventOrder = null,
    Object? eventTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceDockId: freezed == sourceDockId
          ? _value.sourceDockId
          : sourceDockId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDockId: freezed == targetDockId
          ? _value.targetDockId
          : targetDockId // ignore: cast_nullable_to_non_nullable
              as String?,
      previousDockStatus: freezed == previousDockStatus
          ? _value.previousDockStatus
          : previousDockStatus // ignore: cast_nullable_to_non_nullable
              as DockStatus?,
      newDockStatus: freezed == newDockStatus
          ? _value.newDockStatus
          : newDockStatus // ignore: cast_nullable_to_non_nullable
              as DockStatus?,
      previousBatchId: freezed == previousBatchId
          ? _value.previousBatchId
          : previousBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      newBatchId: freezed == newBatchId
          ? _value.newBatchId
          : newBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      eventOrder: null == eventOrder
          ? _value.eventOrder
          : eventOrder // ignore: cast_nullable_to_non_nullable
              as int,
      eventTime: freezed == eventTime
          ? _value.eventTime
          : eventTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeEventModelImplCopyWith<$Res>
    implements $ChangeEventModelCopyWith<$Res> {
  factory _$$ChangeEventModelImplCopyWith(_$ChangeEventModelImpl value,
          $Res Function(_$ChangeEventModelImpl) then) =
      __$$ChangeEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sessionId,
      String warehouseId,
      EventType eventType,
      String? batchId,
      String? sourceDockId,
      String? targetDockId,
      DockStatus? previousDockStatus,
      DockStatus? newDockStatus,
      String? previousBatchId,
      String? newBatchId,
      String? note,
      int eventOrder,
      DateTime? eventTime,
      DateTime? createdAt});
}

/// @nodoc
class __$$ChangeEventModelImplCopyWithImpl<$Res>
    extends _$ChangeEventModelCopyWithImpl<$Res, _$ChangeEventModelImpl>
    implements _$$ChangeEventModelImplCopyWith<$Res> {
  __$$ChangeEventModelImplCopyWithImpl(_$ChangeEventModelImpl _value,
      $Res Function(_$ChangeEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? warehouseId = null,
    Object? eventType = null,
    Object? batchId = freezed,
    Object? sourceDockId = freezed,
    Object? targetDockId = freezed,
    Object? previousDockStatus = freezed,
    Object? newDockStatus = freezed,
    Object? previousBatchId = freezed,
    Object? newBatchId = freezed,
    Object? note = freezed,
    Object? eventOrder = null,
    Object? eventTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChangeEventModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceDockId: freezed == sourceDockId
          ? _value.sourceDockId
          : sourceDockId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDockId: freezed == targetDockId
          ? _value.targetDockId
          : targetDockId // ignore: cast_nullable_to_non_nullable
              as String?,
      previousDockStatus: freezed == previousDockStatus
          ? _value.previousDockStatus
          : previousDockStatus // ignore: cast_nullable_to_non_nullable
              as DockStatus?,
      newDockStatus: freezed == newDockStatus
          ? _value.newDockStatus
          : newDockStatus // ignore: cast_nullable_to_non_nullable
              as DockStatus?,
      previousBatchId: freezed == previousBatchId
          ? _value.previousBatchId
          : previousBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      newBatchId: freezed == newBatchId
          ? _value.newBatchId
          : newBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      eventOrder: null == eventOrder
          ? _value.eventOrder
          : eventOrder // ignore: cast_nullable_to_non_nullable
              as int,
      eventTime: freezed == eventTime
          ? _value.eventTime
          : eventTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeEventModelImpl implements _ChangeEventModel {
  const _$ChangeEventModelImpl(
      {required this.id,
      required this.sessionId,
      required this.warehouseId,
      this.eventType = EventType.manualNote,
      this.batchId,
      this.sourceDockId,
      this.targetDockId,
      this.previousDockStatus,
      this.newDockStatus,
      this.previousBatchId,
      this.newBatchId,
      this.note,
      this.eventOrder = 0,
      this.eventTime,
      this.createdAt});

  factory _$ChangeEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeEventModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sessionId;
  @override
  final String warehouseId;
  @override
  @JsonKey()
  final EventType eventType;
  @override
  final String? batchId;
  @override
  final String? sourceDockId;
  @override
  final String? targetDockId;
  @override
  final DockStatus? previousDockStatus;
  @override
  final DockStatus? newDockStatus;
  @override
  final String? previousBatchId;
  @override
  final String? newBatchId;
  @override
  final String? note;
  @override
  @JsonKey()
  final int eventOrder;
  @override
  final DateTime? eventTime;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChangeEventModel(id: $id, sessionId: $sessionId, warehouseId: $warehouseId, eventType: $eventType, batchId: $batchId, sourceDockId: $sourceDockId, targetDockId: $targetDockId, previousDockStatus: $previousDockStatus, newDockStatus: $newDockStatus, previousBatchId: $previousBatchId, newBatchId: $newBatchId, note: $note, eventOrder: $eventOrder, eventTime: $eventTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeEventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.sourceDockId, sourceDockId) ||
                other.sourceDockId == sourceDockId) &&
            (identical(other.targetDockId, targetDockId) ||
                other.targetDockId == targetDockId) &&
            (identical(other.previousDockStatus, previousDockStatus) ||
                other.previousDockStatus == previousDockStatus) &&
            (identical(other.newDockStatus, newDockStatus) ||
                other.newDockStatus == newDockStatus) &&
            (identical(other.previousBatchId, previousBatchId) ||
                other.previousBatchId == previousBatchId) &&
            (identical(other.newBatchId, newBatchId) ||
                other.newBatchId == newBatchId) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.eventOrder, eventOrder) ||
                other.eventOrder == eventOrder) &&
            (identical(other.eventTime, eventTime) ||
                other.eventTime == eventTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sessionId,
      warehouseId,
      eventType,
      batchId,
      sourceDockId,
      targetDockId,
      previousDockStatus,
      newDockStatus,
      previousBatchId,
      newBatchId,
      note,
      eventOrder,
      eventTime,
      createdAt);

  /// Create a copy of ChangeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeEventModelImplCopyWith<_$ChangeEventModelImpl> get copyWith =>
      __$$ChangeEventModelImplCopyWithImpl<_$ChangeEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeEventModelImplToJson(
      this,
    );
  }
}

abstract class _ChangeEventModel implements ChangeEventModel {
  const factory _ChangeEventModel(
      {required final String id,
      required final String sessionId,
      required final String warehouseId,
      final EventType eventType,
      final String? batchId,
      final String? sourceDockId,
      final String? targetDockId,
      final DockStatus? previousDockStatus,
      final DockStatus? newDockStatus,
      final String? previousBatchId,
      final String? newBatchId,
      final String? note,
      final int eventOrder,
      final DateTime? eventTime,
      final DateTime? createdAt}) = _$ChangeEventModelImpl;

  factory _ChangeEventModel.fromJson(Map<String, dynamic> json) =
      _$ChangeEventModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sessionId;
  @override
  String get warehouseId;
  @override
  EventType get eventType;
  @override
  String? get batchId;
  @override
  String? get sourceDockId;
  @override
  String? get targetDockId;
  @override
  DockStatus? get previousDockStatus;
  @override
  DockStatus? get newDockStatus;
  @override
  String? get previousBatchId;
  @override
  String? get newBatchId;
  @override
  String? get note;
  @override
  int get eventOrder;
  @override
  DateTime? get eventTime;
  @override
  DateTime? get createdAt;

  /// Create a copy of ChangeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeEventModelImplCopyWith<_$ChangeEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
