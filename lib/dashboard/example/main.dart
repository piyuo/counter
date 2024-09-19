import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:libcli/testing/testing.dart' as testing;
import 'package:provider/provider.dart';

import '../dashboard.dart';

main() => app.start(
      {
        '/': (context, state, data) => const DashboardExample(),
      },
    );

class DashboardExample extends StatelessWidget {
  const DashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    dashboardScreen(_) {
      return MultiProvider(providers: [
        ChangeNotifierProvider<DashboardScreenProvider>(
          create: (_) => DashboardScreenProvider(),
        ),
      ], child: const DashboardScreen());
    }

    quickStart(_) {
      return const QuickStart();
    }

    return testing.ExampleScaffold(
      builder: dashboardScreen,
      buttons: [
        testing.ExampleButton('dashboard screen', builder: dashboardScreen, useScaffold: false),
        testing.ExampleButton('quick start', builder: quickStart, useScaffold: false),
      ],
    );
  }
}
