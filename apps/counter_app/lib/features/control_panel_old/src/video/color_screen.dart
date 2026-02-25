import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

/// The color screen for editing the color.
class ColorScreen extends StatelessWidget {
  const ColorScreen({this.previousPageTitle, required this.videoProvider, super.key});

  /// the previous page title
  final String? previousPageTitle;

  /// the video zone editor controller
  final app.VideoProvider videoProvider;

  @override
  Widget build(BuildContext context) {
    final pageTitle = context.l.color_screen_title;
    return ChangeNotifierProvider<ColorScreenProvider>(
      create: (_) => ColorScreenProvider(videoProvider),
      child: Consumer<ColorScreenProvider>(
        builder: (context, colorScreenProvider, child) => feature_pip.PipScaffold(
          title: pageTitle,
          previousPageTitle: previousPageTitle,
          builder: (scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                HueRingPicker(
                  portraitOnly: true,
                  pickerColor: Colors.black,
                  enableAlpha: true,
                  onColorChanged: (color) {},
                ),
                feature_pip.PipFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColorScreenProvider with ChangeNotifier {
  ColorScreenProvider(this.videoProvider);

  /// the video zone editor controller
  final app.VideoProvider videoProvider;
}
