import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/clib/clib.dart' as clib;

import '../wizard_navigator.dart';

/// The zone screen for editing the video zone.
class ZoneScreen extends StatelessWidget {
  const ZoneScreen({
    required this.videoProvider,
    required this.videoZone,
    this.previousPageTitle,
    super.key,
  });

  /// the video zone editor controller
  final app.VideoProvider videoProvider;

  /// the video zone to be edited
  final clib.VideoZone videoZone;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ZoneScreenProvider>(
            create: (_) => ZoneScreenProvider(videoZone, videoProvider),
          ),
          ChangeNotifierProvider<app.VideoProvider>.value(
            value: videoProvider,
          ),
        ],
        child: Consumer2<app.VideoProvider, ZoneScreenProvider>(
          builder: (context, videoProvider, zoneScreenProvider, child) {
            final pageTitle = videoZone.name;
            return pip.PipScaffold(
              previousPageTitle: previousPageTitle,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(
                          context.l.zone_screen_desc,
                          textAlign: TextAlign.center,
                        ),
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

                  // color picker
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.zone_screen_zone_color),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.zone_screen_color),
                        leading: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: videoZone.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                            colorRoute,
                            arguments: {
                              'videoZone': videoZone,
                              'videoProvider': videoProvider,
                              'previousPageTitle': pageTitle,
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.zone_screen_detect_desc),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.zone_screen_detection),
                        leading: const Icon(CupertinoIcons.person),
                        trailing: const CupertinoListTileChevron(),
                        additionalInfo: Text(videoZone.getSelectedObjectClassNames(context)),
                        onTap: () => Navigator.of(context).pushNamed(
                          objectClassRoute,
                          arguments: {
                            'videoProvider': videoProvider,
                            'videoZone': videoZone,
                            'previousPageTitle': pageTitle,
                          },
                        ),
                      ),
                    ],
                  ),

                  // set tally annotation for counter
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: const Text('Counter'),
                    children: videoZone.tallyAnnotations
                        .map((annotation) => CupertinoListTile(
                              title: Text(clib.tallyTypeToString(context, annotation.type)),
                              leading: annotation.enabled
                                  ? Icon(
                                      CupertinoIcons.check_mark,
                                      color: CupertinoColors.activeBlue,
                                    )
                                  : SizedBox.shrink(),
                              trailing: const CupertinoListTileChevron(),
                              onTap: () async {
                                await Navigator.of(context).pushNamed(
                                  tallyRoute,
                                  arguments: {
                                    'videoProvider': videoProvider,
                                    'videoZone': videoZone,
                                    'annotation': annotation,
                                    'previousPageTitle': pageTitle,
                                  },
                                );
                              },
                            ))
                        .toList(),
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
                            if (!videoProvider.isZoneAllowRemove()) {
                              await showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text(context.l.zone_screen_can_not_delete),
                                  content: Text(context.l.zone_screen_one_zone_required),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(context.l.close),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            // show confirmation dialog
                            final bool? result = await showCupertinoDialog<bool>(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text(context.l.zone_screen_delete_header),
                                  content: Text(context.l.zone_screen_delete_content),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: Text(context.l.cancel),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: Text(context.l.zone_screen_delete_button),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (result == null || !result) return;

                            videoProvider.removeZone(videoZone);
                            projectProvider.notifyProjectChanged(videoProvider);
                            if (context.mounted) Navigator.pop(context);
                          },
                          child: Text(context.l.zone_screen_delete_button,
                              style: TextStyle(color: CupertinoColors.systemRed)),
                        )),
                      )
                    ],
                  ),
                ],
              )),
            );
          },
        ));
  }
}

/// provide zone screen support
class ZoneScreenProvider with ChangeNotifier {
  ZoneScreenProvider(this.videoZone, this.videoProvider) {
    zoneNameFieldController.text = videoZone.name;
    zoneNameFieldController.addListener(() {
      videoProvider.setZoneName(videoZone, zoneNameFieldController.text);
    });
  }

  /// the video zone
  final clib.VideoZone videoZone;

  /// the video provider
  final app.VideoProvider videoProvider;

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
      videoProvider.setZoneName(videoZone, zoneNameFieldController.text);
    }
    notifyListeners();
  }

  /// redraw screen when counting strategy changed
  void redraw() {
    notifyListeners();
  }
}
