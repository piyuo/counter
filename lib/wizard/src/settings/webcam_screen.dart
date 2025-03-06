import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class WebcamScreen extends StatelessWidget {
  const WebcamScreen({
    required this.onScroll,
    required this.videoProvider,
    required this.isAddMode,
    this.previousPageTitle,
    super.key,
  });

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  /// is webcam screen from create project or add video
  final bool isAddMode;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final pageTitle = isAddMode ? context.l.webcam_screen_add_title : context.l.webcam_screen_edit_title;
    final projectProvider = app.ProjectProvider.of(context);
    final webcamManager = projectProvider.webcamManager;
    return ChangeNotifierProvider(
      create: (_) => WebcamScreenProvider(onScroll),
      child: Consumer<WebcamScreenProvider>(
        builder: (context, webcamScreenProvider, child) {
          return pip.PipScaffold(
              title: pageTitle,
              previousPageTitle: previousPageTitle,
              child: SingleChildScrollView(
                  controller: webcamScreenProvider._scrollController,
                  child: Column(
                    children: [
                      CupertinoListSection(
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: List.generate(
                          webcamManager.webcamDefines.length,
                          (index) {
                            final webcamDefine = webcamManager.webcamDefines[index];
                            return CupertinoListTile(
                              leading: videoProvider.video.webcam == webcamDefine
                                  ? const Icon(CupertinoIcons.check_mark)
                                  : const SizedBox.shrink(),
                              title: Text(webcamDefine.name),
                              onTap: () async {
                                videoProvider.video.webcam = webcamDefine;
                                await videoProvider.reload(context, projectProvider.project!, false);
                                projectProvider.saveProject(videoProvider);
                                webcamScreenProvider.redraw();
                              },
                            );
                          },
                        ),
                      ),
                      pip.PipFooter(),
                    ],
                  )));
        },
      ),
    );
  }
}

/// webcam provide webcam related settings
class WebcamScreenProvider with ChangeNotifier {
  WebcamScreenProvider(pip.ScrollCallback onScroll) {
    _scrollController.addListener(() => onScroll(_scrollController));
  }

  /// The scroll controller
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// redraw webcam setting screen
  void redraw() {
    notifyListeners();
  }
}
