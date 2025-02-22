import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text(context.l.open_project_screen_no_project));
                    } else {
                      final projects = snapshot.data!;
                      return CupertinoListSection(
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: projects
                            .map((project) => CupertinoListTile(
                                  leading: Icon(CupertinoIcons.archivebox),
                                  title: Text(project.projectName),
                                  trailing: CupertinoListTileChevron(),
                                  onTap: () async {
                                    final ok = await projectProvider.openProject(project.projectId);
                                    if (ok && context.mounted) {
                                      Navigator.of(context).pushReplacementNamed(homeRoute);
                                    }
                                  },
                                ))
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
}
