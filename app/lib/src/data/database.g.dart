// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WarehousesTable extends Warehouses
    with TableInfo<$WarehousesTable, Warehouse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WarehousesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, createdAt, updatedAt, isArchived];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'warehouses';
  @override
  VerificationContext validateIntegrity(Insertable<Warehouse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Warehouse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Warehouse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
    );
  }

  @override
  $WarehousesTable createAlias(String alias) {
    return $WarehousesTable(attachedDatabase, alias);
  }
}

class Warehouse extends DataClass implements Insertable<Warehouse> {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  const Warehouse(
      {required this.id,
      required this.name,
      this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.isArchived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  WarehousesCompanion toCompanion(bool nullToAbsent) {
    return WarehousesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isArchived: Value(isArchived),
    );
  }

  factory Warehouse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Warehouse(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Warehouse copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isArchived}) =>
      Warehouse(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isArchived: isArchived ?? this.isArchived,
      );
  Warehouse copyWithCompanion(WarehousesCompanion data) {
    return Warehouse(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Warehouse(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, createdAt, updatedAt, isArchived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Warehouse &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isArchived == this.isArchived);
}

class WarehousesCompanion extends UpdateCompanion<Warehouse> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const WarehousesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WarehousesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Warehouse> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WarehousesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isArchived,
      Value<int>? rowid}) {
    return WarehousesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WarehousesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocksTable extends Docks with TableInfo<$DocksTable, Dock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currentStatusMeta =
      const VerificationMeta('currentStatus');
  @override
  late final GeneratedColumnWithTypeConverter<DockStatus, String>
      currentStatus = GeneratedColumn<String>(
              'current_status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('empty'))
          .withConverter<DockStatus>($DocksTable.$convertercurrentStatus);
  static const VerificationMeta _currentBatchIdMeta =
      const VerificationMeta('currentBatchId');
  @override
  late final GeneratedColumn<String> currentBatchId = GeneratedColumn<String>(
      'current_batch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
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
        isArchived
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'docks';
  @override
  VerificationContext validateIntegrity(Insertable<Dock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    }
    context.handle(_currentStatusMeta, const VerificationResult.success());
    if (data.containsKey('current_batch_id')) {
      context.handle(
          _currentBatchIdMeta,
          currentBatchId.isAcceptableOrUnknown(
              data['current_batch_id']!, _currentBatchIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dock(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      currentStatus: $DocksTable.$convertercurrentStatus.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}current_status'])!),
      currentBatchId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_batch_id']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
    );
  }

  @override
  $DocksTable createAlias(String alias) {
    return $DocksTable(attachedDatabase, alias);
  }

  static TypeConverter<DockStatus, String> $convertercurrentStatus =
      const DockStatusConverter();
}

class Dock extends DataClass implements Insertable<Dock> {
  final String id;
  final String warehouseId;
  final String name;
  final int displayOrder;
  final int colorValue;
  final DockStatus currentStatus;
  final String? currentBatchId;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  const Dock(
      {required this.id,
      required this.warehouseId,
      required this.name,
      required this.displayOrder,
      required this.colorValue,
      required this.currentStatus,
      this.currentBatchId,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      required this.isArchived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['name'] = Variable<String>(name);
    map['display_order'] = Variable<int>(displayOrder);
    map['color_value'] = Variable<int>(colorValue);
    {
      map['current_status'] = Variable<String>(
          $DocksTable.$convertercurrentStatus.toSql(currentStatus));
    }
    if (!nullToAbsent || currentBatchId != null) {
      map['current_batch_id'] = Variable<String>(currentBatchId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  DocksCompanion toCompanion(bool nullToAbsent) {
    return DocksCompanion(
      id: Value(id),
      warehouseId: Value(warehouseId),
      name: Value(name),
      displayOrder: Value(displayOrder),
      colorValue: Value(colorValue),
      currentStatus: Value(currentStatus),
      currentBatchId: currentBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentBatchId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isArchived: Value(isArchived),
    );
  }

  factory Dock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dock(
      id: serializer.fromJson<String>(json['id']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      name: serializer.fromJson<String>(json['name']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      currentStatus: serializer.fromJson<DockStatus>(json['currentStatus']),
      currentBatchId: serializer.fromJson<String?>(json['currentBatchId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'name': serializer.toJson<String>(name),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'colorValue': serializer.toJson<int>(colorValue),
      'currentStatus': serializer.toJson<DockStatus>(currentStatus),
      'currentBatchId': serializer.toJson<String?>(currentBatchId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Dock copyWith(
          {String? id,
          String? warehouseId,
          String? name,
          int? displayOrder,
          int? colorValue,
          DockStatus? currentStatus,
          Value<String?> currentBatchId = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isArchived}) =>
      Dock(
        id: id ?? this.id,
        warehouseId: warehouseId ?? this.warehouseId,
        name: name ?? this.name,
        displayOrder: displayOrder ?? this.displayOrder,
        colorValue: colorValue ?? this.colorValue,
        currentStatus: currentStatus ?? this.currentStatus,
        currentBatchId:
            currentBatchId.present ? currentBatchId.value : this.currentBatchId,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isArchived: isArchived ?? this.isArchived,
      );
  Dock copyWithCompanion(DocksCompanion data) {
    return Dock(
      id: data.id.present ? data.id.value : this.id,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      name: data.name.present ? data.name.value : this.name,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      currentStatus: data.currentStatus.present
          ? data.currentStatus.value
          : this.currentStatus,
      currentBatchId: data.currentBatchId.present
          ? data.currentBatchId.value
          : this.currentBatchId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dock(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('name: $name, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('colorValue: $colorValue, ')
          ..write('currentStatus: $currentStatus, ')
          ..write('currentBatchId: $currentBatchId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dock &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.name == this.name &&
          other.displayOrder == this.displayOrder &&
          other.colorValue == this.colorValue &&
          other.currentStatus == this.currentStatus &&
          other.currentBatchId == this.currentBatchId &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isArchived == this.isArchived);
}

class DocksCompanion extends UpdateCompanion<Dock> {
  final Value<String> id;
  final Value<String> warehouseId;
  final Value<String> name;
  final Value<int> displayOrder;
  final Value<int> colorValue;
  final Value<DockStatus> currentStatus;
  final Value<String?> currentBatchId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const DocksCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.name = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.currentStatus = const Value.absent(),
    this.currentBatchId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocksCompanion.insert({
    required String id,
    required String warehouseId,
    required String name,
    this.displayOrder = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.currentStatus = const Value.absent(),
    this.currentBatchId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        warehouseId = Value(warehouseId),
        name = Value(name);
  static Insertable<Dock> custom({
    Expression<String>? id,
    Expression<String>? warehouseId,
    Expression<String>? name,
    Expression<int>? displayOrder,
    Expression<int>? colorValue,
    Expression<String>? currentStatus,
    Expression<String>? currentBatchId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (name != null) 'name': name,
      if (displayOrder != null) 'display_order': displayOrder,
      if (colorValue != null) 'color_value': colorValue,
      if (currentStatus != null) 'current_status': currentStatus,
      if (currentBatchId != null) 'current_batch_id': currentBatchId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocksCompanion copyWith(
      {Value<String>? id,
      Value<String>? warehouseId,
      Value<String>? name,
      Value<int>? displayOrder,
      Value<int>? colorValue,
      Value<DockStatus>? currentStatus,
      Value<String?>? currentBatchId,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isArchived,
      Value<int>? rowid}) {
    return DocksCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      name: name ?? this.name,
      displayOrder: displayOrder ?? this.displayOrder,
      colorValue: colorValue ?? this.colorValue,
      currentStatus: currentStatus ?? this.currentStatus,
      currentBatchId: currentBatchId ?? this.currentBatchId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (currentStatus.present) {
      map['current_status'] = Variable<String>(
          $DocksTable.$convertercurrentStatus.toSql(currentStatus.value));
    }
    if (currentBatchId.present) {
      map['current_batch_id'] = Variable<String>(currentBatchId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocksCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('name: $name, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('colorValue: $colorValue, ')
          ..write('currentStatus: $currentStatus, ')
          ..write('currentBatchId: $currentBatchId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatchesTable extends Batches with TableInfo<$BatchesTable, Batche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _batchCodeMeta =
      const VerificationMeta('batchCode');
  @override
  late final GeneratedColumn<String> batchCode = GeneratedColumn<String>(
      'batch_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<BatchStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('waiting'))
          .withConverter<BatchStatus>($BatchesTable.$converterstatus);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
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
        isArchived
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batches';
  @override
  VerificationContext validateIntegrity(Insertable<Batche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('batch_code')) {
      context.handle(_batchCodeMeta,
          batchCode.isAcceptableOrUnknown(data['batch_code']!, _batchCodeMeta));
    } else if (isInserting) {
      context.missing(_batchCodeMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Batche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Batche(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id'])!,
      batchCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}batch_code'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: $BatchesTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
    );
  }

  @override
  $BatchesTable createAlias(String alias) {
    return $BatchesTable(attachedDatabase, alias);
  }

  static TypeConverter<BatchStatus, String> $converterstatus =
      const BatchStatusConverter();
}

class Batche extends DataClass implements Insertable<Batche> {
  final String id;
  final String warehouseId;
  final String batchCode;
  final String? displayName;
  final String? description;
  final BatchStatus status;
  final DateTime createdAt;
  final DateTime startedAt;
  final DateTime? completedAt;
  final DateTime updatedAt;
  final bool isArchived;
  const Batche(
      {required this.id,
      required this.warehouseId,
      required this.batchCode,
      this.displayName,
      this.description,
      required this.status,
      required this.createdAt,
      required this.startedAt,
      this.completedAt,
      required this.updatedAt,
      required this.isArchived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['batch_code'] = Variable<String>(batchCode);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['status'] =
          Variable<String>($BatchesTable.$converterstatus.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  BatchesCompanion toCompanion(bool nullToAbsent) {
    return BatchesCompanion(
      id: Value(id),
      warehouseId: Value(warehouseId),
      batchCode: Value(batchCode),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      createdAt: Value(createdAt),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
      isArchived: Value(isArchived),
    );
  }

  factory Batche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Batche(
      id: serializer.fromJson<String>(json['id']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      batchCode: serializer.fromJson<String>(json['batchCode']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<BatchStatus>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'batchCode': serializer.toJson<String>(batchCode),
      'displayName': serializer.toJson<String?>(displayName),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<BatchStatus>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Batche copyWith(
          {String? id,
          String? warehouseId,
          String? batchCode,
          Value<String?> displayName = const Value.absent(),
          Value<String?> description = const Value.absent(),
          BatchStatus? status,
          DateTime? createdAt,
          DateTime? startedAt,
          Value<DateTime?> completedAt = const Value.absent(),
          DateTime? updatedAt,
          bool? isArchived}) =>
      Batche(
        id: id ?? this.id,
        warehouseId: warehouseId ?? this.warehouseId,
        batchCode: batchCode ?? this.batchCode,
        displayName: displayName.present ? displayName.value : this.displayName,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isArchived: isArchived ?? this.isArchived,
      );
  Batche copyWithCompanion(BatchesCompanion data) {
    return Batche(
      id: data.id.present ? data.id.value : this.id,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      batchCode: data.batchCode.present ? data.batchCode.value : this.batchCode,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Batche(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('batchCode: $batchCode, ')
          ..write('displayName: $displayName, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Batche &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.batchCode == this.batchCode &&
          other.displayName == this.displayName &&
          other.description == this.description &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt &&
          other.isArchived == this.isArchived);
}

class BatchesCompanion extends UpdateCompanion<Batche> {
  final Value<String> id;
  final Value<String> warehouseId;
  final Value<String> batchCode;
  final Value<String?> displayName;
  final Value<String?> description;
  final Value<BatchStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const BatchesCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.batchCode = const Value.absent(),
    this.displayName = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatchesCompanion.insert({
    required String id,
    required String warehouseId,
    required String batchCode,
    this.displayName = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        warehouseId = Value(warehouseId),
        batchCode = Value(batchCode);
  static Insertable<Batche> custom({
    Expression<String>? id,
    Expression<String>? warehouseId,
    Expression<String>? batchCode,
    Expression<String>? displayName,
    Expression<String>? description,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (batchCode != null) 'batch_code': batchCode,
      if (displayName != null) 'display_name': displayName,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatchesCompanion copyWith(
      {Value<String>? id,
      Value<String>? warehouseId,
      Value<String>? batchCode,
      Value<String?>? displayName,
      Value<String?>? description,
      Value<BatchStatus>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? startedAt,
      Value<DateTime?>? completedAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isArchived,
      Value<int>? rowid}) {
    return BatchesCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      batchCode: batchCode ?? this.batchCode,
      displayName: displayName ?? this.displayName,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (batchCode.present) {
      map['batch_code'] = Variable<String>(batchCode.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] =
          Variable<String>($BatchesTable.$converterstatus.toSql(status.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchesCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('batchCode: $batchCode, ')
          ..write('displayName: $displayName, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChangeSessionsTable extends ChangeSessions
    with TableInfo<$ChangeSessionsTable, ChangeSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChangeSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<ChangeSessionStatus, String>
      status = GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('draft'))
          .withConverter<ChangeSessionStatus>(
              $ChangeSessionsTable.$converterstatus);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _beforeSnapshotIdMeta =
      const VerificationMeta('beforeSnapshotId');
  @override
  late final GeneratedColumn<String> beforeSnapshotId = GeneratedColumn<String>(
      'before_snapshot_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _afterSnapshotIdMeta =
      const VerificationMeta('afterSnapshotId');
  @override
  late final GeneratedColumn<String> afterSnapshotId = GeneratedColumn<String>(
      'after_snapshot_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        warehouseId,
        startedAt,
        completedAt,
        status,
        title,
        note,
        beforeSnapshotId,
        afterSnapshotId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'change_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<ChangeSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('before_snapshot_id')) {
      context.handle(
          _beforeSnapshotIdMeta,
          beforeSnapshotId.isAcceptableOrUnknown(
              data['before_snapshot_id']!, _beforeSnapshotIdMeta));
    }
    if (data.containsKey('after_snapshot_id')) {
      context.handle(
          _afterSnapshotIdMeta,
          afterSnapshotId.isAcceptableOrUnknown(
              data['after_snapshot_id']!, _afterSnapshotIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChangeSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChangeSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      status: $ChangeSessionsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      beforeSnapshotId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}before_snapshot_id']),
      afterSnapshotId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}after_snapshot_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChangeSessionsTable createAlias(String alias) {
    return $ChangeSessionsTable(attachedDatabase, alias);
  }

  static TypeConverter<ChangeSessionStatus, String> $converterstatus =
      const ChangeSessionStatusConverter();
}

class ChangeSession extends DataClass implements Insertable<ChangeSession> {
  final String id;
  final String warehouseId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final ChangeSessionStatus status;
  final String? title;
  final String? note;
  final String? beforeSnapshotId;
  final String? afterSnapshotId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChangeSession(
      {required this.id,
      required this.warehouseId,
      required this.startedAt,
      this.completedAt,
      required this.status,
      this.title,
      this.note,
      this.beforeSnapshotId,
      this.afterSnapshotId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    {
      map['status'] =
          Variable<String>($ChangeSessionsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || beforeSnapshotId != null) {
      map['before_snapshot_id'] = Variable<String>(beforeSnapshotId);
    }
    if (!nullToAbsent || afterSnapshotId != null) {
      map['after_snapshot_id'] = Variable<String>(afterSnapshotId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChangeSessionsCompanion toCompanion(bool nullToAbsent) {
    return ChangeSessionsCompanion(
      id: Value(id),
      warehouseId: Value(warehouseId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      beforeSnapshotId: beforeSnapshotId == null && nullToAbsent
          ? const Value.absent()
          : Value(beforeSnapshotId),
      afterSnapshotId: afterSnapshotId == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSnapshotId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChangeSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChangeSession(
      id: serializer.fromJson<String>(json['id']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<ChangeSessionStatus>(json['status']),
      title: serializer.fromJson<String?>(json['title']),
      note: serializer.fromJson<String?>(json['note']),
      beforeSnapshotId: serializer.fromJson<String?>(json['beforeSnapshotId']),
      afterSnapshotId: serializer.fromJson<String?>(json['afterSnapshotId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<ChangeSessionStatus>(status),
      'title': serializer.toJson<String?>(title),
      'note': serializer.toJson<String?>(note),
      'beforeSnapshotId': serializer.toJson<String?>(beforeSnapshotId),
      'afterSnapshotId': serializer.toJson<String?>(afterSnapshotId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChangeSession copyWith(
          {String? id,
          String? warehouseId,
          DateTime? startedAt,
          Value<DateTime?> completedAt = const Value.absent(),
          ChangeSessionStatus? status,
          Value<String?> title = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<String?> beforeSnapshotId = const Value.absent(),
          Value<String?> afterSnapshotId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ChangeSession(
        id: id ?? this.id,
        warehouseId: warehouseId ?? this.warehouseId,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        status: status ?? this.status,
        title: title.present ? title.value : this.title,
        note: note.present ? note.value : this.note,
        beforeSnapshotId: beforeSnapshotId.present
            ? beforeSnapshotId.value
            : this.beforeSnapshotId,
        afterSnapshotId: afterSnapshotId.present
            ? afterSnapshotId.value
            : this.afterSnapshotId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ChangeSession copyWithCompanion(ChangeSessionsCompanion data) {
    return ChangeSession(
      id: data.id.present ? data.id.value : this.id,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      title: data.title.present ? data.title.value : this.title,
      note: data.note.present ? data.note.value : this.note,
      beforeSnapshotId: data.beforeSnapshotId.present
          ? data.beforeSnapshotId.value
          : this.beforeSnapshotId,
      afterSnapshotId: data.afterSnapshotId.present
          ? data.afterSnapshotId.value
          : this.afterSnapshotId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChangeSession(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('beforeSnapshotId: $beforeSnapshotId, ')
          ..write('afterSnapshotId: $afterSnapshotId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      warehouseId,
      startedAt,
      completedAt,
      status,
      title,
      note,
      beforeSnapshotId,
      afterSnapshotId,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChangeSession &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.title == this.title &&
          other.note == this.note &&
          other.beforeSnapshotId == this.beforeSnapshotId &&
          other.afterSnapshotId == this.afterSnapshotId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChangeSessionsCompanion extends UpdateCompanion<ChangeSession> {
  final Value<String> id;
  final Value<String> warehouseId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<ChangeSessionStatus> status;
  final Value<String?> title;
  final Value<String?> note;
  final Value<String?> beforeSnapshotId;
  final Value<String?> afterSnapshotId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChangeSessionsCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.beforeSnapshotId = const Value.absent(),
    this.afterSnapshotId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChangeSessionsCompanion.insert({
    required String id,
    required String warehouseId,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.beforeSnapshotId = const Value.absent(),
    this.afterSnapshotId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        warehouseId = Value(warehouseId);
  static Insertable<ChangeSession> custom({
    Expression<String>? id,
    Expression<String>? warehouseId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<String>? title,
    Expression<String>? note,
    Expression<String>? beforeSnapshotId,
    Expression<String>? afterSnapshotId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
      if (beforeSnapshotId != null) 'before_snapshot_id': beforeSnapshotId,
      if (afterSnapshotId != null) 'after_snapshot_id': afterSnapshotId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChangeSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? warehouseId,
      Value<DateTime>? startedAt,
      Value<DateTime?>? completedAt,
      Value<ChangeSessionStatus>? status,
      Value<String?>? title,
      Value<String?>? note,
      Value<String?>? beforeSnapshotId,
      Value<String?>? afterSnapshotId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ChangeSessionsCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      title: title ?? this.title,
      note: note ?? this.note,
      beforeSnapshotId: beforeSnapshotId ?? this.beforeSnapshotId,
      afterSnapshotId: afterSnapshotId ?? this.afterSnapshotId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $ChangeSessionsTable.$converterstatus.toSql(status.value));
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (beforeSnapshotId.present) {
      map['before_snapshot_id'] = Variable<String>(beforeSnapshotId.value);
    }
    if (afterSnapshotId.present) {
      map['after_snapshot_id'] = Variable<String>(afterSnapshotId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChangeSessionsCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('beforeSnapshotId: $beforeSnapshotId, ')
          ..write('afterSnapshotId: $afterSnapshotId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChangeEventsTable extends ChangeEvents
    with TableInfo<$ChangeEventsTable, ChangeEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChangeEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumnWithTypeConverter<EventType, String> eventType =
      GeneratedColumn<String>('event_type', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('manualNote'))
          .withConverter<EventType>($ChangeEventsTable.$convertereventType);
  static const VerificationMeta _batchIdMeta =
      const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
      'batch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceDockIdMeta =
      const VerificationMeta('sourceDockId');
  @override
  late final GeneratedColumn<String> sourceDockId = GeneratedColumn<String>(
      'source_dock_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetDockIdMeta =
      const VerificationMeta('targetDockId');
  @override
  late final GeneratedColumn<String> targetDockId = GeneratedColumn<String>(
      'target_dock_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _previousDockStatusMeta =
      const VerificationMeta('previousDockStatus');
  @override
  late final GeneratedColumnWithTypeConverter<DockStatus?, String>
      previousDockStatus = GeneratedColumn<String>(
              'previous_dock_status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<DockStatus?>(
              $ChangeEventsTable.$converterpreviousDockStatusn);
  static const VerificationMeta _newDockStatusMeta =
      const VerificationMeta('newDockStatus');
  @override
  late final GeneratedColumnWithTypeConverter<DockStatus?, String>
      newDockStatus = GeneratedColumn<String>(
              'new_dock_status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<DockStatus?>(
              $ChangeEventsTable.$converternewDockStatusn);
  static const VerificationMeta _previousBatchIdMeta =
      const VerificationMeta('previousBatchId');
  @override
  late final GeneratedColumn<String> previousBatchId = GeneratedColumn<String>(
      'previous_batch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _newBatchIdMeta =
      const VerificationMeta('newBatchId');
  @override
  late final GeneratedColumn<String> newBatchId = GeneratedColumn<String>(
      'new_batch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _eventOrderMeta =
      const VerificationMeta('eventOrder');
  @override
  late final GeneratedColumn<int> eventOrder = GeneratedColumn<int>(
      'event_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _eventTimeMeta =
      const VerificationMeta('eventTime');
  @override
  late final GeneratedColumn<DateTime> eventTime = GeneratedColumn<DateTime>(
      'event_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
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
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'change_events';
  @override
  VerificationContext validateIntegrity(Insertable<ChangeEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    context.handle(_eventTypeMeta, const VerificationResult.success());
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta,
          batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    }
    if (data.containsKey('source_dock_id')) {
      context.handle(
          _sourceDockIdMeta,
          sourceDockId.isAcceptableOrUnknown(
              data['source_dock_id']!, _sourceDockIdMeta));
    }
    if (data.containsKey('target_dock_id')) {
      context.handle(
          _targetDockIdMeta,
          targetDockId.isAcceptableOrUnknown(
              data['target_dock_id']!, _targetDockIdMeta));
    }
    context.handle(_previousDockStatusMeta, const VerificationResult.success());
    context.handle(_newDockStatusMeta, const VerificationResult.success());
    if (data.containsKey('previous_batch_id')) {
      context.handle(
          _previousBatchIdMeta,
          previousBatchId.isAcceptableOrUnknown(
              data['previous_batch_id']!, _previousBatchIdMeta));
    }
    if (data.containsKey('new_batch_id')) {
      context.handle(
          _newBatchIdMeta,
          newBatchId.isAcceptableOrUnknown(
              data['new_batch_id']!, _newBatchIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('event_order')) {
      context.handle(
          _eventOrderMeta,
          eventOrder.isAcceptableOrUnknown(
              data['event_order']!, _eventOrderMeta));
    }
    if (data.containsKey('event_time')) {
      context.handle(_eventTimeMeta,
          eventTime.isAcceptableOrUnknown(data['event_time']!, _eventTimeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChangeEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChangeEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id'])!,
      eventType: $ChangeEventsTable.$convertereventType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!),
      batchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}batch_id']),
      sourceDockId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_dock_id']),
      targetDockId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_dock_id']),
      previousDockStatus: $ChangeEventsTable.$converterpreviousDockStatusn
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}previous_dock_status'])),
      newDockStatus: $ChangeEventsTable.$converternewDockStatusn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}new_dock_status'])),
      previousBatchId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}previous_batch_id']),
      newBatchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}new_batch_id']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      eventOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event_order'])!,
      eventTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}event_time'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ChangeEventsTable createAlias(String alias) {
    return $ChangeEventsTable(attachedDatabase, alias);
  }

  static TypeConverter<EventType, String> $convertereventType =
      const EventTypeConverter();
  static TypeConverter<DockStatus, String> $converterpreviousDockStatus =
      const DockStatusConverter();
  static TypeConverter<DockStatus?, String?> $converterpreviousDockStatusn =
      NullAwareTypeConverter.wrap($converterpreviousDockStatus);
  static TypeConverter<DockStatus, String> $converternewDockStatus =
      const DockStatusConverter();
  static TypeConverter<DockStatus?, String?> $converternewDockStatusn =
      NullAwareTypeConverter.wrap($converternewDockStatus);
}

class ChangeEvent extends DataClass implements Insertable<ChangeEvent> {
  final String id;
  final String sessionId;
  final String warehouseId;
  final EventType eventType;
  final String? batchId;
  final String? sourceDockId;
  final String? targetDockId;
  final DockStatus? previousDockStatus;
  final DockStatus? newDockStatus;
  final String? previousBatchId;
  final String? newBatchId;
  final String? note;
  final int eventOrder;
  final DateTime eventTime;
  final DateTime createdAt;
  const ChangeEvent(
      {required this.id,
      required this.sessionId,
      required this.warehouseId,
      required this.eventType,
      this.batchId,
      this.sourceDockId,
      this.targetDockId,
      this.previousDockStatus,
      this.newDockStatus,
      this.previousBatchId,
      this.newBatchId,
      this.note,
      required this.eventOrder,
      required this.eventTime,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['warehouse_id'] = Variable<String>(warehouseId);
    {
      map['event_type'] = Variable<String>(
          $ChangeEventsTable.$convertereventType.toSql(eventType));
    }
    if (!nullToAbsent || batchId != null) {
      map['batch_id'] = Variable<String>(batchId);
    }
    if (!nullToAbsent || sourceDockId != null) {
      map['source_dock_id'] = Variable<String>(sourceDockId);
    }
    if (!nullToAbsent || targetDockId != null) {
      map['target_dock_id'] = Variable<String>(targetDockId);
    }
    if (!nullToAbsent || previousDockStatus != null) {
      map['previous_dock_status'] = Variable<String>($ChangeEventsTable
          .$converterpreviousDockStatusn
          .toSql(previousDockStatus));
    }
    if (!nullToAbsent || newDockStatus != null) {
      map['new_dock_status'] = Variable<String>(
          $ChangeEventsTable.$converternewDockStatusn.toSql(newDockStatus));
    }
    if (!nullToAbsent || previousBatchId != null) {
      map['previous_batch_id'] = Variable<String>(previousBatchId);
    }
    if (!nullToAbsent || newBatchId != null) {
      map['new_batch_id'] = Variable<String>(newBatchId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['event_order'] = Variable<int>(eventOrder);
    map['event_time'] = Variable<DateTime>(eventTime);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChangeEventsCompanion toCompanion(bool nullToAbsent) {
    return ChangeEventsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      warehouseId: Value(warehouseId),
      eventType: Value(eventType),
      batchId: batchId == null && nullToAbsent
          ? const Value.absent()
          : Value(batchId),
      sourceDockId: sourceDockId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceDockId),
      targetDockId: targetDockId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDockId),
      previousDockStatus: previousDockStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(previousDockStatus),
      newDockStatus: newDockStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(newDockStatus),
      previousBatchId: previousBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(previousBatchId),
      newBatchId: newBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(newBatchId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      eventOrder: Value(eventOrder),
      eventTime: Value(eventTime),
      createdAt: Value(createdAt),
    );
  }

  factory ChangeEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChangeEvent(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      eventType: serializer.fromJson<EventType>(json['eventType']),
      batchId: serializer.fromJson<String?>(json['batchId']),
      sourceDockId: serializer.fromJson<String?>(json['sourceDockId']),
      targetDockId: serializer.fromJson<String?>(json['targetDockId']),
      previousDockStatus:
          serializer.fromJson<DockStatus?>(json['previousDockStatus']),
      newDockStatus: serializer.fromJson<DockStatus?>(json['newDockStatus']),
      previousBatchId: serializer.fromJson<String?>(json['previousBatchId']),
      newBatchId: serializer.fromJson<String?>(json['newBatchId']),
      note: serializer.fromJson<String?>(json['note']),
      eventOrder: serializer.fromJson<int>(json['eventOrder']),
      eventTime: serializer.fromJson<DateTime>(json['eventTime']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'eventType': serializer.toJson<EventType>(eventType),
      'batchId': serializer.toJson<String?>(batchId),
      'sourceDockId': serializer.toJson<String?>(sourceDockId),
      'targetDockId': serializer.toJson<String?>(targetDockId),
      'previousDockStatus': serializer.toJson<DockStatus?>(previousDockStatus),
      'newDockStatus': serializer.toJson<DockStatus?>(newDockStatus),
      'previousBatchId': serializer.toJson<String?>(previousBatchId),
      'newBatchId': serializer.toJson<String?>(newBatchId),
      'note': serializer.toJson<String?>(note),
      'eventOrder': serializer.toJson<int>(eventOrder),
      'eventTime': serializer.toJson<DateTime>(eventTime),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChangeEvent copyWith(
          {String? id,
          String? sessionId,
          String? warehouseId,
          EventType? eventType,
          Value<String?> batchId = const Value.absent(),
          Value<String?> sourceDockId = const Value.absent(),
          Value<String?> targetDockId = const Value.absent(),
          Value<DockStatus?> previousDockStatus = const Value.absent(),
          Value<DockStatus?> newDockStatus = const Value.absent(),
          Value<String?> previousBatchId = const Value.absent(),
          Value<String?> newBatchId = const Value.absent(),
          Value<String?> note = const Value.absent(),
          int? eventOrder,
          DateTime? eventTime,
          DateTime? createdAt}) =>
      ChangeEvent(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        warehouseId: warehouseId ?? this.warehouseId,
        eventType: eventType ?? this.eventType,
        batchId: batchId.present ? batchId.value : this.batchId,
        sourceDockId:
            sourceDockId.present ? sourceDockId.value : this.sourceDockId,
        targetDockId:
            targetDockId.present ? targetDockId.value : this.targetDockId,
        previousDockStatus: previousDockStatus.present
            ? previousDockStatus.value
            : this.previousDockStatus,
        newDockStatus:
            newDockStatus.present ? newDockStatus.value : this.newDockStatus,
        previousBatchId: previousBatchId.present
            ? previousBatchId.value
            : this.previousBatchId,
        newBatchId: newBatchId.present ? newBatchId.value : this.newBatchId,
        note: note.present ? note.value : this.note,
        eventOrder: eventOrder ?? this.eventOrder,
        eventTime: eventTime ?? this.eventTime,
        createdAt: createdAt ?? this.createdAt,
      );
  ChangeEvent copyWithCompanion(ChangeEventsCompanion data) {
    return ChangeEvent(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      sourceDockId: data.sourceDockId.present
          ? data.sourceDockId.value
          : this.sourceDockId,
      targetDockId: data.targetDockId.present
          ? data.targetDockId.value
          : this.targetDockId,
      previousDockStatus: data.previousDockStatus.present
          ? data.previousDockStatus.value
          : this.previousDockStatus,
      newDockStatus: data.newDockStatus.present
          ? data.newDockStatus.value
          : this.newDockStatus,
      previousBatchId: data.previousBatchId.present
          ? data.previousBatchId.value
          : this.previousBatchId,
      newBatchId:
          data.newBatchId.present ? data.newBatchId.value : this.newBatchId,
      note: data.note.present ? data.note.value : this.note,
      eventOrder:
          data.eventOrder.present ? data.eventOrder.value : this.eventOrder,
      eventTime: data.eventTime.present ? data.eventTime.value : this.eventTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChangeEvent(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('eventType: $eventType, ')
          ..write('batchId: $batchId, ')
          ..write('sourceDockId: $sourceDockId, ')
          ..write('targetDockId: $targetDockId, ')
          ..write('previousDockStatus: $previousDockStatus, ')
          ..write('newDockStatus: $newDockStatus, ')
          ..write('previousBatchId: $previousBatchId, ')
          ..write('newBatchId: $newBatchId, ')
          ..write('note: $note, ')
          ..write('eventOrder: $eventOrder, ')
          ..write('eventTime: $eventTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChangeEvent &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.warehouseId == this.warehouseId &&
          other.eventType == this.eventType &&
          other.batchId == this.batchId &&
          other.sourceDockId == this.sourceDockId &&
          other.targetDockId == this.targetDockId &&
          other.previousDockStatus == this.previousDockStatus &&
          other.newDockStatus == this.newDockStatus &&
          other.previousBatchId == this.previousBatchId &&
          other.newBatchId == this.newBatchId &&
          other.note == this.note &&
          other.eventOrder == this.eventOrder &&
          other.eventTime == this.eventTime &&
          other.createdAt == this.createdAt);
}

class ChangeEventsCompanion extends UpdateCompanion<ChangeEvent> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> warehouseId;
  final Value<EventType> eventType;
  final Value<String?> batchId;
  final Value<String?> sourceDockId;
  final Value<String?> targetDockId;
  final Value<DockStatus?> previousDockStatus;
  final Value<DockStatus?> newDockStatus;
  final Value<String?> previousBatchId;
  final Value<String?> newBatchId;
  final Value<String?> note;
  final Value<int> eventOrder;
  final Value<DateTime> eventTime;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ChangeEventsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.batchId = const Value.absent(),
    this.sourceDockId = const Value.absent(),
    this.targetDockId = const Value.absent(),
    this.previousDockStatus = const Value.absent(),
    this.newDockStatus = const Value.absent(),
    this.previousBatchId = const Value.absent(),
    this.newBatchId = const Value.absent(),
    this.note = const Value.absent(),
    this.eventOrder = const Value.absent(),
    this.eventTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChangeEventsCompanion.insert({
    required String id,
    required String sessionId,
    required String warehouseId,
    this.eventType = const Value.absent(),
    this.batchId = const Value.absent(),
    this.sourceDockId = const Value.absent(),
    this.targetDockId = const Value.absent(),
    this.previousDockStatus = const Value.absent(),
    this.newDockStatus = const Value.absent(),
    this.previousBatchId = const Value.absent(),
    this.newBatchId = const Value.absent(),
    this.note = const Value.absent(),
    this.eventOrder = const Value.absent(),
    this.eventTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        warehouseId = Value(warehouseId);
  static Insertable<ChangeEvent> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? warehouseId,
    Expression<String>? eventType,
    Expression<String>? batchId,
    Expression<String>? sourceDockId,
    Expression<String>? targetDockId,
    Expression<String>? previousDockStatus,
    Expression<String>? newDockStatus,
    Expression<String>? previousBatchId,
    Expression<String>? newBatchId,
    Expression<String>? note,
    Expression<int>? eventOrder,
    Expression<DateTime>? eventTime,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (eventType != null) 'event_type': eventType,
      if (batchId != null) 'batch_id': batchId,
      if (sourceDockId != null) 'source_dock_id': sourceDockId,
      if (targetDockId != null) 'target_dock_id': targetDockId,
      if (previousDockStatus != null)
        'previous_dock_status': previousDockStatus,
      if (newDockStatus != null) 'new_dock_status': newDockStatus,
      if (previousBatchId != null) 'previous_batch_id': previousBatchId,
      if (newBatchId != null) 'new_batch_id': newBatchId,
      if (note != null) 'note': note,
      if (eventOrder != null) 'event_order': eventOrder,
      if (eventTime != null) 'event_time': eventTime,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChangeEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? warehouseId,
      Value<EventType>? eventType,
      Value<String?>? batchId,
      Value<String?>? sourceDockId,
      Value<String?>? targetDockId,
      Value<DockStatus?>? previousDockStatus,
      Value<DockStatus?>? newDockStatus,
      Value<String?>? previousBatchId,
      Value<String?>? newBatchId,
      Value<String?>? note,
      Value<int>? eventOrder,
      Value<DateTime>? eventTime,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ChangeEventsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      warehouseId: warehouseId ?? this.warehouseId,
      eventType: eventType ?? this.eventType,
      batchId: batchId ?? this.batchId,
      sourceDockId: sourceDockId ?? this.sourceDockId,
      targetDockId: targetDockId ?? this.targetDockId,
      previousDockStatus: previousDockStatus ?? this.previousDockStatus,
      newDockStatus: newDockStatus ?? this.newDockStatus,
      previousBatchId: previousBatchId ?? this.previousBatchId,
      newBatchId: newBatchId ?? this.newBatchId,
      note: note ?? this.note,
      eventOrder: eventOrder ?? this.eventOrder,
      eventTime: eventTime ?? this.eventTime,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(
          $ChangeEventsTable.$convertereventType.toSql(eventType.value));
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (sourceDockId.present) {
      map['source_dock_id'] = Variable<String>(sourceDockId.value);
    }
    if (targetDockId.present) {
      map['target_dock_id'] = Variable<String>(targetDockId.value);
    }
    if (previousDockStatus.present) {
      map['previous_dock_status'] = Variable<String>($ChangeEventsTable
          .$converterpreviousDockStatusn
          .toSql(previousDockStatus.value));
    }
    if (newDockStatus.present) {
      map['new_dock_status'] = Variable<String>($ChangeEventsTable
          .$converternewDockStatusn
          .toSql(newDockStatus.value));
    }
    if (previousBatchId.present) {
      map['previous_batch_id'] = Variable<String>(previousBatchId.value);
    }
    if (newBatchId.present) {
      map['new_batch_id'] = Variable<String>(newBatchId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (eventOrder.present) {
      map['event_order'] = Variable<int>(eventOrder.value);
    }
    if (eventTime.present) {
      map['event_time'] = Variable<DateTime>(eventTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChangeEventsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('eventType: $eventType, ')
          ..write('batchId: $batchId, ')
          ..write('sourceDockId: $sourceDockId, ')
          ..write('targetDockId: $targetDockId, ')
          ..write('previousDockStatus: $previousDockStatus, ')
          ..write('newDockStatus: $newDockStatus, ')
          ..write('previousBatchId: $previousBatchId, ')
          ..write('newBatchId: $newBatchId, ')
          ..write('note: $note, ')
          ..write('eventOrder: $eventOrder, ')
          ..write('eventTime: $eventTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SnapshotsTable extends Snapshots
    with TableInfo<$SnapshotsTable, Snapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _snapshotTypeMeta =
      const VerificationMeta('snapshotType');
  @override
  late final GeneratedColumnWithTypeConverter<SnapshotType, String>
      snapshotType = GeneratedColumn<String>(
              'snapshot_type', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('manual'))
          .withConverter<SnapshotType>($SnapshotsTable.$convertersnapshotType);
  static const VerificationMeta _snapshotTimeMeta =
      const VerificationMeta('snapshotTime');
  @override
  late final GeneratedColumn<DateTime> snapshotTime = GeneratedColumn<DateTime>(
      'snapshot_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _snapshotJsonMeta =
      const VerificationMeta('snapshotJson');
  @override
  late final GeneratedColumn<String> snapshotJson = GeneratedColumn<String>(
      'snapshot_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        warehouseId,
        sessionId,
        snapshotType,
        snapshotTime,
        snapshotJson,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'snapshots';
  @override
  VerificationContext validateIntegrity(Insertable<Snapshot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    }
    context.handle(_snapshotTypeMeta, const VerificationResult.success());
    if (data.containsKey('snapshot_time')) {
      context.handle(
          _snapshotTimeMeta,
          snapshotTime.isAcceptableOrUnknown(
              data['snapshot_time']!, _snapshotTimeMeta));
    }
    if (data.containsKey('snapshot_json')) {
      context.handle(
          _snapshotJsonMeta,
          snapshotJson.isAcceptableOrUnknown(
              data['snapshot_json']!, _snapshotJsonMeta));
    } else if (isInserting) {
      context.missing(_snapshotJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Snapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Snapshot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id']),
      snapshotType: $SnapshotsTable.$convertersnapshotType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}snapshot_type'])!),
      snapshotTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}snapshot_time'])!,
      snapshotJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}snapshot_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SnapshotsTable createAlias(String alias) {
    return $SnapshotsTable(attachedDatabase, alias);
  }

  static TypeConverter<SnapshotType, String> $convertersnapshotType =
      const SnapshotTypeConverter();
}

class Snapshot extends DataClass implements Insertable<Snapshot> {
  final String id;
  final String warehouseId;
  final String? sessionId;
  final SnapshotType snapshotType;
  final DateTime snapshotTime;
  final String snapshotJson;
  final DateTime createdAt;
  const Snapshot(
      {required this.id,
      required this.warehouseId,
      this.sessionId,
      required this.snapshotType,
      required this.snapshotTime,
      required this.snapshotJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['warehouse_id'] = Variable<String>(warehouseId);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    {
      map['snapshot_type'] = Variable<String>(
          $SnapshotsTable.$convertersnapshotType.toSql(snapshotType));
    }
    map['snapshot_time'] = Variable<DateTime>(snapshotTime);
    map['snapshot_json'] = Variable<String>(snapshotJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SnapshotsCompanion toCompanion(bool nullToAbsent) {
    return SnapshotsCompanion(
      id: Value(id),
      warehouseId: Value(warehouseId),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      snapshotType: Value(snapshotType),
      snapshotTime: Value(snapshotTime),
      snapshotJson: Value(snapshotJson),
      createdAt: Value(createdAt),
    );
  }

  factory Snapshot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Snapshot(
      id: serializer.fromJson<String>(json['id']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      snapshotType: serializer.fromJson<SnapshotType>(json['snapshotType']),
      snapshotTime: serializer.fromJson<DateTime>(json['snapshotTime']),
      snapshotJson: serializer.fromJson<String>(json['snapshotJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'sessionId': serializer.toJson<String?>(sessionId),
      'snapshotType': serializer.toJson<SnapshotType>(snapshotType),
      'snapshotTime': serializer.toJson<DateTime>(snapshotTime),
      'snapshotJson': serializer.toJson<String>(snapshotJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Snapshot copyWith(
          {String? id,
          String? warehouseId,
          Value<String?> sessionId = const Value.absent(),
          SnapshotType? snapshotType,
          DateTime? snapshotTime,
          String? snapshotJson,
          DateTime? createdAt}) =>
      Snapshot(
        id: id ?? this.id,
        warehouseId: warehouseId ?? this.warehouseId,
        sessionId: sessionId.present ? sessionId.value : this.sessionId,
        snapshotType: snapshotType ?? this.snapshotType,
        snapshotTime: snapshotTime ?? this.snapshotTime,
        snapshotJson: snapshotJson ?? this.snapshotJson,
        createdAt: createdAt ?? this.createdAt,
      );
  Snapshot copyWithCompanion(SnapshotsCompanion data) {
    return Snapshot(
      id: data.id.present ? data.id.value : this.id,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      snapshotType: data.snapshotType.present
          ? data.snapshotType.value
          : this.snapshotType,
      snapshotTime: data.snapshotTime.present
          ? data.snapshotTime.value
          : this.snapshotTime,
      snapshotJson: data.snapshotJson.present
          ? data.snapshotJson.value
          : this.snapshotJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Snapshot(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('sessionId: $sessionId, ')
          ..write('snapshotType: $snapshotType, ')
          ..write('snapshotTime: $snapshotTime, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, warehouseId, sessionId, snapshotType,
      snapshotTime, snapshotJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Snapshot &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.sessionId == this.sessionId &&
          other.snapshotType == this.snapshotType &&
          other.snapshotTime == this.snapshotTime &&
          other.snapshotJson == this.snapshotJson &&
          other.createdAt == this.createdAt);
}

class SnapshotsCompanion extends UpdateCompanion<Snapshot> {
  final Value<String> id;
  final Value<String> warehouseId;
  final Value<String?> sessionId;
  final Value<SnapshotType> snapshotType;
  final Value<DateTime> snapshotTime;
  final Value<String> snapshotJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SnapshotsCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.snapshotType = const Value.absent(),
    this.snapshotTime = const Value.absent(),
    this.snapshotJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SnapshotsCompanion.insert({
    required String id,
    required String warehouseId,
    this.sessionId = const Value.absent(),
    this.snapshotType = const Value.absent(),
    this.snapshotTime = const Value.absent(),
    required String snapshotJson,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        warehouseId = Value(warehouseId),
        snapshotJson = Value(snapshotJson);
  static Insertable<Snapshot> custom({
    Expression<String>? id,
    Expression<String>? warehouseId,
    Expression<String>? sessionId,
    Expression<String>? snapshotType,
    Expression<DateTime>? snapshotTime,
    Expression<String>? snapshotJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (sessionId != null) 'session_id': sessionId,
      if (snapshotType != null) 'snapshot_type': snapshotType,
      if (snapshotTime != null) 'snapshot_time': snapshotTime,
      if (snapshotJson != null) 'snapshot_json': snapshotJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SnapshotsCompanion copyWith(
      {Value<String>? id,
      Value<String>? warehouseId,
      Value<String?>? sessionId,
      Value<SnapshotType>? snapshotType,
      Value<DateTime>? snapshotTime,
      Value<String>? snapshotJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SnapshotsCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      sessionId: sessionId ?? this.sessionId,
      snapshotType: snapshotType ?? this.snapshotType,
      snapshotTime: snapshotTime ?? this.snapshotTime,
      snapshotJson: snapshotJson ?? this.snapshotJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (snapshotType.present) {
      map['snapshot_type'] = Variable<String>(
          $SnapshotsTable.$convertersnapshotType.toSql(snapshotType.value));
    }
    if (snapshotTime.present) {
      map['snapshot_time'] = Variable<DateTime>(snapshotTime.value);
    }
    if (snapshotJson.present) {
      map['snapshot_json'] = Variable<String>(snapshotJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('sessionId: $sessionId, ')
          ..write('snapshotType: $snapshotType, ')
          ..write('snapshotTime: $snapshotTime, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyRecordsTable extends DailyRecords
    with TableInfo<$DailyRecordsTable, DailyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordDateMeta =
      const VerificationMeta('recordDate');
  @override
  late final GeneratedColumn<DateTime> recordDate = GeneratedColumn<DateTime>(
      'record_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _openingSnapshotIdMeta =
      const VerificationMeta('openingSnapshotId');
  @override
  late final GeneratedColumn<String> openingSnapshotId =
      GeneratedColumn<String>('opening_snapshot_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _closingSnapshotIdMeta =
      const VerificationMeta('closingSnapshotId');
  @override
  late final GeneratedColumn<String> closingSnapshotId =
      GeneratedColumn<String>('closing_snapshot_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        warehouseId,
        recordDate,
        openingSnapshotId,
        closingSnapshotId,
        note,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_records';
  @override
  VerificationContext validateIntegrity(Insertable<DailyRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('record_date')) {
      context.handle(
          _recordDateMeta,
          recordDate.isAcceptableOrUnknown(
              data['record_date']!, _recordDateMeta));
    } else if (isInserting) {
      context.missing(_recordDateMeta);
    }
    if (data.containsKey('opening_snapshot_id')) {
      context.handle(
          _openingSnapshotIdMeta,
          openingSnapshotId.isAcceptableOrUnknown(
              data['opening_snapshot_id']!, _openingSnapshotIdMeta));
    }
    if (data.containsKey('closing_snapshot_id')) {
      context.handle(
          _closingSnapshotIdMeta,
          closingSnapshotId.isAcceptableOrUnknown(
              data['closing_snapshot_id']!, _closingSnapshotIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id'])!,
      recordDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}record_date'])!,
      openingSnapshotId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}opening_snapshot_id']),
      closingSnapshotId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}closing_snapshot_id']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyRecordsTable createAlias(String alias) {
    return $DailyRecordsTable(attachedDatabase, alias);
  }
}

class DailyRecord extends DataClass implements Insertable<DailyRecord> {
  final String id;
  final String warehouseId;
  final DateTime recordDate;
  final String? openingSnapshotId;
  final String? closingSnapshotId;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyRecord(
      {required this.id,
      required this.warehouseId,
      required this.recordDate,
      this.openingSnapshotId,
      this.closingSnapshotId,
      this.note,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['record_date'] = Variable<DateTime>(recordDate);
    if (!nullToAbsent || openingSnapshotId != null) {
      map['opening_snapshot_id'] = Variable<String>(openingSnapshotId);
    }
    if (!nullToAbsent || closingSnapshotId != null) {
      map['closing_snapshot_id'] = Variable<String>(closingSnapshotId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyRecordsCompanion(
      id: Value(id),
      warehouseId: Value(warehouseId),
      recordDate: Value(recordDate),
      openingSnapshotId: openingSnapshotId == null && nullToAbsent
          ? const Value.absent()
          : Value(openingSnapshotId),
      closingSnapshotId: closingSnapshotId == null && nullToAbsent
          ? const Value.absent()
          : Value(closingSnapshotId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRecord(
      id: serializer.fromJson<String>(json['id']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      recordDate: serializer.fromJson<DateTime>(json['recordDate']),
      openingSnapshotId:
          serializer.fromJson<String?>(json['openingSnapshotId']),
      closingSnapshotId:
          serializer.fromJson<String?>(json['closingSnapshotId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'recordDate': serializer.toJson<DateTime>(recordDate),
      'openingSnapshotId': serializer.toJson<String?>(openingSnapshotId),
      'closingSnapshotId': serializer.toJson<String?>(closingSnapshotId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyRecord copyWith(
          {String? id,
          String? warehouseId,
          DateTime? recordDate,
          Value<String?> openingSnapshotId = const Value.absent(),
          Value<String?> closingSnapshotId = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DailyRecord(
        id: id ?? this.id,
        warehouseId: warehouseId ?? this.warehouseId,
        recordDate: recordDate ?? this.recordDate,
        openingSnapshotId: openingSnapshotId.present
            ? openingSnapshotId.value
            : this.openingSnapshotId,
        closingSnapshotId: closingSnapshotId.present
            ? closingSnapshotId.value
            : this.closingSnapshotId,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyRecord copyWithCompanion(DailyRecordsCompanion data) {
    return DailyRecord(
      id: data.id.present ? data.id.value : this.id,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      recordDate:
          data.recordDate.present ? data.recordDate.value : this.recordDate,
      openingSnapshotId: data.openingSnapshotId.present
          ? data.openingSnapshotId.value
          : this.openingSnapshotId,
      closingSnapshotId: data.closingSnapshotId.present
          ? data.closingSnapshotId.value
          : this.closingSnapshotId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecord(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('recordDate: $recordDate, ')
          ..write('openingSnapshotId: $openingSnapshotId, ')
          ..write('closingSnapshotId: $closingSnapshotId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, warehouseId, recordDate,
      openingSnapshotId, closingSnapshotId, note, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRecord &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.recordDate == this.recordDate &&
          other.openingSnapshotId == this.openingSnapshotId &&
          other.closingSnapshotId == this.closingSnapshotId &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyRecordsCompanion extends UpdateCompanion<DailyRecord> {
  final Value<String> id;
  final Value<String> warehouseId;
  final Value<DateTime> recordDate;
  final Value<String?> openingSnapshotId;
  final Value<String?> closingSnapshotId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyRecordsCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.recordDate = const Value.absent(),
    this.openingSnapshotId = const Value.absent(),
    this.closingSnapshotId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyRecordsCompanion.insert({
    required String id,
    required String warehouseId,
    required DateTime recordDate,
    this.openingSnapshotId = const Value.absent(),
    this.closingSnapshotId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        warehouseId = Value(warehouseId),
        recordDate = Value(recordDate);
  static Insertable<DailyRecord> custom({
    Expression<String>? id,
    Expression<String>? warehouseId,
    Expression<DateTime>? recordDate,
    Expression<String>? openingSnapshotId,
    Expression<String>? closingSnapshotId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (recordDate != null) 'record_date': recordDate,
      if (openingSnapshotId != null) 'opening_snapshot_id': openingSnapshotId,
      if (closingSnapshotId != null) 'closing_snapshot_id': closingSnapshotId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? warehouseId,
      Value<DateTime>? recordDate,
      Value<String?>? openingSnapshotId,
      Value<String?>? closingSnapshotId,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return DailyRecordsCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      recordDate: recordDate ?? this.recordDate,
      openingSnapshotId: openingSnapshotId ?? this.openingSnapshotId,
      closingSnapshotId: closingSnapshotId ?? this.closingSnapshotId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (recordDate.present) {
      map['record_date'] = Variable<DateTime>(recordDate.value);
    }
    if (openingSnapshotId.present) {
      map['opening_snapshot_id'] = Variable<String>(openingSnapshotId.value);
    }
    if (closingSnapshotId.present) {
      map['closing_snapshot_id'] = Variable<String>(closingSnapshotId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecordsCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('recordDate: $recordDate, ')
          ..write('openingSnapshotId: $openingSnapshotId, ')
          ..write('closingSnapshotId: $closingSnapshotId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
      'warehouse_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settingKeyMeta =
      const VerificationMeta('settingKey');
  @override
  late final GeneratedColumn<String> settingKey = GeneratedColumn<String>(
      'setting_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _settingValueMeta =
      const VerificationMeta('settingValue');
  @override
  late final GeneratedColumn<String> settingValue = GeneratedColumn<String>(
      'setting_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, warehouseId, settingKey, settingValue, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    }
    if (data.containsKey('setting_key')) {
      context.handle(
          _settingKeyMeta,
          settingKey.isAcceptableOrUnknown(
              data['setting_key']!, _settingKeyMeta));
    } else if (isInserting) {
      context.missing(_settingKeyMeta);
    }
    if (data.containsKey('setting_value')) {
      context.handle(
          _settingValueMeta,
          settingValue.isAcceptableOrUnknown(
              data['setting_value']!, _settingValueMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_id']),
      settingKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}setting_key'])!,
      settingValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}setting_value']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String id;
  final String? warehouseId;
  final String settingKey;
  final String? settingValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Setting(
      {required this.id,
      this.warehouseId,
      required this.settingKey,
      this.settingValue,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || warehouseId != null) {
      map['warehouse_id'] = Variable<String>(warehouseId);
    }
    map['setting_key'] = Variable<String>(settingKey);
    if (!nullToAbsent || settingValue != null) {
      map['setting_value'] = Variable<String>(settingValue);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      warehouseId: warehouseId == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseId),
      settingKey: Value(settingKey),
      settingValue: settingValue == null && nullToAbsent
          ? const Value.absent()
          : Value(settingValue),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<String>(json['id']),
      warehouseId: serializer.fromJson<String?>(json['warehouseId']),
      settingKey: serializer.fromJson<String>(json['settingKey']),
      settingValue: serializer.fromJson<String?>(json['settingValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'warehouseId': serializer.toJson<String?>(warehouseId),
      'settingKey': serializer.toJson<String>(settingKey),
      'settingValue': serializer.toJson<String?>(settingValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith(
          {String? id,
          Value<String?> warehouseId = const Value.absent(),
          String? settingKey,
          Value<String?> settingValue = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Setting(
        id: id ?? this.id,
        warehouseId: warehouseId.present ? warehouseId.value : this.warehouseId,
        settingKey: settingKey ?? this.settingKey,
        settingValue:
            settingValue.present ? settingValue.value : this.settingValue,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      settingKey:
          data.settingKey.present ? data.settingKey.value : this.settingKey,
      settingValue: data.settingValue.present
          ? data.settingValue.value
          : this.settingValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, warehouseId, settingKey, settingValue, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.settingKey == this.settingKey &&
          other.settingValue == this.settingValue &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> id;
  final Value<String?> warehouseId;
  final Value<String> settingKey;
  final Value<String?> settingValue;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String id,
    this.warehouseId = const Value.absent(),
    required String settingKey,
    this.settingValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        settingKey = Value(settingKey);
  static Insertable<Setting> custom({
    Expression<String>? id,
    Expression<String>? warehouseId,
    Expression<String>? settingKey,
    Expression<String>? settingValue,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (settingKey != null) 'setting_key': settingKey,
      if (settingValue != null) 'setting_value': settingValue,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? warehouseId,
      Value<String>? settingKey,
      Value<String?>? settingValue,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SettingsCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      settingKey: settingKey ?? this.settingKey,
      settingValue: settingValue ?? this.settingValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (settingValue.present) {
      map['setting_value'] = Variable<String>(settingValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WarehousesTable warehouses = $WarehousesTable(this);
  late final $DocksTable docks = $DocksTable(this);
  late final $BatchesTable batches = $BatchesTable(this);
  late final $ChangeSessionsTable changeSessions = $ChangeSessionsTable(this);
  late final $ChangeEventsTable changeEvents = $ChangeEventsTable(this);
  late final $SnapshotsTable snapshots = $SnapshotsTable(this);
  late final $DailyRecordsTable dailyRecords = $DailyRecordsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        warehouses,
        docks,
        batches,
        changeSessions,
        changeEvents,
        snapshots,
        dailyRecords,
        settings
      ];
}

typedef $$WarehousesTableCreateCompanionBuilder = WarehousesCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<int> rowid,
});
typedef $$WarehousesTableUpdateCompanionBuilder = WarehousesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<int> rowid,
});

class $$WarehousesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WarehousesTable,
    Warehouse,
    $$WarehousesTableFilterComposer,
    $$WarehousesTableOrderingComposer,
    $$WarehousesTableCreateCompanionBuilder,
    $$WarehousesTableUpdateCompanionBuilder> {
  $$WarehousesTableTableManager(_$AppDatabase db, $WarehousesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WarehousesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WarehousesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WarehousesCompanion(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WarehousesCompanion.insert(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            rowid: rowid,
          ),
        ));
}

class $$WarehousesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WarehousesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DocksTableCreateCompanionBuilder = DocksCompanion Function({
  required String id,
  required String warehouseId,
  required String name,
  Value<int> displayOrder,
  Value<int> colorValue,
  Value<DockStatus> currentStatus,
  Value<String?> currentBatchId,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<int> rowid,
});
typedef $$DocksTableUpdateCompanionBuilder = DocksCompanion Function({
  Value<String> id,
  Value<String> warehouseId,
  Value<String> name,
  Value<int> displayOrder,
  Value<int> colorValue,
  Value<DockStatus> currentStatus,
  Value<String?> currentBatchId,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<int> rowid,
});

class $$DocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocksTable,
    Dock,
    $$DocksTableFilterComposer,
    $$DocksTableOrderingComposer,
    $$DocksTableCreateCompanionBuilder,
    $$DocksTableUpdateCompanionBuilder> {
  $$DocksTableTableManager(_$AppDatabase db, $DocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DocksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DocksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> warehouseId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<DockStatus> currentStatus = const Value.absent(),
            Value<String?> currentBatchId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DocksCompanion(
            id: id,
            warehouseId: warehouseId,
            name: name,
            displayOrder: displayOrder,
            colorValue: colorValue,
            currentStatus: currentStatus,
            currentBatchId: currentBatchId,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String warehouseId,
            required String name,
            Value<int> displayOrder = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<DockStatus> currentStatus = const Value.absent(),
            Value<String?> currentBatchId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DocksCompanion.insert(
            id: id,
            warehouseId: warehouseId,
            name: name,
            displayOrder: displayOrder,
            colorValue: colorValue,
            currentStatus: currentStatus,
            currentBatchId: currentBatchId,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            rowid: rowid,
          ),
        ));
}

class $$DocksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DocksTable> {
  $$DocksTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get displayOrder => $state.composableBuilder(
      column: $state.table.displayOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get colorValue => $state.composableBuilder(
      column: $state.table.colorValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<DockStatus, DockStatus, String>
      get currentStatus => $state.composableBuilder(
          column: $state.table.currentStatus,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get currentBatchId => $state.composableBuilder(
      column: $state.table.currentBatchId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DocksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DocksTable> {
  $$DocksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get displayOrder => $state.composableBuilder(
      column: $state.table.displayOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get colorValue => $state.composableBuilder(
      column: $state.table.colorValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currentStatus => $state.composableBuilder(
      column: $state.table.currentStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currentBatchId => $state.composableBuilder(
      column: $state.table.currentBatchId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BatchesTableCreateCompanionBuilder = BatchesCompanion Function({
  required String id,
  required String warehouseId,
  required String batchCode,
  Value<String?> displayName,
  Value<String?> description,
  Value<BatchStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<int> rowid,
});
typedef $$BatchesTableUpdateCompanionBuilder = BatchesCompanion Function({
  Value<String> id,
  Value<String> warehouseId,
  Value<String> batchCode,
  Value<String?> displayName,
  Value<String?> description,
  Value<BatchStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<int> rowid,
});

class $$BatchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BatchesTable,
    Batche,
    $$BatchesTableFilterComposer,
    $$BatchesTableOrderingComposer,
    $$BatchesTableCreateCompanionBuilder,
    $$BatchesTableUpdateCompanionBuilder> {
  $$BatchesTableTableManager(_$AppDatabase db, $BatchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BatchesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BatchesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> warehouseId = const Value.absent(),
            Value<String> batchCode = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<BatchStatus> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BatchesCompanion(
            id: id,
            warehouseId: warehouseId,
            batchCode: batchCode,
            displayName: displayName,
            description: description,
            status: status,
            createdAt: createdAt,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String warehouseId,
            required String batchCode,
            Value<String?> displayName = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<BatchStatus> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BatchesCompanion.insert(
            id: id,
            warehouseId: warehouseId,
            batchCode: batchCode,
            displayName: displayName,
            description: description,
            status: status,
            createdAt: createdAt,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            rowid: rowid,
          ),
        ));
}

class $$BatchesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get batchCode => $state.composableBuilder(
      column: $state.table.batchCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get displayName => $state.composableBuilder(
      column: $state.table.displayName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<BatchStatus, BatchStatus, String> get status =>
      $state.composableBuilder(
          column: $state.table.status,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BatchesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get batchCode => $state.composableBuilder(
      column: $state.table.batchCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get displayName => $state.composableBuilder(
      column: $state.table.displayName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ChangeSessionsTableCreateCompanionBuilder = ChangeSessionsCompanion
    Function({
  required String id,
  required String warehouseId,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<ChangeSessionStatus> status,
  Value<String?> title,
  Value<String?> note,
  Value<String?> beforeSnapshotId,
  Value<String?> afterSnapshotId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ChangeSessionsTableUpdateCompanionBuilder = ChangeSessionsCompanion
    Function({
  Value<String> id,
  Value<String> warehouseId,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<ChangeSessionStatus> status,
  Value<String?> title,
  Value<String?> note,
  Value<String?> beforeSnapshotId,
  Value<String?> afterSnapshotId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ChangeSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChangeSessionsTable,
    ChangeSession,
    $$ChangeSessionsTableFilterComposer,
    $$ChangeSessionsTableOrderingComposer,
    $$ChangeSessionsTableCreateCompanionBuilder,
    $$ChangeSessionsTableUpdateCompanionBuilder> {
  $$ChangeSessionsTableTableManager(
      _$AppDatabase db, $ChangeSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChangeSessionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ChangeSessionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> warehouseId = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<ChangeSessionStatus> status = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> beforeSnapshotId = const Value.absent(),
            Value<String?> afterSnapshotId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChangeSessionsCompanion(
            id: id,
            warehouseId: warehouseId,
            startedAt: startedAt,
            completedAt: completedAt,
            status: status,
            title: title,
            note: note,
            beforeSnapshotId: beforeSnapshotId,
            afterSnapshotId: afterSnapshotId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String warehouseId,
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<ChangeSessionStatus> status = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> beforeSnapshotId = const Value.absent(),
            Value<String?> afterSnapshotId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChangeSessionsCompanion.insert(
            id: id,
            warehouseId: warehouseId,
            startedAt: startedAt,
            completedAt: completedAt,
            status: status,
            title: title,
            note: note,
            beforeSnapshotId: beforeSnapshotId,
            afterSnapshotId: afterSnapshotId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$ChangeSessionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChangeSessionsTable> {
  $$ChangeSessionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ChangeSessionStatus, ChangeSessionStatus,
          String>
      get status => $state.composableBuilder(
          column: $state.table.status,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get beforeSnapshotId => $state.composableBuilder(
      column: $state.table.beforeSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get afterSnapshotId => $state.composableBuilder(
      column: $state.table.afterSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ChangeSessionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChangeSessionsTable> {
  $$ChangeSessionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get beforeSnapshotId => $state.composableBuilder(
      column: $state.table.beforeSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get afterSnapshotId => $state.composableBuilder(
      column: $state.table.afterSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ChangeEventsTableCreateCompanionBuilder = ChangeEventsCompanion
    Function({
  required String id,
  required String sessionId,
  required String warehouseId,
  Value<EventType> eventType,
  Value<String?> batchId,
  Value<String?> sourceDockId,
  Value<String?> targetDockId,
  Value<DockStatus?> previousDockStatus,
  Value<DockStatus?> newDockStatus,
  Value<String?> previousBatchId,
  Value<String?> newBatchId,
  Value<String?> note,
  Value<int> eventOrder,
  Value<DateTime> eventTime,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ChangeEventsTableUpdateCompanionBuilder = ChangeEventsCompanion
    Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> warehouseId,
  Value<EventType> eventType,
  Value<String?> batchId,
  Value<String?> sourceDockId,
  Value<String?> targetDockId,
  Value<DockStatus?> previousDockStatus,
  Value<DockStatus?> newDockStatus,
  Value<String?> previousBatchId,
  Value<String?> newBatchId,
  Value<String?> note,
  Value<int> eventOrder,
  Value<DateTime> eventTime,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ChangeEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChangeEventsTable,
    ChangeEvent,
    $$ChangeEventsTableFilterComposer,
    $$ChangeEventsTableOrderingComposer,
    $$ChangeEventsTableCreateCompanionBuilder,
    $$ChangeEventsTableUpdateCompanionBuilder> {
  $$ChangeEventsTableTableManager(_$AppDatabase db, $ChangeEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChangeEventsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ChangeEventsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> warehouseId = const Value.absent(),
            Value<EventType> eventType = const Value.absent(),
            Value<String?> batchId = const Value.absent(),
            Value<String?> sourceDockId = const Value.absent(),
            Value<String?> targetDockId = const Value.absent(),
            Value<DockStatus?> previousDockStatus = const Value.absent(),
            Value<DockStatus?> newDockStatus = const Value.absent(),
            Value<String?> previousBatchId = const Value.absent(),
            Value<String?> newBatchId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> eventOrder = const Value.absent(),
            Value<DateTime> eventTime = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChangeEventsCompanion(
            id: id,
            sessionId: sessionId,
            warehouseId: warehouseId,
            eventType: eventType,
            batchId: batchId,
            sourceDockId: sourceDockId,
            targetDockId: targetDockId,
            previousDockStatus: previousDockStatus,
            newDockStatus: newDockStatus,
            previousBatchId: previousBatchId,
            newBatchId: newBatchId,
            note: note,
            eventOrder: eventOrder,
            eventTime: eventTime,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String warehouseId,
            Value<EventType> eventType = const Value.absent(),
            Value<String?> batchId = const Value.absent(),
            Value<String?> sourceDockId = const Value.absent(),
            Value<String?> targetDockId = const Value.absent(),
            Value<DockStatus?> previousDockStatus = const Value.absent(),
            Value<DockStatus?> newDockStatus = const Value.absent(),
            Value<String?> previousBatchId = const Value.absent(),
            Value<String?> newBatchId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> eventOrder = const Value.absent(),
            Value<DateTime> eventTime = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChangeEventsCompanion.insert(
            id: id,
            sessionId: sessionId,
            warehouseId: warehouseId,
            eventType: eventType,
            batchId: batchId,
            sourceDockId: sourceDockId,
            targetDockId: targetDockId,
            previousDockStatus: previousDockStatus,
            newDockStatus: newDockStatus,
            previousBatchId: previousBatchId,
            newBatchId: newBatchId,
            note: note,
            eventOrder: eventOrder,
            eventTime: eventTime,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$ChangeEventsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChangeEventsTable> {
  $$ChangeEventsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sessionId => $state.composableBuilder(
      column: $state.table.sessionId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<EventType, EventType, String> get eventType =>
      $state.composableBuilder(
          column: $state.table.eventType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get batchId => $state.composableBuilder(
      column: $state.table.batchId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceDockId => $state.composableBuilder(
      column: $state.table.sourceDockId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get targetDockId => $state.composableBuilder(
      column: $state.table.targetDockId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<DockStatus?, DockStatus, String>
      get previousDockStatus => $state.composableBuilder(
          column: $state.table.previousDockStatus,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<DockStatus?, DockStatus, String>
      get newDockStatus => $state.composableBuilder(
          column: $state.table.newDockStatus,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get previousBatchId => $state.composableBuilder(
      column: $state.table.previousBatchId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get newBatchId => $state.composableBuilder(
      column: $state.table.newBatchId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get eventOrder => $state.composableBuilder(
      column: $state.table.eventOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get eventTime => $state.composableBuilder(
      column: $state.table.eventTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ChangeEventsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChangeEventsTable> {
  $$ChangeEventsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sessionId => $state.composableBuilder(
      column: $state.table.sessionId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get eventType => $state.composableBuilder(
      column: $state.table.eventType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get batchId => $state.composableBuilder(
      column: $state.table.batchId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceDockId => $state.composableBuilder(
      column: $state.table.sourceDockId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get targetDockId => $state.composableBuilder(
      column: $state.table.targetDockId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get previousDockStatus => $state.composableBuilder(
      column: $state.table.previousDockStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get newDockStatus => $state.composableBuilder(
      column: $state.table.newDockStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get previousBatchId => $state.composableBuilder(
      column: $state.table.previousBatchId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get newBatchId => $state.composableBuilder(
      column: $state.table.newBatchId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get eventOrder => $state.composableBuilder(
      column: $state.table.eventOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get eventTime => $state.composableBuilder(
      column: $state.table.eventTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SnapshotsTableCreateCompanionBuilder = SnapshotsCompanion Function({
  required String id,
  required String warehouseId,
  Value<String?> sessionId,
  Value<SnapshotType> snapshotType,
  Value<DateTime> snapshotTime,
  required String snapshotJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$SnapshotsTableUpdateCompanionBuilder = SnapshotsCompanion Function({
  Value<String> id,
  Value<String> warehouseId,
  Value<String?> sessionId,
  Value<SnapshotType> snapshotType,
  Value<DateTime> snapshotTime,
  Value<String> snapshotJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SnapshotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SnapshotsTable,
    Snapshot,
    $$SnapshotsTableFilterComposer,
    $$SnapshotsTableOrderingComposer,
    $$SnapshotsTableCreateCompanionBuilder,
    $$SnapshotsTableUpdateCompanionBuilder> {
  $$SnapshotsTableTableManager(_$AppDatabase db, $SnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SnapshotsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SnapshotsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> warehouseId = const Value.absent(),
            Value<String?> sessionId = const Value.absent(),
            Value<SnapshotType> snapshotType = const Value.absent(),
            Value<DateTime> snapshotTime = const Value.absent(),
            Value<String> snapshotJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SnapshotsCompanion(
            id: id,
            warehouseId: warehouseId,
            sessionId: sessionId,
            snapshotType: snapshotType,
            snapshotTime: snapshotTime,
            snapshotJson: snapshotJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String warehouseId,
            Value<String?> sessionId = const Value.absent(),
            Value<SnapshotType> snapshotType = const Value.absent(),
            Value<DateTime> snapshotTime = const Value.absent(),
            required String snapshotJson,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SnapshotsCompanion.insert(
            id: id,
            warehouseId: warehouseId,
            sessionId: sessionId,
            snapshotType: snapshotType,
            snapshotTime: snapshotTime,
            snapshotJson: snapshotJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$SnapshotsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sessionId => $state.composableBuilder(
      column: $state.table.sessionId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<SnapshotType, SnapshotType, String>
      get snapshotType => $state.composableBuilder(
          column: $state.table.snapshotType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get snapshotTime => $state.composableBuilder(
      column: $state.table.snapshotTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get snapshotJson => $state.composableBuilder(
      column: $state.table.snapshotJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SnapshotsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sessionId => $state.composableBuilder(
      column: $state.table.sessionId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get snapshotType => $state.composableBuilder(
      column: $state.table.snapshotType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get snapshotTime => $state.composableBuilder(
      column: $state.table.snapshotTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get snapshotJson => $state.composableBuilder(
      column: $state.table.snapshotJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DailyRecordsTableCreateCompanionBuilder = DailyRecordsCompanion
    Function({
  required String id,
  required String warehouseId,
  required DateTime recordDate,
  Value<String?> openingSnapshotId,
  Value<String?> closingSnapshotId,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$DailyRecordsTableUpdateCompanionBuilder = DailyRecordsCompanion
    Function({
  Value<String> id,
  Value<String> warehouseId,
  Value<DateTime> recordDate,
  Value<String?> openingSnapshotId,
  Value<String?> closingSnapshotId,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DailyRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyRecordsTable,
    DailyRecord,
    $$DailyRecordsTableFilterComposer,
    $$DailyRecordsTableOrderingComposer,
    $$DailyRecordsTableCreateCompanionBuilder,
    $$DailyRecordsTableUpdateCompanionBuilder> {
  $$DailyRecordsTableTableManager(_$AppDatabase db, $DailyRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DailyRecordsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DailyRecordsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> warehouseId = const Value.absent(),
            Value<DateTime> recordDate = const Value.absent(),
            Value<String?> openingSnapshotId = const Value.absent(),
            Value<String?> closingSnapshotId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyRecordsCompanion(
            id: id,
            warehouseId: warehouseId,
            recordDate: recordDate,
            openingSnapshotId: openingSnapshotId,
            closingSnapshotId: closingSnapshotId,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String warehouseId,
            required DateTime recordDate,
            Value<String?> openingSnapshotId = const Value.absent(),
            Value<String?> closingSnapshotId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyRecordsCompanion.insert(
            id: id,
            warehouseId: warehouseId,
            recordDate: recordDate,
            openingSnapshotId: openingSnapshotId,
            closingSnapshotId: closingSnapshotId,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$DailyRecordsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get recordDate => $state.composableBuilder(
      column: $state.table.recordDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get openingSnapshotId => $state.composableBuilder(
      column: $state.table.openingSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get closingSnapshotId => $state.composableBuilder(
      column: $state.table.closingSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DailyRecordsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get recordDate => $state.composableBuilder(
      column: $state.table.recordDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get openingSnapshotId => $state.composableBuilder(
      column: $state.table.openingSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get closingSnapshotId => $state.composableBuilder(
      column: $state.table.closingSnapshotId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String id,
  Value<String?> warehouseId,
  required String settingKey,
  Value<String?> settingValue,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> id,
  Value<String?> warehouseId,
  Value<String> settingKey,
  Value<String?> settingValue,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> warehouseId = const Value.absent(),
            Value<String> settingKey = const Value.absent(),
            Value<String?> settingValue = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            id: id,
            warehouseId: warehouseId,
            settingKey: settingKey,
            settingValue: settingValue,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> warehouseId = const Value.absent(),
            required String settingKey,
            Value<String?> settingValue = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            id: id,
            warehouseId: warehouseId,
            settingKey: settingKey,
            settingValue: settingValue,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$SettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get settingKey => $state.composableBuilder(
      column: $state.table.settingKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get settingValue => $state.composableBuilder(
      column: $state.table.settingValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseId => $state.composableBuilder(
      column: $state.table.warehouseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get settingKey => $state.composableBuilder(
      column: $state.table.settingKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get settingValue => $state.composableBuilder(
      column: $state.table.settingValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WarehousesTableTableManager get warehouses =>
      $$WarehousesTableTableManager(_db, _db.warehouses);
  $$DocksTableTableManager get docks =>
      $$DocksTableTableManager(_db, _db.docks);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db, _db.batches);
  $$ChangeSessionsTableTableManager get changeSessions =>
      $$ChangeSessionsTableTableManager(_db, _db.changeSessions);
  $$ChangeEventsTableTableManager get changeEvents =>
      $$ChangeEventsTableTableManager(_db, _db.changeEvents);
  $$SnapshotsTableTableManager get snapshots =>
      $$SnapshotsTableTableManager(_db, _db.snapshots);
  $$DailyRecordsTableTableManager get dailyRecords =>
      $$DailyRecordsTableTableManager(_db, _db.dailyRecords);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
