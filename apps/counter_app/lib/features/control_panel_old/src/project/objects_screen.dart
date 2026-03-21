import 'dart:async';

import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({required this.videoProvider, super.key});

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final pageTitle = context.l.objects_screen_title;
    return feature_pip.PipScaffold(
      builder: (scrollController) => ChangeNotifierProvider(
        create: (_) => ObjectScreenProvider(),
        child: Consumer<ObjectScreenProvider>(
          builder: (context, objectScreenProvider, child) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.list_bullet, size: 44),
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(context.l.objects_screen_desc, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
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
