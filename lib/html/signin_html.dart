import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:libcli/signin/signin.dart' as signin;

main() => app.start(
      {
        '/': (context, state, data) => const BeamPage(
              type: BeamPageType.noTransition,
              key: ValueKey('/'),
              title: 'Sign in',
              child: signin.SigninScreen(),
            ),
      },
    );
