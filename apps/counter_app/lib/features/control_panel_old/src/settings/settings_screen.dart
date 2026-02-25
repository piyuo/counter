import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

/// provide settings screen for the project
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({this.previousPageTitle, super.key});

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.settings_screen_title;
    final projectProvider = app.ProjectProvider.of(context);
    return ChangeNotifierProvider<SettingsScreenProvider>(
      create: (_) => SettingsScreenProvider(projectProvider),
      child: Consumer<SettingsScreenProvider>(
        builder: (context, settingsScreenProvider, child) {
          return feature_pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            builder: (scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  feature_pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.settings, size: 44),
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(context.l.settings_screen_desc, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  CupertinoListSection(
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.settings_screen_project_name),
                    footer: settingsScreenProvider._projectNameErrorMessage.isNotEmpty
                        ? Text(
                            settingsScreenProvider._projectNameErrorMessage,
                            style: TextStyle(color: CupertinoColors.systemRed),
                          )
                        : null,
                    children: [
                      CupertinoTextField(
                        decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        placeholder: context.l.settings_screen_project_name_place_holder,
                        padding: const EdgeInsets.all(16),
                        controller: settingsScreenProvider.projectNameController,
                        onChanged: (text) => settingsScreenProvider.setProjectName(context, text),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.settings_screen_project_id),
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          SelectableText(
                            projectProvider.project!.projectId,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.settings_screen_center_point_title),
                    footer: Text(context.l.settings_screen_center_point_desc),
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.settings_screen_center_point_button),
                        trailing: CupertinoSwitch(
                          value: projectProvider.project!.isShowCenterRedDotOnTarget,
                          onChanged: (bool? value) {
                            projectProvider.setShowCenterRedDotOnTarget(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.settings_screen_lost_target_title),
                    footer: Text(context.l.settings_screen_lost_target_desc),
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.settings_screen_lost_target_button),
                        trailing: CupertinoSwitch(
                          // This bool value toggles the switch.
                          value: projectProvider.project!.isShowGhostTarget,
                          onChanged: (bool? value) {
                            projectProvider.setShowGhostTarget(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    dividerMargin: 0,
                    hasLeading: false,
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.settings_screen_reset_count_header),
                    children: [
                      if (projectProvider.developMode)
                        CupertinoListTile(
                          title: Center(
                            child: CupertinoButton(
                              onPressed: () async {
                                projectProvider.addRandomCounts();
                              },
                              child: Text(context.l.settings_screen_random_count_button),
                            ),
                          ),
                        ),
                      CupertinoListTile(
                        title: Center(
                          child: CupertinoButton(
                            onPressed: () async {
                              final bool? result = await showCupertinoDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text(context.l.settings_screen_reset_count_button),
                                    content: Text(context.l.settings_screen_reset_count_content),
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
                                        child: Text(context.l.settings_screen_reset_count_button),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (result == null || !result) return;
                              projectProvider.resetCounts();
                            },
                            child: Text(
                              context.l.settings_screen_reset_count_button,
                              style: TextStyle(color: CupertinoColors.systemRed),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.settings_screen_delete_header),
                    children: [
                      CupertinoListTile(
                        title: Center(
                          child: CupertinoButton(
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              // show confirmation dialog
                              final bool? result = await showCupertinoDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text(context.l.settings_screen_delete_header),
                                    content: Text(context.l.settings_screen_delete_content),
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
                                        child: Text(context.l.settings_screen_delete_button),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (result == null || !result) return;
                              await Future.delayed(const Duration(milliseconds: 500));
                              projectProvider.deleteProject(projectProvider.project!.projectId);
                            },
                            child: Text(
                              context.l.settings_screen_delete_button,
                              style: TextStyle(color: CupertinoColors.systemRed),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  feature_pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Provide settings screen support
class SettingsScreenProvider with ChangeNotifier {
  SettingsScreenProvider(this.projectProvider) {
    projectNameController.text = projectProvider.project!.projectName;
  }

  /// the project provider
  final app.ProjectProvider projectProvider;

  /// the project name controller
  TextEditingController projectNameController = TextEditingController();

  @override
  void dispose() {
    projectNameController.dispose();
    super.dispose();
  }

  /// the error message for project name
  String _projectNameErrorMessage = '';

  /// set project name
  void setProjectName(BuildContext context, String text) {
    if (text.isEmpty) {
      _projectNameErrorMessage = context.l.settings_screen_project_error;
    } else {
      _projectNameErrorMessage = '';
      projectProvider.setProjectName(text);
    }
    notifyListeners();
  }
}
