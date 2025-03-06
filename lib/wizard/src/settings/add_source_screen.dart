import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../project/video_sources.dart';

/// Add new video screen
class AddSourceScreen extends StatelessWidget {
  const AddSourceScreen({
    required this.onScroll,
    this.previousPageTitle,
    super.key,
  });

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

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
        create: (_) => AddSourceScreenProvider(onScroll),
        child: Consumer<AddSourceScreenProvider>(builder: (context, addSourceScreenProvider, child) {
          return SingleChildScrollView(
              controller: addSourceScreenProvider._scrollController,
              child: Column(
                children: [
                  ChangeNotifierProvider<VideoSourcesProvider>(
                      create: (_) => VideoSourcesProvider(),
                      child: Consumer<VideoSourcesProvider>(
                        builder: (context, videoStarterProvider, child) => CupertinoListSection(
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          header: Text(context.l.add_video_screen_from),
                          children: buildVideoSources(
                            context,
                            videoSourcesProvider: videoStarterProvider,
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
  AddSourceScreenProvider(pip.ScrollCallback onScroll) {
    _scrollController.addListener(() => onScroll(_scrollController));
  }

  /// The scroll controller
  final ScrollController _scrollController = ScrollController();

  void redraw() {
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
