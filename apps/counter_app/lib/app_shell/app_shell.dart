// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/app_shell/app_router.dart';
import 'package:counter_app/app_shell/app_theme.dart';
import 'package:counter_app/app_shell/device_not_supported_screen.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;
import 'package:toastification/toastification.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, this.locale});

  /// The locale to use for the app.
  final Locale? locale;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  /// the navigator key to keep the navigator state from switch between side and floating layout
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // Start the boot sequence. boot() orchestrates hardware + app-flow
      // checks and drives SystemLifecycleNotifier transitions via dispatch().
      ref.read(core_domain.appProvider.notifier).boot();
    });

    // delay to avoid busy state when open project
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      final appFlow = ref.read(core_domain.appFlowProvider);
      final targetState = appFlow is core_domain.OnboardingBegin
          ? feature_pip.SlidingPanelState.open
          : (isPortrait ? feature_pip.SlidingPanelState.halfOpen : feature_pip.SlidingPanelState.open);
      ref.read(feature_pip.pipProvider.notifier).slideUp(targetState);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocaleDelegates = [
      shared_l10n.Localization.delegate,
      appkit.Localization.delegate,
      vision.Localization.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];

    // When session starts running, collapse the panel to halfOpen.
    ref.listen<core_domain.AppFlow>(core_domain.appFlowProvider, (previous, next) {
      if (previous is core_domain.OnboardingBegin && next is core_domain.SessionRunning) {
        ref.read(feature_pip.pipProvider.notifier).slideUp(feature_pip.SlidingPanelState.halfOpen);
      }
    });

    // Watch lifecycle so the widget tree rebuilds when state changes.
    // ignore: unused_local_variable
    final systemLifecycle = ref.watch(core_domain.systemLifecycleProvider);
    final defaultLocale = widget.locale ?? appkit.localeSystem;

    if (systemLifecycle == core_domain.SystemLifecycle.systemDeviceNotSupported()) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: defaultLocale,
        localizationsDelegates: appLocaleDelegates,
        supportedLocales: shared_l10n.Localization.supportedLocales,
        localeResolutionCallback: appkit.localeResolutionCallback,
        theme: AppTheme.themeData,
        home: const DeviceNotSupportedScreen(),
      );
    }

    return ToastificationWrapper(
      child: AppTheme(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          locale: defaultLocale,
          localizationsDelegates: appLocaleDelegates,
          supportedLocales: shared_l10n.Localization.supportedLocales,
          localeResolutionCallback: appkit.localeResolutionCallback,
          theme: AppTheme.themeData,
          initialRoute: '/',
          onGenerateRoute: (routeSettings) {
            return AppRouter.onGenerateRoute(routeSettings, ref, appLocaleDelegates);
          },
        ),
      ),
    );
  }
}
