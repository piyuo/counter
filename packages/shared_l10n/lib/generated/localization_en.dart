// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LocalizationEn extends Localization {
  LocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get about_screen_app_version => 'App Version';

  @override
  String get about_screen_email_us => 'Email us';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get appeared => 'Appeared';

  @override
  String get appeared_help =>
      'Counts people or vehicles whose first detected position was inside this area.\\n\\nUseful for understanding where tracking begins.\\n\\n(Primarily intended for advanced users.)';

  @override
  String get average_occupancy => 'Average Occupancy';

  @override
  String get average_occupancy_help =>
      'Shows the average number of people or vehicles in this area during the current counting window.\\n\\nThis helps measure how busy the area was over the entire counting window.';

  @override
  String get average_stay => 'Average Stay';

  @override
  String get average_stay_help =>
      'Shows the average time people or vehicles stayed in this area.\\n\\nA longer average stay may indicate customers are spending more time in this area.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter uses your camera and on-device AI to count people. First, let\'s make sure your device is compatible.';

  @override
  String get camera_test_screen_instruction =>
      'Point your camera at people. The app will draw boxes around anyone it detects.';

  @override
  String get camera_test_screen_next => 'Tap Next to continue.';

  @override
  String get camera_test_screen_start =>
      'Tap Start. If asked, allow camera access.';

  @override
  String get camera_test_screen_test_failed => 'Test failed!';

  @override
  String get camera_test_screen_test_passed => 'Test passed!';

  @override
  String get camera_test_screen_title => 'AI Camera Test';

  @override
  String get camera_test_screen_wait => 'Waiting for AI to detect people…';

  @override
  String get cta_screen_custom => 'Use Your Own Server';

  @override
  String get cta_screen_custom_help =>
      'Send traffic data directly to your own backend or database.';

  @override
  String get cta_screen_footer =>
      'By continuing, you agree to the Terms of Service and Privacy Policy and Data Processing Agreement.';

  @override
  String get cta_screen_invitation => 'Use an Invitation Code';

  @override
  String get cta_screen_invitation_help =>
      'Join an existing organization using an invitation from your administrator.';

  @override
  String get cta_screen_local => 'Local Device Only';

  @override
  String get cta_screen_local_help =>
      'Store traffic data only on this device. Nothing is uploaded.';

  @override
  String get cta_screen_piyuo => 'Use Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Store traffic data in Piyuo Cloud with dashboards and business insights.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter creates anonymous traffic statistics every 5 minutes.\\nChoose how you want to store and access your data.';

  @override
  String get current_occupancy => 'Current Count';

  @override
  String get current_occupancy_help =>
      'Shows the current count of people or vehicles in this area.\\n\\nThis count updates in real time and is useful for checking that AI detection matches what you see on screen. It is not included in uploaded telemetry.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Saving...';

  @override
  String get custom_server_screen_server_url_label => 'Server URL';

  @override
  String get detection_screen_confidence => 'Confidence Threshold';

  @override
  String get detection_screen_confidence_dialog =>
      'Controls how certain the AI must be before counting a person or vehicle.\\nLower values\\n• Detect more objects\\n• Better for distant or partially hidden objects\\n• May increase false detections\\nHigher values\\n• Count only high-confidence detections\\n• Reduce false detections\\n• May miss small or difficult objects\\nUse a lower value if the app is missing people or vehicles.\\nUse a higher value if the app is counting shadows, reflections, or other false objects.';

  @override
  String get detection_screen_confidence_help =>
      'Minimum confidence required to detect an object.';

  @override
  String get detection_screen_confidence_max_label => 'Strict';

  @override
  String get detection_screen_confidence_min_label => 'Loose';

  @override
  String get detection_screen_disappear => 'Disappear Timeout';

  @override
  String get detection_screen_disappear_dialog =>
      'Determines how long the AI waits before marking an object as disappeared after it is no longer detected.\\nShorter values\\n• Mark objects as disappeared sooner\\n• Better for fast-moving traffic\\n• May mark temporarily hidden objects as disappeared\\nLonger values\\n• Wait longer before marking objects as disappeared\\n• Better when objects are briefly blocked or missed\\n• Delay disappear events';

  @override
  String get detection_screen_disappear_help =>
      'How long the AI waits before marking an object as disappeared after it can no longer detect it.';

  @override
  String get detection_screen_disappear_max_label => 'Slow';

  @override
  String get detection_screen_disappear_min_label => 'Fast';

  @override
  String get detection_screen_memory_dialog =>
      'Controls how long the AI remembers an object after it disappears.\\nIncrease this value if people or vehicles are frequently hidden behind other objects.\\nDecrease this value if objects are incorrectly linked after leaving the scene.';

  @override
  String get detection_screen_min_presence => 'Minimum Presence Time';

  @override
  String get detection_screen_min_presence_help =>
      'An object must remain visible before it can be counted. Longer values help reduce brief false detections.';

  @override
  String get detection_screen_min_presence_max_label => 'Safer';

  @override
  String get detection_screen_min_presence_min_label => 'Faster';

  @override
  String get detection_screen_minimum_visible =>
      'Objects must remain visible for this long before they are counted.\\nIncrease this value to ignore brief false detections.\\nDecrease this value if fast-moving people or vehicles are being missed.';

  @override
  String get detection_screen_new_track => 'New Track Threshold';

  @override
  String get detection_screen_new_track_help =>
      'Minimum confidence required to start tracking a new object. Lower values may create duplicate tracks.';

  @override
  String get detection_screen_new_track_max_label => 'Conservative';

  @override
  String get detection_screen_new_track_min_label => 'Aggressive';

  @override
  String get detection_screen_reset => 'Reset';

  @override
  String get detection_screen_reset_content =>
      'Are you sure you want to reset the detection settings?';

  @override
  String get detection_screen_show_track_id => 'Show Track ID';

  @override
  String get detection_screen_show_track_id_help =>
      'Enable this option to show unique track IDs for each tracked object.';

  @override
  String get detection_screen_stay => 'Stay Time';

  @override
  String get detection_screen_stay_help =>
      'How long an object must remain in the area before it is counted as a stay.';

  @override
  String get detection_screen_stay_max_label => 'Delayed';

  @override
  String get detection_screen_stay_min_label => 'Instant';

  @override
  String get detection_screen_stay_threshold =>
      'Determines when an object contributes to the Stay count.\\nShorter values\\n• Count stays immediately\\n• Better for quick analysis\\nLonger values\\n• Ignore brief pass-through traffic\\n• Better for occupancy measurement';

  @override
  String get detection_screen_subtitle =>
      'Tune how the AI detects and tracks objects.';

  @override
  String get detection_screen_title => 'Tracking & Counting';

  @override
  String get detection_screen_track_dialog =>
      'Controls when a newly detected object becomes a new track.\\nLower values\\n• Start tracking sooner\\n• Better for fast-moving objects\\n• May create duplicate tracks\\nHigher values\\n• Require stronger evidence before creating a new track\\n• Reduce duplicate tracks\\n• May delay tracking new objects';

  @override
  String get detection_screen_track_memory => 'Tracking Memory';

  @override
  String get detection_screen_track_memory_help =>
      'How long to keep tracking an object after it is temporarily lost. Longer values help recover from brief occlusions.';

  @override
  String get detection_screen_track_memory_max_label => 'Long';

  @override
  String get detection_screen_track_memory_min_label => 'Short';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter uses your camera to detect pedestrians and vehicles in real time. This device doesn\\\'t have one available.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Try opening this app on your phone';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'A smartphone or tablet with a camera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'iOS or Android device recommended';

  @override
  String get device_not_supported_screen_requirements_title => 'What you need';

  @override
  String get device_not_supported_screen_title => 'Camera not found';

  @override
  String get disappeared => 'Disappeared';

  @override
  String get disappeared_help =>
      'Counts people or vehicles whose last detected position was inside this area.\\n\\nTracking ends after the configured Disappear Time if the person or vehicle is no longer detected.\\n\\n(Primarily intended for advanced users.)';

  @override
  String get dpa => 'Data Processing Agreement';

  @override
  String get durationDaysShort => '%sd';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%sm';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Entered';

  @override
  String get entered_help =>
      'Counts people or vehicles that entered this area during the current counting window.\\n\\nAn entry is counted when a person or vehicle moves from outside the area to inside.';

  @override
  String get exited => 'Exited';

  @override
  String get exited_help =>
      'Counts people or vehicles that left this area during the current counting window.\\n\\nAn exit is counted when a person or vehicle moves from inside the area to outside.';

  @override
  String get language_screen_language => 'Language';

  @override
  String get language_screen_subtitle => 'Choose the language used in the app.';

  @override
  String get local_only_screen_body =>
      'Local Device Only mode lets you try AI camera detection and tracking without uploading any data. All foot traffic stats are processed only on this device, great for testing before you connect to a server.';

  @override
  String get local_only_screen_use_action => 'Use Local Device Only';

  @override
  String get local_screen_text =>
      'Piyuo Counter will run entirely on this device.\\nTraffic statistics will be stored on this device only and won\'t be uploaded.\\nYou can connect to Piyuo Cloud or your own server later in Settings.';

  @override
  String get maximum_occupancy => 'Maximum Occupancy';

  @override
  String get maximum_occupancy_help =>
      'Shows the highest number of people or vehicles in this area at the same time during the current counting window.\\n\\nUseful for identifying peak crowd or traffic levels.';

  @override
  String get maximum_stay => 'Maximum Stay';

  @override
  String get maximum_stay_help =>
      'Shows the longest time a person or vehicle stayed in this area during the current counting window.\\n\\nUseful for identifying unusually long visits or stops.';

  @override
  String get metric_events => 'Events';

  @override
  String get metric_live => 'Live';

  @override
  String get metric_show_less => 'Show less';

  @override
  String get metric_show_more => 'Show more';

  @override
  String get metric_statistics => 'Statistics';

  @override
  String get metrics_counting_all => 'All';

  @override
  String get metrics_counting_done => 'Done';

  @override
  String get metrics_counting_in_progress => 'In Progress';

  @override
  String get metrics_counting_missing => 'Missing';

  @override
  String get metrics_counting_window => 'Statistics for Each 5-Minute Period';

  @override
  String get onboarding_back_action => 'Back';

  @override
  String get onboarding_cta_no_server => 'Prefer not to upload data?';

  @override
  String get onboarding_cta_title => 'Where should your data go?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter uses your camera and on-device AI to spot people and vehicles in real time.\\nUsing detection and tracking technology, it automatically counts foot traffic and vehicle traffic — all processed right on your device.';

  @override
  String get onboarding_intro_text2 =>
      'All AI processing happens locally on your device. No video, images, faces, or identities are uploaded.\\nOnly anonymous 5-minute summaries are shared, including counts, occupancy, entries, exits, and dwell time statistics.';

  @override
  String get onboarding_intro_text3 =>
      'Just start the app and leave it running. Piyuo Counter continuously collects and stores traffic data automatically.\\nData summaries are saved every 5 minutes and uploaded hourly to Piyuo Cloud or your own server.';

  @override
  String get onboarding_intro_title1 => 'AI Traffic Counting';

  @override
  String get onboarding_intro_title2 => 'Privacy-First by Design';

  @override
  String get onboarding_intro_title3 => 'Runs Automatically 24/7';

  @override
  String get onboarding_next_action => 'Next';

  @override
  String get onboarding_skip_action => 'Skip Intro';

  @override
  String get onboarding_start_action => 'Start';

  @override
  String get passed_by => 'Passed By';

  @override
  String get passed_by_help =>
      'Counts people or vehicles that passed through this area during the current counting window.\\n\\nEach person or vehicle is counted only once for each pass through the area.';

  @override
  String get payloads_screen_area => 'Area';

  @override
  String get payloads_screen_confidence => 'Confidence';

  @override
  String get payloads_screen_coverage => 'Coverage';

  @override
  String get payloads_screen_delivered => 'Delivered';

  @override
  String get payloads_screen_failed_load => 'Failed to load recent payloads';

  @override
  String get payloads_screen_frame_processed => 'Frames processed';

  @override
  String get payloads_screen_hour_not_exists => 'This hour no longer exists.';

  @override
  String get payloads_screen_missing_time => 'Missing Time';

  @override
  String get payloads_screen_no_payloads => 'No payloads yet.';

  @override
  String get payloads_screen_partial => 'Window ended early (partial)';

  @override
  String get payloads_screen_partially => 'Partially delivered';

  @override
  String get payloads_screen_payload_not_exists =>
      'This payload no longer exists.';

  @override
  String get payloads_screen_pending => 'Pending delivery';

  @override
  String get payloads_screen_process_fps => 'Process FPS';

  @override
  String get payloads_screen_resend => 'Resend';

  @override
  String get payloads_screen_select_first =>
      'Select at least one date or hour first.';

  @override
  String get payloads_screen_subtitle => 'Select by date or hour to resend';

  @override
  String get payloads_screen_title => 'Recent Payloads';

  @override
  String get personal_custom_screen_build_server =>
      'Need help setting up your own server?\\nSee our API documentation and server examples.';

  @override
  String get personal_custom_screen_help_action => 'Open API Documentation';

  @override
  String get personal_custom_screen_reset_action => 'Start Over';

  @override
  String get personal_custom_success_screen_help =>
      'Tap Start below to begin counting.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Traffic statistics are uploaded automatically every hour.\\nYou can also upload them manually from the Upload Logs screen.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Your server doesn\'t need to be online yet.\\nStart counting now. You can finish building and testing your server later. Traffic statistics stay on this device until they\'re uploaded successfully.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Traffic statistics will be sent to';

  @override
  String get personal_custom_success_screen_title => 'Your Server Is Ready';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Your Piyuo Cloud URL';

  @override
  String get piyuo_server_screen_copy_action => 'Copy URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL copied';

  @override
  String get piyuo_server_screen_saving_action => 'Saving...';

  @override
  String get piyuo_server_screen_start =>
      'Press \"Start\" below to begin counting.';

  @override
  String get piyuo_server_screen_url_help =>
      'Your personal Piyuo Cloud dashboard is ready at this URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Save this URL to access your traffic dashboard from another device.';

  @override
  String get piyuo_server_screen_use_action => 'Use Piyuo Cloud';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'AI-powered people and vehicle counting.';

  @override
  String get settings_screen_custom_subtitle =>
      'Send traffic data directly to your own backend or database.';

  @override
  String get settings_screen_custom_title => 'Use Custom Server';

  @override
  String get settings_screen_data_server_label => 'Data Server';

  @override
  String get settings_screen_detection_target => 'Detection Target';

  @override
  String get settings_screen_language_title => 'Language';

  @override
  String get settings_screen_local_subtitle =>
      'Store traffic data locally on this device. Nothing is uploaded remotely.';

  @override
  String get settings_screen_local_title => 'Local Device Only';

  @override
  String get settings_screen_misc_label => 'Misc';

  @override
  String get settings_screen_object_detection => 'Object Detection';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Store your traffic data in Piyuo Cloud with dashboards and business insights.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'This will erase all data and start over. This action cannot be undone.';

  @override
  String get settings_screen_reset_all_data_title => 'Reset all data?';

  @override
  String get settings_screen_subscription_body =>
      'Manage your subscription and billing details';

  @override
  String get settings_screen_subscription_title => 'Subscription';

  @override
  String get start_screen_about => 'About';

  @override
  String get start_screen_server_none => 'Stored on this device only';

  @override
  String get start_screen_server_personal => 'Data uploads hourly to';

  @override
  String get start_screen_settings => 'Settings';

  @override
  String get start_screen_upload_logs => 'Upload Logs';

  @override
  String get start_screen_video_sources => 'Video Sources';

  @override
  String get stayed => 'Stayed';

  @override
  String get stayed_help =>
      'Counts people or vehicles that remained in this area for at least the configured Stay Time.\\n\\nThe default Stay Time is 15 seconds and can be changed in Settings.';

  @override
  String get target_pedestrian => 'Pedestrian';

  @override
  String get target_pedestrian_help =>
      'Count people using the pedestrian detection model';

  @override
  String get target_screen_subtitle => 'Choose which detection model to use';

  @override
  String get target_vehicle => 'Vehicle';

  @override
  String get target_vehicle_help =>
      'Count cars and other vehicles using the vehicle model';

  @override
  String get telemetry_error_connection_refused =>
      'Couldn\'t reach the server. It may be offline or unreachable right now.';

  @override
  String get telemetry_error_connection_reset =>
      'The connection was reset. Please check your internet connection and try again.';

  @override
  String get telemetry_error_connection_timeout =>
      'The connection took too long to respond. Please check your internet connection and try again.';

  @override
  String get telemetry_error_database_error =>
      'Failed to write to the database.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Couldn\'t find the server address. Please check your internet connection or the server URL.';

  @override
  String get telemetry_error_http_error_status =>
      'The server rejected the request. Please try again later.';

  @override
  String get telemetry_error_http_unknown_error =>
      'An unexpected error occurred while communicating with the server.';

  @override
  String get telemetry_error_invalid_url =>
      'The server address is invalid. Please check your settings.';

  @override
  String get telemetry_error_network_error =>
      'A network error occurred. Please check your internet connection and try again.';

  @override
  String get telemetry_error_socket_error =>
      'A network connection problem occurred. Please check your internet connection.';

  @override
  String get telemetry_error_transport_exception =>
      'Something went wrong while sending data. Please try again.';

  @override
  String get telemetry_error_unknown_error => 'An unexpected error occurred.';

  @override
  String get terms => 'Terms of Service';

  @override
  String get upload_screen_attempt_time => 'Attempt Time:';

  @override
  String get upload_screen_error => 'Error:';

  @override
  String get upload_screen_failed => 'Failed';

  @override
  String get upload_screen_load_error => 'Unable to load upload logs.';

  @override
  String get upload_screen_log_not_exists =>
      'Upload log is no longer available.';

  @override
  String get upload_screen_next => 'Next upload at ...';

  @override
  String get upload_screen_next_upload_prefix => 'Next upload at ';

  @override
  String get upload_screen_no_data_server =>
      'Please set the Data Server first.';

  @override
  String get upload_screen_no_logs => 'No upload logs yet.';

  @override
  String get upload_screen_payload_count => 'Payload Count';

  @override
  String get upload_screen_payload_count_label => 'Payload Count:';

  @override
  String get upload_screen_payload_size => 'Payload Size:';

  @override
  String get upload_screen_result => 'Result:';

  @override
  String get upload_screen_retry => 'Retry Count:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Success';

  @override
  String get upload_screen_today => 'Today';

  @override
  String get upload_screen_upload_now => 'Upload Now';

  @override
  String get upload_screen_upload_success => 'Upload successful.';

  @override
  String get upload_screen_uploading => 'Uploading...';

  @override
  String get upload_screen_yesterday => 'Yesterday';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP URLs must include a host name.';

  @override
  String get url_screen_invalid_url_error =>
      'Enter a valid URL with a supported scheme.';

  @override
  String get url_screen_subtitle => 'Please enter the live stream URL';

  @override
  String get url_screen_title => 'Live stream URL';

  @override
  String get url_screen_unsupported_scheme_error => 'Es werden nur HTTP-';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Please enter a live stream URL.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Back Camera';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_file => 'File';

  @override
  String get video_sources_front_camera => 'Front Camera';

  @override
  String get video_sources_live_stream => 'Live stream URL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Need grant camera permission to use camera';

  @override
  String get video_sources_screen_camera_not_found_title => 'Camera not found';

  @override
  String get video_sources_screen_import_error =>
      'Failed to import video file.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Please go to settings and allow photos access permission for this app.';

  @override
  String get video_sources_screen_select_camera => 'Tap to select this camera';

  @override
  String get video_sources_screen_select_file => 'Tap to choose a file';

  @override
  String get video_sources_screen_select_live =>
      'Tap to set the live stream URL';

  @override
  String get video_sources_webcam => 'Webcam';
}
