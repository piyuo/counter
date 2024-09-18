import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';

import 'index_screen_provider.dart';

class LandscapeScreen extends StatelessWidget {
  const LandscapeScreen({
    required this.loader,
    required this.indexScreenProvider,
    super.key,
  });

  /// loader is a function that will be called when the screen is loading
  final Future<void> Function(BuildContext) loader;

  final IndexScreenProvider indexScreenProvider;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    buildContent() {
      return SliverToBoxAdapter(
          child: const Image(
        fit: BoxFit.fitHeight,
        image: AssetImage('asset/images/home.png'),
      ));
    }

    buildGrid() {
      return DecoratedSliver(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/home.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          sliver: SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                //childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.9),
                    //margin: const EdgeInsets.all(10),
                    child: Text('Project $index'),
                  );
                },
                childCount: 32,
              ),
            ),
          ));
    }

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return app.AppScaffold(
        loader: () async => await loader(context),
        builder: (isReady) => buildContent(), //buildGrid(),
      );
    });
  }
}
