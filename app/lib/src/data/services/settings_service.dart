import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../database.dart';
import '../repositories/settings_repository.dart';

class SettingsService {
  final SharedPreferences? prefs;
  final SettingsRepository? repo;

  SettingsService({this.prefs, this.repo});

  static Future<SettingsService> create(AppDatabase db) async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsService(prefs: prefs, repo: SettingsRepository(db));
  }

  bool get isFirstRun =>
      prefs?.getBool(AppConstants.prefFirstRun) ?? true;

  Future<void> setFirstRun(bool value) async {
    await prefs?.setBool(AppConstants.prefFirstRun, value);
  }

  String? get currentWarehouseId =>
      prefs?.getString(AppConstants.prefCurrentWarehouse);

  Future<void> setCurrentWarehouse(String? value) async {
    if (value == null) {
      await prefs?.remove(AppConstants.prefCurrentWarehouse);
    } else {
      await prefs?.setString(AppConstants.prefCurrentWarehouse, value);
    }
  }

  ThemeMode get themeMode {
    final raw = prefs?.getString(AppConstants.prefThemeMode) ?? 'system';
    return ThemeMode.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await prefs?.setString(AppConstants.prefThemeMode, mode.name);
  }

  Future<String?> getPin() async {
    return prefs?.getString('pin_code');
  }

  Future<void> setPin(String? pin) async {
    if (pin == null || pin.isEmpty) {
      await prefs?.remove('pin_code');
    } else {
      await prefs?.setString('pin_code', pin);
    }
  }
}
