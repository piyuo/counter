import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/l10n/vision_localization.dart';

/// Camera screen to choose camera
class CameraScreen extends StatelessWidget {
  const CameraScreen({
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
    final projectProvider = app.ProjectProvider.of(context);
    final cameraManager = projectProvider.cameraManager;
    final l = VisionLocalization.of(context);

    return pip.PipScaffold(
      title: isAddMode ? l.camera_screen_add_title : l.camera_screen_edit_title,
      previousPageTitle: previousPageTitle,
      child: SingleChildScrollView(
          child: ChangeNotifierProvider(
        create: (_) => CameraScreenProvider(),
        child: Consumer<CameraScreenProvider>(
          builder: (context, cameraScreenProvider, child) {
            return Column(
              children: [
                CupertinoListSection(
                  backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                  children: List.generate(
                    cameraManager.cameraDefines.length,
                    (index) {
                      final cameraDefine = cameraManager.cameraDefines[index];
                      return CupertinoListTile(
                        leading: videoProvider.video.camera == cameraDefine
                            ? const Icon(CupertinoIcons.check_mark)
                            : const SizedBox.shrink(),
                        title: Text(
                            '${cameraDefine.isFrontCamera ? l.camera_screen_front_camera : l.camera_screen_back_camera} ${cameraDefine.title}'),
                        onTap: () async {
                          videoProvider.video.camera = cameraDefine;
                          await videoProvider.reload(context, projectProvider.project!, false);
                          projectProvider.notifyProjectChanged(videoProvider);
                          cameraScreenProvider.redraw();
                        },
                      );
                    },
                  ),
                ),

                /// camera zoom
                if (videoProvider.isZoomToolEnabled)
                  CupertinoListSection(
                    header: Text(l.camera_screen_zoom_level),
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                          leading: Icon(CupertinoIcons.zoom_in),
                          trailing: Icon(CupertinoIcons.zoom_out),
                          title: SizedBox(
                            width: double.infinity,
                            child: CupertinoSlider(
                              value: videoProvider.zoom,
                              max: videoProvider.maxZoom,
                              min: videoProvider.minZoom,
                              divisions: videoProvider.maxZoom.toInt(),
                              onChanged: (double value) async {
                                await videoProvider.setCameraZoom(value);
                                projectProvider.notifyProjectChanged(videoProvider);
                                cameraScreenProvider.redraw();
                              },
                            ),
                          )),
                    ],
                  ),
              ],
            );
          },
        ),
      )),
    );
  }
}

class CameraScreenProvider with ChangeNotifier {
  /// redraw camera setting screen
  void redraw() {
    notifyListeners();
  }
}
