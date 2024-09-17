import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_lib/delta/delta.dart' as delta;

import 'index_screen_provider.dart';

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
            Widget restraintWidth(Widget child) {
              return Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: child,
                    )),
              );
            }

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
          },
        ));
  }
}
