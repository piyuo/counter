import 'package:counter/app/app.dart' as app;
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
//  final AppDatabase appDatabase = AppDatabase();

  @override
  Widget build(BuildContext context) {
    pip.SlidingPanelState getPanelPositionWhenProjectOpened() {
      final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      return isPortrait ? pip.SlidingPanelState.halfOpen : pip.SlidingPanelState.open;
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => app.LanguageProvider()..loadLocale()),
          ChangeNotifierProvider<app.ProjectProvider>(
              create: (context) => app.ProjectProvider(
                    onProjectOpened: (app.Project project) {
                      print('project ${project.name} opened');
                    },
                    onProjectClosed: (app.Project project) {
                      print('project ${project.name} opened');
                    },
                    onProjectChanged: (app.Project project, app.Video? video) {
                      String videoChanged = '';
                      if (video != null) {
                        videoChanged = ' from ${video.name}';
                      }
                      print('project ${project.name} changed$videoChanged');
                    },
                  )..init(context)),
          ChangeNotifierProvider<pip.PipProvider>(
              create: (_) => pip.PipProvider()..init(const Duration(seconds: 2), getPanelPositionWhenProjectOpened())),
        ],
        child: CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Brightness.dark,
          ),
          child: Consumer2<app.LanguageProvider, app.ProjectProvider>(
              builder: (context, languageProvider, projectProvider, child) {
            buildMainScreen() {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Vision Example'),
                ),
                body: SingleChildScrollView(
                  child: Container(
//                      color: CupertinoColors.systemBackground.resolveFrom(context),
                      color: CupertinoColors.tertiarySystemBackground.resolveFrom(context),
                      alignment: Alignment.center,
                      child: Column(children: [
                        /*SizedBox(
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
                        ),*/
                        const SizedBox(height: 10),
                        Container(
                          height: 800,
                        ),
                      ])),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () async {
                    // await appDatabase.insertItem('hello ${DateTime.now().millisecondsSinceEpoch}');
                    // redraw
                    setState(() {});
                  },
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
              supportedLocales: vision.VisionLocalization.supportedLocales,
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
                builder: (isSideLayout) => app.ProjectScreen(
                  noProjectScreen: buildMainScreen(),
                  isSideLayout: isSideLayout,
                ),
              ),
            );
          }),
        ));
  }
}
