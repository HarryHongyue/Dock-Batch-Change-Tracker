import 'package:drift/drift.dart';

import '../database.dart';
import '../models/settings_model.dart';

class SettingsRepository {
  final AppDatabase db;

  SettingsRepository(this.db);

  Future<List<SettingsModel>> getAll() async {
    final rows = await db.select(db.settings).get();
    return rows.map(_toModel).toList();
  }

  Future<SettingsModel?> getByKey(String key, {String? warehouseId}) async {
    final row = await (db.select(db.settings)
          ..where((t) =>
              t.settingKey.equals(key) &
              ((warehouseId == null)
                  ? t.warehouseId.isNull()
                  : t.warehouseId.equals(warehouseId)))
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<String?> getValue(String key, {String? warehouseId}) async {
    final row = await getByKey(key, warehouseId: warehouseId);
    return row?.value;
  }

  Future<void> setValue(String key, String? value,
      {String? warehouseId, String? id}) async {
    final existing = await getByKey(key, warehouseId: warehouseId);
    final now = DateTime.now();
    if (existing == null) {
      await db.into(db.settings).insert(
        SettingsCompanion(
          id: Value(id ?? _newId()),
          warehouseId: Value(warehouseId),
          settingKey: Value(key),
          settingValue: Value(value),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else {
      await db.update(db.settings).replace(
        SettingsCompanion(
          id: Value(existing.id),
          warehouseId: Value(warehouseId),
          settingKey: Value(key),
          settingValue: Value(value),
          createdAt: Value(existing.createdAt ?? now),
          updatedAt: Value(now),
        ),
      );
    }
  }

  SettingsModel _toModel(Setting r) => SettingsModel(
        id: r.id,
        warehouseId: r.warehouseId,
        key: r.settingKey,
        value: r.settingValue,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
      );

  String _newId() => DateTime.now().millisecondsSinceEpoch.toString();
}
