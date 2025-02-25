import 'dart:async';

import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

import '../wizard_navigator.dart';
import 'gauge_view.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.home_screen_title;

    final projectProvider = app.ProjectProvider.of(context);
    return ChangeNotifierProvider<HomeScreenProvider>(
      create: (_) => HomeScreenProvider(projectProvider),
      child: Consumer2<app.ProjectProvider, HomeScreenProvider>(
        builder: (context, projectProvider, homeScreenProvider, child) {
          if (projectProvider.project == null) {
            // project may not open in time, just return empty. project init is fast so no need to show progress.
            return const SizedBox();
          }
          final project = projectProvider.project!;
          Widget buildZoneGauge(
            app.VideoProvider videoProvider,
            vision.VideoZone videoZone,
            vision.Count count,
            List<vision.TallyCounter> tallyCounters,
            List<vision.TallyAnnotation> tallyAnnotations,
          ) {
            return ChangeNotifierProvider<vision.Sampling>.value(
              value: count.sampling!,
              child: Consumer<vision.Sampling>(
                builder: (context, profilesController, child) {
                  buildZoneGauges() {
                    List<Widget> gauges = [];
                    DateTime now = DateTime.now();
                    for (int i = 0; i < tallyCounters.length; i++) {
                      final tallyCounter = tallyCounters[i];
                      final tallyAnnotation = tallyAnnotations[i];
                      gauges.add(
                        GaugeView(
                          chartColor: videoZone.color,
                          classId: count.classId,
                          tallyCounter: tallyCounter,
                          tallyAnnotation: tallyAnnotation,
                          filter: projectProvider.project!.filter,
                          now: now,
                          onTapChart: () {
                            Navigator.of(context).pushNamed(
                              tallyRoute,
                              arguments: {
                                'videoProvider': videoProvider,
                                'videoZone': videoZone,
                                'annotation': tallyAnnotation,
                                'previousPageTitle': pageTitle,
                              },
                            );
                          },
                        ),
                      );
                    }
                    return gauges;
                  }

                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: buildZoneGauges());
                },
              ),
            );
          }

          List<Widget> buildVideoView() {
            return projectProvider.videoProviders.map(
              (videoProvider) {
                buildGauges() {
                  List<Widget> gauges = [];
                  for (final zone in videoProvider.visionController.zones) {
                    gauges.add(
                      CupertinoListTile(
                        leading: Icon(CupertinoIcons.square_stack, color: zone.videoZone.color),
                        title: Text(zone.videoZone.name, style: TextStyle(color: zone.videoZone.color)),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () async {
                          Navigator.of(context).pushNamed(zoneRoute, arguments: {
                            'previousPageTitle': pageTitle,
                            'videoProvider': videoProvider,
                            'videoZone': zone.videoZone,
                          });
                        },
                      ),
                    );

                    for (final count in zone.counts) {
                      if (!zone.videoZone.selectedClasses.contains(count.classId)) {
                        continue;
                      }
                      final selectedTallyCounters = count.sampling!.tallyCounters
                          .where((element) => zone.videoZone.selectedTallyTypes.contains(element.type))
                          .toList();
                      final selectedTallyAnnotations =
                          zone.videoZone.getTallyAnnotationsByCounters(selectedTallyCounters);
                      gauges.add(
                        buildZoneGauge(
                          videoProvider,
                          zone.videoZone,
                          count,
                          selectedTallyCounters,
                          selectedTallyAnnotations,
                        ),
                      );
                    }
                  }
                  return gauges;
                }

                return ChangeNotifierProvider<app.VideoProvider>.value(
                  value: videoProvider,
                  child: Consumer<app.VideoProvider>(
                    builder: (context, profilesController, child) => CupertinoListSection(
                      topMargin: 10,
                      margin: EdgeInsets.zero,
                      hasLeading: false,
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      children: [
                        CupertinoListTile(
                          leading:
                              Icon(videoProvider.getIcon(), color: CupertinoColors.inactiveGray.resolveFrom(context)),
                          title: Text(videoProvider.video.videoName,
                              style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
                          trailing: const CupertinoListTileChevron(),
                          additionalInfo: Text(vision.mediaTypeToString(context, videoProvider.video.mediaType),
                              style: TextStyle(color: CupertinoColors.inactiveGray.resolveFrom(context))),
                          onTap: () {
                            gotoSourceRoute(
                              projectProvider: projectProvider,
                              videoProvider: videoProvider,
                              previousPageTitle: pageTitle,
                            );
                          },
                        ),
                        ...buildGauges(),
                      ],
                    ),
                  ),
                );
              },
            ).toList();
          }

          final languageProvider = vision.LanguageProvider.of(context);
          buildTimeTagString() {
            final now = DateTime.now();
            return '${DateFormat.yMMMMEEEEd(languageProvider.locale).format(now)} ${DateFormat.jm(languageProvider.locale).format(now)}';
          }

          return ChangeNotifierProvider<TimeTagProvider>.value(
              value: homeScreenProvider.timeTagProvider,
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, result) async {
                  if (didPop) {
                    return;
                  }
                  final bool shouldPop = await showCupertinoDialog<bool?>(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: Text(context.l.home_screen_exit_confirm_title),
                          content: Text(context.l.home_screen_exit_confirm_content),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              textStyle: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
                              onPressed: () => Navigator.pop(context),
                              child: Text(context.l.no),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(context.l.yes),
                            ),
                          ],
                        ),
                      ) ??
                      false;

                  if (shouldPop) {
                    projectProvider.closeProject();
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: pip.PipScaffold(
                  previousPageTitle: context.l.home_screen_exit_button,
                  action: CupertinoButton(
                    child: Text(context.l.home_screen_add_video_button),
                    onPressed: () {
                      Navigator.of(context).pushNamed(addVideoRoute, arguments: {
                        'previousPageTitle': pageTitle,
                      });
                    },
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        pip.PipHeader(
                          showBottomBorder: false,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.quaternarySystemFill.resolveFrom(context),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(CupertinoIcons.play_fill,
                                    size: 48.0,
                                    color: projectProvider.videoPlayingState == app.VideoPlayingState.allPlay
                                        ? CupertinoColors.systemRed.resolveFrom(context)
                                        : projectProvider.videoPlayingState == app.VideoPlayingState.somePlay
                                            ? CupertinoColors.activeOrange.resolveFrom(context)
                                            : CupertinoColors.inactiveGray.resolveFrom(context)),
                              ),
                              SizedBox(height: 10),
                              Text(project.projectName,
                                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              Consumer<TimeTagProvider>(
                                builder: (context, timeTagProvider, child) => Text(
                                  buildTimeTagString(),
                                  style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CupertinoListSection(
                          topMargin: 0,
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          children: [
                            CupertinoListTile(
                              title: Text(context.l.home_screen_report_from,
                                  style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
                              additionalInfo: Text(projectProvider.project!.filter.formattedString(context)),
                              trailing: const CupertinoListTileChevron(),
                              onTap: () async {
                                Navigator.of(context).pushNamed(filterRoute, arguments: {
                                  'previousPageTitle': pageTitle,
                                });
                              },
                            )
                          ],
                        ),

                        // no need to show gauge if zone editor is enabled
                        if (!projectProvider.isZoneEditorEnabled) ...buildVideoView(),
                        CupertinoListSection(
                          header: Text(context.l.home_screen_title),
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          children: [
                            CupertinoListTile(
                              title: Text(context.l.home_screen_report_settings),
                              leading: const Icon(CupertinoIcons.settings),
                              trailing: const CupertinoListTileChevron(),
                              onTap: () async {
                                Navigator.of(context).pushNamed(settingsRoute, arguments: {
                                  'previousPageTitle': pageTitle,
                                });
                                return;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

/// provide home screen support.
class HomeScreenProvider with ChangeNotifier {
  HomeScreenProvider(app.ProjectProvider projectProvider) {
    _gaugeViewRefreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (projectProvider.videoPlayingState != app.VideoPlayingState.allPlay) {
        // some video is not playing, need to refresh their gauge count
        projectProvider.noActivityCheck(DateTime.now());
      }
      timeTagProvider.redraw();
    });
  }

  /// Timer to refresh the gauge view every minute where some video player stop counting.
  Timer? _gaugeViewRefreshTimer;

  /// Time tag provider.
  final TimeTagProvider timeTagProvider = TimeTagProvider();

  @override
  dispose() {
    _gaugeViewRefreshTimer?.cancel();
    timeTagProvider.dispose();
    super.dispose();
  }
}

/// provide time tag support.
class TimeTagProvider with ChangeNotifier {
  void redraw() {
    notifyListeners();
  }
}
