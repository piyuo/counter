import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

/// The color screen for editing the color.
class ColorScreen extends StatelessWidget {
  const ColorScreen({required this.scrollController, this.previousPageTitle, required this.videoProvider, super.key});

  /// the scroll controller
  final ScrollController scrollController;

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
        builder: (context, colorScreenProvider, child) => pip.PipScaffold(
          title: pageTitle,
          previousPageTitle: previousPageTitle,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                HueRingPicker(
                  portraitOnly: true,
                  pickerColor: Colors.black,
                  enableAlpha: true,
                  onColorChanged: (color) {},
                ),
                pip.PipFooter(),
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
