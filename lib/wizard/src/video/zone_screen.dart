import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../wizard_app.dart';

/// The zone screen for editing the video zone.
class ZoneScreen extends StatelessWidget {
  const ZoneScreen({required this.scrollController, required this.videoProvider, this.previousPageTitle, super.key});

  /// the video zone editor controller
  final app.VideoProvider videoProvider;

  /// the previous page title
  final String? previousPageTitle;

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider<app.VideoProvider>.value(value: videoProvider)],
      child: Consumer2<app.VideoProvider, ZoneScreenProvider>(
        builder: (context, videoProvider, zoneScreenProvider, child) {
          return pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        const SizedBox(height: 8.0),
                        Text(context.l.zone_screen_desc, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: const Text('Zone name'),
                    footer: zoneScreenProvider._zoneNameErrorMessage.isNotEmpty
                        ? Text(
                            zoneScreenProvider._zoneNameErrorMessage,
                            style: TextStyle(color: CupertinoColors.systemRed),
                          )
                        : null,
                    children: [
                      CupertinoTextField(
                        decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        placeholder: context.l.zone_screen_name_placeholder,
                        padding: EdgeInsets.all(16),
                        controller: zoneScreenProvider.zoneNameFieldController,
                        onChanged: (text) => zoneScreenProvider.setZoneName(context, text),
                      ),
                    ],
                  ),

                  // zone's color and summary
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.zone_screen_zone),
                    children: [
                      // color
                      CupertinoListTile(
                        title: Text(context.l.zone_screen_color),
                        leading: Container(width: 20, height: 20),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () async {
                          Navigator.of(context).pushNamed(colorRoute, arguments: {'videoProvider': videoProvider});
                        },
                      ),

                      // summary
                      CupertinoListTile(
                        title: Text(context.l.zone_screen_zone_show_summary),
                        leading: SizedBox.shrink(),
                        trailing: CupertinoSwitch(
                          value: true,
                          onChanged: (bool value) {
                            zoneScreenProvider.setZoneShowSummaryOnScreen(value);
                          },
                        ),
                      ),
                    ],
                  ),

                  /*
                      buildThreshold('Cross zone (count)', videoZone.crossedZonesThreshold, (value) {
                        videoZone.crossedZonesThreshold = value.toInt();
                        zoneScreenProvider.redraw();
                      }),
                  CupertinoListSection(
                    children: [
                      // add cupertino switch for ignoreIfCounted
                      CupertinoListTile(
                        title: Text('Ignore Object if counted'),
                        trailing: CupertinoSwitch(
                          value: videoZone.ignoreIfCounted,
                          onChanged: (value) {
                            videoZone.ignoreIfCounted = value;
                            zoneScreenProvider.redraw();
                          },
                        ),
                      )
                    ],
                  ),
*/
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.zone_screen_delete_header),
                    children: [
                      CupertinoListTile(
                        title: Center(
                          child: CupertinoButton(
                            onPressed: () async {
                              // show confirmation dialog
                              final bool? result = await showCupertinoDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text(context.l.zone_screen_delete_header),
                                    content: Text(context.l.zone_screen_delete_content),
                                    actions: [
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        textStyle: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
                                        onPressed: () => Navigator.pop(context, false),
                                        child: Text(context.l.cancel),
                                      ),
                                      CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        onPressed: () => Navigator.pop(context, true),
                                        child: Text(context.l.zone_screen_delete_button),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (result == null || !result) return;
                              if (context.mounted) Navigator.pop(context);
                            },
                            child: Text(
                              context.l.zone_screen_delete_button,
                              style: TextStyle(color: CupertinoColors.systemRed),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide zone screen support
class ZoneScreenProvider with ChangeNotifier {
  /// the project name controller
  TextEditingController zoneNameFieldController = TextEditingController();

  /// the error message for video name
  String _zoneNameErrorMessage = '';

  @override
  void dispose() {
    zoneNameFieldController.dispose();
    super.dispose();
  }

  /// set zone name
  void setZoneName(BuildContext context, String text) {
    if (text.isEmpty) {
      _zoneNameErrorMessage = context.l.zone_screen_zone_name_required;
    } else {
      _zoneNameErrorMessage = '';
    }
    notifyListeners();
  }

  /// set show summary on screen
  void setZoneShowSummaryOnScreen(bool value) {
    notifyListeners();
  }

  /// redraw screen when counting strategy changed
  void redraw() {
    notifyListeners();
  }
}
