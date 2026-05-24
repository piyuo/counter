import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localization_ar.dart' deferred as localization_ar;
import 'localization_bn.dart' deferred as localization_bn;
import 'localization_de.dart' deferred as localization_de;
import 'localization_el.dart' deferred as localization_el;
import 'localization_en.dart' deferred as localization_en;
import 'localization_es.dart' deferred as localization_es;
import 'localization_fa.dart' deferred as localization_fa;
import 'localization_fr.dart' deferred as localization_fr;
import 'localization_he.dart' deferred as localization_he;
import 'localization_hi.dart' deferred as localization_hi;
import 'localization_hu.dart' deferred as localization_hu;
import 'localization_id.dart' deferred as localization_id;
import 'localization_it.dart' deferred as localization_it;
import 'localization_ja.dart' deferred as localization_ja;
import 'localization_ko.dart' deferred as localization_ko;
import 'localization_ms.dart' deferred as localization_ms;
import 'localization_my.dart' deferred as localization_my;
import 'localization_nl.dart' deferred as localization_nl;
import 'localization_pl.dart' deferred as localization_pl;
import 'localization_pt.dart' deferred as localization_pt;
import 'localization_ro.dart' deferred as localization_ro;
import 'localization_ru.dart' deferred as localization_ru;
import 'localization_sr.dart' deferred as localization_sr;
import 'localization_th.dart' deferred as localization_th;
import 'localization_tr.dart' deferred as localization_tr;
import 'localization_uk.dart' deferred as localization_uk;
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
/// import 'generated/localization.dart';
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
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('my'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sr'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'CN'),
  ];

  /// No description provided for @about_screen_app_version.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get about_screen_app_version;

  /// No description provided for @about_screen_benchmark.
  ///
  /// In en, this message translates to:
  /// **'Benchmark'**
  String get about_screen_benchmark;

  /// No description provided for @about_screen_build_info_title.
  ///
  /// In en, this message translates to:
  /// **'Build Information'**
  String get about_screen_build_info_title;

  /// No description provided for @about_screen_email_us.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get about_screen_email_us;

  /// No description provided for @about_screen_force_window_end_title.
  ///
  /// In en, this message translates to:
  /// **'Force Window End'**
  String get about_screen_force_window_end_title;

  /// No description provided for @about_screen_models.
  ///
  /// In en, this message translates to:
  /// **'Object detection models'**
  String get about_screen_models;

  /// No description provided for @about_screen_opencv_build_info.
  ///
  /// In en, this message translates to:
  /// **'OpenCV Build Info'**
  String get about_screen_opencv_build_info;

  /// No description provided for @about_screen_platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get about_screen_platform;

  /// No description provided for @about_screen_reset_app_state_success.
  ///
  /// In en, this message translates to:
  /// **'App state has been reset.'**
  String get about_screen_reset_app_state_success;

  /// No description provided for @about_screen_reset_app_state_title.
  ///
  /// In en, this message translates to:
  /// **'Reset App State'**
  String get about_screen_reset_app_state_title;

  /// No description provided for @about_screen_title.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about_screen_title;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @count_avg_dwell.
  ///
  /// In en, this message translates to:
  /// **'Avg Dwell'**
  String get count_avg_dwell;

  /// No description provided for @count_avg_occ.
  ///
  /// In en, this message translates to:
  /// **'Avg Occ'**
  String get count_avg_occ;

  /// No description provided for @count_max_dwell.
  ///
  /// In en, this message translates to:
  /// **'Peak Dwell'**
  String get count_max_dwell;

  /// No description provided for @count_max_occ.
  ///
  /// In en, this message translates to:
  /// **'Peak Occ'**
  String get count_max_occ;

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

  /// No description provided for @detection_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Detection Settings'**
  String get detection_screen_title;

  /// No description provided for @detection_type_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Choose which detection model to use for this project.'**
  String get detection_type_screen_body;

  /// No description provided for @detection_type_screen_load_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to load detection types.'**
  String get detection_type_screen_load_error;

  /// No description provided for @detection_type_screen_pedestrian_body.
  ///
  /// In en, this message translates to:
  /// **'Count people using the pedestrian detection model.'**
  String get detection_type_screen_pedestrian_body;

  /// No description provided for @detection_type_screen_pedestrian_title.
  ///
  /// In en, this message translates to:
  /// **'Pedestrian'**
  String get detection_type_screen_pedestrian_title;

  /// No description provided for @detection_type_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Detection Type'**
  String get detection_type_screen_title;

  /// No description provided for @detection_type_screen_vehicle_body.
  ///
  /// In en, this message translates to:
  /// **'Count cars and other vehicles using the vehicle model.'**
  String get detection_type_screen_vehicle_body;

  /// No description provided for @detection_type_screen_vehicle_title.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get detection_type_screen_vehicle_title;

  /// No description provided for @language_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language for the app interface.'**
  String get language_screen_body;

  /// No description provided for @language_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_screen_language;

  /// No description provided for @language_screen_system_label.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get language_screen_system_label;

  /// No description provided for @live_url_screen_examples_label.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get live_url_screen_examples_label;

  /// No description provided for @live_url_screen_invalid_rtsp_error.
  ///
  /// In en, this message translates to:
  /// **'RTSP URLs must include a host name.'**
  String get live_url_screen_invalid_rtsp_error;

  /// No description provided for @live_url_screen_invalid_url_error.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL with a supported scheme.'**
  String get live_url_screen_invalid_url_error;

  /// No description provided for @live_url_screen_unsupported_scheme_error.
  ///
  /// In en, this message translates to:
  /// **'Only HTTP'**
  String get live_url_screen_unsupported_scheme_error;

  /// No description provided for @live_url_screen_url_empty_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a live stream URL.'**
  String get live_url_screen_url_empty_error;

  /// No description provided for @main_screen_booting.
  ///
  /// In en, this message translates to:
  /// **'Starting up...'**
  String get main_screen_booting;

  /// No description provided for @main_screen_checking_hardware.
  ///
  /// In en, this message translates to:
  /// **'Checking hardware...'**
  String get main_screen_checking_hardware;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @no_camera_screen_body.
  ///
  /// In en, this message translates to:
  /// **'There is no camera detected on this device. Please connect a camera to use the app.\\nOr you can use Live URL or a file to test the app.'**
  String get no_camera_screen_body;

  /// No description provided for @no_camera_screen_title.
  ///
  /// In en, this message translates to:
  /// **'No Camera Detected'**
  String get no_camera_screen_title;

  /// No description provided for @product_copyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2025'**
  String get product_copyright;

  /// No description provided for @product_desc.
  ///
  /// In en, this message translates to:
  /// **'Using computer vision and ai to count people, vehicles, pets, and more.'**
  String get product_desc;

  /// No description provided for @product_name.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get product_name;

  /// No description provided for @settings_piyuo_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Use a Piyuo Cloud URL for uploads.'**
  String get settings_piyuo_screen_body;

  /// No description provided for @settings_piyuo_screen_cloud_url_label.
  ///
  /// In en, this message translates to:
  /// **'Cloud URL'**
  String get settings_piyuo_screen_cloud_url_label;

  /// No description provided for @settings_piyuo_screen_copy_action.
  ///
  /// In en, this message translates to:
  /// **'Copy URL'**
  String get settings_piyuo_screen_copy_action;

  /// No description provided for @settings_piyuo_screen_copy_success.
  ///
  /// In en, this message translates to:
  /// **'URL copied'**
  String get settings_piyuo_screen_copy_success;

  /// No description provided for @settings_piyuo_screen_invalid_url_error.
  ///
  /// In en, this message translates to:
  /// **'Please paste a valid Piyuo Cloud URL.'**
  String get settings_piyuo_screen_invalid_url_error;

  /// No description provided for @settings_piyuo_screen_legacy_body.
  ///
  /// In en, this message translates to:
  /// **'If you already had a Piyuo Cloud URL from an older install'**
  String get settings_piyuo_screen_legacy_body;

  /// No description provided for @settings_piyuo_screen_saving_action.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get settings_piyuo_screen_saving_action;

  /// No description provided for @settings_piyuo_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Cloud'**
  String get settings_piyuo_screen_title;

  /// No description provided for @settings_piyuo_screen_use_action.
  ///
  /// In en, this message translates to:
  /// **'Use Piyuo Cloud'**
  String get settings_piyuo_screen_use_action;

  /// No description provided for @settings_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Set project name, detection parameters, count clearing.'**
  String get settings_screen_body;

  /// No description provided for @settings_screen_custom_server_body.
  ///
  /// In en, this message translates to:
  /// **'We will help set up a local server.'**
  String get settings_screen_custom_server_body;

  /// No description provided for @settings_screen_custom_server_title.
  ///
  /// In en, this message translates to:
  /// **'Use your own server'**
  String get settings_screen_custom_server_title;

  /// No description provided for @settings_screen_data_server_label.
  ///
  /// In en, this message translates to:
  /// **'Data Server'**
  String get settings_screen_data_server_label;

  /// No description provided for @settings_screen_delivery_label.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get settings_screen_delivery_label;

  /// No description provided for @settings_screen_demo_mode_body.
  ///
  /// In en, this message translates to:
  /// **'Test only. Data is not exported.'**
  String get settings_screen_demo_mode_body;

  /// No description provided for @settings_screen_demo_mode_title.
  ///
  /// In en, this message translates to:
  /// **'Demo mode'**
  String get settings_screen_demo_mode_title;

  /// No description provided for @settings_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Set Project name, detection parameters, count clearing.'**
  String get settings_screen_desc;

  /// No description provided for @settings_screen_detection_label.
  ///
  /// In en, this message translates to:
  /// **'Detection'**
  String get settings_screen_detection_label;

  /// No description provided for @settings_screen_parameters_label.
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get settings_screen_parameters_label;

  /// No description provided for @settings_screen_piyuo_cloud_body.
  ///
  /// In en, this message translates to:
  /// **'Send results to our cloud service.'**
  String get settings_screen_piyuo_cloud_body;

  /// No description provided for @settings_screen_piyuo_cloud_title.
  ///
  /// In en, this message translates to:
  /// **'Use Piyuo Cloud'**
  String get settings_screen_piyuo_cloud_title;

  /// No description provided for @settings_screen_reset_all_data_body.
  ///
  /// In en, this message translates to:
  /// **'This will erase all data and start from the beginning. This action cannot be undone.'**
  String get settings_screen_reset_all_data_body;

  /// No description provided for @settings_screen_reset_all_data_title.
  ///
  /// In en, this message translates to:
  /// **'Reset all data?'**
  String get settings_screen_reset_all_data_title;

  /// No description provided for @settings_screen_subscription_body.
  ///
  /// In en, this message translates to:
  /// **'Manage your subscription and billing details.'**
  String get settings_screen_subscription_body;

  /// No description provided for @settings_screen_subscription_title.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settings_screen_subscription_title;

  /// No description provided for @settings_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_screen_title;

  /// No description provided for @settings_server_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Set the server URL used for uploads.'**
  String get settings_server_screen_body;

  /// No description provided for @settings_server_screen_delivery_cadence_label.
  ///
  /// In en, this message translates to:
  /// **'Deliver Payload On Wall Clock'**
  String get settings_server_screen_delivery_cadence_label;

  /// No description provided for @settings_server_screen_hour_unit_plural.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get settings_server_screen_hour_unit_plural;

  /// No description provided for @settings_server_screen_hour_unit_singular.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get settings_server_screen_hour_unit_singular;

  /// No description provided for @settings_server_screen_minute_unit_plural.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get settings_server_screen_minute_unit_plural;

  /// No description provided for @settings_server_screen_saving_action.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get settings_server_screen_saving_action;

  /// No description provided for @settings_server_screen_server_url_label.
  ///
  /// In en, this message translates to:
  /// **'Server URL'**
  String get settings_server_screen_server_url_label;

  /// No description provided for @settings_server_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Custom Server'**
  String get settings_server_screen_title;

  /// No description provided for @settings_server_screen_use_action.
  ///
  /// In en, this message translates to:
  /// **'Use Custom Server'**
  String get settings_server_screen_use_action;

  /// No description provided for @start_screen_demo_mode_body.
  ///
  /// In en, this message translates to:
  /// **'Demo mode. No data leaves your device.'**
  String get start_screen_demo_mode_body;

  /// No description provided for @start_screen_invitation_label.
  ///
  /// In en, this message translates to:
  /// **'Invitation'**
  String get start_screen_invitation_label;

  /// No description provided for @start_screen_not_set_label.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get start_screen_not_set_label;

  /// No description provided for @start_screen_own_server_label.
  ///
  /// In en, this message translates to:
  /// **'Own Server'**
  String get start_screen_own_server_label;

  /// No description provided for @start_screen_piyuo_cloud_label.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Cloud'**
  String get start_screen_piyuo_cloud_label;

  /// No description provided for @start_screen_product_body.
  ///
  /// In en, this message translates to:
  /// **'Pedestrian and vehicle counter with data collection.'**
  String get start_screen_product_body;

  /// No description provided for @start_screen_product_title.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Counter'**
  String get start_screen_product_title;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @upload_config_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Configure delivery settings for telemetry uploads.'**
  String get upload_config_screen_body;

  /// No description provided for @upload_config_screen_fast_fail_label.
  ///
  /// In en, this message translates to:
  /// **'Fast fail'**
  String get upload_config_screen_fast_fail_label;

  /// No description provided for @upload_config_screen_frequent_label.
  ///
  /// In en, this message translates to:
  /// **'Frequent'**
  String get upload_config_screen_frequent_label;

  /// No description provided for @upload_config_screen_large_label.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get upload_config_screen_large_label;

  /// No description provided for @upload_config_screen_load_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to load delivery settings.'**
  String get upload_config_screen_load_error;

  /// No description provided for @upload_config_screen_max_batch_size_body.
  ///
  /// In en, this message translates to:
  /// **'Max number of payload records sent in one HTTP request.'**
  String get upload_config_screen_max_batch_size_body;

  /// No description provided for @upload_config_screen_max_batch_size_title.
  ///
  /// In en, this message translates to:
  /// **'Maximum Batch Size'**
  String get upload_config_screen_max_batch_size_title;

  /// No description provided for @upload_config_screen_request_timeout_body.
  ///
  /// In en, this message translates to:
  /// **'HTTP timeout per upload request.'**
  String get upload_config_screen_request_timeout_body;

  /// No description provided for @upload_config_screen_request_timeout_title.
  ///
  /// In en, this message translates to:
  /// **'Request Timeout'**
  String get upload_config_screen_request_timeout_title;

  /// No description provided for @upload_config_screen_reset_body.
  ///
  /// In en, this message translates to:
  /// **'This restores upload cadence, batching, and timeout to defaults.'**
  String get upload_config_screen_reset_body;

  /// No description provided for @upload_config_screen_reset_title.
  ///
  /// In en, this message translates to:
  /// **'Reset delivery settings?'**
  String get upload_config_screen_reset_title;

  /// No description provided for @upload_config_screen_small_label.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get upload_config_screen_small_label;

  /// No description provided for @upload_config_screen_sparse_label.
  ///
  /// In en, this message translates to:
  /// **'Sparse'**
  String get upload_config_screen_sparse_label;

  /// No description provided for @upload_config_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Delivery Settings'**
  String get upload_config_screen_title;

  /// No description provided for @upload_config_screen_wait_longer_label.
  ///
  /// In en, this message translates to:
  /// **'Wait longer'**
  String get upload_config_screen_wait_longer_label;

  /// No description provided for @upload_config_screen_wall_clock_cadence_body.
  ///
  /// In en, this message translates to:
  /// **'How often pending telemetry is uploaded on minute-aligned boundaries.'**
  String get upload_config_screen_wall_clock_cadence_body;

  /// No description provided for @upload_config_screen_wall_clock_cadence_title.
  ///
  /// In en, this message translates to:
  /// **'Wall-Clock Upload Cadence'**
  String get upload_config_screen_wall_clock_cadence_title;

  /// No description provided for @upload_logs_screen_check_data_server_error_prefix.
  ///
  /// In en, this message translates to:
  /// **'Unable to check Data Server: '**
  String get upload_logs_screen_check_data_server_error_prefix;

  /// No description provided for @upload_logs_screen_detail_unavailable_body.
  ///
  /// In en, this message translates to:
  /// **'Upload log detail is no longer available.'**
  String get upload_logs_screen_detail_unavailable_body;

  /// No description provided for @upload_logs_screen_empty_body.
  ///
  /// In en, this message translates to:
  /// **'No upload logs yet.'**
  String get upload_logs_screen_empty_body;

  /// No description provided for @upload_logs_screen_load_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to load upload logs.'**
  String get upload_logs_screen_load_error;

  /// No description provided for @upload_logs_screen_next_upload_pending.
  ///
  /// In en, this message translates to:
  /// **'Next upload at ...'**
  String get upload_logs_screen_next_upload_pending;

  /// No description provided for @upload_logs_screen_next_upload_prefix.
  ///
  /// In en, this message translates to:
  /// **'Next upload at '**
  String get upload_logs_screen_next_upload_prefix;

  /// No description provided for @upload_logs_screen_payloads_unit.
  ///
  /// In en, this message translates to:
  /// **'payloads'**
  String get upload_logs_screen_payloads_unit;

  /// No description provided for @upload_logs_screen_retry_action.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get upload_logs_screen_retry_action;

  /// No description provided for @upload_logs_screen_set_data_server_first_body.
  ///
  /// In en, this message translates to:
  /// **'Please set the Data Server first.'**
  String get upload_logs_screen_set_data_server_first_body;

  /// No description provided for @upload_logs_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Upload Logs'**
  String get upload_logs_screen_title;

  /// No description provided for @upload_logs_screen_today_label.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get upload_logs_screen_today_label;

  /// No description provided for @upload_logs_screen_upload_failed_prefix.
  ///
  /// In en, this message translates to:
  /// **'Upload failed: '**
  String get upload_logs_screen_upload_failed_prefix;

  /// No description provided for @upload_logs_screen_upload_failed_unknown.
  ///
  /// In en, this message translates to:
  /// **'Upload failed due to an unknown error.'**
  String get upload_logs_screen_upload_failed_unknown;

  /// No description provided for @upload_logs_screen_upload_now_action.
  ///
  /// In en, this message translates to:
  /// **'Upload Now'**
  String get upload_logs_screen_upload_now_action;

  /// No description provided for @upload_logs_screen_uploaded_success.
  ///
  /// In en, this message translates to:
  /// **'Uploaded payloads to remote server.'**
  String get upload_logs_screen_uploaded_success;

  /// No description provided for @upload_logs_screen_uploading_action.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get upload_logs_screen_uploading_action;

  /// No description provided for @upload_logs_screen_yesterday_label.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get upload_logs_screen_yesterday_label;

  /// No description provided for @url_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Enter the live stream URL for your camera source.'**
  String get url_screen_body;

  /// No description provided for @url_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the live stream URL'**
  String get url_screen_desc;

  /// No description provided for @url_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get url_screen_title;

  /// No description provided for @url_screen_url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url_screen_url;

  /// No description provided for @url_screen_url_hint.
  ///
  /// In en, this message translates to:
  /// **'http://example.com/stream or rtsp://example.com/stream'**
  String get url_screen_url_hint;

  /// No description provided for @url_screen_url_placeholder.
  ///
  /// In en, this message translates to:
  /// **'http://example.com/stream or rtsp://example.com/stream'**
  String get url_screen_url_placeholder;

  /// No description provided for @video_screen_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage video sources, add or modify detection zones.'**
  String get video_screen_desc;

  /// No description provided for @video_sources_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get video_sources_camera;

  /// No description provided for @video_sources_camera_not_found_message.
  ///
  /// In en, this message translates to:
  /// **'Need grant camera permission to use camera'**
  String get video_sources_camera_not_found_message;

  /// No description provided for @video_sources_camera_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'Camera not found'**
  String get video_sources_camera_not_found_title;

  /// No description provided for @video_sources_file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get video_sources_file;

  /// No description provided for @video_sources_file_hint.
  ///
  /// In en, this message translates to:
  /// **'Pick a video from your device'**
  String get video_sources_file_hint;

  /// No description provided for @video_sources_import_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to import video file.'**
  String get video_sources_import_error;

  /// No description provided for @video_sources_live_stream.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get video_sources_live_stream;

  /// No description provided for @video_sources_load_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video sources.'**
  String get video_sources_load_error;

  /// No description provided for @video_sources_photos_denied_msg.
  ///
  /// In en, this message translates to:
  /// **'Please go to settings and allow photos access permission for this app.'**
  String get video_sources_photos_denied_msg;

  /// No description provided for @video_sources_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Manage video sources'**
  String get video_sources_screen_body;

  /// No description provided for @video_sources_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Video Sources'**
  String get video_sources_screen_title;

  /// No description provided for @video_sources_webcam.
  ///
  /// In en, this message translates to:
  /// **'Webcam'**
  String get video_sources_webcam;

  /// No description provided for @wizard_screen_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get wizard_screen_about;

  /// No description provided for @wizard_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get wizard_screen_language;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();

  @override
  Future<Localization> load(Locale locale) {
    return lookupLocalization(locale);
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'el',
    'en',
    'es',
    'fa',
    'fr',
    'he',
    'hi',
    'hu',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'my',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sr',
    'th',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}

