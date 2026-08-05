import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../data/services/export_service.dart';
import '../../data/services/seed_service.dart';
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
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: settingsAsync.when(
        data: (settings) => _buildBody(context, settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: ' + e.toString())),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingsService settings) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('深色模式'),
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
          title: const Text('仓库管理'),
          onTap: () => context.push('/warehouses'),
        ),
        ListTile(
          leading: const Icon(Icons.science),
          title: const Text('载入测试数据'),
          subtitle: const Text('创建 Maastricht 仓库及示例数据'),
          onTap: () => _seed(context),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.file_upload),
          title: const Text('导出 JSON 备份'),
          onTap: () => _exportJson(context),
        ),
        ListTile(
          leading: const Icon(Icons.table_chart),
          title: const Text('导出 CSV'),
          onTap: () => _exportCsv(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _importPathController,
            decoration: const InputDecoration(
              labelText: '备份文件路径',
              hintText: '输入要导入的 JSON 文件完整路径',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () => _importJson(context),
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
                    '导入 JSON',
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
        const ListTile(
          leading: Icon(Icons.info),
          title: Text('关于'),
          subtitle: Text(AppConstants.appNameCn + ' v' + AppConstants.appVersion),
        ),
      ],
    );
  }

  Future<void> _seed(BuildContext context) async {
    try {
      final db = await ref.read(databaseProvider.future);
      await SeedService(db).seed();
      _refresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('测试数据已载入')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('载入失败: ' + e.toString())),
        );
      }
    }
  }

  Future<void> _exportJson(BuildContext context) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final path = await ExportService(db).exportJson();
      await ExportService(db).shareFiles([path]);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: ' + e.toString())),
        );
      }
    }
  }

  Future<void> _exportCsv(BuildContext context) async {
    try {
      final db = await ref.read(databaseProvider.future);
      final paths = await ExportService(db).exportCsv();
      await ExportService(db).shareFiles(paths);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: ' + e.toString())),
        );
      }
    }
  }

  Future<void> _importJson(BuildContext context) async {
    final path = _importPathController.text.trim();
    if (path.isEmpty) return;
    if (!File(path).existsSync()) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('文件不存在')),
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
          SnackBar(content: Text('已导入 ' + count.toString() + ' 条记录')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导入失败: ' + e.toString())),
        );
      }
    }
  }

  void _refresh() {
    ref.invalidate(databaseProvider);
    ref.invalidate(settingsProvider);
  }
}
