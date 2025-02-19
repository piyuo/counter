import 'dart:async';

import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/clib/clib.dart' as clib;
import 'package:vision/l10n/vision_localization.dart';

class ObjectClassScreen extends StatelessWidget {
  const ObjectClassScreen({
    required this.videoProvider,
    required this.videoZone,
    super.key,
  });

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  /// the video zone to be edited
  final clib.VideoZone videoZone;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final l = VisionLocalization.of(context);
    final pageTitle = l.object_class_screen_title;
    return pip.PipScaffold(
      title: pageTitle,
      child: ChangeNotifierProvider(
          create: (_) => ObjectClassScreenProvider(),
          child: Consumer<ObjectClassScreenProvider>(builder: (context, objectClassScreenProvider, child) {
            return SingleChildScrollView(
                child: CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: List.generate(
                      clib.ObjectClass.values.length,
                      (classId) {
                        return CupertinoListTile(
                            leading: videoZone.selectedClasses.contains(classId)
                                ? Icon(CupertinoIcons.check_mark)
                                : const SizedBox.shrink(),
                            title: Text(
                              clib.classTitleById(context, classId),
                            ),
                            trailing: Icon(clib.classIconById(classId), color: CupertinoColors.opaqueSeparator),
                            onTap: () {
                              objectClassScreenProvider.selectClass(projectProvider, videoProvider, videoZone, classId);
                            });
                      },
                    )));
          })),
    );
  }
}

/// provide object class screen support.
class ObjectClassScreenProvider with ChangeNotifier {
  ObjectClassScreenProvider();

  @override
  void dispose() {
    _classChangedTimer?.cancel();
    _classChangedTimer = null;
    super.dispose();
  }

  /// used to delay the class setting
  Timer? _classChangedTimer;

  /// select the class
  void selectClass(
    app.ProjectProvider projectProvider,
    app.VideoProvider videoProvider,
    clib.VideoZone videoZone,
    int classId,
  ) {
    videoProvider.toggleZoneSelectedClasses(videoZone, classId);
    notifyListeners();
    _classChangedTimer?.cancel();
    _classChangedTimer = Timer(const Duration(seconds: 2), () async {
      await videoProvider.rebuildRecognitionClasses();
      notifyListeners();
      _classChangedTimer = null;
    });
  }
}
