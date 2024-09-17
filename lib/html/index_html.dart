import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as app;
import 'package:counter/index/index.dart' as index;
import 'package:flutter/material.dart';

main() => app.start(
      {
        '/': (context, state, data) => BeamPage(
              type: BeamPageType.noTransition,
              key: const ValueKey('/'),
              title: context.l10n.indexPageTitle,
              child: const index.IndexScreen(),
            ),
      },
    );
