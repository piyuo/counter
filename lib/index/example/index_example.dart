import 'package:counter/app/app.dart' as app;
import 'package:counter/index/index.dart' as index;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_lib/testing/testing.dart' as testing;

main() => app.start(
      {
        '/': (context, state, data) => const Example(),
      },
    );

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const testing.ExampleScaffold(
      builder: indexExample,
      buttons: [
        testing.ExampleButton(
          'index page',
          builder: indexExample,
          useScaffold: false,
        ),
      ],
    );
  }
}

Widget indexExample(BuildContext context) {
  return MultiProvider(providers: [
    ChangeNotifierProvider<index.IndexScreenProvider>(
      create: (_) => index.IndexScreenProvider(),
    ),
  ], child: const index.IndexScreen());
}
