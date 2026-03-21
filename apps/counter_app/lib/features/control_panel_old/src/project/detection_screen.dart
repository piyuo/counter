import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({required this.videoProvider, required this.previousPageTitle, super.key});

  /// the video provider
  final app.VideoProvider videoProvider;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final pageTitle = context.l.detection_screen_title;
    final video = videoProvider.video;
    return feature_pip.PipScaffold(
      title: pageTitle,
      previousPageTitle: previousPageTitle,
      builder: (scrollController) => ChangeNotifierProvider<DetectionScreenProvider>(
        create: (_) => DetectionScreenProvider(),
        child: Consumer<DetectionScreenProvider>(
          builder: (context, detectionScreenProvider, child) {
            final classPercentage = '${(video.confidenceThreshold * 100).toStringAsFixed(0)}%';
            final nmsPercentage = '${(video.nmsThreshold * 100).toStringAsFixed(0)}%';
            // no tracking setting for now, it just a priority setting not that easy to explain to user
            final matchPercentage = '${(video.matchThreshold * 100).toStringAsFixed(0)}%';

            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CupertinoListSection(
                    header: Text(context.l.detection_screen_confidence),
                    footer: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(context.l.detection_screen_confidence_desc.replaceAll('#0', classPercentage)),
                    ),
                    children: [
                      CupertinoListTile(
                        leading: Text(context.l.detection_screen_low),
                        trailing: Text(context.l.detection_screen_high),
                        additionalInfo: SizedBox.shrink(),
                        title: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: video.confidenceThreshold,
                            max: 1,
                            min: 0.1,
                            divisions: 100,
                            onChanged: (double value) async {
                              await videoProvider.setSettingsDetectionThreshold(value);
                              detectionScreenProvider.onDetectionThresholdChanged();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.detection_screen_nms),
                    footer: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(maxLines: 8, context.l.detection_screen_nms_desc.replaceAll('#0', nmsPercentage)),
                    ),
                    children: [
                      CupertinoListTile(
                        leading: Text(context.l.detection_screen_low),
                        trailing: Text(context.l.detection_screen_high),
                        additionalInfo: SizedBox.shrink(),
                        title: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: video.nmsThreshold,
                            max: 1,
                            min: 0.1,
                            divisions: 100,
                            onChanged: (double value) async {
                              await videoProvider.setSettingsNmsThreshold(value);
                              detectionScreenProvider.onNmsThresholdChanged();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.detection_screen_match),
                    footer: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(maxLines: 8, context.l.detection_screen_match_desc.replaceAll('#0', matchPercentage)),
                    ),
                    children: [
                      CupertinoListTile(
                        leading: Text(context.l.detection_screen_low),
                        trailing: Text(context.l.detection_screen_high),
                        additionalInfo: SizedBox.shrink(),
                        title: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: video.matchThreshold,
                            max: 1,
                            min: 0.1,
                            divisions: 100,
                            onChanged: (double value) async {
                              await videoProvider.setSettingsMatchThreshold(value);
                              detectionScreenProvider.onMatchThresholdChanged();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.detection_screen_lost),
                    footer: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(maxLines: 3, context.l.detection_screen_lost_desc),
                    ),
                    children: [
                      CupertinoListTile(
                        leadingSize: 40,
                        leading: Text(context.l.detection_screen_low),
                        additionalInfo: SizedBox.shrink(),
                        title: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: video.minLostSeconds.toDouble(),
                            min: 0.5,
                            max: 5,
                            divisions: 150,
                            onChanged: (double value) async {
                              await videoProvider.setSettingsMinLostSeconds(value);
                              detectionScreenProvider.onMinLostSecondsChanged();
                            },
                          ),
                        ),
                      ),
                      CupertinoListTile(
                        leadingSize: 40,
                        leading: Text(context.l.detection_screen_high),
                        additionalInfo: SizedBox.shrink(),
                        title: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: video.maxLostSeconds.toDouble(),
                            min: 5,
                            max: 60,
                            divisions: 150,
                            onChanged: (double value) async {
                              await videoProvider.setSettingsMaxLostSeconds(value);
                              detectionScreenProvider.onMaxLostSecondsChanged();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.detection_screen_consider_valid),
                    footer: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(maxLines: 3, context.l.detection_screen_consider_valid_desc),
                    ),
                    children: [
                      CupertinoListTile(
                        additionalInfo: SizedBox.shrink(),
                        title: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: video.validThreshold / 1000,
                            min: 0,
                            max: 60,
                            divisions: 150,
                            onChanged: (double value) async {
                              await videoProvider.setSettingsValidThreshold((value * 1000).toInt());
                              detectionScreenProvider.onValidThresholdChanged();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    children: [
                      CupertinoListTile(
                        title: Center(
                          child: Text(
                            context.l.detection_screen_reset,
                            style: TextStyle(color: CupertinoColors.systemRed),
                          ),
                        ),
                        onTap: () async {
                          final bool? okToReset = await feature_pip.showYesNoMessageDialog(
                            context.l.detection_screen_reset_content,
                            title: context.l.detection_screen_reset,
                            noLabel: context.l.no,
                            yesLabel: context.l.yes,
                            isYesDestructive: true,
                          );
                          if (okToReset ?? false) {
                            await videoProvider.resetDetectionSettings();
                            detectionScreenProvider.onDetectionSettingsChanged();
                          }
                        },
                      ),
                    ],
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

/// ai screen provider
class DetectionScreenProvider with ChangeNotifier {
  DetectionScreenProvider();

  /// redraw the screen when model changed
  void onModelChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onDetectionThresholdChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onNmsThresholdChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onMatchThresholdChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onValidThresholdChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onMaxLostSecondsChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onMinLostSecondsChanged() {
    notifyListeners();
  }

  /// redraw the screen when settings changed
  void onDetectionSettingsChanged() {
    notifyListeners();
  }
}
