import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../wizard_navigator.dart';

class OpenProjectScreen extends StatelessWidget {
  const OpenProjectScreen({
    this.previousPageTitle,
    super.key,
  });

  /// the previous page title
  final String? previousPageTitle;

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

    return ChangeNotifierProvider(
      create: (_) => OpenProjectScreenProvider(),
      child: Consumer<OpenProjectScreenProvider>(
        builder: (context, openProjectScreenProvider, child) {
          return pip.PipScaffold(
            title: pageTitle,
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              child: Column(children: [
                FutureBuilder<List<app.ProjectSummary>>(
                  future: projectProvider.getProjectSummaries(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return buildMaxHeight(CupertinoActivityIndicator(radius: 28));
                    } else if (snapshot.hasError) {
                      return buildMaxHeight(Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return buildMaxHeight(Text(context.l.open_project_screen_no_project));
                    } else {
                      final projects = snapshot.data!;
                      return CupertinoListSection(
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: projects
                            .map((project) => Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      onPressed: (_) {
                                        projectProvider.deleteProject(project.projectId);
                                        openProjectScreenProvider.onProjectDeleted();
                                      },
                                      flex: 2,
                                      backgroundColor: CupertinoColors.systemRed,
                                      foregroundColor: CupertinoColors.white,
                                      icon: CupertinoIcons.delete,
                                      label: 'Remove',
                                    ),
                                  ],
                                ),
                                child: CupertinoListTile(
                                  leading: Icon(CupertinoIcons.archivebox),
                                  title: Text(project.projectName),
                                  trailing: CupertinoListTileChevron(),
                                  onTap: () async {
                                    final ok = await projectProvider.openProject(context, project.projectId);
                                    if (ok && context.mounted) {
                                      Navigator.of(context).pushReplacementNamed(homeRoute);
                                    }
                                  },
                                )))
                            .toList(),
                      );
                    }
                  },
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

/// provide open project screen support.
class OpenProjectScreenProvider with ChangeNotifier {
  OpenProjectScreenProvider();

  /// called when the project is deleted.
  void onProjectDeleted() {
    notifyListeners();
  }
}
