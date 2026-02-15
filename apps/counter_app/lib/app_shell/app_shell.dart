// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/app_shell/app_providers.dart';
import 'package:counter_app/app_shell/app_router.dart';
import 'package:counter_app/app_shell/app_theme.dart';
import 'package:counter_app/features/control_panel/control_panel.dart' as control_panel;
import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:provider/provider.dart' as provider;
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;
import 'package:toastification/toastification.dart';

final GlobalKey<control_panel.ControlPanelShellState> wizardKey = GlobalKey<control_panel.ControlPanelShellState>();

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, this.locale});

  /// The locale to use for the app.
  final Locale? locale;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    // delay to avoid busy state when open project
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      ref
          .read(feature_pip.pipProvider.notifier)
          .slideUp(isPortrait ? feature_pip.SlidingPanelState.halfOpen : feature_pip.SlidingPanelState.open);
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

    final pipState = ref.watch(feature_pip.pipProvider);

    return AppProviders(
      child: CupertinoTheme(
        data: AppTheme.cupertinoTheme,
        child: provider.Consumer<app.ProjectProvider>(
          builder: (context, projectProvider, child) {
            // app lifecycle start
            // ignore: unused_local_variable
            final lifecycle = ref.watch(core_domain.lifecycleProvider);
            final defaultLocale = widget.locale ?? appkit.localeSystem;

            return ToastificationWrapper(
              child: MaterialApp(
                navigatorKey: projectProvider.navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: defaultLocale,
                localizationsDelegates: appLocaleDelegates,
                supportedLocales: shared_l10n.Localization.supportedLocales,
                localeResolutionCallback: appkit.localeResolutionCallback,
                theme: AppTheme.materialTheme,
                navigatorObservers: [pipState.scrollObserver],
                initialRoute: '/',
                onGenerateRoute: (routeSettings) {
                  return AppRouter.onGenerateRoute(routeSettings, ref, projectProvider, wizardKey, appLocaleDelegates);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
