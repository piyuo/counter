import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

/// The zone screen for editing the video zone.
class ZoneScreen extends StatelessWidget {
  const ZoneScreen({required this.videoProvider, this.previousPageTitle, super.key});

  /// the video zone editor controller
  final app.VideoProvider videoProvider;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider<app.VideoProvider>.value(value: videoProvider)],
      child: Consumer2<app.VideoProvider, ZoneScreenProvider>(
        builder: (context, videoProvider, zoneScreenProvider, child) {
          return feature_pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            builder: (scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        const SizedBox(height: 8.0),
                        Text(context.l.zone_screen_desc, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  CupertinoListSection(
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
                    header: Text(context.l.zone_screen_zone),
                    children: [
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
                    header: Text(context.l.zone_screen_delete_header),
                    children: [
                      CupertinoListTile(
                        title: Center(
                          child: CupertinoButton(
                            onPressed: () async {
                              // show confirmation dialog
                              final bool? result = await feature_pip.showYesNoMessageDialog(
                                context.l.zone_screen_delete_content,
                                title: context.l.zone_screen_delete_header,
                                noLabel: context.l.cancel,
                                yesLabel: context.l.zone_screen_delete_button,
                                isYesDestructive: true,
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
