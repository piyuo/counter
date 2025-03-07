import 'package:counter/app/app.dart' as app;
import 'package:counter/db/db.dart' as db;
import 'package:counter/l10n/app_localization.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:counter/wizard/wizard.dart' as wizard;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vision/vision.dart' as vision;

main() {
  registerTimeagoLocales();
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
//                      print('--------------- project changed!!!----------------');
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
          child: Consumer3<vision.LanguageProvider, app.ProjectProvider, pip.PipProvider>(
              builder: (context, languageProvider, projectProvider, pipProvider, child) {
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
              locale: Intl.defaultLocale == null ? null : Locale(Intl.defaultLocale!),
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
                deviceOrientationForPortrait:
                    projectProvider.isLockToPortrait ? projectProvider.deviceOrientation : null,
                slidingBuilder: (isPanelOpened) => wizard.WizardNavigator(
                  isPanelOpened: isPanelOpened,
                  pipProvider: pipProvider,
                  onScroll: (scrollController) => pipProvider.onScroll(scrollController),
                ),
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

/// Register timeago locales
void registerTimeagoLocales() async {
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
  timeago.setLocaleMessages('az', timeago.AzMessages());
  timeago.setLocaleMessages('az_short', timeago.AzShortMessages());
  timeago.setLocaleMessages('ca', timeago.CaMessages());
  timeago.setLocaleMessages('ca_short', timeago.CaShortMessages());
  timeago.setLocaleMessages('cs', timeago.CsMessages());
  timeago.setLocaleMessages('cs_short', timeago.CsShortMessages());
  timeago.setLocaleMessages('bn', timeago.BnMessages());
  timeago.setLocaleMessages('bn_short', timeago.BnShortMessages());
  timeago.setLocaleMessages('da', timeago.DaMessages());
  timeago.setLocaleMessages('da_short', timeago.DaShortMessages());
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('de_short', timeago.DeShortMessages());
  timeago.setLocaleMessages('dv', timeago.DvMessages());
  timeago.setLocaleMessages('dv_short', timeago.DvShortMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
  timeago.setLocaleMessages('es', timeago.EsMessages());
  timeago.setLocaleMessages('es_short', timeago.EsShortMessages());
  timeago.setLocaleMessages('et', timeago.EtMessages());
  timeago.setLocaleMessages('et_short', timeago.EtShortMessages());
  timeago.setLocaleMessages('fa', timeago.FaMessages());
  timeago.setLocaleMessages('fi', timeago.FiMessages());
  timeago.setLocaleMessages('fi_short', timeago.FiShortMessages());
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
  timeago.setLocaleMessages('gr', timeago.GrMessages());
  timeago.setLocaleMessages('gr_short', timeago.GrShortMessages());
  timeago.setLocaleMessages('he', timeago.HeMessages());
  timeago.setLocaleMessages('he', timeago.HeMessages());
  timeago.setLocaleMessages('he_short', timeago.HeShortMessages());
  timeago.setLocaleMessages('hi', timeago.HiMessages());
  timeago.setLocaleMessages('hi_short', timeago.HiShortMessages());
  timeago.setLocaleMessages('hu', timeago.HuMessages());
  timeago.setLocaleMessages('hu_short', timeago.HuShortMessages());
  timeago.setLocaleMessages('id', timeago.IdMessages());
  timeago.setLocaleMessages('id_short', timeago.IdShortMessages());
  timeago.setLocaleMessages('it', timeago.ItMessages());
  timeago.setLocaleMessages('it_short', timeago.ItShortMessages());
  timeago.setLocaleMessages('ja', timeago.JaMessages());
  timeago.setLocaleMessages('km', timeago.KmMessages());
  timeago.setLocaleMessages('km_short', timeago.KmShortMessages());
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  timeago.setLocaleMessages('ku', timeago.KuMessages());
  timeago.setLocaleMessages('ku_short', timeago.KuShortMessages());
  timeago.setLocaleMessages('mn', timeago.MnMessages());
  timeago.setLocaleMessages('mn_short', timeago.MnShortMessages());
  timeago.setLocaleMessages('ms_MY', timeago.MsMyMessages());
  timeago.setLocaleMessages('ms_MY_short', timeago.MsMyShortMessages());
  timeago.setLocaleMessages('nb_NO', timeago.NbNoMessages());
  timeago.setLocaleMessages('nb_NO_short', timeago.NbNoShortMessages());
  timeago.setLocaleMessages('nl', timeago.NlMessages());
  timeago.setLocaleMessages('nl_short', timeago.NlShortMessages());
  timeago.setLocaleMessages('nn_NO', timeago.NnNoMessages());
  timeago.setLocaleMessages('nn_NO_short', timeago.NnNoShortMessages());
  timeago.setLocaleMessages('pl', timeago.PlMessages());
  timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
  timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
  timeago.setLocaleMessages('ro', timeago.RoMessages());
  timeago.setLocaleMessages('ro_short', timeago.RoShortMessages());
  timeago.setLocaleMessages('ru', timeago.RuMessages());
  timeago.setLocaleMessages('ru_short', timeago.RuShortMessages());
  timeago.setLocaleMessages('rw', timeago.RwMessages());
  timeago.setLocaleMessages('rw_short', timeago.RwShortMessages());
  timeago.setLocaleMessages('sv', timeago.SvMessages());
  timeago.setLocaleMessages('sv_short', timeago.SvShortMessages());
  timeago.setLocaleMessages('ta', timeago.TaMessages());
  timeago.setLocaleMessages('th', timeago.ThMessages());
  timeago.setLocaleMessages('th_short', timeago.ThShortMessages());
  timeago.setLocaleMessages('tk', timeago.TkMessages());
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  timeago.setLocaleMessages('tr', timeago.TrShortMessages());
  timeago.setLocaleMessages('uk', timeago.UkMessages());
  timeago.setLocaleMessages('uk_short', timeago.UkShortMessages());
  timeago.setLocaleMessages('ur', timeago.UrMessages());
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
  timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
  timeago.setLocaleMessages('zh', timeago.ZhMessages());
}
