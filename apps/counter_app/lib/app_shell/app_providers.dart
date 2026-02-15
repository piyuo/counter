import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

class AppProviders extends ConsumerWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We read the notifier here to use it in the callback
    final pipController = ref.read(feature_pip.pipProvider.notifier);

    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider<app.ProjectProvider>(
          create: (context) => app.ProjectProvider(
            onDatabaseMaintain: () {},
            onClearActivities: (String projectId) async {},
            onProjectOpened: (_) async {
              // 2 seconds wait to avoid busy state when open project
              await Future.delayed(const Duration(seconds: 2));
              pipController.animatePanelToSnapPoint();
            },
            onProjectSave: (app.Project project, app.Video? video) async {},
            onGetProjectById: (String projectId) async {
              return null;
            },
            onDeleteProject: (String projectId) async {},
          )..init(context),
        ),
      ],
      child: child,
    );
  }
}
