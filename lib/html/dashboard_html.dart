import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as app;
import 'package:counter/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

main() => app.start(
      {
        '/': (context, state, data) => BeamPage(
              type: BeamPageType.noTransition,
              key: const ValueKey('dashboard'),
              title: context.l10n.dashboardPageTitle,
              child: const DashboardScreen(),
            ),
      },
    );
