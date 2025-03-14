import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
          return pip.PipScaffold(
              title: pageTitle,
              previousPageTitle: previousPageTitle,
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      CupertinoListSection(
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: List.generate(
                          projectProvider.webcamCount,
                          (index) {
                            final webcamDefine = projectProvider.getWebcamDefine(index);
                            return webcamDefine != null
                                ? CupertinoListTile(
                                    leading: videoProvider.video.webcam == webcamDefine
                                        ? const Icon(CupertinoIcons.check_mark)
                                        : const SizedBox.shrink(),
                                    title: Text(webcamDefine.name),
                                    onTap: () async {
                                      videoProvider.video.webcam = webcamDefine;
                                      await videoProvider.reload(projectProvider.project!, false);
                                      projectProvider.saveProject(videoProvider);
                                      webcamScreenProvider.redraw();
                                    },
                                  )
                                : const SizedBox.shrink();
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
  WebcamScreenProvider();

  /// redraw webcam setting screen
  void redraw() {
    notifyListeners();
  }
}
