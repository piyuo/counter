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

  /// No description provided for @about_screen_email_us.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get about_screen_email_us;

  /// No description provided for @about_screen_platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get about_screen_platform;

  /// No description provided for @appeared.
  ///
  /// In en, this message translates to:
  /// **'Appeared'**
  String get appeared;

  /// No description provided for @appeared_help.
  ///
  /// In en, this message translates to:
  /// **'Counts people or vehicles whose first detected position was inside this area.\\n\\nUseful for understanding where tracking begins.\\n\\n(Primarily intended for advanced users.)'**
  String get appeared_help;

  /// No description provided for @average_occupancy.
  ///
  /// In en, this message translates to:
  /// **'Average Occupancy'**
  String get average_occupancy;

  /// No description provided for @average_occupancy_help.
  ///
  /// In en, this message translates to:
  /// **'Shows the average number of people or vehicles in this area during the current counting window.\\n\\nThis helps measure how busy the area was over the entire counting window.'**
  String get average_occupancy_help;

  /// No description provided for @average_stay.
  ///
  /// In en, this message translates to:
  /// **'Average Stay'**
  String get average_stay;

  /// No description provided for @average_stay_help.
  ///
  /// In en, this message translates to:
  /// **'Shows the average time people or vehicles stayed in this area.\\n\\nA longer average stay may indicate customers are spending more time in this area.'**
  String get average_stay_help;

  /// No description provided for @camera_test_screen_help.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Counter uses your camera and on-device AI to count people. First, let\'s make sure your device is compatible.'**
  String get camera_test_screen_help;

  /// No description provided for @camera_test_screen_instruction.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at people. The app will draw boxes around anyone it detects.'**
  String get camera_test_screen_instruction;

  /// No description provided for @camera_test_screen_next.
  ///
  /// In en, this message translates to:
  /// **'Tap Next to continue.'**
  String get camera_test_screen_next;

  /// No description provided for @camera_test_screen_start.
  ///
  /// In en, this message translates to:
  /// **'Tap Start. If asked, allow camera access.'**
  String get camera_test_screen_start;

  /// No description provided for @camera_test_screen_test_failed.
  ///
  /// In en, this message translates to:
  /// **'Test failed!'**
  String get camera_test_screen_test_failed;

  /// No description provided for @camera_test_screen_test_passed.
  ///
  /// In en, this message translates to:
  /// **'Test passed!'**
  String get camera_test_screen_test_passed;

  /// No description provided for @camera_test_screen_title.
  ///
  /// In en, this message translates to:
  /// **'AI Camera Test'**
  String get camera_test_screen_title;

  /// No description provided for @camera_test_screen_wait.
  ///
  /// In en, this message translates to:
  /// **'Waiting for AI to detect people…'**
  String get camera_test_screen_wait;

  /// No description provided for @cta_screen_custom.
  ///
  /// In en, this message translates to:
  /// **'Use Your Own Server'**
  String get cta_screen_custom;

  /// No description provided for @cta_screen_custom_help.
  ///
  /// In en, this message translates to:
  /// **'Send traffic data directly to your own backend or database.'**
  String get cta_screen_custom_help;

  /// No description provided for @cta_screen_footer.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the Terms of Service and Privacy Policy and Data Processing Agreement.'**
  String get cta_screen_footer;

  /// No description provided for @cta_screen_invitation.
  ///
  /// In en, this message translates to:
  /// **'Use an Invitation Code'**
  String get cta_screen_invitation;

  /// No description provided for @cta_screen_invitation_help.
  ///
  /// In en, this message translates to:
  /// **'Join an existing organization using an invitation from your administrator.'**
  String get cta_screen_invitation_help;

  /// No description provided for @cta_screen_local.
  ///
  /// In en, this message translates to:
  /// **'Local Device Only'**
  String get cta_screen_local;

  /// No description provided for @cta_screen_local_help.
  ///
  /// In en, this message translates to:
  /// **'Store traffic data only on this device. Nothing is uploaded.'**
  String get cta_screen_local_help;

  /// No description provided for @cta_screen_piyuo.
  ///
  /// In en, this message translates to:
  /// **'Use Piyuo Cloud'**
  String get cta_screen_piyuo;

  /// No description provided for @cta_screen_piyuo_help.
  ///
  /// In en, this message translates to:
  /// **'Store traffic data in Piyuo Cloud with dashboards and business insights.'**
  String get cta_screen_piyuo_help;

  /// No description provided for @cta_screen_premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get cta_screen_premium;

  /// No description provided for @cta_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Counter creates anonymous traffic statistics every 5 minutes.\\nChoose how you want to store and access your data.'**
  String get cta_screen_title;

  /// No description provided for @current_occupancy.
  ///
  /// In en, this message translates to:
  /// **'Current Count'**
  String get current_occupancy;

  /// No description provided for @current_occupancy_help.
  ///
  /// In en, this message translates to:
  /// **'Shows the current count of people or vehicles in this area.\\n\\nThis count updates in real time and is useful for checking that AI detection matches what you see on screen. It is not included in uploaded telemetry.'**
  String get current_occupancy_help;

  /// No description provided for @custom_server_screen_bearer_saving_action.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get custom_server_screen_bearer_saving_action;

  /// No description provided for @custom_server_screen_server_url_label.
  ///
  /// In en, this message translates to:
  /// **'Server URL'**
  String get custom_server_screen_server_url_label;

  /// No description provided for @detection_screen_confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence Threshold'**
  String get detection_screen_confidence;

  /// No description provided for @detection_screen_confidence_dialog.
  ///
  /// In en, this message translates to:
  /// **'Controls how certain the AI must be before counting a person or vehicle.\\nLower values\\n• Detect more objects\\n• Better for distant or partially hidden objects\\n• May increase false detections\\nHigher values\\n• Count only high-confidence detections\\n• Reduce false detections\\n• May miss small or difficult objects\\nUse a lower value if the app is missing people or vehicles.\\nUse a higher value if the app is counting shadows, reflections, or other false objects.'**
  String get detection_screen_confidence_dialog;

  /// No description provided for @detection_screen_confidence_help.
  ///
  /// In en, this message translates to:
  /// **'Minimum confidence required to detect an object.'**
  String get detection_screen_confidence_help;

  /// No description provided for @detection_screen_confidence_max_label.
  ///
  /// In en, this message translates to:
  /// **'Strict'**
  String get detection_screen_confidence_max_label;

  /// No description provided for @detection_screen_confidence_min_label.
  ///
  /// In en, this message translates to:
  /// **'Loose'**
  String get detection_screen_confidence_min_label;

  /// No description provided for @detection_screen_disappear.
  ///
  /// In en, this message translates to:
  /// **'Disappear Timeout'**
  String get detection_screen_disappear;

  /// No description provided for @detection_screen_disappear_dialog.
  ///
  /// In en, this message translates to:
  /// **'Determines how long the AI waits before marking an object as disappeared after it is no longer detected.\\nShorter values\\n• Mark objects as disappeared sooner\\n• Better for fast-moving traffic\\n• May mark temporarily hidden objects as disappeared\\nLonger values\\n• Wait longer before marking objects as disappeared\\n• Better when objects are briefly blocked or missed\\n• Delay disappear events'**
  String get detection_screen_disappear_dialog;

  /// No description provided for @detection_screen_disappear_help.
  ///
  /// In en, this message translates to:
  /// **'How long the AI waits before marking an object as disappeared after it can no longer detect it.'**
  String get detection_screen_disappear_help;

  /// No description provided for @detection_screen_disappear_max_label.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get detection_screen_disappear_max_label;

  /// No description provided for @detection_screen_disappear_min_label.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get detection_screen_disappear_min_label;

  /// No description provided for @detection_screen_memory_dialog.
  ///
  /// In en, this message translates to:
  /// **'Controls how long the AI remembers an object after it disappears.\\nIncrease this value if people or vehicles are frequently hidden behind other objects.\\nDecrease this value if objects are incorrectly linked after leaving the scene.'**
  String get detection_screen_memory_dialog;

  /// No description provided for @detection_screen_min_presence.
  ///
  /// In en, this message translates to:
  /// **'Minimum Presence Time'**
  String get detection_screen_min_presence;

  /// No description provided for @detection_screen_min_presence_help.
  ///
  /// In en, this message translates to:
  /// **'An object must remain visible before it can be counted. Longer values help reduce brief false detections.'**
  String get detection_screen_min_presence_help;

  /// No description provided for @detection_screen_min_presence_max_label.
  ///
  /// In en, this message translates to:
  /// **'Safer'**
  String get detection_screen_min_presence_max_label;

  /// No description provided for @detection_screen_min_presence_min_label.
  ///
  /// In en, this message translates to:
  /// **'Faster'**
  String get detection_screen_min_presence_min_label;

  /// No description provided for @detection_screen_minimum_visible.
  ///
  /// In en, this message translates to:
  /// **'Objects must remain visible for this long before they are counted.\\nIncrease this value to ignore brief false detections.\\nDecrease this value if fast-moving people or vehicles are being missed.'**
  String get detection_screen_minimum_visible;

  /// No description provided for @detection_screen_new_track.
  ///
  /// In en, this message translates to:
  /// **'New Track Threshold'**
  String get detection_screen_new_track;

  /// No description provided for @detection_screen_new_track_help.
  ///
  /// In en, this message translates to:
  /// **'Minimum confidence required to start tracking a new object. Lower values may create duplicate tracks.'**
  String get detection_screen_new_track_help;

  /// No description provided for @detection_screen_new_track_max_label.
  ///
  /// In en, this message translates to:
  /// **'Conservative'**
  String get detection_screen_new_track_max_label;

  /// No description provided for @detection_screen_new_track_min_label.
  ///
  /// In en, this message translates to:
  /// **'Aggressive'**
  String get detection_screen_new_track_min_label;

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

  /// No description provided for @detection_screen_show_track_id.
  ///
  /// In en, this message translates to:
  /// **'Show Track ID'**
  String get detection_screen_show_track_id;

  /// No description provided for @detection_screen_show_track_id_help.
  ///
  /// In en, this message translates to:
  /// **'Enable this option to show unique track IDs for each tracked object.'**
  String get detection_screen_show_track_id_help;

  /// No description provided for @detection_screen_stay.
  ///
  /// In en, this message translates to:
  /// **'Stay Time'**
  String get detection_screen_stay;

  /// No description provided for @detection_screen_stay_help.
  ///
  /// In en, this message translates to:
  /// **'How long an object must remain in the area before it is counted as a stay.'**
  String get detection_screen_stay_help;

  /// No description provided for @detection_screen_stay_max_label.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get detection_screen_stay_max_label;

  /// No description provided for @detection_screen_stay_min_label.
  ///
  /// In en, this message translates to:
  /// **'Instant'**
  String get detection_screen_stay_min_label;

  /// No description provided for @detection_screen_stay_threshold.
  ///
  /// In en, this message translates to:
  /// **'Determines when an object contributes to the Stay count.\\nShorter values\\n• Count stays immediately\\n• Better for quick analysis\\nLonger values\\n• Ignore brief pass-through traffic\\n• Better for occupancy measurement'**
  String get detection_screen_stay_threshold;

  /// No description provided for @detection_screen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tune how the AI detects and tracks objects.'**
  String get detection_screen_subtitle;

  /// No description provided for @detection_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Tracking & Counting'**
  String get detection_screen_title;

  /// No description provided for @detection_screen_track_dialog.
  ///
  /// In en, this message translates to:
  /// **'Controls when a newly detected object becomes a new track.\\nLower values\\n• Start tracking sooner\\n• Better for fast-moving objects\\n• May create duplicate tracks\\nHigher values\\n• Require stronger evidence before creating a new track\\n• Reduce duplicate tracks\\n• May delay tracking new objects'**
  String get detection_screen_track_dialog;

  /// No description provided for @detection_screen_track_memory.
  ///
  /// In en, this message translates to:
  /// **'Tracking Memory'**
  String get detection_screen_track_memory;

  /// No description provided for @detection_screen_track_memory_help.
  ///
  /// In en, this message translates to:
  /// **'How long to keep tracking an object after it is temporarily lost. Longer values help recover from brief occlusions.'**
  String get detection_screen_track_memory_help;

  /// No description provided for @detection_screen_track_memory_max_label.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get detection_screen_track_memory_max_label;

  /// No description provided for @detection_screen_track_memory_min_label.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get detection_screen_track_memory_min_label;

  /// No description provided for @device_not_supported_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Counter uses your camera to detect pedestrians and vehicles in real time. This device doesn\\\'t have one available.'**
  String get device_not_supported_screen_body;

  /// No description provided for @device_not_supported_screen_footer_hint.
  ///
  /// In en, this message translates to:
  /// **'Try opening this app on your phone'**
  String get device_not_supported_screen_footer_hint;

  /// No description provided for @device_not_supported_screen_requirement_camera.
  ///
  /// In en, this message translates to:
  /// **'A smartphone or tablet with a camera'**
  String get device_not_supported_screen_requirement_camera;

  /// No description provided for @device_not_supported_screen_requirement_platform.
  ///
  /// In en, this message translates to:
  /// **'iOS or Android device recommended'**
  String get device_not_supported_screen_requirement_platform;

  /// No description provided for @device_not_supported_screen_requirements_title.
  ///
  /// In en, this message translates to:
  /// **'What you need'**
  String get device_not_supported_screen_requirements_title;

  /// No description provided for @device_not_supported_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Camera not found'**
  String get device_not_supported_screen_title;

  /// No description provided for @disappeared.
  ///
  /// In en, this message translates to:
  /// **'Disappeared'**
  String get disappeared;

  /// No description provided for @disappeared_help.
  ///
  /// In en, this message translates to:
  /// **'Counts people or vehicles whose last detected position was inside this area.\\n\\nTracking ends after the configured Disappear Time if the person or vehicle is no longer detected.\\n\\n(Primarily intended for advanced users.)'**
  String get disappeared_help;

  /// No description provided for @dpa.
  ///
  /// In en, this message translates to:
  /// **'Data Processing Agreement'**
  String get dpa;

  /// No description provided for @durationDaysShort.
  ///
  /// In en, this message translates to:
  /// **'%sd'**
  String get durationDaysShort;

  /// No description provided for @durationHoursShort.
  ///
  /// In en, this message translates to:
  /// **'%sh'**
  String get durationHoursShort;

  /// No description provided for @durationMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'%sm'**
  String get durationMinutesShort;

  /// No description provided for @durationSecondsShort.
  ///
  /// In en, this message translates to:
  /// **'%ss'**
  String get durationSecondsShort;

  /// No description provided for @durationTwoUnit.
  ///
  /// In en, this message translates to:
  /// **'%first %second'**
  String get durationTwoUnit;

  /// No description provided for @entered.
  ///
  /// In en, this message translates to:
  /// **'Entered'**
  String get entered;

  /// No description provided for @entered_help.
  ///
  /// In en, this message translates to:
  /// **'Counts people or vehicles that entered this area during the current counting window.\\n\\nAn entry is counted when a person or vehicle moves from outside the area to inside.'**
  String get entered_help;

  /// No description provided for @exited.
  ///
  /// In en, this message translates to:
  /// **'Exited'**
  String get exited;

  /// No description provided for @exited_help.
  ///
  /// In en, this message translates to:
  /// **'Counts people or vehicles that left this area during the current counting window.\\n\\nAn exit is counted when a person or vehicle moves from inside the area to outside.'**
  String get exited_help;

  /// No description provided for @language_screen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_screen_language;

  /// No description provided for @language_screen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language used in the app.'**
  String get language_screen_subtitle;

  /// No description provided for @local_only_screen_body.
  ///
  /// In en, this message translates to:
  /// **'Local Device Only mode lets you try AI camera detection and tracking without uploading any data. All foot traffic stats are processed only on this device, great for testing before you connect to a server.'**
  String get local_only_screen_body;

  /// No description provided for @local_only_screen_use_action.
  ///
  /// In en, this message translates to:
  /// **'Use Local Device Only'**
  String get local_only_screen_use_action;

  /// No description provided for @local_screen_text.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Counter will run entirely on this device.\\nTraffic statistics will be stored on this device only and won\'t be uploaded.\\nYou can connect to Piyuo Cloud or your own server later in Settings.'**
  String get local_screen_text;

  /// No description provided for @maximum_occupancy.
  ///
  /// In en, this message translates to:
  /// **'Maximum Occupancy'**
  String get maximum_occupancy;

  /// No description provided for @maximum_occupancy_help.
  ///
  /// In en, this message translates to:
  /// **'Shows the highest number of people or vehicles in this area at the same time during the current counting window.\\n\\nUseful for identifying peak crowd or traffic levels.'**
  String get maximum_occupancy_help;

  /// No description provided for @maximum_stay.
  ///
  /// In en, this message translates to:
  /// **'Maximum Stay'**
  String get maximum_stay;

  /// No description provided for @maximum_stay_help.
  ///
  /// In en, this message translates to:
  /// **'Shows the longest time a person or vehicle stayed in this area during the current counting window.\\n\\nUseful for identifying unusually long visits or stops.'**
  String get maximum_stay_help;

  /// No description provided for @metric_events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get metric_events;

  /// No description provided for @metric_live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get metric_live;

  /// No description provided for @metric_show_less.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get metric_show_less;

  /// No description provided for @metric_show_more.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get metric_show_more;

  /// No description provided for @metric_statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get metric_statistics;

  /// No description provided for @metrics_counting_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get metrics_counting_all;

  /// No description provided for @metrics_counting_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get metrics_counting_done;

  /// No description provided for @metrics_counting_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get metrics_counting_in_progress;

  /// No description provided for @metrics_counting_missing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get metrics_counting_missing;

  /// No description provided for @metrics_counting_window.
  ///
  /// In en, this message translates to:
  /// **'Statistics for Each 5-Minute Period'**
  String get metrics_counting_window;

  /// No description provided for @onboarding_back_action.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboarding_back_action;

  /// No description provided for @onboarding_cta_no_server.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to upload data?'**
  String get onboarding_cta_no_server;

  /// No description provided for @onboarding_cta_title.
  ///
  /// In en, this message translates to:
  /// **'Where should your data go?'**
  String get onboarding_cta_title;

  /// No description provided for @onboarding_intro_text1.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Counter uses your camera and on-device AI to spot people and vehicles in real time.\\nUsing detection and tracking technology, it automatically counts foot traffic and vehicle traffic — all processed right on your device.'**
  String get onboarding_intro_text1;

  /// No description provided for @onboarding_intro_text2.
  ///
  /// In en, this message translates to:
  /// **'All AI processing happens locally on your device. No video, images, faces, or identities are uploaded.\\nOnly anonymous 5-minute summaries are shared, including counts, occupancy, entries, exits, and dwell time statistics.'**
  String get onboarding_intro_text2;

  /// No description provided for @onboarding_intro_text3.
  ///
  /// In en, this message translates to:
  /// **'Just start the app and leave it running. Piyuo Counter continuously collects and stores traffic data automatically.\\nData summaries are saved every 5 minutes and uploaded hourly to Piyuo Cloud or your own server.'**
  String get onboarding_intro_text3;

  /// No description provided for @onboarding_intro_title1.
  ///
  /// In en, this message translates to:
  /// **'AI Traffic Counting'**
  String get onboarding_intro_title1;

  /// No description provided for @onboarding_intro_title2.
  ///
  /// In en, this message translates to:
  /// **'Privacy-First by Design'**
  String get onboarding_intro_title2;

  /// No description provided for @onboarding_intro_title3.
  ///
  /// In en, this message translates to:
  /// **'Runs Automatically 24/7'**
  String get onboarding_intro_title3;

  /// No description provided for @onboarding_next_action.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next_action;

  /// No description provided for @onboarding_skip_action.
  ///
  /// In en, this message translates to:
  /// **'Skip Intro'**
  String get onboarding_skip_action;

  /// No description provided for @onboarding_start_action.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboarding_start_action;

  /// No description provided for @passed_by.
  ///
  /// In en, this message translates to:
  /// **'Passed By'**
  String get passed_by;

  /// No description provided for @passed_by_help.
  ///
  /// In en, this message translates to:
  /// **'Counts people or vehicles that passed through this area during the current counting window.\\n\\nEach person or vehicle is counted only once for each pass through the area.'**
  String get passed_by_help;

  /// No description provided for @payloads_screen_area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get payloads_screen_area;

  /// No description provided for @payloads_screen_confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get payloads_screen_confidence;

  /// No description provided for @payloads_screen_coverage.
  ///
  /// In en, this message translates to:
  /// **'Coverage'**
  String get payloads_screen_coverage;

  /// No description provided for @payloads_screen_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get payloads_screen_delivered;

  /// No description provided for @payloads_screen_failed_load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load recent payloads'**
  String get payloads_screen_failed_load;

  /// No description provided for @payloads_screen_frame_processed.
  ///
  /// In en, this message translates to:
  /// **'Frames processed'**
  String get payloads_screen_frame_processed;

  /// No description provided for @payloads_screen_hour_not_exists.
  ///
  /// In en, this message translates to:
  /// **'This hour no longer exists.'**
  String get payloads_screen_hour_not_exists;

  /// No description provided for @payloads_screen_missing_time.
  ///
  /// In en, this message translates to:
  /// **'Missing Time'**
  String get payloads_screen_missing_time;

  /// No description provided for @payloads_screen_no_payloads.
  ///
  /// In en, this message translates to:
  /// **'No payloads yet.'**
  String get payloads_screen_no_payloads;

  /// No description provided for @payloads_screen_partial.
  ///
  /// In en, this message translates to:
  /// **'Window ended early (partial)'**
  String get payloads_screen_partial;

  /// No description provided for @payloads_screen_partially.
  ///
  /// In en, this message translates to:
  /// **'Partially delivered'**
  String get payloads_screen_partially;

  /// No description provided for @payloads_screen_payload_not_exists.
  ///
  /// In en, this message translates to:
  /// **'This payload no longer exists.'**
  String get payloads_screen_payload_not_exists;

  /// No description provided for @payloads_screen_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending delivery'**
  String get payloads_screen_pending;

  /// No description provided for @payloads_screen_process_fps.
  ///
  /// In en, this message translates to:
  /// **'Process FPS'**
  String get payloads_screen_process_fps;

  /// No description provided for @payloads_screen_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get payloads_screen_resend;

  /// No description provided for @payloads_screen_select_first.
  ///
  /// In en, this message translates to:
  /// **'Select at least one date or hour first.'**
  String get payloads_screen_select_first;

  /// No description provided for @payloads_screen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select by date or hour to resend'**
  String get payloads_screen_subtitle;

  /// No description provided for @payloads_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Recent Payloads'**
  String get payloads_screen_title;

  /// No description provided for @personal_custom_screen_build_server.
  ///
  /// In en, this message translates to:
  /// **'Need help setting up your own server?\\nSee our API documentation and server examples.'**
  String get personal_custom_screen_build_server;

  /// No description provided for @personal_custom_screen_help_action.
  ///
  /// In en, this message translates to:
  /// **'Open API Documentation'**
  String get personal_custom_screen_help_action;

  /// No description provided for @personal_custom_screen_reset_action.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get personal_custom_screen_reset_action;

  /// No description provided for @personal_custom_success_screen_help.
  ///
  /// In en, this message translates to:
  /// **'Tap Start below to begin counting.'**
  String get personal_custom_success_screen_help;

  /// No description provided for @personal_custom_success_screen_help1.
  ///
  /// In en, this message translates to:
  /// **'Traffic statistics are uploaded automatically every hour.\\nYou can also upload them manually from the Upload Logs screen.'**
  String get personal_custom_success_screen_help1;

  /// No description provided for @personal_custom_success_screen_help2.
  ///
  /// In en, this message translates to:
  /// **'Your server doesn\'t need to be online yet.\\nStart counting now. You can finish building and testing your server later. Traffic statistics stay on this device until they\'re uploaded successfully.'**
  String get personal_custom_success_screen_help2;

  /// No description provided for @personal_custom_success_screen_send_to.
  ///
  /// In en, this message translates to:
  /// **'Traffic statistics will be sent to'**
  String get personal_custom_success_screen_send_to;

  /// No description provided for @personal_custom_success_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Your Server Is Ready'**
  String get personal_custom_success_screen_title;

  /// No description provided for @piyuo_server_screen_cloud_url_label.
  ///
  /// In en, this message translates to:
  /// **'Your Piyuo Cloud URL'**
  String get piyuo_server_screen_cloud_url_label;

  /// No description provided for @piyuo_server_screen_copy_action.
  ///
  /// In en, this message translates to:
  /// **'Copy URL'**
  String get piyuo_server_screen_copy_action;

  /// No description provided for @piyuo_server_screen_copy_success.
  ///
  /// In en, this message translates to:
  /// **'URL copied'**
  String get piyuo_server_screen_copy_success;

  /// No description provided for @piyuo_server_screen_saving_action.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get piyuo_server_screen_saving_action;

  /// No description provided for @piyuo_server_screen_start.
  ///
  /// In en, this message translates to:
  /// **'Press \"Start\" below to begin counting.'**
  String get piyuo_server_screen_start;

  /// No description provided for @piyuo_server_screen_url_help.
  ///
  /// In en, this message translates to:
  /// **'Your personal Piyuo Cloud dashboard is ready at this URL.'**
  String get piyuo_server_screen_url_help;

  /// No description provided for @piyuo_server_screen_url_remember.
  ///
  /// In en, this message translates to:
  /// **'Save this URL to access your traffic dashboard from another device.'**
  String get piyuo_server_screen_url_remember;

  /// No description provided for @piyuo_server_screen_use_action.
  ///
  /// In en, this message translates to:
  /// **'Use Piyuo Cloud'**
  String get piyuo_server_screen_use_action;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @product_copyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2026'**
  String get product_copyright;

  /// No description provided for @product_desc.
  ///
  /// In en, this message translates to:
  /// **'AI-powered people and vehicle counting.'**
  String get product_desc;

  /// No description provided for @settings_screen_custom_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Send traffic data directly to your own backend or database.'**
  String get settings_screen_custom_subtitle;

  /// No description provided for @settings_screen_custom_title.
  ///
  /// In en, this message translates to:
  /// **'Use Custom Server'**
  String get settings_screen_custom_title;

  /// No description provided for @settings_screen_data_server_label.
  ///
  /// In en, this message translates to:
  /// **'Data Server'**
  String get settings_screen_data_server_label;

  /// No description provided for @settings_screen_detection_target.
  ///
  /// In en, this message translates to:
  /// **'Detection Target'**
  String get settings_screen_detection_target;

  /// No description provided for @settings_screen_language_title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_screen_language_title;

  /// No description provided for @settings_screen_local_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Store traffic data locally on this device. Nothing is uploaded remotely.'**
  String get settings_screen_local_subtitle;

  /// No description provided for @settings_screen_local_title.
  ///
  /// In en, this message translates to:
  /// **'Local Device Only'**
  String get settings_screen_local_title;

  /// No description provided for @settings_screen_misc_label.
  ///
  /// In en, this message translates to:
  /// **'Misc'**
  String get settings_screen_misc_label;

  /// No description provided for @settings_screen_object_detection.
  ///
  /// In en, this message translates to:
  /// **'Object Detection'**
  String get settings_screen_object_detection;

  /// No description provided for @settings_screen_piyuo_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Store your traffic data in Piyuo Cloud with dashboards and business insights.'**
  String get settings_screen_piyuo_subtitle;

  /// No description provided for @settings_screen_piyuo_title.
  ///
  /// In en, this message translates to:
  /// **'Piyuo Cloud'**
  String get settings_screen_piyuo_title;

  /// No description provided for @settings_screen_reset_all_data_body.
  ///
  /// In en, this message translates to:
  /// **'This will erase all data and start over. This action cannot be undone.'**
  String get settings_screen_reset_all_data_body;

  /// No description provided for @settings_screen_reset_all_data_title.
  ///
  /// In en, this message translates to:
  /// **'Reset all data?'**
  String get settings_screen_reset_all_data_title;

  /// No description provided for @settings_screen_subscription_body.
  ///
  /// In en, this message translates to:
  /// **'Manage your subscription and billing details'**
  String get settings_screen_subscription_body;

  /// No description provided for @settings_screen_subscription_title.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settings_screen_subscription_title;

  /// No description provided for @start_screen_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get start_screen_about;

  /// No description provided for @start_screen_server_none.
  ///
  /// In en, this message translates to:
  /// **'Stored on this device only'**
  String get start_screen_server_none;

  /// No description provided for @start_screen_server_personal.
  ///
  /// In en, this message translates to:
  /// **'Data uploads hourly to'**
  String get start_screen_server_personal;

  /// No description provided for @start_screen_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get start_screen_settings;

  /// No description provided for @start_screen_upload_logs.
  ///
  /// In en, this message translates to:
  /// **'Upload Logs'**
  String get start_screen_upload_logs;

  /// No description provided for @start_screen_video_sources.
  ///
  /// In en, this message translates to:
  /// **'Video Sources'**
  String get start_screen_video_sources;

  /// No description provided for @stayed.
  ///
  /// In en, this message translates to:
  /// **'Stayed'**
  String get stayed;

  /// No description provided for @stayed_help.
  ///
  /// In en, this message translates to:
  /// **'Counts people or vehicles that remained in this area for at least the configured Stay Time.\\n\\nThe default Stay Time is 15 seconds and can be changed in Settings.'**
  String get stayed_help;

  /// No description provided for @target_pedestrian.
  ///
  /// In en, this message translates to:
  /// **'Pedestrian'**
  String get target_pedestrian;

  /// No description provided for @target_pedestrian_help.
  ///
  /// In en, this message translates to:
  /// **'Count people using the pedestrian detection model'**
  String get target_pedestrian_help;

  /// No description provided for @target_screen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose which detection model to use'**
  String get target_screen_subtitle;

  /// No description provided for @target_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get target_vehicle;

  /// No description provided for @target_vehicle_help.
  ///
  /// In en, this message translates to:
  /// **'Count cars and other vehicles using the vehicle model'**
  String get target_vehicle_help;

  /// No description provided for @telemetry_error_connection_refused.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the server. It may be offline or unreachable right now.'**
  String get telemetry_error_connection_refused;

  /// No description provided for @telemetry_error_connection_reset.
  ///
  /// In en, this message translates to:
  /// **'The connection was reset. Please check your internet connection and try again.'**
  String get telemetry_error_connection_reset;

  /// No description provided for @telemetry_error_connection_timeout.
  ///
  /// In en, this message translates to:
  /// **'The connection took too long to respond. Please check your internet connection and try again.'**
  String get telemetry_error_connection_timeout;

  /// No description provided for @telemetry_error_dns_lookup_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the server address. Please check your internet connection or the server URL.'**
  String get telemetry_error_dns_lookup_failed;

  /// No description provided for @telemetry_error_http_error_status.
  ///
  /// In en, this message translates to:
  /// **'The server rejected the request. Please try again later.'**
  String get telemetry_error_http_error_status;

  /// No description provided for @telemetry_error_http_unknown_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred while communicating with the server.'**
  String get telemetry_error_http_unknown_error;

  /// No description provided for @telemetry_error_invalid_url.
  ///
  /// In en, this message translates to:
  /// **'The server address is invalid. Please check your settings.'**
  String get telemetry_error_invalid_url;

  /// No description provided for @telemetry_error_network_error.
  ///
  /// In en, this message translates to:
  /// **'A network error occurred. Please check your internet connection and try again.'**
  String get telemetry_error_network_error;

  /// No description provided for @telemetry_error_socket_error.
  ///
  /// In en, this message translates to:
  /// **'A network connection problem occurred. Please check your internet connection.'**
  String get telemetry_error_socket_error;

  /// No description provided for @telemetry_error_transport_exception.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while sending data. Please try again.'**
  String get telemetry_error_transport_exception;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms;

  /// No description provided for @upload_screen_attempt_time.
  ///
  /// In en, this message translates to:
  /// **'Attempt Time:'**
  String get upload_screen_attempt_time;

  /// No description provided for @upload_screen_error.
  ///
  /// In en, this message translates to:
  /// **'Error:'**
  String get upload_screen_error;

  /// No description provided for @upload_screen_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get upload_screen_failed;

  /// No description provided for @upload_screen_load_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to load upload logs.'**
  String get upload_screen_load_error;

  /// No description provided for @upload_screen_log_not_exists.
  ///
  /// In en, this message translates to:
  /// **'Upload log is no longer available.'**
  String get upload_screen_log_not_exists;

  /// No description provided for @upload_screen_next.
  ///
  /// In en, this message translates to:
  /// **'Next upload at ...'**
  String get upload_screen_next;

  /// No description provided for @upload_screen_next_upload_prefix.
  ///
  /// In en, this message translates to:
  /// **'Next upload at '**
  String get upload_screen_next_upload_prefix;

  /// No description provided for @upload_screen_no_data_server.
  ///
  /// In en, this message translates to:
  /// **'Please set the Data Server first.'**
  String get upload_screen_no_data_server;

  /// No description provided for @upload_screen_no_logs.
  ///
  /// In en, this message translates to:
  /// **'No upload logs yet.'**
  String get upload_screen_no_logs;

  /// No description provided for @upload_screen_payload_count.
  ///
  /// In en, this message translates to:
  /// **'Payload Count'**
  String get upload_screen_payload_count;

  /// No description provided for @upload_screen_payload_count_label.
  ///
  /// In en, this message translates to:
  /// **'Payload Count:'**
  String get upload_screen_payload_count_label;

  /// No description provided for @upload_screen_payload_size.
  ///
  /// In en, this message translates to:
  /// **'Payload Size:'**
  String get upload_screen_payload_size;

  /// No description provided for @upload_screen_result.
  ///
  /// In en, this message translates to:
  /// **'Result:'**
  String get upload_screen_result;

  /// No description provided for @upload_screen_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry Count:'**
  String get upload_screen_retry;

  /// No description provided for @upload_screen_size_kb.
  ///
  /// In en, this message translates to:
  /// **'KB'**
  String get upload_screen_size_kb;

  /// No description provided for @upload_screen_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get upload_screen_success;

  /// No description provided for @upload_screen_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get upload_screen_today;

  /// No description provided for @upload_screen_upload_now.
  ///
  /// In en, this message translates to:
  /// **'Upload Now'**
  String get upload_screen_upload_now;

  /// No description provided for @upload_screen_upload_success.
  ///
  /// In en, this message translates to:
  /// **'Upload successful.'**
  String get upload_screen_upload_success;

  /// No description provided for @upload_screen_uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get upload_screen_uploading;

  /// No description provided for @upload_screen_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get upload_screen_yesterday;

  /// No description provided for @url_screen_invalid_rtsp_error.
  ///
  /// In en, this message translates to:
  /// **'RTSP URLs must include a host name.'**
  String get url_screen_invalid_rtsp_error;

  /// No description provided for @url_screen_invalid_url_error.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL with a supported scheme.'**
  String get url_screen_invalid_url_error;

  /// No description provided for @url_screen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter the live stream URL'**
  String get url_screen_subtitle;

  /// No description provided for @url_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get url_screen_title;

  /// No description provided for @url_screen_unsupported_scheme_error.
  ///
  /// In en, this message translates to:
  /// **'Es werden nur HTTP-'**
  String get url_screen_unsupported_scheme_error;

  /// No description provided for @url_screen_url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url_screen_url;

  /// No description provided for @url_screen_url_empty_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a live stream URL.'**
  String get url_screen_url_empty_error;

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

  /// No description provided for @video_sources_back_camera.
  ///
  /// In en, this message translates to:
  /// **'Back Camera'**
  String get video_sources_back_camera;

  /// No description provided for @video_sources_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get video_sources_camera;

  /// No description provided for @video_sources_file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get video_sources_file;

  /// No description provided for @video_sources_front_camera.
  ///
  /// In en, this message translates to:
  /// **'Front Camera'**
  String get video_sources_front_camera;

  /// No description provided for @video_sources_live_stream.
  ///
  /// In en, this message translates to:
  /// **'Live stream URL'**
  String get video_sources_live_stream;

  /// No description provided for @video_sources_screen_camera_not_found_message.
  ///
  /// In en, this message translates to:
  /// **'Need grant camera permission to use camera'**
  String get video_sources_screen_camera_not_found_message;

  /// No description provided for @video_sources_screen_camera_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'Camera not found'**
  String get video_sources_screen_camera_not_found_title;

  /// No description provided for @video_sources_screen_import_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to import video file.'**
  String get video_sources_screen_import_error;

  /// No description provided for @video_sources_screen_photos_denied_msg.
  ///
  /// In en, this message translates to:
  /// **'Please go to settings and allow photos access permission for this app.'**
  String get video_sources_screen_photos_denied_msg;

  /// No description provided for @video_sources_screen_select_camera.
  ///
  /// In en, this message translates to:
  /// **'Tap to select this camera'**
  String get video_sources_screen_select_camera;

  /// No description provided for @video_sources_screen_select_file.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose a file'**
  String get video_sources_screen_select_file;

  /// No description provided for @video_sources_screen_select_live.
  ///
  /// In en, this message translates to:
  /// **'Tap to set the live stream URL'**
  String get video_sources_screen_select_live;

  /// No description provided for @video_sources_webcam.
  ///
  /// In en, this message translates to:
  /// **'Webcam'**
  String get video_sources_webcam;
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
