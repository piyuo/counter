import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({
    required this.previousPageTitle,
    super.key,
  });

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final pageTitle = context.l.detection_screen_title;

    final projectProvider = app.ProjectProvider.of(context);
    final project = projectProvider.project;
    return pip.PipScaffold(
      title: pageTitle,
      previousPageTitle: previousPageTitle,
      child: ChangeNotifierProvider<DetectionScreenProvider>(
          create: (_) => DetectionScreenProvider(),
          child: Consumer<DetectionScreenProvider>(builder: (context, detectionScreenProvider, child) {
            final classPercentage = '${(project!.confidenceThreshold * 100).toStringAsFixed(0)}%';
            final nmsPercentage = '${(project.nmsThreshold * 100).toStringAsFixed(0)}%';
            // no tracking setting for now, it just a priority setting not that easy to explain to user
            final validThreshold = '${project.validThreshold / 1000}';
            final matchPercentage = '${(project.matchThreshold * 100).toStringAsFixed(0)}%';
            final maxLostSeconds = '${project.maxLostSeconds}';

            return SingleChildScrollView(
                controller: detectionScreenProvider.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.detection_screen_models),
                      children: List.generate(
                        vision.Models.values.length,
                        (index) {
                          final model = vision.Models.values[index];
                          return CupertinoListTile(
                            leading: model == project.model
                                ? const Icon(CupertinoIcons.check_mark)
                                : const SizedBox.shrink(),
                            title: Text(vision.getModelName(model)),
                            onTap: () async {
                              await projectProvider.setModel(model);
                              detectionScreenProvider.onModelChanged();
                            },
                          );
                        },
                      ),
                    ),
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
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
                                value: project.confidenceThreshold,
                                max: 1,
                                min: 0.1,
                                divisions: 100,
                                onChanged: (double value) async {
                                  await projectProvider.setSettingsDetectionThreshold(value);
                                  detectionScreenProvider.onDetectionThresholdChanged();
                                },
                              ),
                            )),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.detection_screen_nms),
                      footer: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          maxLines: 4,
                          context.l.detection_screen_nms_desc.replaceAll('#0', nmsPercentage),
                        ),
                      ),
                      children: [
                        CupertinoListTile(
                            leading: Text(context.l.detection_screen_low),
                            trailing: Text(context.l.detection_screen_high),
                            additionalInfo: SizedBox.shrink(),
                            title: SizedBox(
                              width: double.infinity,
                              child: CupertinoSlider(
                                value: project.nmsThreshold,
                                max: 1,
                                min: 0.1,
                                divisions: 100,
                                onChanged: (double value) async {
                                  await projectProvider.setSettingsNmsThreshold(value);
                                  detectionScreenProvider.onNmsThresholdChanged();
                                },
                              ),
                            )),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.detection_screen_match),
                      footer: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child:
                            Text(maxLines: 3, context.l.detection_screen_match_desc.replaceAll('#0', matchPercentage)),
                      ),
                      children: [
                        CupertinoListTile(
                            leading: Text(context.l.detection_screen_low),
                            trailing: Text(context.l.detection_screen_high),
                            additionalInfo: SizedBox.shrink(),
                            title: SizedBox(
                              width: double.infinity,
                              child: CupertinoSlider(
                                value: project.matchThreshold,
                                max: 1,
                                min: 0.1,
                                divisions: 100,
                                onChanged: (double value) async {
                                  await projectProvider.setSettingsMatchThreshold(value);
                                  detectionScreenProvider.onMatchThresholdChanged();
                                },
                              ),
                            )),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.detection_screen_lost),
                      footer: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(maxLines: 3, context.l.detection_screen_lost_desc.replaceAll('#0', maxLostSeconds)),
                      ),
                      children: [
                        CupertinoListTile(
                            leading: Text(context.l.detection_screen_1),
                            trailing: Text(context.l.detection_screen_30),
                            additionalInfo: SizedBox.shrink(),
                            title: SizedBox(
                              width: double.infinity,
                              child: CupertinoSlider(
                                value: project.maxLostSeconds.toDouble(),
                                max: 30,
                                min: 1,
                                divisions: 100,
                                onChanged: (double value) async {
                                  await projectProvider.setSettingsMaxLostSeconds(value.toInt());
                                  detectionScreenProvider.onMaxLostSecondsChanged();
                                },
                              ),
                            )),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.detection_screen_consider_valid),
                      footer: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                            maxLines: 3,
                            context.l.detection_screen_consider_valid_desc.replaceAll('#0', validThreshold)),
                      ),
                      children: [
                        CupertinoListTile(
                            leading: Text(context.l.detection_screen_0),
                            trailing: Text(context.l.detection_screen_30),
                            additionalInfo: SizedBox.shrink(),
                            title: SizedBox(
                              width: double.infinity,
                              child: CupertinoSlider(
                                value: project.validThreshold / 1000,
                                max: 30,
                                min: 0,
                                divisions: 150,
                                onChanged: (double value) async {
                                  await projectProvider.setSettingsValidThreshold((value * 1000).toInt());
                                  detectionScreenProvider.onValidThresholdChanged();
                                },
                              ),
                            )),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      children: [
                        CupertinoListTile(
                          title: Center(
                              child: Text(context.l.detection_screen_reset,
                                  style: TextStyle(color: CupertinoColors.systemRed))),
                          onTap: () async {
                            final bool okToReset = await showCupertinoDialog<bool?>(
                                  context: context,
                                  builder: (BuildContext context) => CupertinoAlertDialog(
                                    title: Text(context.l.detection_screen_reset),
                                    content: Text(context.l.detection_screen_reset_content),
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
                            if (!okToReset) return;
                            await projectProvider.resetDetectionSettings();
                            detectionScreenProvider.onDetectionSettingsChanged();
                          },
                        ),
                      ],
                    ),
                    pip.PipFooter(),
                  ],
                ));
          })),
    );
  }
}

/// ai screen provider
class DetectionScreenProvider with ChangeNotifier {
  DetectionScreenProvider();

  /// scroll controller
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
  void onDetectionSettingsChanged() {
    notifyListeners();
  }
}
