import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class WebcamScreen extends StatelessWidget {
  const WebcamScreen({
    required this.scrollController,
    required this.videoProvider,
    required this.isAddMode,
    this.previousPageTitle,
    super.key,
  });

  /// the scroll controller
  final ScrollController scrollController;

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
    return ChangeNotifierProvider(
      create: (_) => WebcamScreenProvider(),
      child: Consumer<WebcamScreenProvider>(
        builder: (context, webcamScreenProvider, child) {
          return feature_pip.PipScaffold(
            title: pageTitle,
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  CupertinoListSection(
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    children: List.generate(projectProvider.webcamCount, (index) {
                      final webcamDefine = projectProvider.getWebcamDefine(index);
                      return webcamDefine != null
                          ? CupertinoListTile(
                              leading: videoProvider.video.webcam == webcamDefine
                                  ? const Icon(CupertinoIcons.check_mark)
                                  : const SizedBox.shrink(),
                              title: Text(webcamDefine.name),
                              onTap: () async {
                                videoProvider.video.webcam = webcamDefine;
                                await videoProvider.reload(projectProvider.project!);
                                projectProvider.saveProject(videoProvider);
                                webcamScreenProvider.redraw();
                              },
                            )
                          : const SizedBox.shrink();
                    }),
                  ),
                  feature_pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// webcam provide webcam related settings
class WebcamScreenProvider with ChangeNotifier {
  WebcamScreenProvider();

  /// redraw webcam setting screen
  void redraw() {
    notifyListeners();
  }
}
