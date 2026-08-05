
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/services/settings_service.dart';
import 'database_provider.dart';

export '../data/services/settings_service.dart';

const String _prefLocale = 'app_locale';

final settingsProvider = FutureProvider<SettingsService>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return SettingsService.create(db);
});

final themeModeProvider = FutureProvider<ThemeMode>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  return settings.themeMode;
});

final localeProvider = FutureProvider<Locale>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString(_prefLocale);
  if (saved == null) {
    final platform = WidgetsBinding.instance.platformDispatcher.locale;
    if (platform.languageCode == 'zh') {
      return const Locale('zh');
    }
    return const Locale('en');
  }
  if (saved == 'en') {
    return const Locale('en');
  }
  return const Locale('zh');
});

Future<void> setLocale(String code) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_prefLocale, code);
}
