import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/l10n/vision_localization.dart';

import '../home/video_starter.dart';

/// Add new video screen
class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({
    this.previousPageTitle,
    super.key,
  });

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final l = VisionLocalization.of(context);
    final pageTitle = l.add_video_screen_title;
    final projectProvider = app.ProjectProvider.of(context);
    return pip.PipScaffold(
      previousPageTitle: previousPageTitle,
      title: pageTitle,
      child: ChangeNotifierProvider<AddVideoScreenProvider>(
        create: (_) => AddVideoScreenProvider(),
        child: Consumer<AddVideoScreenProvider>(builder: (context, aiProvider, child) {
          return SingleChildScrollView(
              child: Column(
            children: [
              ChangeNotifierProvider<VideoStarterProvider>(
                  create: (_) => VideoStarterProvider(),
                  child: Consumer<VideoStarterProvider>(
                    builder: (context, videoStarterProvider, child) => CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(l.add_video_screen_from),
                      children: buildVideoStarter(
                        context,
                        videoStarterProvider: videoStarterProvider,
                        projectProvider: projectProvider,
                        isAddMode: true,
                        previousPageTitle: previousPageTitle,
                      ),
                    ),
                  )),
            ],
          ));
        }),
      ),
    );
  }
}

/// provider for add video screen
class AddVideoScreenProvider with ChangeNotifier {
  AddVideoScreenProvider();

  void redraw() {
    notifyListeners();
  }
}
