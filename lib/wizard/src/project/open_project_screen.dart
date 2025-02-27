import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vision/vision.dart' as vision;

import '../wizard_navigator.dart';

class OpenProjectScreen extends StatefulWidget {
  const OpenProjectScreen({
    this.previousPageTitle,
    super.key,
  });

  /// The title of the previous page.
  final String? previousPageTitle;

  @override
  State<OpenProjectScreen> createState() => _OpenProjectScreenState();
}

class _OpenProjectScreenState extends State<OpenProjectScreen> {
  /// The list of projects to display.
  final List<app.ProjectSummary> _projects = [];

  /// Whether the projects are still loading.
  bool _isLoading = true;

  /// which project is loading
  String _loadingProject = '';

  @override
  void initState() {
    super.initState();
    _initializeProjects();
  }

  Future<void> _initializeProjects() async {
    final projectProvider = app.ProjectProvider.of(context);
    final initialProjects = await projectProvider.getProjectSummaries();
    setState(() {
      _projects.clear();
      _projects.addAll(initialProjects);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.open_project_screen_title;
    final projectProvider = app.ProjectProvider.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    buildMaxHeight(child) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: Center(child: child),
      );
    }

    if (_isLoading) {
      return pip.PipScaffold(
        title: pageTitle,
        previousPageTitle: widget.previousPageTitle,
        child: buildMaxHeight(CupertinoActivityIndicator(radius: 28)),
      );
    }

    if (_projects.isEmpty) {
      return pip.PipScaffold(
        title: pageTitle,
        previousPageTitle: widget.previousPageTitle,
        child: buildMaxHeight(Text(context.l.open_project_screen_no_project)),
      );
    }
    final languageProvider = vision.LanguageProvider.of(context);
    int index = 1;
    return pip.PipScaffold(
      previousPageTitle: widget.previousPageTitle,
      child: SingleChildScrollView(
        child: Column(children: [
          pip.PipHeader(
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
          ),
          CupertinoListSection(backgroundColor: pip.getCupertinoListSectionBackgroundColor(context), children: [
            ..._projects.map((project) {
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
                  // Remove the project from the local list first.
                  setState(() {
                    _projects.removeWhere((p) => p.projectId == project.projectId);
                  });
                  // Then perform the actual deletion operation in the background.
                  projectProvider.deleteProject(project.projectId);
                },
                child: CupertinoListTile(
                  leading: _loadingProject == project.projectId
                      ? CupertinoActivityIndicator()
                      : Text((index++).toString(),
                          style: TextStyle(color: CupertinoColors.tertiaryLabel.resolveFrom(context))),
                  title: Text(project.projectName),
                  trailing: CupertinoListTileChevron(),
                  subtitle: Text(timeago.format(project.updatedAt, locale: languageProvider.locale.toString())),
                  onTap: _loadingProject.isEmpty
                      ? () async {
                          setState(() {
                            _loadingProject = project.projectId;
                          });
                          final ok = await projectProvider.openProject(context, project.projectId);
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
  }
}
