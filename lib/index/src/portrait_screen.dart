import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'index_screen_provider.dart';

const BorderRadiusGeometry _slidingRadius = BorderRadius.only(
  topLeft: Radius.circular(20.0),
  topRight: Radius.circular(20.0),
);

class PortraitScreen extends StatelessWidget {
  const PortraitScreen({
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
    buildEmptyArea(double maxHeight) {
      return SliverToBoxAdapter(
          child: Image(
        height: maxHeight,
        fit: BoxFit.cover,
        image: const AssetImage('asset/images/home.png'),
      ));
    }

    List<Widget> buildSlidingHeader() {
      return [
        const SizedBox(height: 3),
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Start new project",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 8),
      ];
    }

    Widget buildSlidingButton({
      required String title,
      required void Function()? onPressed,
    }) {
      return SizedBox(
          height: 42, // Set a fixed height for each button
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            onPressed: onPressed,
            child: Text(title),
          ));
    }

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return SlidingUpPanel(
        minHeight: 74,
        maxHeight: 390, //340,
        borderRadius: _slidingRadius,
        collapsed: Container(
          decoration: const BoxDecoration(
            borderRadius: _slidingRadius, // Add rounded corners here
          ),
          child: Column(
            children: buildSlidingHeader(),
          ),
        ),
        panel: Container(
          decoration: const BoxDecoration(
            borderRadius: _slidingRadius, // Add rounded corners here
          ),
          child: Column(
            children: [
              ...buildSlidingHeader(),
              const SizedBox(height: 8),
              buildSlidingButton(
                onPressed: () {},
                title: 'Count from camera',
              ),
              const SizedBox(height: 24),
              buildSlidingButton(
                onPressed: () {},
                title: 'Count from video file',
              ),
              const SizedBox(height: 24),
              buildSlidingButton(
                onPressed: () {},
                title: 'Count from RTSP stream',
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              buildSlidingButton(
                onPressed: () {},
                title: 'Count from existing project',
              ),
            ],
          ),
        ),
        body: app.AppScaffold(
          loader: () async {},
          builder: (isReady) => buildEmptyArea(constraints.maxHeight), //buildGrid(),
        ),
      );
    });
  }
}
