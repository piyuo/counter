import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/l10n/vision_localization.dart';

class WebcamScreen extends StatelessWidget {
  const WebcamScreen({
    required this.videoProvider,
    required this.isAddMode,
    this.previousPageTitle,
    super.key,
  });

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  /// is webcam screen from create project or add video
  final bool isAddMode;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final l = VisionLocalization.of(context);
    final pageTitle = isAddMode ? l.webcam_screen_add_title : l.webcam_screen_edit_title;
    final projectProvider = app.ProjectProvider.of(context);
    final webcamManager = projectProvider.webcamManager;
    return pip.PipScaffold(
      title: pageTitle,
      previousPageTitle: previousPageTitle,
      child: SingleChildScrollView(
          child: ChangeNotifierProvider(
        create: (_) => WebcamScreenProvider(),
        child: Consumer<WebcamScreenProvider>(
          builder: (context, webcamScreenProvider, child) {
            return Column(
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
                          projectProvider.notifyProjectChanged(videoProvider);
                          webcamScreenProvider.redraw();
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}

/// webcam provide webcam related settings
class WebcamScreenProvider with ChangeNotifier {
  /// redraw webcam setting screen
  void redraw() {
    notifyListeners();
  }
}
