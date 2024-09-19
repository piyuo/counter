import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:libcli/testing/testing.dart' as testing;

main() => app.start(
      {
        '/': (context, state, data) => const _Example(),
      },
    );

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    appScaffold(_) {
      return app.AppScaffold(
        builder: (bool isReady) {
          return const SliverToBoxAdapter(child: Text('hello'));
        },
        loader: () async {},
      );
    }

    userScaffold(_) {
      return app.UserScaffold(
        title: 'User Scaffold',
        child: Column(children: [
          Container(color: Colors.red, height: 300),
          Container(color: Colors.blue, height: 300),
          Container(color: Colors.yellow, height: 300),
          Container(color: Colors.green, height: 300),
        ]),
      );
    }

    return testing.ExampleScaffold(
      builder: appScaffold,
      buttons: [
        testing.ExampleButton('portal scaffold', builder: appScaffold, useScaffold: false),
        testing.ExampleButton('user scaffold', builder: userScaffold, useScaffold: false),
      ],
    );
  }
}
