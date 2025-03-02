// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationZh extends AppLocalization {
  AppLocalizationZh([String locale = 'zh']) : super(locale);

  @override
  String get product_name => '影像計數器';

  @override
  String get product_desc => 'Using computer vision and ai to count people, vehicles, pets, and more.';

  @override
  String get product_copyright => '版權所有 © 2025';

  @override
  String get video_starter_webcam => '網路攝影機';

  @override
  String get video_starter_live_stream => '直播串流網址';

  @override
  String get video_starter_file => '檔案';

  @override
  String get video_starter_camera => '相機';

  @override
  String get wizard_screen_desc => '建立新專案以開始計數。';

  @override
  String get wizard_screen_new_project_from => '從以下來源建立新專案';

  @override
  String get wizard_screen_language => '語言';

  @override
  String get wizard_screen_about => '關於';

  @override
  String get wizard_screen_open_projects_tip => '所有專案將自動儲存至本機';

  @override
  String get wizard_screen_open_projects => '開啟現有專案';

  @override
  String get language_screen_language => '語言';

  @override
  String get about_screen_title => '關於';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_app_version => '應用程式版本';

  @override
  String get about_screen_models => '模型';

  @override
  String get about_screen_benchmark => '效能測試';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 編譯資訊';

  @override
  String get benchmark_screen_title => '效能測試';

  @override
  String get benchmark_screen_recommended => '建議';

  @override
  String get benchmark_screen_fps => '每秒畫面數';

  @override
  String get benchmark_screen_start_button => '開始效能測試';

  @override
  String get benchmark_screen_start_failed => '啟動效能測試失敗，錯誤代碼為';

  @override
  String get benchmark_screen_models => '物件偵測模型';

  @override
  String get project_screen_title => '專案';

  @override
  String get project_screen_exit_confirm_title => '確認離開專案';

  @override
  String get project_screen_exit_confirm_content => '離開專案將停止計數。您確定要繼續嗎？';

  @override
  String get project_screen_exit_button => '離開';

  @override
  String get project_screen_add_video_button => '新增影片';

  @override
  String get project_screen_from_desc => '我們保留24小時的滾動記錄，因此您可以查看任何需要的時間片段。';

  @override
  String get project_screen_report_settings => '設定';

  @override
  String get filter_screen_title => '篩選';

  @override
  String get filter_screen_desc => '從下方列表選擇篩選範圍';

  @override
  String get filter_screen_error_title => '篩選';

  @override
  String get filter_screen_error_content => '結束時間必須晚於開始時間';

  @override
  String get filter_screen_error_custom => '自訂';

  @override
  String get filter_screen_error_start => '開始';

  @override
  String get filter_screen_error_end => '結束';

  @override
  String get settings_screen_title => '設定';

  @override
  String get settings_screen_desc => '設定專案名稱、偵測參數、計數清除。';

  @override
  String get settings_screen_project_id => '專案編號';

  @override
  String get settings_screen_project_name => '專案名稱';

  @override
  String get settings_screen_project_name_place_holder => '123 大道 或 公園大道';

  @override
  String get settings_screen_project_error => '專案名稱不能為空';

  @override
  String get settings_screen_detection => '偵測';

  @override
  String get settings_screen_random_count_button => '新增隨機計數';

  @override
  String get settings_screen_reset_count_header => '重設此專案中的所有計數';

  @override
  String get settings_screen_reset_count_button => '重設計數';

  @override
  String get settings_screen_reset_count_content => '您確定要重設所有計數嗎？';

  @override
  String get settings_screen_delete_header => '刪除此專案';

  @override
  String get settings_screen_delete_content => '您確定要刪除此專案嗎？';

  @override
  String get settings_screen_delete_button => '刪除';

  @override
  String get detection_screen_title => '偵測';

  @override
  String get detection_screen_models => '模型';

  @override
  String get detection_screen_confidence => '信心度';

  @override
  String get detection_screen_confidence_desc => '信心度超過 #0 被視為有效偵測';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_nms => '非極大值抑制';

  @override
  String get detection_screen_nms_desc => '#0 較低的 NMS 閾值（如 30%）將更積極地移除重疊的邊界框，而較高的 NMS 閾值（如 0.6）將允許更多重疊';

  @override
  String get detection_screen_match => '匹配';

  @override
  String get detection_screen_match_desc => '匹配超過 #0 被視為同一物體。';

  @override
  String get detection_screen_lost => '丟失';

  @override
  String get detection_screen_lost_desc => '若追蹤物體丟失 #0 秒將被移除';

  @override
  String get detection_screen_0 => '0';

  @override
  String get detection_screen_1 => '1';

  @override
  String get detection_screen_30 => '30 秒';

  @override
  String get detection_screen_consider_valid => '視為有效的時間';

  @override
  String get detection_screen_consider_valid_desc => '追蹤物體在 #0 秒後被視為有效';

  @override
  String get detection_screen_reset => '重設';

  @override
  String get detection_screen_reset_content => '您確定要重設偵測設定嗎？';

  @override
  String get url_screen_title => '直播串流網址';

  @override
  String get url_screen_desc => '請輸入直播串流網址';

  @override
  String get url_screen_url => '網址';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '新增影片';

  @override
  String get add_video_screen_from => '從以下來源新增影片';

  @override
  String get webcam_screen_add_title => '新增網路攝影機';

  @override
  String get webcam_screen_edit_title => '選擇網路攝影機';

  @override
  String get webcam_manager_webcam => '網路攝影機';

  @override
  String get camera_screen_front_camera => '後置相機';

  @override
  String get camera_screen_back_camera => '前置相機';

  @override
  String get camera_screen_add_title => '新增相機';

  @override
  String get camera_screen_edit_title => '選擇相機';

  @override
  String get camera_screen_zoom_level => '縮放等級';

  @override
  String get source_screen_desc => '管理影片來源，新增或修改偵測區域。';

  @override
  String get source_screen_video_name => '影片名稱';

  @override
  String get source_screen_edit_placeholder => '前門攝影機或停車場攝影機';

  @override
  String get source_screen_url => '目前網址';

  @override
  String get source_screen_change_file => '更換檔案';

  @override
  String get source_screen_file => '檔案';

  @override
  String get source_screen_camera => '相機';

  @override
  String get source_screen_webcam => '網路攝影機';

  @override
  String get source_screen_zones => '區域';

  @override
  String get source_screen_zones_desc => '使用拖放來調整區域';

  @override
  String get source_screen_tools => '工具';

  @override
  String get source_screen_move_bottom => '將目前區域移至底部';

  @override
  String get source_screen_add_point => '為目前區域新增點';

  @override
  String get source_screen_remove_point => '從目前區域移除點';

  @override
  String get source_screen_playback_speed => '播放速度';

  @override
  String get source_screen_playback_current => '目前： ';

  @override
  String get source_screen_playback_14x => '1/4 倍速';

  @override
  String get source_screen_playback_2x => '2 倍速';

  @override
  String get source_screen_delete_header => '刪除此影片';

  @override
  String get source_screen_delete_content => '您確定要刪除此影片嗎？';

  @override
  String get source_screen_delete_button => '刪除';

  @override
  String get color_screen_title => '選取顏色';

  @override
  String get zone_screen_desc => '區域可設定要偵測的物體類型，並選擇顯示哪些計數器，如已偵測、已出現和已進入。';

  @override
  String get zone_screen_name_placeholder => '區域的名稱，如人行道或停車場';

  @override
  String get zone_screen_zone_color => '區域顏色';

  @override
  String get zone_screen_color => '顏色';

  @override
  String get zone_screen_objects_header => '偵測物體，如人、車輛、狗等。';

  @override
  String get zone_screen_objects => '物體';

  @override
  String get zone_screen_delete_header => '刪除此區域';

  @override
  String get zone_screen_delete_content => '您確定要刪除此區域嗎？';

  @override
  String get zone_screen_delete_button => '刪除';

  @override
  String get zone_screen_can_not_delete => '無法刪除區域';

  @override
  String get zone_screen_one_zone_required => '至少需要一個區域。';

  @override
  String get zone_screen_zone_name_required => '區域名稱不能為空';

  @override
  String get counter_screen_show_on => '在螢幕上顯示';

  @override
  String get counter_screen_enabled => '已啟用';

  @override
  String get counter_screen_reentry_threshold => '重新進入閾值';

  @override
  String get counter_screen_reentry_desc => '物體必須進入 #0 次，每次離開和重新進入之間有 #1 秒的冷卻時間，才能觸發重新進入';

  @override
  String get counter_screen_reentry_title => '重新進入計數';

  @override
  String get counter_screen_cooldown_threshold => '冷卻閾值';

  @override
  String get counter_screen_cooldown_desc => '離開偵測區域後需要 #0 秒的冷卻時間才能重新進入';

  @override
  String get counter_screen_cooldown_time => '冷卻時間';

  @override
  String get counter_screen_cooldown_in_seconds => '以秒為單位';

  @override
  String get counter_screen_stagnant_threshold => '滯留閾值';

  @override
  String get counter_screen_stagnant_desc => '物體靜止超過 #0 秒將被視為滯留';

  @override
  String get counter_screen_stagnant_consider => '視為滯留';

  @override
  String get counter_screen_stagnant_in_seconds => '以秒為單位';

  @override
  String get counter_screen_stagnant_desc_prefix => '描述前綴';

  @override
  String get counter_screen_stagnant_desc_suffix => '描述後綴';

  @override
  String get counter_screen_name_error => '計數器名稱不能為空';

  @override
  String get counter_screen_enabled_error => '錯誤';

  @override
  String get counter_screen_enabled_error_content => '您需要先啟用其他計數器，然後才能停用此計數器';

  @override
  String get objects_screen_title => '物體';

  @override
  String get objects_screen_desc => '選擇偵測目標，如人、汽車、巴士等。';

  @override
  String get open_project_screen_title => '開啟專案';

  @override
  String get open_project_screen_desc => '開啟先前建立的專案，僅保留最近的20個。';

  @override
  String get open_project_screen_no_project => '找不到專案。';

  @override
  String get default_project_name => '專案';

  @override
  String get default_video_name => '影像來源';

  @override
  String get default_zone_name => '區域';

  @override
  String get submit => '提交';

  @override
  String get ok => '確定';

  @override
  String get cancel => '取消';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get close => '關閉';

  @override
  String get back => '返回';
}
