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
import 'indicator_view.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({
    required this.onScroll,
    super.key,
  });

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.project_screen_title;

    final projectProvider = app.ProjectProvider.of(context);
    return ChangeNotifierProvider<ProjectScreenProvider>(
      create: (_) => ProjectScreenProvider(projectProvider, onScroll),
      child: Consumer2<app.ProjectProvider, ProjectScreenProvider>(
        builder: (context, projectProvider, projectScreenProvider, child) {
          if (projectProvider.project == null) {
            // project may not open in time, just return empty. project init is fast so no need to show progress.
            return const SizedBox();
          }
          final project = projectProvider.project!;
          Widget buildZone(
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
                        buildZone(
                            videoProvider, zone.videoZone, count, selectedTallyCounters, selectedTallyAnnotations),
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
                          leading: Icon(videoProvider.getMediaTypeIcon(),
                              color: CupertinoColors.inactiveGray.resolveFrom(context)),
                          title: Text(videoProvider.video.videoName),
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

          buildTimeTagString() {
            final now = DateTime.now();
            return '${DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(now)} ${DateFormat.jm(Intl.getCurrentLocale()).format(now)}';
          }

          return ChangeNotifierProvider<GaugeViewRedrawProvider>.value(
              value: projectScreenProvider.gaugeViewRedrawProvider,
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, result) async {
                  if (didPop) {
                    return;
                  }
                  final bool shouldPop = await showCupertinoDialog<bool?>(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: Text(context.l.project_screen_exit_confirm_title),
                          content: Text(context.l.project_screen_exit_confirm_content),
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
                  previousPageTitle: context.l.project_screen_exit_button,
                  action: CupertinoButton(
                    child: Text(context.l.project_screen_add_video_button),
                    onPressed: () {
                      Navigator.of(context).pushNamed(addSourceRoute, arguments: {
                        'previousPageTitle': pageTitle,
                      });
                    },
                  ),
                  child: SingleChildScrollView(
                    controller: projectScreenProvider._scrollController,
                    child: Column(
                      children: [
                        pip.PipHeader(
                          showBottomBorder: false,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: ChangeNotifierProvider<IndicatorRedrawProvider>.value(
                                  value: projectScreenProvider.indicatorRedrawProvider,
                                  child: Consumer<IndicatorRedrawProvider>(
                                    builder: (context, indicatorProvider, child) => IndicatorView(
                                      value: indicatorProvider.value.toDouble(),
                                      maxValue: indicatorProvider.maxValue.toDouble(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(project.projectName,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                                  )),
                            ],
                          ),
                        ),
                        CupertinoListSection(
                          topMargin: 0,
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          footer: Text(context.l.project_screen_from_desc),
                          children: [
                            CupertinoListTile(
                              title: Text(projectProvider.project!.filter.formattedString(context)),
                              subtitle: Consumer<GaugeViewRedrawProvider>(
                                builder: (context, timeTagProvider, child) => Text(
                                  buildTimeTagString(),
                                  style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                                ),
                              ),
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
                          header: Text(context.l.project_screen_title),
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          children: [
                            CupertinoListTile(
                              title: Text(context.l.project_screen_report_settings),
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
                        pip.PipFooter(),
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

/// provide project screen support.
class ProjectScreenProvider with ChangeNotifier {
  ProjectScreenProvider(app.ProjectProvider projectProvider, pip.ScrollCallback onScroll) {
    _scrollController.addListener(() => onScroll(_scrollController));
    _gaugeViewRefreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (projectProvider.videoPlayingState != app.VideoPlayingState.allPlay) {
        // some video is not playing, need to refresh their gauge count
        projectProvider.noActivityCheck(DateTime.now());
      }
      gaugeViewRedrawProvider.redraw();
    });

    _indicatorRefreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final value = projectProvider.currentOccupiedCount;
      indicatorRedrawProvider.setValue(value);
    });
  }

  /// The scroll controller
  final _scrollController = ScrollController();

  /// Timer to refresh the gauge view every minute where some video player stop counting.
  Timer? _gaugeViewRefreshTimer;

  /// Timer to refresh the indicator view every 1 seconds.
  Timer? _indicatorRefreshTimer;

  /// Gauge view redraw provider.
  final GaugeViewRedrawProvider gaugeViewRedrawProvider = GaugeViewRedrawProvider();

  /// Indicator redraw provider.
  final IndicatorRedrawProvider indicatorRedrawProvider = IndicatorRedrawProvider();

  @override
  dispose() {
    _scrollController.dispose();
    _gaugeViewRefreshTimer?.cancel();
    _indicatorRefreshTimer?.cancel();
    gaugeViewRedrawProvider.dispose();
    super.dispose();
  }
}

/// provide gauge view redraw support.
class GaugeViewRedrawProvider with ChangeNotifier {
  void redraw() {
    notifyListeners();
  }
}

/// provide indicator redraw support.
class IndicatorRedrawProvider with ChangeNotifier {
  /// The value to be displayed.
  int value = 0;

  /// The maximum value.
  int maxValue = 0;

  /// set value and update max value.
  void setValue(int newValue) {
    if (value == newValue) {
      return;
    }

    value = newValue;
    if (value > maxValue) {
      maxValue = value;
    }
    notifyListeners();
  }
}
