import 'dart:async';

import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

import 'indicator_view.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({required this.scrollController, super.key});

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.project_screen_title;

    final projectProvider = app.ProjectProvider.of(context);
    return ChangeNotifierProvider<ProjectScreenProvider>(
      create: (_) => ProjectScreenProvider(projectProvider),
      child: Consumer2<app.ProjectProvider, ProjectScreenProvider>(
        builder: (context, projectProvider, projectScreenProvider, child) {
          if (projectProvider.project == null) {
            // project may not open in time, just return empty. project init is fast so no need to show progress.
            return const SizedBox();
          }
          final project = projectProvider.project!;

          List<Widget> buildVideoView() {
            return projectProvider.videoProviders.map((videoProvider) {
              return ChangeNotifierProvider<app.VideoProvider>.value(
                value: videoProvider,
                child: Consumer<app.VideoProvider>(
                  builder: (context, profilesController, child) => CupertinoListSection(
                    topMargin: 10,
                    margin: EdgeInsets.zero,
                    hasLeading: false,
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    children: [],
                  ),
                ),
              );
            }).toList();
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
                final bool shouldPop =
                    await showCupertinoDialog<bool?>(
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
                  await projectProvider.closeProject();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: feature_pip.PipScaffold(
                previousPageTitle: context.l.project_screen_exit_button,
                action: CupertinoButton(
                  sizeStyle: CupertinoButtonSize.medium,
                  child: Text(context.l.project_screen_add_video_button),
                  onPressed: () {},
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      feature_pip.PipHeader(
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
                            Text(
                              project.projectName,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.secondaryLabel.resolveFrom(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoListSection(
                        topMargin: 0,
                        backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                        footer: Text(context.l.project_screen_from_desc),
                        children: [
                          CupertinoListTile(
                            title: Text('filter'),
                            subtitle: Consumer<GaugeViewRedrawProvider>(
                              builder: (context, timeTagProvider, child) => Text(
                                buildTimeTagString(),
                                style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                              ),
                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () async {},
                          ),
                        ],
                      ),

                      // no need to show gauge if zone editor is enabled
                      if (!projectProvider.isZoneEditorEnabled) ...buildVideoView(),
                      CupertinoListSection(
                        header: Text(context.l.project_screen_title),
                        backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                        children: [
                          CupertinoListTile(
                            title: Text(context.l.project_screen_report_settings),
                            leading: const Icon(CupertinoIcons.settings),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () async {
                              return;
                            },
                          ),
                        ],
                      ),
                      feature_pip.PipFooter(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide project screen support.
class ProjectScreenProvider with ChangeNotifier {
  ProjectScreenProvider(app.ProjectProvider projectProvider) {
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



/*
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

 */