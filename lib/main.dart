import 'package:counter/app/app.dart' as app;
import 'package:counter/db/db.dart' as db;
import 'package:counter/l10n/app_localization.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:counter/wizard/wizard.dart' as wizard;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();
  final db.DataManager dataManager = db.DataManager();
//  final AppDatabase appDatabase = AppDatabase();

  @override
  Widget build(BuildContext context) {
    pip.SlidingPanelState getPanelPositionWhenProjectOpened() {
      final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      return isPortrait ? pip.SlidingPanelState.halfOpen : pip.SlidingPanelState.open;
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => vision.LanguageProvider()..loadLocale()),
          ChangeNotifierProvider<app.ProjectProvider>(
              create: (context) => app.ProjectProvider(
                    onDatabaseMaintain: () {
                      dataManager.maintainDatabase();
                    },
                    onGetRecentProjectActivities: (String projectId) async {
                      return await dataManager.getRecentProjectActivities(projectId);
                    },
                    onClearActivities: (String projectId) async {
                      await dataManager.deleteActivitiesInProject(projectId);
                    },
                    onActivityAdded:
                        (String projectId, int videoId, int zoneId, int classId, vision.Activity activity) async {
                      await dataManager.addActivity(projectId, videoId, zoneId, classId, activity);
                    },
                    onProjectOpened: (_) async {
                      dataManager.deleteActivitiesOlderThanOneDay();
                    },
                    onProjectSave: (app.Project project, app.Video? video) async {
                      await dataManager.setProject(project);
                      print('--------------- project changed!!!----------------');
                    },
                    onGetProjectSummaries: () async {
                      return await dataManager.getProjectSummaries();
                    },
                    onGetProjectById: (String projectId) async {
                      return await dataManager.getProjectById(projectId);
                    },
                    onDeleteProject: (String projectId) async {
                      await dataManager.deleteProject(projectId);
                    },
                  )..init(context)),
          ChangeNotifierProvider<pip.PipProvider>(
              create: (_) => pip.PipProvider()..init(const Duration(seconds: 2), getPanelPositionWhenProjectOpened())),
        ],
        child: CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Brightness.dark,
          ),
          child: Consumer2<vision.LanguageProvider, app.ProjectProvider>(
              builder: (context, languageProvider, projectProvider, child) {
            buildMainScreen() {
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: languageProvider.locale,
              localizationsDelegates: const [
                AppLocalization.delegate,
                vision.VisionLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalization.supportedLocales,
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: CupertinoColors.activeBlue,
                ),
                brightness: Brightness.dark,
                cupertinoOverrideTheme: const CupertinoThemeData(
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
              ),
              home: pip.PipScreen(
                sideLayoutWidthThreshold: projectProvider.sideLayoutWidthThreshold,
                deviceOrientation: projectProvider.isLockToPortrait ? projectProvider.deviceOrientation : null,
                sliding: wizard.WizardNavigator(),
                builder: (isSideLayout) => app.ProjectView(
                  noProjectScreen: buildMainScreen(),
                  isSideLayout: isSideLayout,
                ),
              ),
            );
          }),
        ));
  }
}


/*


floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () async {
                    await appDatabase.insertItem('hello ${DateTime.now().millisecondsSinceEpoch}');
                    // redraw
                    setState(() {});
                  },
                ),

                        SizedBox(
                          height: 300,
                          child: FutureBuilder<List<TodoItem>>(
                            future: appDatabase.getAllItems(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Text('Loading ...');
                              final counts = snapshot.data!;
                              return ListView.builder(
                                itemCount: counts.length,
                                itemBuilder: (context, index) {
                                  final pedestrian = counts[index];
                                  return ListTile(
                                    title: Text("Count: ${pedestrian.title}"),
                                    subtitle: Text("Timestamp: ${pedestrian.createdAt}"),
                                  );
                                },
                              );
                            },
                          ),
                        ),

 */