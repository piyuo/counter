import 'dart:async';

import 'package:counter/l10n/l10n.dart';
import 'package:counter/monitor/monitor.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({required this.videoProvider, required this.scrollController, super.key});

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final pageTitle = context.l.objects_screen_title;
    return pip.PipScaffold(
      child: ChangeNotifierProvider(
        create: (_) => ObjectScreenProvider(),
        child: Consumer<ObjectScreenProvider>(
          builder: (context, objectScreenProvider, child) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.list_bullet, size: 44),
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(context.l.objects_screen_desc, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  pip.PipFooter(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// provide object class screen support.
class ObjectScreenProvider with ChangeNotifier {
  ObjectScreenProvider();

  @override
  void dispose() {
    _classChangedTimer?.cancel();
    _classChangedTimer = null;
    super.dispose();
  }

  /// used to delay the class setting
  Timer? _classChangedTimer;

  /// select the class
  void selectClass(app.ProjectProvider projectProvider, app.VideoProvider videoProvider, int classId) {
    videoProvider.toggleObjectClass(classId);
    notifyListeners();
    _classChangedTimer?.cancel();
    _classChangedTimer = Timer(const Duration(milliseconds: 900), () async {
      await videoProvider.setObjectClassesToRecognition();
      notifyListeners();
      _classChangedTimer = null;
    });
  }
}
