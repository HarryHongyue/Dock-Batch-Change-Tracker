import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'ui/pages/batch_detail_page.dart';
import 'ui/pages/change_mode_page.dart';
import 'ui/pages/daily_record_page.dart';
import 'ui/pages/dock_detail_page.dart';
import 'ui/pages/dock_kanban_page.dart';
import 'ui/pages/onboarding_page.dart';
import 'ui/pages/settings_page.dart';
import 'ui/pages/snapshot_compare_page.dart';
import 'ui/pages/splash_page.dart';
import 'ui/pages/timeline_page.dart';
import 'ui/pages/warehouse_list_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/warehouses',
        builder: (context, state) => const WarehouseListPage(),
      ),
      GoRoute(
        path: '/kanban',
        builder: (context, state) => DockKanbanPage(
          warehouseId: state.uri.queryParameters['warehouseId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/change',
        builder: (context, state) => ChangeModePage(
          warehouseId: state.uri.queryParameters['warehouseId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/timeline',
        builder: (context, state) => const TimelinePage(),
      ),
      GoRoute(
        path: '/batch/:id',
        builder: (context, state) => BatchDetailPage(
          batchId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: '/dock/:id',
        builder: (context, state) => DockDetailPage(
          dockId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: '/daily',
        builder: (context, state) => const DailyRecordPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/snapshot-compare',
        builder: (context, state) => SnapshotComparePage(
          beforeId: state.uri.queryParameters['beforeId'],
          afterId: state.uri.queryParameters['afterId'],
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('路由未找到: ${state.uri}'),
      ),
    ),
  );
});
