import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../project/video_sources.dart';

/// Add new video screen
class AddSourceScreen extends StatelessWidget {
  const AddSourceScreen({
    this.previousPageTitle,
    super.key,
  });

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final pageTitle = context.l.add_video_screen_title;
    final projectProvider = app.ProjectProvider.of(context);
    return pip.PipScaffold(
      previousPageTitle: previousPageTitle,
      title: pageTitle,
      child: ChangeNotifierProvider<AddSourceScreenProvider>(
        create: (_) => AddSourceScreenProvider(),
        child: Consumer<AddSourceScreenProvider>(builder: (context, aiProvider, child) {
          return SingleChildScrollView(
              child: Column(
            children: [
              ChangeNotifierProvider<VideoStarterProvider>(
                  create: (_) => VideoStarterProvider(),
                  child: Consumer<VideoStarterProvider>(
                    builder: (context, videoStarterProvider, child) => CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.add_video_screen_from),
                      children: buildVideoSources(
                        context,
                        videoStarterProvider: videoStarterProvider,
                        projectProvider: projectProvider,
                        isAddMode: true,
                        previousPageTitle: previousPageTitle,
                      ),
                    ),
                  )),
              pip.PipFooter(),
            ],
          ));
        }),
      ),
    );
  }
}

/// provider for add video screen
class AddSourceScreenProvider with ChangeNotifier {
  AddSourceScreenProvider();

  void redraw() {
    notifyListeners();
  }
}
