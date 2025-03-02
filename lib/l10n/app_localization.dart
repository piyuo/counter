import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_en.dart';
import 'app_localization_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalization
/// returned by `AppLocalization.of(context)`.
///
/// Applications need to include `AppLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalization.localizationsDelegates,
///   supportedLocales: AppLocalization.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalization.supportedLocales
/// property.
abstract class AppLocalization {
  AppLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @product_name.
  ///
  /// In en, this message translates to:
  /// **'Vision Counter'**
  String get product_name;

  /// No description provided for @product_copyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2025'**
  String get product_copyright;

  /// No description provided for @video_starter_webcam.
  ///
  /// In en, this message translates to:
  /// **'Webcam'**
  String get video_starter_webcam;

  /// No description provided for @video_starter_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get video_starter_camera;

  /// No description provided for @video_starter_live_stream.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get video_starter_live_stream;

  /// No description provided for @video_starter_file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get video_starter_file;

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
  /// **'All project will save to local automatically'**
  String get wizard_screen_open_projects_tip;

  /// No description provided for @wizard_screen_open_projects.
  ///
  /// In en, this message translates to:
  /// **'Open existing project'**
  String get wizard_screen_open_projects;

  /// No description provided for @language_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_screen_language;

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
  /// **'Models'**
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
  /// **'Benchmarks'**
  String get benchmark_screen_title;

  /// No description provided for @benchmark_screen_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
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
  /// **'Add video'**
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
  /// **'Select report range from the list below'**
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

  /// No description provided for @settings_screen_detection.
  ///
  /// In en, this message translates to:
  /// **'Detection'**
  String get settings_screen_detection;

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

  /// No description provided for @detection_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Detection'**
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
  /// **'#0 A lower NMS threshold (e.g., 30%) will more aggressively remove overlapping bounding boxes, while a higher NMS threshold (e.g., 0.6) will allow more overlap'**
  String get detection_screen_nms_desc;

  /// No description provided for @detection_screen_match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get detection_screen_match;

  /// No description provided for @detection_screen_match_desc.
  ///
  /// In en, this message translates to:
  /// **'Match over #0 is considered to be the same object.'**
  String get detection_screen_match_desc;

  /// No description provided for @detection_screen_lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get detection_screen_lost;

  /// No description provided for @detection_screen_lost_desc.
  ///
  /// In en, this message translates to:
  /// **'Track object will be removed if it is lost for #0 seconds'**
  String get detection_screen_lost_desc;

  /// No description provided for @detection_screen_0.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get detection_screen_0;

  /// No description provided for @detection_screen_1.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get detection_screen_1;

  /// No description provided for @detection_screen_30.
  ///
  /// In en, this message translates to:
  /// **'30 seconds'**
  String get detection_screen_30;

  /// No description provided for @detection_screen_consider_valid.
  ///
  /// In en, this message translates to:
  /// **'Consider valid after'**
  String get detection_screen_consider_valid;

  /// No description provided for @detection_screen_consider_valid_desc.
  ///
  /// In en, this message translates to:
  /// **'Track object will be consider valid after #0 seconds'**
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
  /// **'Add Video'**
  String get add_video_screen_title;

  /// No description provided for @add_video_screen_from.
  ///
  /// In en, this message translates to:
  /// **'Add video from'**
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
  /// **'Back Camera'**
  String get camera_screen_front_camera;

  /// No description provided for @camera_screen_back_camera.
  ///
  /// In en, this message translates to:
  /// **'Front Camera'**
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

  /// No description provided for @source_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage video sources, add or modify detection zones.'**
  String get source_screen_desc;

  /// No description provided for @source_screen_video_name.
  ///
  /// In en, this message translates to:
  /// **'Video Name'**
  String get source_screen_video_name;

  /// No description provided for @source_screen_edit_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Front Door Cam or Parking Lot Cam'**
  String get source_screen_edit_placeholder;

  /// No description provided for @source_screen_url.
  ///
  /// In en, this message translates to:
  /// **'Current URL'**
  String get source_screen_url;

  /// No description provided for @source_screen_change_file.
  ///
  /// In en, this message translates to:
  /// **'Change File'**
  String get source_screen_change_file;

  /// No description provided for @source_screen_file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get source_screen_file;

  /// No description provided for @source_screen_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get source_screen_camera;

  /// No description provided for @source_screen_webcam.
  ///
  /// In en, this message translates to:
  /// **'Webcam'**
  String get source_screen_webcam;

  /// No description provided for @source_screen_zones.
  ///
  /// In en, this message translates to:
  /// **'Zones'**
  String get source_screen_zones;

  /// No description provided for @source_screen_zones_desc.
  ///
  /// In en, this message translates to:
  /// **'Use drag and drop to adjust zones'**
  String get source_screen_zones_desc;

  /// No description provided for @source_screen_tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get source_screen_tools;

  /// No description provided for @source_screen_move_bottom.
  ///
  /// In en, this message translates to:
  /// **'Move current zone to bottom'**
  String get source_screen_move_bottom;

  /// No description provided for @source_screen_add_point.
  ///
  /// In en, this message translates to:
  /// **'Add point to current zone'**
  String get source_screen_add_point;

  /// No description provided for @source_screen_remove_point.
  ///
  /// In en, this message translates to:
  /// **'Remove point from current zone'**
  String get source_screen_remove_point;

  /// No description provided for @source_screen_playback_speed.
  ///
  /// In en, this message translates to:
  /// **'Playback Speed'**
  String get source_screen_playback_speed;

  /// No description provided for @source_screen_playback_current.
  ///
  /// In en, this message translates to:
  /// **'current: '**
  String get source_screen_playback_current;

  /// No description provided for @source_screen_playback_14x.
  ///
  /// In en, this message translates to:
  /// **'1/4x'**
  String get source_screen_playback_14x;

  /// No description provided for @source_screen_playback_2x.
  ///
  /// In en, this message translates to:
  /// **'2x'**
  String get source_screen_playback_2x;

  /// No description provided for @source_screen_delete_header.
  ///
  /// In en, this message translates to:
  /// **'Delete this video'**
  String get source_screen_delete_header;

  /// No description provided for @source_screen_delete_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this video?'**
  String get source_screen_delete_content;

  /// No description provided for @source_screen_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get source_screen_delete_button;

  /// No description provided for @color_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get color_screen_title;

  /// No description provided for @zone_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'The zone can set the types of objects to detect and choose which counters to display, such as Detected, Spawned, and Entered.'**
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

  /// No description provided for @zone_screen_objects_header.
  ///
  /// In en, this message translates to:
  /// **'Detects objects such as people, vehicles, dogs.'**
  String get zone_screen_objects_header;

  /// No description provided for @zone_screen_objects.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get zone_screen_objects;

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
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(lookupAppLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}

AppLocalization lookupAppLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationEn();
    case 'zh': return AppLocalizationZh();
  }

  throw FlutterError(
    'AppLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
