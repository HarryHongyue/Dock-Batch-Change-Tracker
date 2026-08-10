import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/app_localizations.dart';
import '../../providers/settings_provider.dart';
import '../../providers/warehouse_providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final settings = await ref.read(settingsProvider.future);
    final isFirstRun = settings.isFirstRun;

    if (!mounted) return;

    if (isFirstRun) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      context.go('/onboarding');
      return;
    }

    final warehouses = await ref.read(warehouseListProvider.future);
    if (!mounted) return;

    if (warehouses.isEmpty) {
      context.go('/onboarding');
      return;
    }

    final currentId = settings.currentWarehouseId;
    if (currentId != null && warehouses.any((w) => w.id == currentId)) {
      context.go('/kanban?warehouseId=$currentId');
    } else {
      context.go('/warehouses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).appName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              '正在初始化本地数据库…',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
