import 'dart:async';

import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({
    required this.videoProvider,
    required this.videoZone,
    required this.onScroll,
    super.key,
  });

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  /// the video zone to be edited
  final vision.VideoZone videoZone;

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final pageTitle = context.l.objects_screen_title;
    return pip.PipScaffold(
      child: ChangeNotifierProvider(
          create: (_) => ObjectScreenProvider(onScroll),
          child: Consumer<ObjectScreenProvider>(builder: (context, objectScreenProvider, child) {
            return SingleChildScrollView(
              controller: objectScreenProvider._scrollController,
              child: Column(children: [
                pip.PipHeader(
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.list_bullet, size: 44, color: videoZone.color),
                      const SizedBox(height: 8.0),
                      Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(
                        context.l.objects_screen_desc,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
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
                              objectScreenProvider.selectClass(projectProvider, videoProvider, videoZone, classId);
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
class ObjectScreenProvider with ChangeNotifier {
  ObjectScreenProvider(pip.ScrollCallback onScroll) {
    _scrollController.addListener(() => onScroll(_scrollController));
  }

  /// The scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
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
    _classChangedTimer = Timer(const Duration(milliseconds: 900), () async {
      await videoProvider.rebuildRecognitionClasses();
      notifyListeners();
      _classChangedTimer = null;
    });
  }
}
