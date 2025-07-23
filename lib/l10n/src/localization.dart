import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localization_af.dart' deferred as localization_af;
import 'localization_am.dart' deferred as localization_am;
import 'localization_ar.dart' deferred as localization_ar;
import 'localization_az.dart' deferred as localization_az;
import 'localization_bg.dart' deferred as localization_bg;
import 'localization_bn.dart' deferred as localization_bn;
import 'localization_ca.dart' deferred as localization_ca;
import 'localization_cs.dart' deferred as localization_cs;
import 'localization_da.dart' deferred as localization_da;
import 'localization_de.dart' deferred as localization_de;
import 'localization_el.dart' deferred as localization_el;
import 'localization_en.dart' deferred as localization_en;
import 'localization_es.dart' deferred as localization_es;
import 'localization_et.dart' deferred as localization_et;
import 'localization_fa.dart' deferred as localization_fa;
import 'localization_fi.dart' deferred as localization_fi;
import 'localization_fr.dart' deferred as localization_fr;
import 'localization_gl.dart' deferred as localization_gl;
import 'localization_gu.dart' deferred as localization_gu;
import 'localization_he.dart' deferred as localization_he;
import 'localization_hi.dart' deferred as localization_hi;
import 'localization_hr.dart' deferred as localization_hr;
import 'localization_hu.dart' deferred as localization_hu;
import 'localization_id.dart' deferred as localization_id;
import 'localization_it.dart' deferred as localization_it;
import 'localization_ja.dart' deferred as localization_ja;
import 'localization_kk.dart' deferred as localization_kk;
import 'localization_ko.dart' deferred as localization_ko;
import 'localization_lt.dart' deferred as localization_lt;
import 'localization_lv.dart' deferred as localization_lv;
import 'localization_ml.dart' deferred as localization_ml;
import 'localization_mn.dart' deferred as localization_mn;
import 'localization_mr.dart' deferred as localization_mr;
import 'localization_ms.dart' deferred as localization_ms;
import 'localization_my.dart' deferred as localization_my;
import 'localization_nb.dart' deferred as localization_nb;
import 'localization_ne.dart' deferred as localization_ne;
import 'localization_nl.dart' deferred as localization_nl;
import 'localization_pl.dart' deferred as localization_pl;
import 'localization_pt.dart' deferred as localization_pt;
import 'localization_ro.dart' deferred as localization_ro;
import 'localization_ru.dart' deferred as localization_ru;
import 'localization_si.dart' deferred as localization_si;
import 'localization_sk.dart' deferred as localization_sk;
import 'localization_sl.dart' deferred as localization_sl;
import 'localization_sr.dart' deferred as localization_sr;
import 'localization_sv.dart' deferred as localization_sv;
import 'localization_sw.dart' deferred as localization_sw;
import 'localization_ta.dart' deferred as localization_ta;
import 'localization_te.dart' deferred as localization_te;
import 'localization_th.dart' deferred as localization_th;
import 'localization_tl.dart' deferred as localization_tl;
import 'localization_tr.dart' deferred as localization_tr;
import 'localization_uk.dart' deferred as localization_uk;
import 'localization_ur.dart' deferred as localization_ur;
import 'localization_uz.dart' deferred as localization_uz;
import 'localization_vi.dart' deferred as localization_vi;
import 'localization_zh.dart' deferred as localization_zh;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Localization
/// returned by `Localization.of(context)`.
///
/// Applications need to include `Localization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Localization.localizationsDelegates,
///   supportedLocales: Localization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Localization.supportedLocales
/// property.
abstract class Localization {
  Localization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization)!;
  }

  static const LocalizationsDelegate<Localization> delegate =
      _LocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('am'),
    Locale('ar'),
    Locale('ar', 'AE'),
    Locale('ar', 'DZ'),
    Locale('ar', 'EG'),
    Locale('az'),
    Locale('bg'),
    Locale('bn'),
    Locale('bn', 'IN'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('de', 'AT'),
    Locale('de', 'CH'),
    Locale('el'),
    Locale('en'),
    Locale('en', 'AU'),
    Locale('en', 'CA'),
    Locale('en', 'GB'),
    Locale('en', 'IN'),
    Locale('es'),
    Locale('es', 'AR'),
    Locale('es', 'CO'),
    Locale('es', 'MX'),
    Locale('et'),
    Locale('fa'),
    Locale('fi'),
    Locale('fr'),
    Locale('fr', 'BE'),
    Locale('fr', 'CA'),
    Locale('fr', 'CH'),
    Locale('gl'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kk'),
    Locale('ko'),
    Locale('lt'),
    Locale('lv'),
    Locale('ml'),
    Locale('mn'),
    Locale('mr'),
    Locale('ms'),
    Locale('ms', 'SG'),
    Locale('my'),
    Locale('nb'),
    Locale('ne'),
    Locale('nl'),
    Locale('nl', 'BE'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('ru', 'KZ'),
    Locale('ru', 'UA'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('sr'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('ur', 'IN'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zh', 'MO'),
    Locale('zh', 'SG')
  ];

  /// No description provided for @product_name.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get product_name;

  /// No description provided for @product_desc.
  ///
  /// In en, this message translates to:
  /// **'Using computer vision and ai to count people, vehicles, pets, and more.'**
  String get product_desc;

  /// No description provided for @product_copyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2025'**
  String get product_copyright;

  /// No description provided for @video_sources_webcam.
  ///
  /// In en, this message translates to:
  /// **'Webcam'**
  String get video_sources_webcam;

  /// No description provided for @video_sources_live_stream.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get video_sources_live_stream;

  /// No description provided for @video_sources_file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get video_sources_file;

  /// No description provided for @video_sources_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get video_sources_camera;

  /// No description provided for @video_sources_camera_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'Camera not found'**
  String get video_sources_camera_not_found_title;

  /// No description provided for @video_sources_camera_not_found_message.
  ///
  /// In en, this message translates to:
  /// **'Need grant camera permission to use camera'**
  String get video_sources_camera_not_found_message;

  /// No description provided for @video_sources_webcam_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'Webcam not found'**
  String get video_sources_webcam_not_found_title;

  /// No description provided for @video_sources_webcam_not_found_message.
  ///
  /// In en, this message translates to:
  /// **'Please check app permission and webcam connection'**
  String get video_sources_webcam_not_found_message;

  /// No description provided for @wizard_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Create a new project below to start counting.'**
  String get wizard_screen_desc;

  /// No description provided for @wizard_screen_new_project_from.
  ///
  /// In en, this message translates to:
  /// **'New Project from'**
  String get wizard_screen_new_project_from;

  /// No description provided for @wizard_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get wizard_screen_language;

  /// No description provided for @wizard_screen_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get wizard_screen_about;

  /// No description provided for @wizard_screen_open_projects_tip.
  ///
  /// In en, this message translates to:
  /// **'All projects will be saved locally automatically'**
  String get wizard_screen_open_projects_tip;

  /// No description provided for @wizard_screen_open_projects.
  ///
  /// In en, this message translates to:
  /// **'Open existing project'**
  String get wizard_screen_open_projects;

  /// No description provided for @wizard_screen_email_us.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get wizard_screen_email_us;

  /// No description provided for @language_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_screen_language;

  /// No description provided for @project_view_no_videos.
  ///
  /// In en, this message translates to:
  /// **'No video source available.'**
  String get project_view_no_videos;

  /// No description provided for @about_screen_title.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about_screen_title;

  /// No description provided for @about_screen_platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get about_screen_platform;

  /// No description provided for @about_screen_app_version.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get about_screen_app_version;

  /// No description provided for @about_screen_models.
  ///
  /// In en, this message translates to:
  /// **'Object detection models'**
  String get about_screen_models;

  /// No description provided for @about_screen_benchmark.
  ///
  /// In en, this message translates to:
  /// **'Benchmark'**
  String get about_screen_benchmark;

  /// No description provided for @about_screen_opencv_build_info.
  ///
  /// In en, this message translates to:
  /// **'OpenCV Build Info'**
  String get about_screen_opencv_build_info;

  /// No description provided for @benchmark_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Models Benchmarks'**
  String get benchmark_screen_title;

  /// No description provided for @benchmark_screen_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended Model'**
  String get benchmark_screen_recommended;

  /// No description provided for @benchmark_screen_fps.
  ///
  /// In en, this message translates to:
  /// **'FPS'**
  String get benchmark_screen_fps;

  /// No description provided for @benchmark_screen_start_button.
  ///
  /// In en, this message translates to:
  /// **'Start Benchmark'**
  String get benchmark_screen_start_button;

  /// No description provided for @benchmark_screen_start_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to start benchmark, the error code is'**
  String get benchmark_screen_start_failed;

  /// No description provided for @benchmark_screen_models.
  ///
  /// In en, this message translates to:
  /// **'Object detection models'**
  String get benchmark_screen_models;

  /// No description provided for @project_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project_screen_title;

  /// No description provided for @project_screen_exit_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm exit the project'**
  String get project_screen_exit_confirm_title;

  /// No description provided for @project_screen_exit_confirm_content.
  ///
  /// In en, this message translates to:
  /// **'Leaving the project will stop Counting. Are you sure you want to continue?'**
  String get project_screen_exit_confirm_content;

  /// No description provided for @project_screen_exit_button.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get project_screen_exit_button;

  /// No description provided for @project_screen_add_video_button.
  ///
  /// In en, this message translates to:
  /// **'Add video source'**
  String get project_screen_add_video_button;

  /// No description provided for @project_screen_from_desc.
  ///
  /// In en, this message translates to:
  /// **'We keep a rolling 24-hour record, so you can view any time slice you need.'**
  String get project_screen_from_desc;

  /// No description provided for @project_screen_report_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get project_screen_report_settings;

  /// No description provided for @filter_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter_screen_title;

  /// No description provided for @filter_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Select a filter range from the list below'**
  String get filter_screen_desc;

  /// No description provided for @filter_screen_error_title.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter_screen_error_title;

  /// No description provided for @filter_screen_error_content.
  ///
  /// In en, this message translates to:
  /// **'End time must be greater than start time'**
  String get filter_screen_error_content;

  /// No description provided for @filter_screen_error_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get filter_screen_error_custom;

  /// No description provided for @filter_screen_error_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get filter_screen_error_start;

  /// No description provided for @filter_screen_error_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get filter_screen_error_end;

  /// No description provided for @settings_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_screen_title;

  /// No description provided for @settings_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Set Project name, detection parameters, count clearing.'**
  String get settings_screen_desc;

  /// No description provided for @settings_screen_project_id.
  ///
  /// In en, this message translates to:
  /// **'Project Id'**
  String get settings_screen_project_id;

  /// No description provided for @settings_screen_project_name.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get settings_screen_project_name;

  /// No description provided for @settings_screen_project_name_place_holder.
  ///
  /// In en, this message translates to:
  /// **'123 Main St. or Park Avenue'**
  String get settings_screen_project_name_place_holder;

  /// No description provided for @settings_screen_project_error.
  ///
  /// In en, this message translates to:
  /// **'The project name cannot be empty'**
  String get settings_screen_project_error;

  /// No description provided for @settings_screen_random_count_button.
  ///
  /// In en, this message translates to:
  /// **'Add random counts'**
  String get settings_screen_random_count_button;

  /// No description provided for @settings_screen_reset_count_header.
  ///
  /// In en, this message translates to:
  /// **'Reset all counts in this project'**
  String get settings_screen_reset_count_header;

  /// No description provided for @settings_screen_reset_count_button.
  ///
  /// In en, this message translates to:
  /// **'Reset counts'**
  String get settings_screen_reset_count_button;

  /// No description provided for @settings_screen_reset_count_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all counts?'**
  String get settings_screen_reset_count_content;

  /// No description provided for @settings_screen_delete_header.
  ///
  /// In en, this message translates to:
  /// **'Delete this project'**
  String get settings_screen_delete_header;

  /// No description provided for @settings_screen_delete_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this project?'**
  String get settings_screen_delete_content;

  /// No description provided for @settings_screen_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settings_screen_delete_button;

  /// No description provided for @settings_screen_center_point_title.
  ///
  /// In en, this message translates to:
  /// **'Center Point on Target'**
  String get settings_screen_center_point_title;

  /// No description provided for @settings_screen_center_point_desc.
  ///
  /// In en, this message translates to:
  /// **'The center point helps determine whether the target is within the hit zone.'**
  String get settings_screen_center_point_desc;

  /// No description provided for @settings_screen_center_point_button.
  ///
  /// In en, this message translates to:
  /// **'Show Center Point on Target'**
  String get settings_screen_center_point_button;

  /// No description provided for @settings_screen_lost_target_title.
  ///
  /// In en, this message translates to:
  /// **'Lost Target'**
  String get settings_screen_lost_target_title;

  /// No description provided for @settings_screen_lost_target_desc.
  ///
  /// In en, this message translates to:
  /// **'When object tracking loses a target, this option makes it visible. By default, lost targets are not shown.'**
  String get settings_screen_lost_target_desc;

  /// No description provided for @settings_screen_lost_target_button.
  ///
  /// In en, this message translates to:
  /// **'Show Lost Target'**
  String get settings_screen_lost_target_button;

  /// No description provided for @detection_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Detection Settings'**
  String get detection_screen_title;

  /// No description provided for @detection_screen_models.
  ///
  /// In en, this message translates to:
  /// **'Models'**
  String get detection_screen_models;

  /// No description provided for @detection_screen_confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get detection_screen_confidence;

  /// No description provided for @detection_screen_confidence_desc.
  ///
  /// In en, this message translates to:
  /// **'confidence over #0 considered as a valid detection'**
  String get detection_screen_confidence_desc;

  /// No description provided for @detection_screen_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get detection_screen_low;

  /// No description provided for @detection_screen_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get detection_screen_high;

  /// No description provided for @detection_screen_nms.
  ///
  /// In en, this message translates to:
  /// **'Non-Maximum Suppression'**
  String get detection_screen_nms;

  /// No description provided for @detection_screen_nms_desc.
  ///
  /// In en, this message translates to:
  /// **'#0 Lower NMS threshold (e.g. 0.3-0.4) removes overlapping boxes more strictly and reduces false positives but may miss overlapping people. Higher threshold (0.7-0.9) keeps more boxes which may increase false positives but better detects overlapping people.'**
  String get detection_screen_nms_desc;

  /// No description provided for @detection_screen_match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get detection_screen_match;

  /// No description provided for @detection_screen_match_desc.
  ///
  /// In en, this message translates to:
  /// **'#0 matchThreshold is a key parameter in object tracking that measures the degree of matching between different detection boxes. Lower value makes object association easier but increases the risk of wrong associations. Higher value is stricter on object associations but may miss some true matches.'**
  String get detection_screen_match_desc;

  /// No description provided for @detection_screen_lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get detection_screen_lost;

  /// No description provided for @detection_screen_lost_desc.
  ///
  /// In en, this message translates to:
  /// **'Dynamically determines lost object removal time between #0 and #1 based on movement speed'**
  String get detection_screen_lost_desc;

  /// No description provided for @detection_screen_consider_valid.
  ///
  /// In en, this message translates to:
  /// **'Consider valid after'**
  String get detection_screen_consider_valid;

  /// No description provided for @detection_screen_consider_valid_desc.
  ///
  /// In en, this message translates to:
  /// **'Track object will be consider valid after #0'**
  String get detection_screen_consider_valid_desc;

  /// No description provided for @detection_screen_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get detection_screen_reset;

  /// No description provided for @detection_screen_reset_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the detection settings?'**
  String get detection_screen_reset_content;

  /// No description provided for @url_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get url_screen_title;

  /// No description provided for @url_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the live stream URL'**
  String get url_screen_desc;

  /// No description provided for @url_screen_url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url_screen_url;

  /// No description provided for @url_screen_url_placeholder.
  ///
  /// In en, this message translates to:
  /// **'http://example.com/stream or rtsp://example.com/stream'**
  String get url_screen_url_placeholder;

  /// No description provided for @add_video_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Add Video source'**
  String get add_video_screen_title;

  /// No description provided for @add_video_screen_from.
  ///
  /// In en, this message translates to:
  /// **'Add video source from'**
  String get add_video_screen_from;

  /// No description provided for @webcam_screen_add_title.
  ///
  /// In en, this message translates to:
  /// **'Add Webcam'**
  String get webcam_screen_add_title;

  /// No description provided for @webcam_screen_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Webcam'**
  String get webcam_screen_edit_title;

  /// No description provided for @webcam_manager_webcam.
  ///
  /// In en, this message translates to:
  /// **'Webcam'**
  String get webcam_manager_webcam;

  /// No description provided for @camera_screen_front_camera.
  ///
  /// In en, this message translates to:
  /// **'Front Camera'**
  String get camera_screen_front_camera;

  /// No description provided for @camera_screen_back_camera.
  ///
  /// In en, this message translates to:
  /// **'Back Camera'**
  String get camera_screen_back_camera;

  /// No description provided for @camera_screen_add_title.
  ///
  /// In en, this message translates to:
  /// **'Add Camera'**
  String get camera_screen_add_title;

  /// No description provided for @camera_screen_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Camera'**
  String get camera_screen_edit_title;

  /// No description provided for @camera_screen_zoom_level.
  ///
  /// In en, this message translates to:
  /// **'Zoom Level'**
  String get camera_screen_zoom_level;

  /// No description provided for @video_screen_name_empty.
  ///
  /// In en, this message translates to:
  /// **'The video name cannot be empty.'**
  String get video_screen_name_empty;

  /// No description provided for @video_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage video sources, add or modify detection zones.'**
  String get video_screen_desc;

  /// No description provided for @video_screen_video_name.
  ///
  /// In en, this message translates to:
  /// **'Video source name'**
  String get video_screen_video_name;

  /// No description provided for @video_screen_edit_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Front Door Cam or Parking Lot Cam'**
  String get video_screen_edit_placeholder;

  /// No description provided for @video_screen_change_file.
  ///
  /// In en, this message translates to:
  /// **'Change File'**
  String get video_screen_change_file;

  /// No description provided for @video_screen_add_zone.
  ///
  /// In en, this message translates to:
  /// **'Add detection zone'**
  String get video_screen_add_zone;

  /// No description provided for @video_screen_zones.
  ///
  /// In en, this message translates to:
  /// **'Detection zones'**
  String get video_screen_zones;

  /// No description provided for @video_screen_zones_desc.
  ///
  /// In en, this message translates to:
  /// **'Use drag and drop to adjust zones'**
  String get video_screen_zones_desc;

  /// No description provided for @video_screen_tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get video_screen_tools;

  /// No description provided for @video_screen_move_bottom.
  ///
  /// In en, this message translates to:
  /// **'Move current zone to bottom'**
  String get video_screen_move_bottom;

  /// No description provided for @video_screen_add_point.
  ///
  /// In en, this message translates to:
  /// **'Add point to current zone'**
  String get video_screen_add_point;

  /// No description provided for @video_screen_remove_point.
  ///
  /// In en, this message translates to:
  /// **'Remove point from current zone'**
  String get video_screen_remove_point;

  /// No description provided for @video_screen_playback_speed.
  ///
  /// In en, this message translates to:
  /// **'Playback Speed'**
  String get video_screen_playback_speed;

  /// No description provided for @video_screen_playback_current.
  ///
  /// In en, this message translates to:
  /// **'current: '**
  String get video_screen_playback_current;

  /// No description provided for @video_screen_playback_14x.
  ///
  /// In en, this message translates to:
  /// **'1/4x'**
  String get video_screen_playback_14x;

  /// No description provided for @video_screen_playback_2x.
  ///
  /// In en, this message translates to:
  /// **'2x'**
  String get video_screen_playback_2x;

  /// No description provided for @video_screen_delete_header.
  ///
  /// In en, this message translates to:
  /// **'Delete this video source'**
  String get video_screen_delete_header;

  /// No description provided for @video_screen_delete_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this video source?'**
  String get video_screen_delete_content;

  /// No description provided for @video_screen_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get video_screen_delete_button;

  /// No description provided for @video_screen_sources.
  ///
  /// In en, this message translates to:
  /// **'Configure image source, detection targets, and model parameters.'**
  String get video_screen_sources;

  /// No description provided for @video_screen_targets.
  ///
  /// In en, this message translates to:
  /// **'Detection targets'**
  String get video_screen_targets;

  /// No description provided for @video_screen_detection.
  ///
  /// In en, this message translates to:
  /// **'Model parameters'**
  String get video_screen_detection;

  /// No description provided for @color_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get color_screen_title;

  /// No description provided for @zone_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'The detection zone can set the types of objects to detect and choose which counters to display, such as Detected, Spawned, and Entered.'**
  String get zone_screen_desc;

  /// No description provided for @zone_screen_name_placeholder.
  ///
  /// In en, this message translates to:
  /// **'The name of the zone, like Sidewalk or Parking Lot'**
  String get zone_screen_name_placeholder;

  /// No description provided for @zone_screen_zone_color.
  ///
  /// In en, this message translates to:
  /// **'Zone color'**
  String get zone_screen_zone_color;

  /// No description provided for @zone_screen_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get zone_screen_color;

  /// No description provided for @zone_screen_delete_header.
  ///
  /// In en, this message translates to:
  /// **'Delete this zone'**
  String get zone_screen_delete_header;

  /// No description provided for @zone_screen_delete_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this zone?'**
  String get zone_screen_delete_content;

  /// No description provided for @zone_screen_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get zone_screen_delete_button;

  /// No description provided for @zone_screen_can_not_delete.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete zone'**
  String get zone_screen_can_not_delete;

  /// No description provided for @zone_screen_one_zone_required.
  ///
  /// In en, this message translates to:
  /// **'At least one zone is required.'**
  String get zone_screen_one_zone_required;

  /// No description provided for @zone_screen_zone_name_required.
  ///
  /// In en, this message translates to:
  /// **'The zone name cannot be empty'**
  String get zone_screen_zone_name_required;

  /// No description provided for @counter_screen_show_on.
  ///
  /// In en, this message translates to:
  /// **'Show on screen'**
  String get counter_screen_show_on;

  /// No description provided for @counter_screen_enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get counter_screen_enabled;

  /// No description provided for @counter_screen_reentry_threshold.
  ///
  /// In en, this message translates to:
  /// **'Re-entry Threshold'**
  String get counter_screen_reentry_threshold;

  /// No description provided for @counter_screen_reentry_desc.
  ///
  /// In en, this message translates to:
  /// **'Objects must enter #0 times, with a #1 second cooldown between each exit and re-entry, to trigger re-entry'**
  String get counter_screen_reentry_desc;

  /// No description provided for @counter_screen_reentry_title.
  ///
  /// In en, this message translates to:
  /// **'Re-entry count'**
  String get counter_screen_reentry_title;

  /// No description provided for @counter_screen_cooldown_threshold.
  ///
  /// In en, this message translates to:
  /// **'Cooldown Threshold'**
  String get counter_screen_cooldown_threshold;

  /// No description provided for @counter_screen_cooldown_desc.
  ///
  /// In en, this message translates to:
  /// **'Re-entry requires a #0 second cooldown after exiting the detection zone'**
  String get counter_screen_cooldown_desc;

  /// No description provided for @counter_screen_cooldown_time.
  ///
  /// In en, this message translates to:
  /// **'Cooldown Time'**
  String get counter_screen_cooldown_time;

  /// No description provided for @counter_screen_cooldown_in_seconds.
  ///
  /// In en, this message translates to:
  /// **'in seconds'**
  String get counter_screen_cooldown_in_seconds;

  /// No description provided for @counter_screen_stagnant_threshold.
  ///
  /// In en, this message translates to:
  /// **'Stagnant Threshold'**
  String get counter_screen_stagnant_threshold;

  /// No description provided for @counter_screen_stagnant_desc.
  ///
  /// In en, this message translates to:
  /// **'Objects remaining stationary for more than #0 seconds will be considered stagnant'**
  String get counter_screen_stagnant_desc;

  /// No description provided for @counter_screen_stagnant_consider.
  ///
  /// In en, this message translates to:
  /// **'Consider as stagnant'**
  String get counter_screen_stagnant_consider;

  /// No description provided for @counter_screen_stagnant_in_seconds.
  ///
  /// In en, this message translates to:
  /// **'in seconds'**
  String get counter_screen_stagnant_in_seconds;

  /// No description provided for @counter_screen_stagnant_desc_prefix.
  ///
  /// In en, this message translates to:
  /// **'Description Prefix'**
  String get counter_screen_stagnant_desc_prefix;

  /// No description provided for @counter_screen_stagnant_desc_suffix.
  ///
  /// In en, this message translates to:
  /// **'Description Suffix'**
  String get counter_screen_stagnant_desc_suffix;

  /// No description provided for @counter_screen_name_error.
  ///
  /// In en, this message translates to:
  /// **'The counter name cannot be empty'**
  String get counter_screen_name_error;

  /// No description provided for @counter_screen_enabled_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get counter_screen_enabled_error;

  /// No description provided for @counter_screen_enabled_error_content.
  ///
  /// In en, this message translates to:
  /// **'You need to enable other counter first, then you can disable this counter'**
  String get counter_screen_enabled_error_content;

  /// No description provided for @objects_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get objects_screen_title;

  /// No description provided for @objects_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Choose detection targets like person, car, bus, etc.'**
  String get objects_screen_desc;

  /// No description provided for @open_project_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Open Project'**
  String get open_project_screen_title;

  /// No description provided for @open_project_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Open previously created projects, keeping only the most recent 20.'**
  String get open_project_screen_desc;

  /// No description provided for @open_project_screen_no_project.
  ///
  /// In en, this message translates to:
  /// **'No project found.'**
  String get open_project_screen_no_project;

  /// No description provided for @default_project_name.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get default_project_name;

  /// No description provided for @default_video_name.
  ///
  /// In en, this message translates to:
  /// **'Video source'**
  String get default_video_name;

  /// No description provided for @default_zone_name.
  ///
  /// In en, this message translates to:
  /// **'Detection zone'**
  String get default_zone_name;

  /// No description provided for @error_oops.
  ///
  /// In en, this message translates to:
  /// **'Oops, something went wrong'**
  String get error_oops;

  /// No description provided for @error_content.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Would you like to submit a email report?'**
  String get error_content;

  /// No description provided for @error_report.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get error_report;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @zone_screen_zone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zone_screen_zone;

  /// No description provided for @zone_screen_zone_show_summary.
  ///
  /// In en, this message translates to:
  /// **'Show summary on screen'**
  String get zone_screen_zone_show_summary;

  /// No description provided for @video_sources_photos_denied.
  ///
  /// In en, this message translates to:
  /// **'Access to photos denied'**
  String get video_sources_photos_denied;

  /// No description provided for @video_sources_photos_goto_settings.
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get video_sources_photos_goto_settings;

  /// No description provided for @video_sources_camera_denied.
  ///
  /// In en, this message translates to:
  /// **'Access to camera denied'**
  String get video_sources_camera_denied;

  /// No description provided for @video_sources_photos_denied_msg.
  ///
  /// In en, this message translates to:
  /// **'Please go to settings and allow photos access permission for this app.'**
  String get video_sources_photos_denied_msg;

  /// No description provided for @video_sources_camera_denied_msg.
  ///
  /// In en, this message translates to:
  /// **'Please go to settings and allow camera access permission for this app.'**
  String get video_sources_camera_denied_msg;
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();

  @override
  Future<Localization> load(Locale locale) {
    return lookupLocalization(locale);
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'am',
        'ar',
        'az',
        'bg',
        'bn',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'et',
        'fa',
        'fi',
        'fr',
        'gl',
        'gu',
        'he',
        'hi',
        'hr',
        'hu',
        'id',
        'it',
        'ja',
        'kk',
        'ko',
        'lt',
        'lv',
        'ml',
        'mn',
        'mr',
        'ms',
        'my',
        'nb',
        'ne',
        'nl',
        'pl',
        'pt',
        'ro',
        'ru',
        'si',
        'sk',
        'sl',
        'sr',
        'sv',
        'sw',
        'ta',
        'te',
        'th',
        'tl',
        'tr',
        'uk',
        'ur',
        'uz',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}

Future<Localization> lookupLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'AE':
            return localization_ar
                .loadLibrary()
                .then((dynamic _) => localization_ar.LocalizationArAe());
          case 'DZ':
            return localization_ar
                .loadLibrary()
                .then((dynamic _) => localization_ar.LocalizationArDz());
          case 'EG':
            return localization_ar
                .loadLibrary()
                .then((dynamic _) => localization_ar.LocalizationArEg());
        }
        break;
      }
    case 'bn':
      {
        switch (locale.countryCode) {
          case 'IN':
            return localization_bn
                .loadLibrary()
                .then((dynamic _) => localization_bn.LocalizationBnIn());
        }
        break;
      }
    case 'de':
      {
        switch (locale.countryCode) {
          case 'AT':
            return localization_de
                .loadLibrary()
                .then((dynamic _) => localization_de.LocalizationDeAt());
          case 'CH':
            return localization_de
                .loadLibrary()
                .then((dynamic _) => localization_de.LocalizationDeCh());
        }
        break;
      }
    case 'en':
      {
        switch (locale.countryCode) {
          case 'AU':
            return localization_en
                .loadLibrary()
                .then((dynamic _) => localization_en.LocalizationEnAu());
          case 'CA':
            return localization_en
                .loadLibrary()
                .then((dynamic _) => localization_en.LocalizationEnCa());
          case 'GB':
            return localization_en
                .loadLibrary()
                .then((dynamic _) => localization_en.LocalizationEnGb());
          case 'IN':
            return localization_en
                .loadLibrary()
                .then((dynamic _) => localization_en.LocalizationEnIn());
        }
        break;
      }
    case 'es':
      {
        switch (locale.countryCode) {
          case 'AR':
            return localization_es
                .loadLibrary()
                .then((dynamic _) => localization_es.LocalizationEsAr());
          case 'CO':
            return localization_es
                .loadLibrary()
                .then((dynamic _) => localization_es.LocalizationEsCo());
          case 'MX':
            return localization_es
                .loadLibrary()
                .then((dynamic _) => localization_es.LocalizationEsMx());
        }
        break;
      }
    case 'fr':
      {
        switch (locale.countryCode) {
          case 'BE':
            return localization_fr
                .loadLibrary()
                .then((dynamic _) => localization_fr.LocalizationFrBe());
          case 'CA':
            return localization_fr
                .loadLibrary()
                .then((dynamic _) => localization_fr.LocalizationFrCa());
          case 'CH':
            return localization_fr
                .loadLibrary()
                .then((dynamic _) => localization_fr.LocalizationFrCh());
        }
        break;
      }
    case 'ms':
      {
        switch (locale.countryCode) {
          case 'SG':
            return localization_ms
                .loadLibrary()
                .then((dynamic _) => localization_ms.LocalizationMsSg());
        }
        break;
      }
    case 'nl':
      {
        switch (locale.countryCode) {
          case 'BE':
            return localization_nl
                .loadLibrary()
                .then((dynamic _) => localization_nl.LocalizationNlBe());
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'PT':
            return localization_pt
                .loadLibrary()
                .then((dynamic _) => localization_pt.LocalizationPtPt());
        }
        break;
      }
    case 'ru':
      {
        switch (locale.countryCode) {
          case 'KZ':
            return localization_ru
                .loadLibrary()
                .then((dynamic _) => localization_ru.LocalizationRuKz());
          case 'UA':
            return localization_ru
                .loadLibrary()
                .then((dynamic _) => localization_ru.LocalizationRuUa());
        }
        break;
      }
    case 'ur':
      {
        switch (locale.countryCode) {
          case 'IN':
            return localization_ur
                .loadLibrary()
                .then((dynamic _) => localization_ur.LocalizationUrIn());
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return localization_zh
                .loadLibrary()
                .then((dynamic _) => localization_zh.LocalizationZhCn());
          case 'HK':
            return localization_zh
                .loadLibrary()
                .then((dynamic _) => localization_zh.LocalizationZhHk());
          case 'MO':
            return localization_zh
                .loadLibrary()
                .then((dynamic _) => localization_zh.LocalizationZhMo());
          case 'SG':
            return localization_zh
                .loadLibrary()
                .then((dynamic _) => localization_zh.LocalizationZhSg());
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return localization_af
          .loadLibrary()
          .then((dynamic _) => localization_af.LocalizationAf());
    case 'am':
      return localization_am
          .loadLibrary()
          .then((dynamic _) => localization_am.LocalizationAm());
    case 'ar':
      return localization_ar
          .loadLibrary()
          .then((dynamic _) => localization_ar.LocalizationAr());
    case 'az':
      return localization_az
          .loadLibrary()
          .then((dynamic _) => localization_az.LocalizationAz());
    case 'bg':
      return localization_bg
          .loadLibrary()
          .then((dynamic _) => localization_bg.LocalizationBg());
    case 'bn':
      return localization_bn
          .loadLibrary()
          .then((dynamic _) => localization_bn.LocalizationBn());
    case 'ca':
      return localization_ca
          .loadLibrary()
          .then((dynamic _) => localization_ca.LocalizationCa());
    case 'cs':
      return localization_cs
          .loadLibrary()
          .then((dynamic _) => localization_cs.LocalizationCs());
    case 'da':
      return localization_da
          .loadLibrary()
          .then((dynamic _) => localization_da.LocalizationDa());
    case 'de':
      return localization_de
          .loadLibrary()
          .then((dynamic _) => localization_de.LocalizationDe());
    case 'el':
      return localization_el
          .loadLibrary()
          .then((dynamic _) => localization_el.LocalizationEl());
    case 'en':
      return localization_en
          .loadLibrary()
          .then((dynamic _) => localization_en.LocalizationEn());
    case 'es':
      return localization_es
          .loadLibrary()
          .then((dynamic _) => localization_es.LocalizationEs());
    case 'et':
      return localization_et
          .loadLibrary()
          .then((dynamic _) => localization_et.LocalizationEt());
    case 'fa':
      return localization_fa
          .loadLibrary()
          .then((dynamic _) => localization_fa.LocalizationFa());
    case 'fi':
      return localization_fi
          .loadLibrary()
          .then((dynamic _) => localization_fi.LocalizationFi());
    case 'fr':
      return localization_fr
          .loadLibrary()
          .then((dynamic _) => localization_fr.LocalizationFr());
    case 'gl':
      return localization_gl
          .loadLibrary()
          .then((dynamic _) => localization_gl.LocalizationGl());
    case 'gu':
      return localization_gu
          .loadLibrary()
          .then((dynamic _) => localization_gu.LocalizationGu());
    case 'he':
      return localization_he
          .loadLibrary()
          .then((dynamic _) => localization_he.LocalizationHe());
    case 'hi':
      return localization_hi
          .loadLibrary()
          .then((dynamic _) => localization_hi.LocalizationHi());
    case 'hr':
      return localization_hr
          .loadLibrary()
          .then((dynamic _) => localization_hr.LocalizationHr());
    case 'hu':
      return localization_hu
          .loadLibrary()
          .then((dynamic _) => localization_hu.LocalizationHu());
    case 'id':
      return localization_id
          .loadLibrary()
          .then((dynamic _) => localization_id.LocalizationId());
    case 'it':
      return localization_it
          .loadLibrary()
          .then((dynamic _) => localization_it.LocalizationIt());
    case 'ja':
      return localization_ja
          .loadLibrary()
          .then((dynamic _) => localization_ja.LocalizationJa());
    case 'kk':
      return localization_kk
          .loadLibrary()
          .then((dynamic _) => localization_kk.LocalizationKk());
    case 'ko':
      return localization_ko
          .loadLibrary()
          .then((dynamic _) => localization_ko.LocalizationKo());
    case 'lt':
      return localization_lt
          .loadLibrary()
          .then((dynamic _) => localization_lt.LocalizationLt());
    case 'lv':
      return localization_lv
          .loadLibrary()
          .then((dynamic _) => localization_lv.LocalizationLv());
    case 'ml':
      return localization_ml
          .loadLibrary()
          .then((dynamic _) => localization_ml.LocalizationMl());
    case 'mn':
      return localization_mn
          .loadLibrary()
          .then((dynamic _) => localization_mn.LocalizationMn());
    case 'mr':
      return localization_mr
          .loadLibrary()
          .then((dynamic _) => localization_mr.LocalizationMr());
    case 'ms':
      return localization_ms
          .loadLibrary()
          .then((dynamic _) => localization_ms.LocalizationMs());
    case 'my':
      return localization_my
          .loadLibrary()
          .then((dynamic _) => localization_my.LocalizationMy());
    case 'nb':
      return localization_nb
          .loadLibrary()
          .then((dynamic _) => localization_nb.LocalizationNb());
    case 'ne':
      return localization_ne
          .loadLibrary()
          .then((dynamic _) => localization_ne.LocalizationNe());
    case 'nl':
      return localization_nl
          .loadLibrary()
          .then((dynamic _) => localization_nl.LocalizationNl());
    case 'pl':
      return localization_pl
          .loadLibrary()
          .then((dynamic _) => localization_pl.LocalizationPl());
    case 'pt':
      return localization_pt
          .loadLibrary()
          .then((dynamic _) => localization_pt.LocalizationPt());
    case 'ro':
      return localization_ro
          .loadLibrary()
          .then((dynamic _) => localization_ro.LocalizationRo());
    case 'ru':
      return localization_ru
          .loadLibrary()
          .then((dynamic _) => localization_ru.LocalizationRu());
    case 'si':
      return localization_si
          .loadLibrary()
          .then((dynamic _) => localization_si.LocalizationSi());
    case 'sk':
      return localization_sk
          .loadLibrary()
          .then((dynamic _) => localization_sk.LocalizationSk());
    case 'sl':
      return localization_sl
          .loadLibrary()
          .then((dynamic _) => localization_sl.LocalizationSl());
    case 'sr':
      return localization_sr
          .loadLibrary()
          .then((dynamic _) => localization_sr.LocalizationSr());
    case 'sv':
      return localization_sv
          .loadLibrary()
          .then((dynamic _) => localization_sv.LocalizationSv());
    case 'sw':
      return localization_sw
          .loadLibrary()
          .then((dynamic _) => localization_sw.LocalizationSw());
    case 'ta':
      return localization_ta
          .loadLibrary()
          .then((dynamic _) => localization_ta.LocalizationTa());
    case 'te':
      return localization_te
          .loadLibrary()
          .then((dynamic _) => localization_te.LocalizationTe());
    case 'th':
      return localization_th
          .loadLibrary()
          .then((dynamic _) => localization_th.LocalizationTh());
    case 'tl':
      return localization_tl
          .loadLibrary()
          .then((dynamic _) => localization_tl.LocalizationTl());
    case 'tr':
      return localization_tr
          .loadLibrary()
          .then((dynamic _) => localization_tr.LocalizationTr());
    case 'uk':
      return localization_uk
          .loadLibrary()
          .then((dynamic _) => localization_uk.LocalizationUk());
    case 'ur':
      return localization_ur
          .loadLibrary()
          .then((dynamic _) => localization_ur.LocalizationUr());
    case 'uz':
      return localization_uz
          .loadLibrary()
          .then((dynamic _) => localization_uz.LocalizationUz());
    case 'vi':
      return localization_vi
          .loadLibrary()
          .then((dynamic _) => localization_vi.LocalizationVi());
    case 'zh':
      return localization_zh
          .loadLibrary()
          .then((dynamic _) => localization_zh.LocalizationZh());
  }

  throw FlutterError(
      'Localization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
