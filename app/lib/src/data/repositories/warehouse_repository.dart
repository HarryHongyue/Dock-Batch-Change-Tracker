import 'package:drift/drift.dart';

import '../database.dart';
import '../models/warehouse_model.dart';

class WarehouseRepository {
  final AppDatabase db;

  WarehouseRepository(this.db);

  Future<List<WarehouseModel>> getAll({bool includeArchived = false}) async {
    final query = db.select(db.warehouses)
      ..where((t) => Constant(includeArchived) | t.isArchived.equals(false));
    final rows = await query.get();
    return rows
        .map(
          (r) => WarehouseModel(
            id: r.id,
            name: r.name,
            description: r.description,
            createdAt: r.createdAt,
            updatedAt: r.updatedAt,
            isArchived: r.isArchived,
          ),
        )
        .toList();
  }

  Future<WarehouseModel?> getById(String id) async {
    final row = await (db.select(db.warehouses)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return WarehouseModel(
      id: row.id,
      name: row.name,
      description: row.description,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isArchived: row.isArchived,
    );
  }

  Future<void> insert(WarehouseModel model) => db.into(db.warehouses).insert(
        WarehousesCompanion(
          id: Value(model.id),
          name: Value(model.name),
          description: Value(model.description),
          createdAt: Value(model.createdAt ?? DateTime.now()),
          updatedAt: Value(model.updatedAt ?? DateTime.now()),
          isArchived: Value(model.isArchived),
        ),
      );

  Future<void> update(WarehouseModel model) =>
      db.update(db.warehouses).replace(_companion(model, touch: true));

  WarehousesCompanion _companion(WarehouseModel m, {bool touch = false}) =>
      WarehousesCompanion(
        id: Value(m.id),
        name: Value(m.name),
        description: Value(m.description),
        createdAt: Value(m.createdAt ?? DateTime.now()),
        updatedAt: Value(touch ? DateTime.now() : (m.updatedAt ?? DateTime.now())),
        isArchived: Value(m.isArchived),
      );

  Future<void> deleteOrArchive(String id) =>
      (db.update(db.warehouses)..where((t) => t.id.equals(id))).write(
        WarehousesCompanion(
          isArchived: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
}
