// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class LocalizationRo extends Localization {
  LocalizationRo([String locale = 'ro']) : super(locale);

  @override
  String get about_screen_app_version => 'Versiune aplicație';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_build_info_title => 'Build Information';

  @override
  String get about_screen_email_us => 'Trimite-ne un email';

  @override
  String get about_screen_force_window_end_title => 'Force Window End';

  @override
  String get about_screen_models => 'Modele de detectare a obiectelor';

  @override
  String get about_screen_opencv_build_info =>
      'Informații despre build-ul OpenCV';

  @override
  String get about_screen_platform => 'Platformă';

  @override
  String get about_screen_reset_app_state_success =>
      'App state has been reset.';

  @override
  String get about_screen_reset_app_state_title => 'Reset App State';

  @override
  String get about_screen_title => 'Despre';

  @override
  String get cancel => 'Cancel';

  @override
  String get count_avg_dwell => 'Dur. Med.';

  @override
  String get count_avg_occ => 'Ocup. Med.';

  @override
  String get count_max_dwell => 'Dur. Max.';

  @override
  String get count_max_occ => 'Ocup. Max.';

  @override
  String get detection_screen_reset => 'Resetare';

  @override
  String get detection_screen_reset_content =>
      'Sunteți sigur că doriți să resetați setările de detectare?';

  @override
  String get detection_screen_title => 'Setări de detectare';

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
  String get language_screen_language => 'Limbă';

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
  String get main_screen_booting => 'Se pornește...';

  @override
  String get main_screen_checking_hardware => 'Se verifică hardware-ul...';

  @override
  String get no => 'Nu';

  @override
  String get no_camera_screen_body =>
      'There is no camera detected on this device. Please connect a camera to use the app.\\nOr you can use Live URL or a file to test the app.';

  @override
  String get no_camera_screen_title => 'No Camera Detected';

  @override
  String get product_copyright => 'Drepturi de autor © 2025';

  @override
  String get product_desc =>
      'Folosește viziunea computerizată și inteligența artificială pentru a număra persoane, vehicule, animale de companie și multe altele.';

  @override
  String get product_name => 'Contor';

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
      'Setați numele proiectului, parametrii de detectare, resetarea numărării.';

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
  String get submit => 'Trimite';

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
  String get url_screen_desc => 'Vă rugăm să introduceți URL-ul fluxului live';

  @override
  String get url_screen_title => 'URL flux live';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://exemplu.com/flux sau rtsp://exemplu.com/flux';

  @override
  String get video_screen_desc =>
      'Gestionează sursele video, adaugă sau modifică zonele de detectare.';

  @override
  String get video_sources_camera => 'Cameră';

  @override
  String get video_sources_camera_not_found_message =>
      'Trebuie să acordați permisiunea pentru cameră pentru a o putea utiliza';

  @override
  String get video_sources_camera_not_found_title => 'Camera nu a fost găsită';

  @override
  String get video_sources_file => 'Fișier';

  @override
  String get video_sources_file_hint =>
      'Alege un videoclip de pe dispozitivul tău';

  @override
  String get video_sources_import_error =>
      'Nu s-a putut importa fișierul video.';

  @override
  String get video_sources_live_stream => 'URL flux live';

  @override
  String get video_sources_load_error => 'Nu s-au putut încărca sursele video.';

  @override
  String get video_sources_photos_denied_msg =>
      'Mergeți la setări și permiteți accesul la fotografii pentru această aplicație.';

  @override
  String get video_sources_screen_body =>
      'ဗီဒီယိုရင်းမြစ်များကို စီမံပြီး ရှာဖွေဧရိယာများကို ထည့်သွင်း သို့မဟုတ် ပြင်ဆင်ပါ။';

  @override
  String get video_sources_screen_title => 'Surse video';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get wizard_screen_about => 'Despre';

  @override
  String get wizard_screen_language => 'Limbă';

  @override
  String get yes => 'Da';
}
