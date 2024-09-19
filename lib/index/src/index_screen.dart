import 'package:flutter/material.dart';
import 'package:libcli/delta/delta.dart' as delta;
import 'package:provider/provider.dart';

import 'index_screen_provider.dart';
import 'landscape_screen.dart';
import 'portrait_screen.dart';

const kMaxContentWidth = 1024.0;

final kHorizontalPadding = delta.phoneScreen ? 10.0 : 28.0;

/// _load providers when loading screen show
Future<void> _load(BuildContext context) async {}

class IndexScreen extends StatelessWidget {
  const IndexScreen({
    this.loader = _load,
    super.key,
  });

  /// loader is a function that will be called when the screen is loading
  final Future<void> Function(BuildContext) loader;

  @override
  Widget build(BuildContext context) {
    debugPrint('default font family: ${DefaultTextStyle.of(context).style.fontFamily}');
    final colorScheme = Theme.of(context).colorScheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<IndexScreenProvider>(
            create: (context) => IndexScreenProvider(),
          ),
        ],
        child: Consumer<IndexScreenProvider>(
          builder: (context, indexScreenProvider, _) {
            return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              final isLandscape = constraints.maxWidth > 744; // 744 is ipad mini portrait width
              return isLandscape
                  ? LandscapeScreen(
                      loader: loader,
                      indexScreenProvider: indexScreenProvider,
                      maxHeight: constraints.maxHeight,
                    )
                  : PortraitScreen(
                      loader: loader,
                      indexScreenProvider: indexScreenProvider,
                      maxHeight: constraints.maxHeight,
                    );
            });
          },
        ));
  }
}
