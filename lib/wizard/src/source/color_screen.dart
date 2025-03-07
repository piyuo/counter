import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

/// The color screen for editing the color.
class ColorScreen extends StatelessWidget {
  const ColorScreen({
    required this.onScroll,
    this.previousPageTitle,
    required this.videoProvider,
    required this.videoZone,
    super.key,
  });

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  /// the previous page title
  final String? previousPageTitle;

  /// the video zone editor controller
  final app.VideoProvider videoProvider;

  /// the video zone to be edited
  final vision.VideoZone videoZone;

  @override
  Widget build(BuildContext context) {
    final pageTitle = context.l.color_screen_title;
    return ChangeNotifierProvider<ColorScreenProvider>(
        create: (_) => ColorScreenProvider(videoProvider, onScroll),
        child: Consumer<ColorScreenProvider>(
            builder: (context, colorScreenProvider, child) => pip.PipScaffold(
                  title: pageTitle,
                  previousPageTitle: previousPageTitle,
                  child: SingleChildScrollView(
                    controller: colorScreenProvider._scrollController,
                    child: Column(
                      children: [
                        HueRingPicker(
                          portraitOnly: true,
                          pickerColor: videoZone.color,
                          enableAlpha: true,
                          onColorChanged: (color) {
                            colorScreenProvider.setVideoZoneColor(videoZone, color);
                          },
                        ),
                        pip.PipFooter(),
                      ],
                    ),
                  ),
                )));
  }
}

class ColorScreenProvider with ChangeNotifier {
  ColorScreenProvider(this.videoProvider, pip.ScrollCallback onScroll) {
    _scrollController.addListener(() => onScroll(_scrollController));
  }

  /// the video zone editor controller
  final app.VideoProvider videoProvider;

  /// The scroll controller
  final ScrollController _scrollController = ScrollController();

  /// set the color of the video zone
  void setVideoZoneColor(vision.VideoZone videoZone, Color color) {
    videoProvider.setZoneColor(videoZone, color);
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
