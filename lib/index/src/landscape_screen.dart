import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';

import 'index_screen_provider.dart';

class LandscapeScreen extends StatelessWidget {
  const LandscapeScreen({
    required this.loader,
    required this.indexScreenProvider,
    required this.maxHeight,
    super.key,
  });

  /// loader is a function that will be called when the screen is loading
  final Future<void> Function(BuildContext) loader;

  final IndexScreenProvider indexScreenProvider;

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    buildEmptyArea(double maxHeight) {
      return SliverToBoxAdapter(
          child: Image(
        height: maxHeight,
        fit: BoxFit.cover,
        image: const AssetImage('asset/images/home.png'),
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

    List<Widget> buildSidebarHeader() {
      return [
        const SizedBox(height: 16),
        const Text(
          "Piyuo People Counter",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 3),
        const Text(
          "Start new project",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 4),
        const SizedBox(height: 8),
      ];
    }

    Widget buildSidebarButton({
      required String title,
      required void Function()? onPressed,
    }) {
      return SizedBox(
          width: 220,
          height: 32, // Set a fixed height for each button
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(.15),
              foregroundColor: colorScheme.onPrimary,
            ),
            onPressed: onPressed,
            child: Text(title),
          ));
    }

    buildSidebar() {
      return Container(
        width: 240,
        color: colorScheme.inverseSurface,
        child: Column(
          children: [
            ...buildSidebarHeader(),
            const SizedBox(height: 8),
            buildSidebarButton(
              onPressed: () {},
              title: 'Count from camera',
            ),
            const SizedBox(height: 24),
            buildSidebarButton(
              onPressed: () {},
              title: 'Count from video file',
            ),
            const SizedBox(height: 24),
            buildSidebarButton(
              onPressed: () {},
              title: 'Count from RTSP stream',
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            buildSidebarButton(
              onPressed: () {},
              title: 'Continue existing project',
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Row(children: [
        buildSidebar(),
        Expanded(
            child: app.AppScaffold(
          loader: () async => await loader(context),
          builder: (isReady) => buildEmptyArea(maxHeight), //buildGrid(),
        )),
      ]);
    });
  }
}
