// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class LocalizationMy extends Localization {
  LocalizationMy([String locale = 'my']) : super(locale);

  @override
  String get about_screen_app_version => 'အက်ပ်ဗားရှင်း';

  @override
  String get about_screen_benchmark => 'စံပြုတိုင်းတာချက်';

  @override
  String get about_screen_build_info_title => 'Build Information';

  @override
  String get about_screen_email_us => 'ကျွန်ုပ်တို့ထံ အီးမေးလ်ပို့ပါ';

  @override
  String get about_screen_force_window_end_title => 'Force Window End';

  @override
  String get about_screen_models => 'အရာဝတ္ထုရှာဖွေခြင်းမော်ဒယ်များ';

  @override
  String get about_screen_opencv_build_info => 'OpenCV ဆောက်လုပ်မှုအချက်အလက်';

  @override
  String get about_screen_platform => 'ပလက်ဖောင်း';

  @override
  String get about_screen_reset_app_state_success =>
      'App state has been reset.';

  @override
  String get about_screen_reset_app_state_title => 'Reset App State';

  @override
  String get about_screen_title => 'အကြောင်း';

  @override
  String get cancel => 'Cancel';

  @override
  String get count_avg_dwell => 'ပျမ်းတည်နေချိန်';

  @override
  String get count_avg_occ => 'ပျမ်းမျှ';

  @override
  String get count_max_dwell => 'အများဆုံးနေချိန်';

  @override
  String get count_max_occ => 'အများဆုံးလူ';

  @override
  String get detection_screen_reset => 'ပြန်လည်သတ်မှတ်ပါ';

  @override
  String get detection_screen_reset_content =>
      'ရှာဖွေခြင်းဆက်တင်များကို ပြန်လည်သတ်မှတ်ရန် သေချာပါသလား။';

  @override
  String get detection_screen_title => 'ရှာဖွေခြင်းဆက်တင်များ';

  @override
  String get detection_type_screen_body =>
      'Choose which detection model to use for this project.';

  @override
  String get detection_type_screen_load_error =>
      'Failed to load detection types.';

  @override
  String get detection_type_screen_pedestrian_body =>
      'Count people using the pedestrian detection model.';

  @override
  String get detection_type_screen_pedestrian_title => 'Pedestrian';

  @override
  String get detection_type_screen_title => 'Detection Type';

  @override
  String get detection_type_screen_vehicle_body =>
      'Count cars and other vehicles using the vehicle model.';

  @override
  String get detection_type_screen_vehicle_title => 'Vehicle';

  @override
  String get language_screen_body =>
      'Select your preferred language for the app interface.';

  @override
  String get language_screen_language => 'ဘာသာစကား';

  @override
  String get language_screen_system_label => 'System language';

  @override
  String get live_url_screen_examples_label => 'Example';

  @override
  String get live_url_screen_invalid_rtsp_error =>
      'RTSP URLs must include a host name.';

  @override
  String get live_url_screen_invalid_url_error =>
      'Enter a valid URL with a supported scheme.';

  @override
  String get live_url_screen_unsupported_scheme_error => 'Only HTTP';

  @override
  String get live_url_screen_url_empty_error =>
      'Please enter a live stream URL.';

  @override
  String get main_screen_booting => 'စတင်နေသည်...';

  @override
  String get main_screen_checking_hardware => 'ဟာ့ဒ်ဝဲစစ်ဆေးနေသည်...';

  @override
  String get no => 'မဟုတ်ပါ';

  @override
  String get no_camera_screen_body =>
      'There is no camera detected on this device. Please connect a camera to use the app.\\nOr you can use Live URL or a file to test the app.';

  @override
  String get no_camera_screen_title => 'No Camera Detected';

  @override
  String get product_copyright => 'မူပိုင်ခွင့် © 2025';

  @override
  String get product_desc =>
      'ကွန်ပျူတာမျက်စိနှင့် AI ကိုအသုံးပြု၍ လူများ၊ ယာဉ်များ၊ အိမ်မွေးတိရစ္ဆာန်များနှင့် အခြားအရာများကို ရေတွက်ပါ။';

  @override
  String get product_name => 'ကောင်တာ';

  @override
  String get settings_piyuo_screen_body => 'Use a Piyuo Cloud URL for uploads.';

  @override
  String get settings_piyuo_screen_cloud_url_label => 'Cloud URL';

  @override
  String get settings_piyuo_screen_copy_action => 'Copy URL';

  @override
  String get settings_piyuo_screen_copy_success => 'URL copied';

  @override
  String get settings_piyuo_screen_invalid_url_error =>
      'Please paste a valid Piyuo Cloud URL.';

  @override
  String get settings_piyuo_screen_legacy_body =>
      'If you already had a Piyuo Cloud URL from an older install';

  @override
  String get settings_piyuo_screen_saving_action => 'Saving...';

  @override
  String get settings_piyuo_screen_title => 'Piyuo Cloud';

  @override
  String get settings_piyuo_screen_use_action => 'Use Piyuo Cloud';

  @override
  String get settings_screen_body =>
      'Set project name, detection parameters, count clearing.';

  @override
  String get settings_screen_custom_server_body =>
      'We will help set up a local server.';

  @override
  String get settings_screen_custom_server_title => 'Use your own server';

  @override
  String get settings_screen_data_server_label => 'Data Server';

  @override
  String get settings_screen_delivery_label => 'Delivery';

  @override
  String get settings_screen_demo_mode_body =>
      'Test only. Data is not exported.';

  @override
  String get settings_screen_demo_mode_title => 'Demo mode';

  @override
  String get settings_screen_desc =>
      'စီမံကိန်းအမည်၊ ရှာဖွေမှုသတ်မှတ်ချက်များ၊ ရေတွက်မှုရှင်းလင်းခြင်းတို့ကို သတ်မှတ်ပါ။';

  @override
  String get settings_screen_detection_label => 'Detection';

  @override
  String get settings_screen_parameters_label => 'Parameters';

  @override
  String get settings_screen_piyuo_cloud_body =>
      'Send results to our cloud service.';

  @override
  String get settings_screen_piyuo_cloud_title => 'Use Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'This will erase all data and start from the beginning. This action cannot be undone.';

  @override
  String get settings_screen_reset_all_data_title => 'Reset all data?';

  @override
  String get settings_screen_subscription_body =>
      'Manage your subscription and billing details.';

  @override
  String get settings_screen_subscription_title => 'Subscription';

  @override
  String get settings_screen_title => 'Settings';

  @override
  String get settings_server_screen_body =>
      'Set the server URL used for uploads.';

  @override
  String get settings_server_screen_delivery_cadence_label =>
      'Deliver Payload On Wall Clock';

  @override
  String get settings_server_screen_hour_unit_plural => 'hours';

  @override
  String get settings_server_screen_hour_unit_singular => 'hour';

  @override
  String get settings_server_screen_minute_unit_plural => 'minutes';

  @override
  String get settings_server_screen_saving_action => 'Saving...';

  @override
  String get settings_server_screen_server_url_label => 'Server URL';

  @override
  String get settings_server_screen_title => 'Custom Server';

  @override
  String get settings_server_screen_use_action => 'Use Custom Server';

  @override
  String get start_screen_demo_mode_body =>
      'Demo mode. No data leaves your device.';

  @override
  String get start_screen_invitation_label => 'Invitation';

  @override
  String get start_screen_not_set_label => 'Not Set';

  @override
  String get start_screen_own_server_label => 'Own Server';

  @override
  String get start_screen_piyuo_cloud_label => 'Piyuo Cloud';

  @override
  String get start_screen_product_body =>
      'Pedestrian and vehicle counter with data collection.';

  @override
  String get start_screen_product_title => 'Piyuo Counter';

  @override
  String get submit => 'တင်သွင်းပါ';

  @override
  String get upload_config_screen_body =>
      'Configure delivery settings for telemetry uploads.';

  @override
  String get upload_config_screen_fast_fail_label => 'Fast fail';

  @override
  String get upload_config_screen_frequent_label => 'Frequent';

  @override
  String get upload_config_screen_large_label => 'Large';

  @override
  String get upload_config_screen_load_error =>
      'Failed to load delivery settings.';

  @override
  String get upload_config_screen_max_batch_size_body =>
      'Max number of payload records sent in one HTTP request.';

  @override
  String get upload_config_screen_max_batch_size_title => 'Maximum Batch Size';

  @override
  String get upload_config_screen_request_timeout_body =>
      'HTTP timeout per upload request.';

  @override
  String get upload_config_screen_request_timeout_title => 'Request Timeout';

  @override
  String get upload_config_screen_reset_body =>
      'This restores upload cadence, batching, and timeout to defaults.';

  @override
  String get upload_config_screen_reset_title => 'Reset delivery settings?';

  @override
  String get upload_config_screen_small_label => 'Small';

  @override
  String get upload_config_screen_sparse_label => 'Sparse';

  @override
  String get upload_config_screen_title => 'Delivery Settings';

  @override
  String get upload_config_screen_wait_longer_label => 'Wait longer';

  @override
  String get upload_config_screen_wall_clock_cadence_body =>
      'How often pending telemetry is uploaded on minute-aligned boundaries.';

  @override
  String get upload_config_screen_wall_clock_cadence_title =>
      'Wall-Clock Upload Cadence';

  @override
  String get upload_logs_screen_check_data_server_error_prefix =>
      'Unable to check Data Server: ';

  @override
  String get upload_logs_screen_detail_unavailable_body =>
      'Upload log detail is no longer available.';

  @override
  String get upload_logs_screen_empty_body => 'No upload logs yet.';

  @override
  String get upload_logs_screen_load_error => 'Unable to load upload logs.';

  @override
  String get upload_logs_screen_next_upload_pending => 'Next upload at ...';

  @override
  String get upload_logs_screen_next_upload_prefix => 'Next upload at ';

  @override
  String get upload_logs_screen_payloads_unit => 'payloads';

  @override
  String get upload_logs_screen_retry_action => 'Retry';

  @override
  String get upload_logs_screen_set_data_server_first_body =>
      'Please set the Data Server first.';

  @override
  String get upload_logs_screen_title => 'Upload Logs';

  @override
  String get upload_logs_screen_today_label => 'Today';

  @override
  String get upload_logs_screen_upload_failed_prefix => 'Upload failed: ';

  @override
  String get upload_logs_screen_upload_failed_unknown =>
      'Upload failed due to an unknown error.';

  @override
  String get upload_logs_screen_upload_now_action => 'Upload Now';

  @override
  String get upload_logs_screen_uploaded_success =>
      'Uploaded payloads to remote server.';

  @override
  String get upload_logs_screen_uploading_action => 'Uploading...';

  @override
  String get upload_logs_screen_yesterday_label => 'Yesterday';

  @override
  String get url_screen_body =>
      'Enter the live stream URL for your camera source.';

  @override
  String get url_screen_desc => 'တိုက်ရိုက်ထုတ်လွှင့်မှု URL ကို ထည့်သွင်းပါ';

  @override
  String get url_screen_title => 'တိုက်ရိုက်ထုတ်လွှင့်မှု URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream သို့မဟုတ် rtsp://example.com/stream';

  @override
  String get video_screen_desc =>
      'ဗီဒီယိုရင်းမြစ်များကို စီမံခန့်ခွဲပါ၊ ရှာဖွေမှုဇုန်များကို ထည့်သွင်းခြင်း သို့မဟုတ် ပြုပြင်ခြင်း။';

  @override
  String get video_sources_camera => 'ကင်မရာ';

  @override
  String get video_sources_camera_not_found_message =>
      'ကင်မရာကိုအသုံးပြုရန် ကင်မရာခွင့်ပြုချက်လိုအပ်သည်';

  @override
  String get video_sources_camera_not_found_title => 'ကင်မရာမတွေ့ပါ';

  @override
  String get video_sources_file => 'ဖိုင်';

  @override
  String get video_sources_file_hint => 'သင့်စက်မှ ဗီဒီယိုတစ်ခု ရွေးပါ';

  @override
  String get video_sources_import_error => 'ဗီဒီယိုဖိုင်ကို တင်သွင်းမရပါ။';

  @override
  String get video_sources_live_stream => 'တိုက်ရိုက်ထုတ်လွှင့်မှု URL';

  @override
  String get video_sources_load_error => 'ဗီဒီယိုရင်းမြစ်များကို ဖွင့်မရပါ။';

  @override
  String get video_sources_photos_denied_msg =>
      'ဆက်တင်သို့သွားပြီး ဤအက်ပ်အတွက် ဓာတ်ပုံဝင်ရောက်ခွင့် ခွင့်ပြုပါ။';

  @override
  String get video_sources_screen_body => 'ビデオソースを管理し、検出ゾーンを追加または変更します。';

  @override
  String get video_sources_screen_title => 'ဗီဒီယိုရင်းမြစ်များ';

  @override
  String get video_sources_webcam => 'ဝက်ဘ်ကင်မရာ';

  @override
  String get wizard_screen_about => 'အကြောင်း';

  @override
  String get wizard_screen_language => 'ဘာသာစကား';

  @override
  String get yes => 'ဟုတ်ကဲ့';
}
