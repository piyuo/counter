import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// Camera screen to choose camera
class CameraScreen extends StatelessWidget {
  const CameraScreen({
    required this.scrollController,
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

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);

    return ChangeNotifierProvider(
      create: (_) => CameraScreenProvider(),
      child: Consumer<CameraScreenProvider>(
        builder: (context, cameraScreenProvider, child) {
          return pip.PipScaffold(
              title: isAddMode ? context.l.camera_screen_add_title : context.l.camera_screen_edit_title,
              previousPageTitle: previousPageTitle,
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      CupertinoListSection(
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: List.generate(
                          projectProvider.cameraCount,
                          (index) {
                            final cameraDefine = projectProvider.getCameraDefine(index);
                            return cameraDefine != null
                                ? CupertinoListTile(
                                    leading: videoProvider.video.camera == cameraDefine
                                        ? const Icon(CupertinoIcons.check_mark)
                                        : const SizedBox.shrink(),
                                    title: Text(
                                        '${cameraDefine.isFrontCamera ? context.l.camera_screen_front_camera : context.l.camera_screen_back_camera} ${cameraDefine.title}'),
                                    onTap: () async {
                                      videoProvider.setCamera(cameraDefine);
                                      cameraScreenProvider.redraw();
                                    },
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ),

                      /// camera zoom
                      if (videoProvider.isZoomToolEnabled)
                        CupertinoListSection(
                          header: Text(context.l.camera_screen_zoom_level),
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
                                      cameraScreenProvider.redraw();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      pip.PipFooter(),
                    ],
                  )));
        },
      ),
    );
  }
}

class CameraScreenProvider with ChangeNotifier {
  CameraScreenProvider();

  /// redraw camera setting screen
  void redraw() {
    notifyListeners();
  }
}
