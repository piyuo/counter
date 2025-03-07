import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../wizard_navigator.dart';

class OpenProjectScreen extends StatelessWidget {
  const OpenProjectScreen({
    required this.scrollController,
    this.previousPageTitle,
    super.key,
  });

  /// the scroll controller
  final ScrollController scrollController;

  /// The title of the previous page.
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.open_project_screen_title;
    final projectProvider = app.ProjectProvider.of(context);

    return ChangeNotifierProvider<OpenProjectScreenProvider>(
        create: (_) => OpenProjectScreenProvider()..init(projectProvider),
        child: Consumer2<app.ProjectProvider, OpenProjectScreenProvider>(
            builder: (context, projectProvider, openProjectScreenProvider, child) {
          buildHeader() {
            return pip.PipHeader(
              child: Column(
                children: [
                  Icon(CupertinoIcons.archivebox, size: 44),
                  const SizedBox(height: 8.0),
                  Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                    context.l.open_project_screen_desc,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          int index = 1;
          return pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                  children: openProjectScreenProvider._isLoading
                      ? [
                          buildHeader(),
                          SizedBox(
                              height: 200,
                              child: Center(
                                child: CupertinoActivityIndicator(radius: 28),
                              ))
                        ]
                      : [
                          buildHeader(),
                          if (openProjectScreenProvider._projects.isEmpty)
                            SizedBox(height: 200, child: Center(child: Text(context.l.open_project_screen_no_project))),
                          if (openProjectScreenProvider._projects.isNotEmpty)
                            CupertinoListSection(
                                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                                children: [
                                  ...openProjectScreenProvider._projects.map((project) {
                                    return Dismissible(
                                      key: ValueKey(project.projectId),
                                      background: Container(
                                        color: CupertinoColors.systemRed,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Icon(
                                          CupertinoIcons.delete,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      direction: DismissDirection.startToEnd,
                                      onDismissed: (direction) {
                                        openProjectScreenProvider.deleteProject(projectProvider, project.projectId);
                                      },
                                      child: CupertinoListTile(
                                        leading: openProjectScreenProvider._loadingProject == project.projectId
                                            ? CupertinoActivityIndicator()
                                            : Text((index++).toString(),
                                                style: TextStyle(
                                                    color: CupertinoColors.tertiaryLabel.resolveFrom(context))),
                                        title: Text(project.projectName),
                                        trailing: CupertinoListTileChevron(),
                                        subtitle:
                                            Text(timeago.format(project.updatedAt, locale: Intl.getCurrentLocale())),
                                        onTap: openProjectScreenProvider._loadingProject.isEmpty
                                            ? () async {
                                                final ok = await openProjectScreenProvider.openProject(
                                                    context, projectProvider, project.projectId);
                                                if (ok && context.mounted) {
                                                  Navigator.of(context).pushReplacementNamed(projectRoute);
                                                }
                                              }
                                            : null,
                                      ),
                                    );
                                  }),
                                ]),
                          pip.PipFooter(),
                        ]),
            ),
          );
        }));
  }
}

/// provide open project screen support
class OpenProjectScreenProvider with ChangeNotifier {
  OpenProjectScreenProvider();

  /// The list of projects to display.
  final List<app.ProjectSummary> _projects = [];

  /// Whether the projects are still loading.
  bool _isLoading = true;

  /// which project is loading
  String _loadingProject = '';

  /// Get the list of projects.
  Future<void> init(app.ProjectProvider projectProvider) async {
    final initialProjects = await projectProvider.getProjectSummaries();
    _projects.clear();
    _projects.addAll(initialProjects);
    _isLoading = false;
    notifyListeners();
  }

  /// delete the project
  void deleteProject(app.ProjectProvider projectProvider, String projectId) {
    // Remove the project from the local list first.
    _projects.removeWhere((p) => p.projectId == projectId);
    notifyListeners();
    // Then perform the actual deletion operation in the background.
    projectProvider.deleteProject(projectId);
  }

  /// open the project
  Future<bool> openProject(BuildContext context, app.ProjectProvider projectProvider, String projectId) async {
    _loadingProject = projectId;
    notifyListeners();
    final ok = await projectProvider.openProject(context, projectId);
    return ok;
  }
}
