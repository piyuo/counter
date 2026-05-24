// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class LocalizationZh extends Localization {
  LocalizationZh([String locale = 'zh']) : super(locale);

  @override
  String get about_screen_app_version => '應用程式版本';

  @override
  String get about_screen_benchmark => '基準測試';

  @override
  String get about_screen_build_info_title => 'Build Information';

  @override
  String get about_screen_email_us => '寫信給我們';

  @override
  String get about_screen_force_window_end_title => 'Force Window End';

  @override
  String get about_screen_models => '物體偵測模型';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 構建資訊';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_reset_app_state_success =>
      'App state has been reset.';

  @override
  String get about_screen_reset_app_state_title => 'Reset App State';

  @override
  String get about_screen_title => '關於';

  @override
  String get cancel => 'Cancel';

  @override
  String get count_avg_dwell => '平均停留';

  @override
  String get count_avg_occ => '平均人數';

  @override
  String get count_max_dwell => '最大停留';

  @override
  String get count_max_occ => '最多人數';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您確定要重置偵測設定嗎？';

  @override
  String get detection_screen_title => '偵測設定';

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
  String get language_screen_language => '語言';

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
  String get live_url_screen_unsupported_scheme_error =>
      ' and RTSPS URLs are supported.';

  @override
  String get live_url_screen_url_empty_error =>
      'Please enter a live stream URL.';

  @override
  String get main_screen_booting => '正在啟動...';

  @override
  String get main_screen_checking_hardware => '正在檢查硬體...';

  @override
  String get no => '否';

  @override
  String get no_camera_screen_body =>
      'There is no camera detected on this device. Please connect a camera to use the app.\\nOr you can use Live URL or a file to test the app.';

  @override
  String get no_camera_screen_title => 'No Camera Detected';

  @override
  String get product_copyright => '版權所有 © 2025';

  @override
  String get product_desc => '使用電腦視覺和人工智慧來計數人員、車輛、寵物等。';

  @override
  String get product_name => '計數器';

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
      ' paste it here to keep using the same cloud space.';

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
  String get settings_screen_desc => '設定專案名稱、偵測參數、計數清除。';

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
  String get submit => '提交';

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
  String get url_screen_desc => '請輸入即時串流網址';

  @override
  String get url_screen_title => '即時串流網址';

  @override
  String get url_screen_url => '網址';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get video_screen_desc => '管理影片來源，新增或修改偵測區域。';

  @override
  String get video_sources_camera => '相機';

  @override
  String get video_sources_camera_not_found_message => '使用此功能需要相機權限。';

  @override
  String get video_sources_camera_not_found_title => '找不到相機';

  @override
  String get video_sources_file => '檔案';

  @override
  String get video_sources_file_hint => '從裝置選擇影片';

  @override
  String get video_sources_import_error => '無法匯入影片檔案。';

  @override
  String get video_sources_live_stream => '直播串流網址';

  @override
  String get video_sources_load_error => '無法載入視訊來源。';

  @override
  String get video_sources_photos_denied_msg => '請前往設定並允許此應用程式的相片存取權限。';

  @override
  String get video_sources_screen_body => 'Upravljajte izvorima videa';

  @override
  String get video_sources_screen_title => '視訊來源';

  @override
  String get video_sources_webcam => '網路攝影機';

  @override
  String get wizard_screen_about => '關於';

  @override
  String get wizard_screen_language => '語言';

  @override
  String get yes => '是';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class LocalizationZhCn extends LocalizationZh {
  LocalizationZhCn() : super('zh_CN');

  @override
  String get about_screen_app_version => '应用程序版本';

  @override
  String get about_screen_benchmark => '基准测试';

  @override
  String get about_screen_build_info_title => 'Build Information';

  @override
  String get about_screen_email_us => '发邮件给我们';

  @override
  String get about_screen_force_window_end_title => 'Force Window End';

  @override
  String get about_screen_models => '物体检测模型';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 构建信息';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_reset_app_state_success =>
      'App state has been reset.';

  @override
  String get about_screen_reset_app_state_title => 'Reset App State';

  @override
  String get about_screen_title => '关于';

  @override
  String get cancel => 'Cancel';

  @override
  String get count_avg_dwell => '平均停留';

  @override
  String get count_avg_occ => '平均人数';

  @override
  String get count_max_dwell => '最大停留';

  @override
  String get count_max_occ => '最多人数';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您确定要重置检测设置吗？';

  @override
  String get detection_screen_title => '检测设置';

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
  String get language_screen_language => '语言';

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
  String get main_screen_booting => '正在启动...';

  @override
  String get main_screen_checking_hardware => '正在检查硬件...';

  @override
  String get no => '否';

  @override
  String get no_camera_screen_body =>
      'There is no camera detected on this device. Please connect a camera to use the app.\\nOr you can use Live URL or a file to test the app.';

  @override
  String get no_camera_screen_title => 'No Camera Detected';

  @override
  String get product_copyright => '版权所有 © 2025';

  @override
  String get product_desc => '使用计算机视觉和人工智能来计数人员、车辆、宠物等。';

  @override
  String get product_name => '计数器';

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
  String get settings_screen_desc => '设置项目名称、检测参数、计数清除。';

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
  String get submit => '提交';

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
      'Unable to check Data Server:';

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
  String get upload_logs_screen_next_upload_prefix => 'Next upload at';

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
  String get upload_logs_screen_upload_failed_prefix => 'Upload failed:';

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
  String get url_screen_desc => '请输入直播流网址';

  @override
  String get url_screen_title => '直播流网址';

  @override
  String get url_screen_url => '网址';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get video_screen_desc => '管理视频源，添加或修改检测区域。';

  @override
  String get video_sources_camera => '相机';

  @override
  String get video_sources_camera_not_found_message => '使用此功能需要相机权限。';

  @override
  String get video_sources_camera_not_found_title => '找不到相机';

  @override
  String get video_sources_file => '文件';

  @override
  String get video_sources_file_hint => '从设备中选择视频';

  @override
  String get video_sources_import_error => '无法导入视频文件。';

  @override
  String get video_sources_live_stream => '直播流网址';

  @override
  String get video_sources_load_error => '无法加载视频来源。';

  @override
  String get video_sources_photos_denied_msg => '请前往设置并允许此应用的照片访问权限。';

  @override
  String get video_sources_screen_body =>
      ' dodajte ili izmenite zone detekcije.';

  @override
  String get video_sources_screen_title => '视频来源';

  @override
  String get video_sources_webcam => '网络摄像头';

  @override
  String get wizard_screen_about => '关于';

  @override
  String get wizard_screen_language => '语言';

  @override
  String get yes => '是';
}
