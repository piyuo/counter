import 'dart:async';

import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

class ObjectClassScreen extends StatelessWidget {
  const ObjectClassScreen({
    required this.videoProvider,
    required this.videoZone,
    super.key,
  });

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  /// the video zone to be edited
  final vision.VideoZone videoZone;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final pageTitle = context.l.object_class_screen_title;
    return pip.PipScaffold(
      title: pageTitle,
      child: ChangeNotifierProvider(
          create: (_) => ObjectClassScreenProvider(),
          child: Consumer<ObjectClassScreenProvider>(builder: (context, objectClassScreenProvider, child) {
            return SingleChildScrollView(
              child: Column(children: [
                CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: List.generate(
                      vision.ObjectClass.values.length,
                      (classId) {
                        return CupertinoListTile(
                            leading: videoZone.selectedClasses.contains(classId)
                                ? Icon(CupertinoIcons.check_mark)
                                : const SizedBox.shrink(),
                            title: Text(
                              vision.classTitleById(context, classId),
                            ),
                            trailing: Icon(vision.classIconById(classId), color: CupertinoColors.opaqueSeparator),
                            onTap: () {
                              objectClassScreenProvider.selectClass(projectProvider, videoProvider, videoZone, classId);
                            });
                      },
                    )),
                pip.PipFooter(),
              ]),
            );
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
    vision.VideoZone videoZone,
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
