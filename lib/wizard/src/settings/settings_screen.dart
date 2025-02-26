import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../wizard_navigator.dart';

/// provide settings screen for the project
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    this.previousPageTitle,
    super.key,
  });

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
          return pip.PipScaffold(
            title: pageTitle,
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
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
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.settings_screen_detection),
                        leading: const Icon(CupertinoIcons.eye),
                        trailing: const CupertinoListTileChevron(),
                        additionalInfo:
                            projectProvider.project != null ? Text(projectProvider.project!.model.name) : null,
                        onTap: () => Navigator.of(context).pushNamed(detectionRoute, arguments: {
                          'previousPageTitle': pageTitle,
                        }),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
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
                            navigator.pushNamedAndRemoveUntil(
                              initialRoute,
                              (Route<dynamic> route) => false,
                            );
                            await Future.delayed(const Duration(milliseconds: 500));
                            projectProvider.deleteProject(projectProvider.project!.projectId);
                          },
                          child: Text(context.l.settings_screen_delete_button,
                              style: TextStyle(color: CupertinoColors.systemRed)),
                        )),
                      )
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