Future<Localization> lookupLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return localization_zh.loadLibrary().then(
              (dynamic _) => localization_zh.LocalizationZhCn(),
            );
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return localization_ar.loadLibrary().then(
        (dynamic _) => localization_ar.LocalizationAr(),
      );
    case 'bn':
      return localization_bn.loadLibrary().then(
        (dynamic _) => localization_bn.LocalizationBn(),
      );
    case 'de':
      return localization_de.loadLibrary().then(
        (dynamic _) => localization_de.LocalizationDe(),
      );
    case 'el':
      return localization_el.loadLibrary().then(
        (dynamic _) => localization_el.LocalizationEl(),
      );
    case 'en':
      return localization_en.loadLibrary().then(
        (dynamic _) => localization_en.LocalizationEn(),
      );
    case 'es':
      return localization_es.loadLibrary().then(
        (dynamic _) => localization_es.LocalizationEs(),
      );
    case 'fa':
      return localization_fa.loadLibrary().then(
        (dynamic _) => localization_fa.LocalizationFa(),
      );
    case 'fr':
      return localization_fr.loadLibrary().then(
        (dynamic _) => localization_fr.LocalizationFr(),
      );
    case 'he':
      return localization_he.loadLibrary().then(
        (dynamic _) => localization_he.LocalizationHe(),
      );
    case 'hi':
      return localization_hi.loadLibrary().then(
        (dynamic _) => localization_hi.LocalizationHi(),
      );
    case 'hu':
      return localization_hu.loadLibrary().then(
        (dynamic _) => localization_hu.LocalizationHu(),
      );
    case 'id':
      return localization_id.loadLibrary().then(
        (dynamic _) => localization_id.LocalizationId(),
      );
    case 'it':
      return localization_it.loadLibrary().then(
        (dynamic _) => localization_it.LocalizationIt(),
      );
    case 'ja':
      return localization_ja.loadLibrary().then(
        (dynamic _) => localization_ja.LocalizationJa(),
      );
    case 'ko':
      return localization_ko.loadLibrary().then(
        (dynamic _) => localization_ko.LocalizationKo(),
      );
    case 'ms':
      return localization_ms.loadLibrary().then(
        (dynamic _) => localization_ms.LocalizationMs(),
      );
    case 'my':
      return localization_my.loadLibrary().then(
        (dynamic _) => localization_my.LocalizationMy(),
      );
    case 'nl':
      return localization_nl.loadLibrary().then(
        (dynamic _) => localization_nl.LocalizationNl(),
      );
    case 'pl':
      return localization_pl.loadLibrary().then(
        (dynamic _) => localization_pl.LocalizationPl(),
      );
    case 'pt':
      return localization_pt.loadLibrary().then(
        (dynamic _) => localization_pt.LocalizationPt(),
      );
    case 'ro':
      return localization_ro.loadLibrary().then(
        (dynamic _) => localization_ro.LocalizationRo(),
      );
    case 'ru':
      return localization_ru.loadLibrary().then(
        (dynamic _) => localization_ru.LocalizationRu(),
      );
    case 'sr':
      return localization_sr.loadLibrary().then(
        (dynamic _) => localization_sr.LocalizationSr(),
      );
    case 'th':
      return localization_th.loadLibrary().then(
        (dynamic _) => localization_th.LocalizationTh(),
      );
    case 'tr':
      return localization_tr.loadLibrary().then(
        (dynamic _) => localization_tr.LocalizationTr(),
      );
    case 'uk':
      return localization_uk.loadLibrary().then(
        (dynamic _) => localization_uk.LocalizationUk(),
      );
    case 'vi':
      return localization_vi.loadLibrary().then(
        (dynamic _) => localization_vi.LocalizationVi(),
      );
    case 'zh':
      return localization_zh.loadLibrary().then(
        (dynamic _) => localization_zh.LocalizationZh(),
      );
  }

  throw FlutterError(
    'Localization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
