import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../i18n/app_localizations.dart';
import '../../data/services/export_service.dart';

import '../../providers/database_provider.dart';
import '../../providers/settings_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _importPathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: settingsAsync.when(
        data: (settings) => _buildBody(context, l, settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.loadFailed)),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l, SettingsService settings) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(l.language),
          trailing: DropdownButton<Locale>(
            value: ref.watch(localeProvider).valueOrNull ?? const Locale('zh'),
            items: const [
              DropdownMenuItem(value: Locale('zh'), child: Text('简体中文')),
              DropdownMenuItem(value: Locale('en'), child: Text('English')),
            ],
            onChanged: (v) async {
              if (v == null) return;
              await setLocale(v.languageCode);
              ref.invalidate(localeProvider);
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: Text(l.theme),
          trailing: DropdownButton<ThemeMode>(
            value: settings.themeMode,
            items: ThemeMode.values
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(m.name),
                    ))
                .toList(),
            onChanged: (m) async {
              if (m == null) return;
              await settings.setThemeMode(m);
              ref.invalidate(themeModeProvider);
            },
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.account_balance),
          title: Text(l.warehouseList),
          onTap: () => context.push('/warehouses'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.file_upload),
          title: Text('JSON ${l.exportFailed}'),
          onTap: () => _exportJson(context, l),
        ),
        ListTile(
          leading: const Icon(Icons.table_chart),
          title: Text('CSV ${l.exportFailed}'),
          onTap: () => _exportCsv(context, l),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _importPathController,
            decoration: InputDecoration(
              labelText: l.importFailed,
              hintText: l.inputDockName,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () => _importJson(context, l),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.35),
                    offset: const Offset(-6, -6),
                    blurRadius: 12,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(6, 6),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_download,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l.importFailed,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info),
          title: Text(l.about),
          subtitle: Text.rich(
            TextSpan(
              text: l.appNameFull,
              children: const [
                TextSpan(text: ' v'),
                TextSpan(text: AppConstants.appVersion),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _exportJson(BuildContext context, AppLocalizations l) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final path = await ExportService(db).exportJson();
      await ExportService(db).shareFiles([path]);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.exportFailed)),
        );
      }
    }
  }

  Future<void> _exportCsv(BuildContext context, AppLocalizations l) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final paths = await ExportService(db).exportCsv();
      await ExportService(db).shareFiles(paths);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.exportFailed)),
        );
      }
    }
  }

  Future<void> _importJson(BuildContext context, AppLocalizations l) async {
    final path = _importPathController.text.trim();
    if (path.isEmpty) return;
    if (!File(path).existsSync()) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.fileNotFound)),
        );
      }
      return;
    }
    try {
      final db = await ref.read(databaseProvider.future);
      final count = await ExportService(db).importJson(path);
      _refresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.recordsImported(count))),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.importFailed)),
        );
      }
    }
  }

  void _refresh() {
    ref.invalidate(databaseProvider);
    ref.invalidate(settingsProvider);
  }
}
