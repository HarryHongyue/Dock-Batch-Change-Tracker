import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/settings_service.dart';
import 'database_provider.dart';

export '../data/services/settings_service.dart';

final settingsProvider = FutureProvider<SettingsService>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return SettingsService.create(db);
});

final themeModeProvider = FutureProvider<ThemeMode>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  return settings.themeMode;
});
