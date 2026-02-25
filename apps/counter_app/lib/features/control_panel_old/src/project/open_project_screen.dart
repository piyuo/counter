import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class OpenProjectScreen extends StatelessWidget {
  const OpenProjectScreen({this.previousPageTitle, super.key});

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
            return feature_pip.PipHeader(
              child: Column(
                children: [
                  Icon(CupertinoIcons.archivebox, size: 44),
                  const SizedBox(height: 8.0),
                  Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(context.l.open_project_screen_desc, textAlign: TextAlign.center),
                ],
              ),
            );
          }

          int index = 1;
          return feature_pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            builder: (scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: openProjectScreenProvider._isLoading
                    ? [
                        buildHeader(),
                        SizedBox(height: 200, child: Center(child: CupertinoActivityIndicator(radius: 28))),
                      ]
                    : [buildHeader(), feature_pip.PipFooter()],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide open project screen support
class OpenProjectScreenProvider with ChangeNotifier {
  OpenProjectScreenProvider();

  /// Whether the projects are still loading.
  bool _isLoading = true;

  /// which project is loading
  String _loadingProject = '';

  /// Get the list of projects.
  Future<void> init(app.ProjectProvider projectProvider) async {}

  /// delete the project
  void deleteProject(app.ProjectProvider projectProvider, String projectId) {
    // Remove the project from the local list first.
    notifyListeners();
    // Then perform the actual deletion operation in the background.
    projectProvider.deleteProject(projectId);
  }

  /// open the project
  Future<bool> openProject(app.ProjectProvider projectProvider, String projectId) async {
    _loadingProject = projectId;
    notifyListeners();
    final ok = await projectProvider.openProject(projectId);
    return ok;
  }
}
