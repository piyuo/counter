import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';
import 'package:vision/clib/clib.dart' as clib;

class CounterScreen extends StatelessWidget {
  const CounterScreen({
    required this.videoProvider,
    required this.videoZone,
    required this.annotation,
    super.key,
  });

  /// the video provider this settings is working on
  final app.VideoProvider videoProvider;

  /// the video zone to be edited
  final clib.VideoZone videoZone;

  /// the annotation to edit
  final clib.TallyAnnotation annotation;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TallyScreenProvider(videoProvider, annotation),
      child: Consumer<TallyScreenProvider>(
        builder: (context, tallyScreenProvider, child) {
          return pip.PipScaffold(
              child: SingleChildScrollView(
            child: Column(children: [
              pip.PipHeader(
                child: Column(
                  children: [
                    Text(clib.tallyTypeToString(context, annotation.type),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text(
                      clib.tallyTypeToDescription(context, annotation.type),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CupertinoListSection(
                header: Text(context.l.counter_screen_show_on),
                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                children: [
                  CupertinoListTile(
                    title: Text(context.l.counter_screen_enabled),
                    trailing: CupertinoSwitch(
                      // This bool value toggles the switch.
                      value: annotation.enabled,
                      onChanged: (bool? value) {
                        tallyScreenProvider.toggleEnabled(context, videoProvider, videoZone, annotation);
                      },
                    ),
                  ),
                ],
              ),
              CupertinoListSection(
                header: const Text('Title'),
                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                footer: tallyScreenProvider._titleErrorMessage.isNotEmpty
                    ? Text(
                        tallyScreenProvider._titleErrorMessage,
                        style: TextStyle(color: CupertinoColors.systemRed),
                      )
                    : null,
                children: [
                  CupertinoTextField(
                    decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    padding: const EdgeInsets.all(16),
                    controller: tallyScreenProvider.titleController,
                    onChanged: (text) => tallyScreenProvider.setTitle(context, text),
                  )
                ],
              ),
              if (annotation.type == clib.TallyType.reentered)
                CupertinoListSection(
                  backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                  header: Text(context.l.counter_screen_reentry_threshold),
                  footer: Text(context.l.counter_screen_reentry_desc
                      .replaceAll('#0', '${videoZone.reenteredThreshold}')
                      .replaceAll('#1', '${videoZone.cooldownThreshold}')),
                  children: [
                    CupertinoListTile(
                      title: Text(context.l.counter_screen_reentry_title),
                      trailing: InputQty(
                        initVal: videoZone.reenteredThreshold,
                        onQtyChanged: (v) {
                          tallyScreenProvider.setReenteredThreshold(videoZone, v.toInt());
                        },
                        decoration: QtyDecorationProps(
                          isBordered: false,
                          borderShape: BorderShapeBtn.circle,
                          btnColor: CupertinoColors.activeBlue,
                          width: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              if (annotation.type == clib.TallyType.reentered)
                CupertinoListSection(
                  backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                  header: Text(context.l.counter_screen_cooldown_threshold),
                  footer:
                      Text(context.l.counter_screen_cooldown_desc.replaceAll('#0', '${videoZone.cooldownThreshold}')),
                  children: [
                    CupertinoListTile(
                      title: Text(context.l.counter_screen_cooldown_time),
                      subtitle: Text(context.l.counter_screen_cooldown_in_seconds),
                      trailing: InputQty(
                        initVal: videoZone.cooldownThreshold,
                        onQtyChanged: (v) {
                          tallyScreenProvider.setCooldownThreshold(videoZone, v.toInt());
                        },
                        decoration: QtyDecorationProps(
                          isBordered: false,
                          borderShape: BorderShapeBtn.circle,
                          btnColor: CupertinoColors.activeBlue,
                          width: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              if (annotation.type == clib.TallyType.stagnant)
                CupertinoListSection(
                  backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                  header: Text(context.l.counter_screen_stagnant_threshold),
                  footer: Text(
                    context.l.counter_screen_stagnant_desc.replaceAll('#0', '${videoZone.stagnantThreshold}'),
                  ),
                  children: [
                    CupertinoListTile(
                      title: Text(context.l.counter_screen_stagnant_consider),
                      subtitle: Text(context.l.counter_screen_stagnant_in_seconds),
                      trailing: InputQty(
                        initVal: videoZone.stagnantThreshold,
                        onQtyChanged: (v) {
                          tallyScreenProvider.setStagnantThreshold(videoZone, v.toInt());
                        },
                        decoration: QtyDecorationProps(
                          isBordered: false,
                          borderShape: BorderShapeBtn.circle,
                          btnColor: CupertinoColors.activeBlue,
                          width: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              CupertinoListSection(
                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                header: Text(context.l.counter_screen_stagnant_desc_prefix),
                children: [
                  CupertinoTextField(
                    decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    padding: const EdgeInsets.all(16),
                    controller: tallyScreenProvider.prefixController,
                    onChanged: (text) => tallyScreenProvider.setPrefix(text),
                  )
                ],
              ),
              CupertinoListSection(
                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                header: Text(context.l.counter_screen_stagnant_desc_suffix),
                children: [
                  CupertinoTextField(
                    decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    padding: const EdgeInsets.all(16),
                    controller: tallyScreenProvider.suffixController,
                    onChanged: (text) => tallyScreenProvider.setSuffix(text),
                  )
                ],
              ),
            ]),
          ));
        },
      ),
    );
  }
}

/// provide tally screen support.
class TallyScreenProvider with ChangeNotifier {
  TallyScreenProvider(this.videoProvider, this.annotation) {
    titleController.text = annotation.title;
    prefixController.text = annotation.prefix;
    suffixController.text = annotation.suffix;
  }

  /// the video provider
  final app.VideoProvider videoProvider;

  /// the annotation to edit
  final clib.TallyAnnotation annotation;

  /// the title field controller
  TextEditingController titleController = TextEditingController();

  /// the description prefix controller
  TextEditingController prefixController = TextEditingController();

  /// the description suffix controller
  TextEditingController suffixController = TextEditingController();

  /// the error message for title
  String _titleErrorMessage = '';

  @override
  void dispose() {
    titleController.dispose();
    prefixController.dispose();
    suffixController.dispose();
    super.dispose();
  }

  /// set title
  void setTitle(BuildContext context, String text) {
    if (text.isEmpty) {
      _titleErrorMessage = context.l.counter_screen_name_error;
    } else {
      _titleErrorMessage = '';
      annotation.title = text;
      videoProvider.updateTallyAnnotation(annotation);
    }
    notifyListeners();
  }

  /// set prefix text
  void setPrefix(String text) {
    annotation.prefix = text;
    videoProvider.updateTallyAnnotation(annotation);
  }

  /// set suffix text
  void setSuffix(String text) {
    annotation.suffix = text;
    videoProvider.updateTallyAnnotation(annotation);
  }

  /// toggle enabled state
  void toggleEnabled(
    BuildContext context,
    app.VideoProvider videoProvider,
    clib.VideoZone videoZone,
    clib.TallyAnnotation annotation,
  ) {
    final projectProvider = app.ProjectProvider.of(context);

    final ok = videoProvider.toggleZoneTollyAnnotation(videoZone, annotation);
    if (!ok) {
      // alert user that they need enable other strategy first, then they can disable this strategy
      // show cupertino alert dialog
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(context.l.counter_screen_enabled_error),
          content: Text(context.l.counter_screen_enabled_error_content),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l.ok),
            ),
          ],
        ),
      );

      return;
    }
    projectProvider.notifyTallyAnnotationsChanged();
    notifyListeners();
  }

  /// set the stagnant threshold
  void setStagnantThreshold(clib.VideoZone videoZone, int value) {
    videoProvider.setZoneStagnantThreshold(videoZone, value);
    notifyListeners();
  }

  /// set the reentered threshold
  void setReenteredThreshold(clib.VideoZone videoZone, int value) {
    videoProvider.setZoneReenteredThreshold(videoZone, value);
    notifyListeners();
  }

  /// set the cooldown threshold
  void setCooldownThreshold(clib.VideoZone videoZone, int value) {
    videoProvider.setZoneCooldownThreshold(videoZone, value);
    notifyListeners();
  }
}
