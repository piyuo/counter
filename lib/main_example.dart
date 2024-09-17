import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as app;
import 'package:counter/dashboard/dashboard.dart';
import 'package:counter/index/example/index_example.dart' as index_example;
import 'package:flutter/material.dart';
import 'package:sample_lib/signin/signin.dart' as signin;

main() => app.start(
      {
        app.indexPath: (context, _, __) => BeamPage(
              key: const ValueKey('/'),
              title: context.l10n.indexPageTitle,
              child: index_example.indexExample(context),
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
