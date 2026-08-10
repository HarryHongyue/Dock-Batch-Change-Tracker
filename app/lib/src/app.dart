import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i18n/app_localizations.dart';
import 'router.dart';
import 'theme.dart';
import 'providers/settings_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);
    final localeAsync = ref.watch(localeProvider);
    final locale = localeAsync.valueOrNull ?? const Locale('zh');

    AppLocalizations.current = AppLocalizations(locale);

    return themeAsync.when(
      data: (themeMode) => MaterialApp.router(
        title: AppLocalizations.current.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: themeMode,
        locale: locale,
        supportedLocales: const [Locale('zh'), Locale('en')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
      ),
      loading: () => MaterialApp(
        title: AppLocalizations.current.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => MaterialApp(
        title: AppLocalizations.current.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const Scaffold(
          body: Center(child: Text('加载设置失败')),
        ),
      ),
    );
  }
}
