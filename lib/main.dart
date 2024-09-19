import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as app;
import 'package:counter/dashboard/dashboard.dart';
import 'package:counter/index/index.dart' as index;
import 'package:flutter/material.dart';
import 'package:libcli/signin/signin.dart' as signin;

main() => app.start(
      {
        app.indexPath: (context, state, data) => BeamPage(
              key: const ValueKey('/'),
              title: context.l10n.indexPageTitle,
              child: const index.IndexScreen(),
            ),
        app.signinPath: (context, state, data) => BeamPage(
              key: const ValueKey(app.signinPath),
              title: context.l10n.indexPageTitle,
              child: const signin.SigninScreen(),
            ),
        app.dashboardPath: (context, state, data) => BeamPage(
              key: const ValueKey('dashboard'),
              title: context.l10n.dashboardPageTitle,
              child: const DashboardScreen(),
            ),
      },
    );
