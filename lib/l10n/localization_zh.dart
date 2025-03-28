// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class LocalizationZh extends Localization {
  LocalizationZh([String locale = 'zh']) : super(locale);

  @override
  String get product_name => '計數器';

  @override
  String get product_desc => '使用電腦視覺和人工智慧來計數人員、車輛、寵物等。';

  @override
  String get product_copyright => '版權所有 © 2025';

  @override
  String get video_sources_webcam => '網路攝影機';

  @override
  String get video_sources_live_stream => '直播串流網址';

  @override
  String get video_sources_file => '檔案';

  @override
  String get video_sources_camera => '相機';

  @override
  String get video_sources_camera_not_found_title => '找不到相機';

  @override
  String get video_sources_camera_not_found_message => '使用此功能需要相機權限。';

  @override
  String get video_sources_webcam_not_found_title => '找不到網路攝影機';

  @override
  String get video_sources_webcam_not_found_message => '請確認已給予 App 存取攝影機的權限並確認網路攝影機已正確連接。';

  @override
  String get wizard_screen_desc => '建立新專案以開始計數。';

  @override
  String get wizard_screen_new_project_from => '從以下創建新專案';

  @override
  String get wizard_screen_language => '語言';

  @override
  String get wizard_screen_about => '關於';

  @override
  String get wizard_screen_open_projects_tip => '所有專案將自動保存在本機';

  @override
  String get wizard_screen_open_projects => '開啟現有專案';

  @override
  String get wizard_screen_email_us => '寫信給我們';

  @override
  String get language_screen_language => '語言';

  @override
  String get project_view_no_videos => '沒有影像來源。';

  @override
  String get about_screen_title => '關於';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_app_version => '應用程式版本';

  @override
  String get about_screen_models => '物體偵測模型';

  @override
  String get about_screen_benchmark => '基準測試';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 構建資訊';

  @override
  String get benchmark_screen_title => '模型基準測試';

  @override
  String get benchmark_screen_recommended => '推薦模型';

  @override
  String get benchmark_screen_fps => '每秒畫面數';

  @override
  String get benchmark_screen_start_button => '開始基準測試';

  @override
  String get benchmark_screen_start_failed => '基準測試啟動失敗，錯誤代碼為';

  @override
  String get benchmark_screen_models => '物體偵測模型';

  @override
  String get project_screen_title => '專案';

  @override
  String get project_screen_exit_confirm_title => '確認退出專案';

  @override
  String get project_screen_exit_confirm_content => '離開專案將停止計數。您確定要繼續嗎？';

  @override
  String get project_screen_exit_button => '退出';

  @override
  String get project_screen_add_video_button => '新增影片來源';

  @override
  String get project_screen_from_desc => '我們保留連續 24 小時的記錄，因此您可以查看任何需要的時間片段。';

  @override
  String get project_screen_report_settings => '設定';

  @override
  String get filter_screen_title => '篩選';

  @override
  String get filter_screen_desc => '從下列清單中選擇篩選範圍';

  @override
  String get filter_screen_error_title => '篩選';

  @override
  String get filter_screen_error_content => '結束時間必須大於開始時間';

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
  String get settings_screen_project_id => '專案 ID';

  @override
  String get settings_screen_project_name => '專案名稱';

  @override
  String get settings_screen_project_name_place_holder => '123 大同路 或 中正公園';

  @override
  String get settings_screen_project_error => '專案名稱不能為空';

  @override
  String get settings_screen_random_count_button => '新增隨機計數';

  @override
  String get settings_screen_reset_count_header => '重置此專案中的所有計數';

  @override
  String get settings_screen_reset_count_button => '重置計數';

  @override
  String get settings_screen_reset_count_content => '您確定要重置所有計數嗎？';

  @override
  String get settings_screen_delete_header => '刪除此專案';

  @override
  String get settings_screen_delete_content => '您確定要刪除此專案嗎？';

  @override
  String get settings_screen_delete_button => '刪除';

  @override
  String get settings_screen_center_point_title => '目標中心點';

  @override
  String get settings_screen_center_point_desc => '中心點可幫助判斷目標是否位於命中區域內。';

  @override
  String get settings_screen_center_point_button => '顯示目標中心點';

  @override
  String get settings_screen_lost_target_title => '遺失目標';

  @override
  String get settings_screen_lost_target_desc => '當物件追蹤遺失目標時，啟用此選項可顯示遺失的目標。預設情況下，遺失目標不會顯示。';

  @override
  String get settings_screen_lost_target_button => '顯示遺失目標';

  @override
  String get detection_screen_title => '偵測設定';

  @override
  String get detection_screen_models => '模型';

  @override
  String get detection_screen_confidence => '置信度';

  @override
  String get detection_screen_confidence_desc => '置信度高於 #0 視為有效偵測';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_nms => '非極大值抑制';

  @override
  String get detection_screen_nms_desc => '#0 較低的 NMS 閾值（例如 30%）將更積極地移除重疊的邊界框，而較高的 NMS 閾值（例如 0.6）將允許更多重疊';

  @override
  String get detection_screen_match => '匹配';

  @override
  String get detection_screen_match_desc => '匹配度超過 #0 視為同一物體。';

  @override
  String get detection_screen_lost => '丟失';

  @override
  String get detection_screen_lost_desc => '如果物體丟失 #0，追蹤物體將被移除';

  @override
  String get detection_screen_consider_valid => '視為有效時間';

  @override
  String get detection_screen_consider_valid_desc => '追蹤物體在 #0 後視為有效';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您確定要重置偵測設定嗎？';

  @override
  String get url_screen_title => '即時串流網址';

  @override
  String get url_screen_desc => '請輸入即時串流網址';

  @override
  String get url_screen_url => '網址';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '新增影片來源';

  @override
  String get add_video_screen_from => '從以下來源新增影片';

  @override
  String get webcam_screen_add_title => '新增網路攝影機';

  @override
  String get webcam_screen_edit_title => '選擇網路攝影機';

  @override
  String get webcam_manager_webcam => '網路攝影機';

  @override
  String get camera_screen_front_camera => '前置相機';

  @override
  String get camera_screen_back_camera => '後置相機';

  @override
  String get camera_screen_add_title => '新增相機';

  @override
  String get camera_screen_edit_title => '選擇相機';

  @override
  String get camera_screen_zoom_level => '縮放級別';

  @override
  String get video_screen_name_empty => '影片來源名稱不能為空。';

  @override
  String get video_screen_desc => '管理影片來源，新增或修改偵測區域。';

  @override
  String get video_screen_video_name => '影片來源名稱';

  @override
  String get video_screen_edit_placeholder => '前門攝影機或停車場攝影機';

  @override
  String get video_screen_change_file => '更改檔案';

  @override
  String get video_screen_add_zone => '新增偵測區域';

  @override
  String get video_screen_zones => '偵測區域';

  @override
  String get video_screen_zones_desc => '使用拖放調整區域';

  @override
  String get video_screen_tools => '工具';

  @override
  String get video_screen_move_bottom => '將目前區域移至底部';

  @override
  String get video_screen_add_point => '向目前區域新增點';

  @override
  String get video_screen_remove_point => '從目前區域移除點';

  @override
  String get video_screen_playback_speed => '播放速度';

  @override
  String get video_screen_playback_current => '目前: ';

  @override
  String get video_screen_playback_14x => '1/4倍速';

  @override
  String get video_screen_playback_2x => '2倍速';

  @override
  String get video_screen_delete_header => '刪除此影片來源';

  @override
  String get video_screen_delete_content => '您確定要刪除此影片來源嗎？';

  @override
  String get video_screen_delete_button => '刪除';

  @override
  String get video_screen_sources => '設定影像來源、偵測目標及模型參數';

  @override
  String get video_screen_targets => '偵測目標';

  @override
  String get video_screen_detection => '模型參數';

  @override
  String get color_screen_title => '選擇顏色';

  @override
  String get zone_screen_desc => '偵測區域可以設定要偵測的物體類型，並選擇要顯示的計數器，如已偵測、已產生和已進入。';

  @override
  String get zone_screen_name_placeholder => '區域名稱，如人行道或停車場';

  @override
  String get zone_screen_zone_color => '區域顏色';

  @override
  String get zone_screen_color => '顏色';

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
  String get counter_screen_reentry_desc => '物體必須進入 #0 次，每次退出和重新進入之間有 #1 秒冷卻時間，才能觸發重新進入';

  @override
  String get counter_screen_reentry_title => '重新進入計數';

  @override
  String get counter_screen_cooldown_threshold => '冷卻閾值';

  @override
  String get counter_screen_cooldown_desc => '重新進入需要在離開偵測區域後有 #0 秒的冷卻時間';

  @override
  String get counter_screen_cooldown_time => '冷卻時間';

  @override
  String get counter_screen_cooldown_in_seconds => '單位：秒';

  @override
  String get counter_screen_stagnant_threshold => '停滯閾值';

  @override
  String get counter_screen_stagnant_desc => '物體靜止超過 #0 秒將被視為停滯';

  @override
  String get counter_screen_stagnant_consider => '視為停滯';

  @override
  String get counter_screen_stagnant_in_seconds => '單位：秒';

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
  String get objects_screen_desc => '選擇偵測目標，如人員、汽車、公車等。';

  @override
  String get open_project_screen_title => '開啟專案';

  @override
  String get open_project_screen_desc => '開啟先前創建的專案，僅保留最近的 20 個。';

  @override
  String get open_project_screen_no_project => '未找到專案。';

  @override
  String get default_project_name => '專案';

  @override
  String get default_video_name => '影片來源';

  @override
  String get default_zone_name => '偵測區域';

  @override
  String get error_oops => '糟糕，出了點問題';

  @override
  String get error_content => '發生了意外錯誤。您要提交電子郵件報告嗎？';

  @override
  String get error_report => '寄信給我們';

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

  @override
  String get zone_screen_zone => '區域';

  @override
  String get zone_screen_zone_show_summary => '在螢幕上顯示總結';

  @override
  String get video_sources_photos_denied => '相片存取被拒';

  @override
  String get video_sources_photos_goto_settings => '前往設定';

  @override
  String get video_sources_camera_denied => '相機存取被拒';

  @override
  String get video_sources_photos_denied_msg => '請前往設定並允許此應用程式的相片存取權限。';

  @override
  String get video_sources_camera_denied_msg => '請前往設定並允許此應用程式的相機存取權限。';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class LocalizationZhCn extends LocalizationZh {
  LocalizationZhCn(): super('zh_CN');

  @override
  String get product_name => '计数器';

  @override
  String get product_desc => '使用计算机视觉和人工智能来计数人员、车辆、宠物等。';

  @override
  String get product_copyright => '版权所有 © 2025';

  @override
  String get video_sources_webcam => '网络摄像头';

  @override
  String get video_sources_live_stream => '直播流网址';

  @override
  String get video_sources_file => '文件';

  @override
  String get video_sources_camera => '相机';

  @override
  String get video_sources_camera_not_found_title => '找不到相机';

  @override
  String get video_sources_camera_not_found_message => '使用此功能需要相机权限。';

  @override
  String get video_sources_webcam_not_found_title => '找不到网络摄像头';

  @override
  String get video_sources_webcam_not_found_message => '请确认已给予 App 访问摄像头的权限并确认网络摄像头已正确连接。';

  @override
  String get wizard_screen_desc => '创建新项目以开始计数。';

  @override
  String get wizard_screen_new_project_from => '从以下创建新项目';

  @override
  String get wizard_screen_language => '语言';

  @override
  String get wizard_screen_about => '关于';

  @override
  String get wizard_screen_open_projects_tip => '所有项目将自动保存在本地';

  @override
  String get wizard_screen_open_projects => '打开现有项目';

  @override
  String get wizard_screen_email_us => '发邮件给我们';

  @override
  String get language_screen_language => '语言';

  @override
  String get project_view_no_videos => '没有视频源。';

  @override
  String get about_screen_title => '关于';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_app_version => '应用程序版本';

  @override
  String get about_screen_models => '物体检测模型';

  @override
  String get about_screen_benchmark => '基准测试';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 构建信息';

  @override
  String get benchmark_screen_title => '模型基准测试';

  @override
  String get benchmark_screen_recommended => '推荐模型';

  @override
  String get benchmark_screen_fps => '每秒帧数';

  @override
  String get benchmark_screen_start_button => '开始基准测试';

  @override
  String get benchmark_screen_start_failed => '基准测试启动失败，错误代码为';

  @override
  String get benchmark_screen_models => '物体检测模型';

  @override
  String get project_screen_title => '项目';

  @override
  String get project_screen_exit_confirm_title => '确认退出项目';

  @override
  String get project_screen_exit_confirm_content => '离开项目将停止计数。您确定要继续吗？';

  @override
  String get project_screen_exit_button => '退出';

  @override
  String get project_screen_add_video_button => '添加视频源';

  @override
  String get project_screen_from_desc => '我们保留连续 24 小时的记录，因此您可以查看任何需要的时间片段。';

  @override
  String get project_screen_report_settings => '设置';

  @override
  String get filter_screen_title => '筛选';

  @override
  String get filter_screen_desc => '从下列列表中选择筛选范围';

  @override
  String get filter_screen_error_title => '筛选';

  @override
  String get filter_screen_error_content => '结束时间必须大于开始时间';

  @override
  String get filter_screen_error_custom => '自定义';

  @override
  String get filter_screen_error_start => '开始';

  @override
  String get filter_screen_error_end => '结束';

  @override
  String get settings_screen_title => '设置';

  @override
  String get settings_screen_desc => '设置项目名称、检测参数、计数清除。';

  @override
  String get settings_screen_project_id => '项目 ID';

  @override
  String get settings_screen_project_name => '项目名称';

  @override
  String get settings_screen_project_name_place_holder => '123 人民路 或 中山公园';

  @override
  String get settings_screen_project_error => '项目名称不能为空';

  @override
  String get settings_screen_random_count_button => '添加随机计数';

  @override
  String get settings_screen_reset_count_header => '重置此项目中的所有计数';

  @override
  String get settings_screen_reset_count_button => '重置计数';

  @override
  String get settings_screen_reset_count_content => '您确定要重置所有计数吗？';

  @override
  String get settings_screen_delete_header => '删除此项目';

  @override
  String get settings_screen_delete_content => '您确定要删除此项目吗？';

  @override
  String get settings_screen_delete_button => '删除';

  @override
  String get settings_screen_center_point_title => '目标中心点';

  @override
  String get settings_screen_center_point_desc => '中心点可帮助判断目标是否位于命中区域内。';

  @override
  String get settings_screen_center_point_button => '显示目标中心点';

  @override
  String get settings_screen_lost_target_title => '丢失目标';

  @override
  String get settings_screen_lost_target_desc => '当物体跟踪丢失目标时，启用此选项可显示丢失的目标。默认情况下，丢失目标不会显示。';

  @override
  String get settings_screen_lost_target_button => '显示丢失目标';

  @override
  String get detection_screen_title => '检测设置';

  @override
  String get detection_screen_models => '模型';

  @override
  String get detection_screen_confidence => '置信度';

  @override
  String get detection_screen_confidence_desc => '置信度高于 #0 视为有效检测';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_nms => '非极大值抑制';

  @override
  String get detection_screen_nms_desc => '#0 较低的 NMS 阈值（例如 30%）将更积极地移除重叠的边界框，而较高的 NMS 阈值（例如 0.6）将允许更多重叠';

  @override
  String get detection_screen_match => '匹配';

  @override
  String get detection_screen_match_desc => '匹配度超过 #0 视为同一物体。';

  @override
  String get detection_screen_lost => '丢失';

  @override
  String get detection_screen_lost_desc => '如果物体丢失 #0，跟踪物体将被移除';

  @override
  String get detection_screen_consider_valid => '视为有效时间';

  @override
  String get detection_screen_consider_valid_desc => '跟踪物体在 #0 后视为有效';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您确定要重置检测设置吗？';

  @override
  String get url_screen_title => '直播流网址';

  @override
  String get url_screen_desc => '请输入直播流网址';

  @override
  String get url_screen_url => '网址';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '添加视频源';

  @override
  String get add_video_screen_from => '从以下来源添加视频';

  @override
  String get webcam_screen_add_title => '添加网络摄像头';

  @override
  String get webcam_screen_edit_title => '选择网络摄像头';

  @override
  String get webcam_manager_webcam => '网络摄像头';

  @override
  String get camera_screen_front_camera => '前置相机';

  @override
  String get camera_screen_back_camera => '后置相机';

  @override
  String get camera_screen_add_title => '添加相机';

  @override
  String get camera_screen_edit_title => '选择相机';

  @override
  String get camera_screen_zoom_level => '缩放级别';

  @override
  String get video_screen_name_empty => '视频源名称不能为空。';

  @override
  String get video_screen_desc => '管理视频源，添加或修改检测区域。';

  @override
  String get video_screen_video_name => '视频源名称';

  @override
  String get video_screen_edit_placeholder => '前门摄像头或停车场摄像头';

  @override
  String get video_screen_change_file => '更改文件';

  @override
  String get video_screen_add_zone => '添加检测区域';

  @override
  String get video_screen_zones => '检测区域';

  @override
  String get video_screen_zones_desc => '使用拖放调整区域';

  @override
  String get video_screen_tools => '工具';

  @override
  String get video_screen_move_bottom => '将当前区域移至底部';

  @override
  String get video_screen_add_point => '向当前区域添加点';

  @override
  String get video_screen_remove_point => '从当前区域移除点';

  @override
  String get video_screen_playback_speed => '播放速度';

  @override
  String get video_screen_playback_current => '当前: ';

  @override
  String get video_screen_playback_14x => '1/4倍速';

  @override
  String get video_screen_playback_2x => '2倍速';

  @override
  String get video_screen_delete_header => '删除此视频源';

  @override
  String get video_screen_delete_content => '您确定要删除此视频源吗？';

  @override
  String get video_screen_delete_button => '删除';

  @override
  String get video_screen_sources => '配置图像源、检测目标及模型参数';

  @override
  String get video_screen_targets => '检测目标';

  @override
  String get video_screen_detection => '模型参数';

  @override
  String get color_screen_title => '选择颜色';

  @override
  String get zone_screen_desc => '检测区域可以设置要检测的物体类型，并选择要显示的计数器，如已检测、已生成和已进入。';

  @override
  String get zone_screen_name_placeholder => '区域名称，如人行道或停车场';

  @override
  String get zone_screen_zone_color => '区域颜色';

  @override
  String get zone_screen_color => '颜色';

  @override
  String get zone_screen_delete_header => '删除此区域';

  @override
  String get zone_screen_delete_content => '您确定要删除此区域吗？';

  @override
  String get zone_screen_delete_button => '删除';

  @override
  String get zone_screen_can_not_delete => '无法删除区域';

  @override
  String get zone_screen_one_zone_required => '至少需要一个区域。';

  @override
  String get zone_screen_zone_name_required => '区域名称不能为空';

  @override
  String get counter_screen_show_on => '在屏幕上显示';

  @override
  String get counter_screen_enabled => '已启用';

  @override
  String get counter_screen_reentry_threshold => '重新进入阈值';

  @override
  String get counter_screen_reentry_desc => '物体必须进入 #0 次，每次退出和重新进入之间有 #1 秒冷却时间，才能触发重新进入';

  @override
  String get counter_screen_reentry_title => '重新进入计数';

  @override
  String get counter_screen_cooldown_threshold => '冷却阈值';

  @override
  String get counter_screen_cooldown_desc => '重新进入需要在离开检测区域后有 #0 秒的冷却时间';

  @override
  String get counter_screen_cooldown_time => '冷却时间';

  @override
  String get counter_screen_cooldown_in_seconds => '单位：秒';

  @override
  String get counter_screen_stagnant_threshold => '停滞阈值';

  @override
  String get counter_screen_stagnant_desc => '物体静止超过 #0 秒将被视为停滞';

  @override
  String get counter_screen_stagnant_consider => '视为停滞';

  @override
  String get counter_screen_stagnant_in_seconds => '单位：秒';

  @override
  String get counter_screen_stagnant_desc_prefix => '描述前缀';

  @override
  String get counter_screen_stagnant_desc_suffix => '描述后缀';

  @override
  String get counter_screen_name_error => '计数器名称不能为空';

  @override
  String get counter_screen_enabled_error => '错误';

  @override
  String get counter_screen_enabled_error_content => '您需要先启用其他计数器，然后才能禁用此计数器';

  @override
  String get objects_screen_title => '物体';

  @override
  String get objects_screen_desc => '选择检测目标，如人员、汽车、公交车等。';

  @override
  String get open_project_screen_title => '打开项目';

  @override
  String get open_project_screen_desc => '打开先前创建的项目，仅保留最近的 20 个。';

  @override
  String get open_project_screen_no_project => '未找到项目。';

  @override
  String get default_project_name => '项目';

  @override
  String get default_video_name => '视频源';

  @override
  String get default_zone_name => '检测区域';

  @override
  String get error_oops => '抱歉，出现了问题';

  @override
  String get error_content => '发生了意外错误。您要提交电子邮件报告吗？';

  @override
  String get error_report => '发邮件给我们';

  @override
  String get submit => '提交';

  @override
  String get ok => '确定';

  @override
  String get cancel => '取消';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get close => '关闭';

  @override
  String get back => '返回';

  @override
  String get zone_screen_zone => '区域';

  @override
  String get zone_screen_zone_show_summary => '在屏幕上显示摘要';

  @override
  String get video_sources_photos_denied => '照片访问被拒绝';

  @override
  String get video_sources_photos_goto_settings => '前往设置';

  @override
  String get video_sources_camera_denied => '摄像头访问被拒绝';

  @override
  String get video_sources_photos_denied_msg => '请前往设置并允许此应用的照片访问权限。';

  @override
  String get video_sources_camera_denied_msg => '请前往设置并允许此应用的相机访问权限。';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class LocalizationZhHk extends LocalizationZh {
  LocalizationZhHk(): super('zh_HK');

  @override
  String get product_name => '計數器';

  @override
  String get product_desc => '使用電腦視覺和人工智能來計數人員、車輛、寵物等。';

  @override
  String get product_copyright => '版權所有 © 2025';

  @override
  String get video_sources_webcam => '網絡攝影機';

  @override
  String get video_sources_live_stream => '直播串流網址';

  @override
  String get video_sources_file => '檔案';

  @override
  String get video_sources_camera => '相機';

  @override
  String get video_sources_camera_not_found_title => '找不到相機';

  @override
  String get video_sources_camera_not_found_message => '使用此功能需要相機權限。';

  @override
  String get video_sources_webcam_not_found_title => '找不到網絡攝影機';

  @override
  String get video_sources_webcam_not_found_message => '請確認已給予 App 存取攝影機的權限並確認網絡攝影機已正確連接。';

  @override
  String get wizard_screen_desc => '建立新項目以開始計數。';

  @override
  String get wizard_screen_new_project_from => '從以下創建新項目';

  @override
  String get wizard_screen_language => '語言';

  @override
  String get wizard_screen_about => '關於';

  @override
  String get wizard_screen_open_projects_tip => '所有項目將自動保存在本機';

  @override
  String get wizard_screen_open_projects => '開啟現有項目';

  @override
  String get wizard_screen_email_us => '電郵聯絡我們';

  @override
  String get language_screen_language => '語言';

  @override
  String get project_view_no_videos => '沒有影像來源。';

  @override
  String get about_screen_title => '關於';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_app_version => '應用程式版本';

  @override
  String get about_screen_models => '物體偵測模型';

  @override
  String get about_screen_benchmark => '基準測試';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 構建資訊';

  @override
  String get benchmark_screen_title => '模型基準測試';

  @override
  String get benchmark_screen_recommended => '建議模型';

  @override
  String get benchmark_screen_fps => '每秒畫面數';

  @override
  String get benchmark_screen_start_button => '開始基準測試';

  @override
  String get benchmark_screen_start_failed => '基準測試啟動失敗，錯誤代碼為';

  @override
  String get benchmark_screen_models => '物體偵測模型';

  @override
  String get project_screen_title => '項目';

  @override
  String get project_screen_exit_confirm_title => '確認退出項目';

  @override
  String get project_screen_exit_confirm_content => '離開項目將停止計數。您確定要繼續嗎？';

  @override
  String get project_screen_exit_button => '退出';

  @override
  String get project_screen_add_video_button => '新增影片來源';

  @override
  String get project_screen_from_desc => '我們保留連續 24 小時的記錄，因此您可以查看任何需要的時間片段。';

  @override
  String get project_screen_report_settings => '設定';

  @override
  String get filter_screen_title => '篩選';

  @override
  String get filter_screen_desc => '從下列列表中選擇篩選範圍';

  @override
  String get filter_screen_error_title => '篩選';

  @override
  String get filter_screen_error_content => '結束時間必須大於開始時間';

  @override
  String get filter_screen_error_custom => '自訂';

  @override
  String get filter_screen_error_start => '開始';

  @override
  String get filter_screen_error_end => '結束';

  @override
  String get settings_screen_title => '設定';

  @override
  String get settings_screen_desc => '設定項目名稱、偵測參數、計數清除。';

  @override
  String get settings_screen_project_id => '項目 ID';

  @override
  String get settings_screen_project_name => '項目名稱';

  @override
  String get settings_screen_project_name_place_holder => '123 彌敦道 或 維多利亞公園';

  @override
  String get settings_screen_project_error => '項目名稱不能為空';

  @override
  String get settings_screen_random_count_button => '新增隨機計數';

  @override
  String get settings_screen_reset_count_header => '重置此項目中的所有計數';

  @override
  String get settings_screen_reset_count_button => '重置計數';

  @override
  String get settings_screen_reset_count_content => '您確定要重置所有計數嗎？';

  @override
  String get settings_screen_delete_header => '刪除此項目';

  @override
  String get settings_screen_delete_content => '您確定要刪除此項目嗎？';

  @override
  String get settings_screen_delete_button => '刪除';

  @override
  String get settings_screen_center_point_title => '目標中心點';

  @override
  String get settings_screen_center_point_desc => '中心點可幫助判斷目標是否位於命中區域內。';

  @override
  String get settings_screen_center_point_button => '顯示目標中心點';

  @override
  String get settings_screen_lost_target_title => '遺失目標';

  @override
  String get settings_screen_lost_target_desc => '當物件追蹤遺失目標時，啟用此選項可顯示遺失的目標。預設情況下，遺失目標不會顯示。';

  @override
  String get settings_screen_lost_target_button => '顯示遺失目標';

  @override
  String get detection_screen_title => '偵測設定';

  @override
  String get detection_screen_models => '模型';

  @override
  String get detection_screen_confidence => '置信度';

  @override
  String get detection_screen_confidence_desc => '置信度高於 #0 視為有效偵測';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_nms => '非極大值抑制';

  @override
  String get detection_screen_nms_desc => '#0 較低的 NMS 閾值（例如 30%）將更積極地移除重疊的邊界框，而較高的 NMS 閾值（例如 0.6）將允許更多重疊';

  @override
  String get detection_screen_match => '匹配';

  @override
  String get detection_screen_match_desc => '匹配度超過 #0 視為同一物體。';

  @override
  String get detection_screen_lost => '丟失';

  @override
  String get detection_screen_lost_desc => '如果物體丟失 #0，追蹤物體將被移除';

  @override
  String get detection_screen_consider_valid => '視為有效時間';

  @override
  String get detection_screen_consider_valid_desc => '追蹤物體在 #0 後視為有效';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您確定要重置偵測設定嗎？';

  @override
  String get url_screen_title => '即時串流網址';

  @override
  String get url_screen_desc => '請輸入即時串流網址';

  @override
  String get url_screen_url => '網址';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '新增影片來源';

  @override
  String get add_video_screen_from => '從以下來源新增影片';

  @override
  String get webcam_screen_add_title => '新增網絡攝影機';

  @override
  String get webcam_screen_edit_title => '選擇網絡攝影機';

  @override
  String get webcam_manager_webcam => '網絡攝影機';

  @override
  String get camera_screen_front_camera => '前置相機';

  @override
  String get camera_screen_back_camera => '後置相機';

  @override
  String get camera_screen_add_title => '新增相機';

  @override
  String get camera_screen_edit_title => '選擇相機';

  @override
  String get camera_screen_zoom_level => '縮放級別';

  @override
  String get video_screen_name_empty => '影片來源名稱不能為空。';

  @override
  String get video_screen_desc => '管理影片來源，新增或修改偵測區域。';

  @override
  String get video_screen_video_name => '影片來源名稱';

  @override
  String get video_screen_edit_placeholder => '前門攝影機或停車場攝影機';

  @override
  String get video_screen_change_file => '更改檔案';

  @override
  String get video_screen_add_zone => '新增偵測區域';

  @override
  String get video_screen_zones => '偵測區域';

  @override
  String get video_screen_zones_desc => '使用拖放調整區域';

  @override
  String get video_screen_tools => '工具';

  @override
  String get video_screen_move_bottom => '將目前區域移至底部';

  @override
  String get video_screen_add_point => '向目前區域新增點';

  @override
  String get video_screen_remove_point => '從目前區域移除點';

  @override
  String get video_screen_playback_speed => '播放速度';

  @override
  String get video_screen_playback_current => '目前: ';

  @override
  String get video_screen_playback_14x => '1/4倍速';

  @override
  String get video_screen_playback_2x => '2倍速';

  @override
  String get video_screen_delete_header => '刪除此影片來源';

  @override
  String get video_screen_delete_content => '您確定要刪除此影片來源嗎？';

  @override
  String get video_screen_delete_button => '刪除';

  @override
  String get video_screen_sources => '設定影像來源、偵測目標及模型參數';

  @override
  String get video_screen_targets => '偵測目標';

  @override
  String get video_screen_detection => '模型參數';

  @override
  String get color_screen_title => '選擇顏色';

  @override
  String get zone_screen_desc => '偵測區域可以設定要偵測的物體類型，並選擇要顯示的計數器，如已偵測、已產生和已進入。';

  @override
  String get zone_screen_name_placeholder => '區域名稱，如行人路或停車場';

  @override
  String get zone_screen_zone_color => '區域顏色';

  @override
  String get zone_screen_color => '顏色';

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
  String get counter_screen_reentry_desc => '物體必須進入 #0 次，每次退出和重新進入之間有 #1 秒冷卻時間，才能觸發重新進入';

  @override
  String get counter_screen_reentry_title => '重新進入計數';

  @override
  String get counter_screen_cooldown_threshold => '冷卻閾值';

  @override
  String get counter_screen_cooldown_desc => '重新進入需要在離開偵測區域後有 #0 秒的冷卻時間';

  @override
  String get counter_screen_cooldown_time => '冷卻時間';

  @override
  String get counter_screen_cooldown_in_seconds => '單位：秒';

  @override
  String get counter_screen_stagnant_threshold => '停滯閾值';

  @override
  String get counter_screen_stagnant_desc => '物體靜止超過 #0 秒將被視為停滯';

  @override
  String get counter_screen_stagnant_consider => '視為停滯';

  @override
  String get counter_screen_stagnant_in_seconds => '單位：秒';

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
  String get objects_screen_desc => '選擇偵測目標，如人員、汽車、巴士等。';

  @override
  String get open_project_screen_title => '開啟項目';

  @override
  String get open_project_screen_desc => '開啟先前創建的項目，僅保留最近的 20 個。';

  @override
  String get open_project_screen_no_project => '未找到項目。';

  @override
  String get default_project_name => '項目';

  @override
  String get default_video_name => '影片來源';

  @override
  String get default_zone_name => '偵測區域';

  @override
  String get error_oops => '糟糕，出了點問題';

  @override
  String get error_content => '發生了意外錯誤。您要提交電子郵件報告嗎？';

  @override
  String get error_report => '電郵聯絡我們';

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

  @override
  String get zone_screen_zone => '區域';

  @override
  String get zone_screen_zone_show_summary => '在螢幕上顯示摘要';

  @override
  String get video_sources_photos_denied => '相片存取被拒';

  @override
  String get video_sources_photos_goto_settings => '前往設定';

  @override
  String get video_sources_camera_denied => '相機存取被拒';

  @override
  String get video_sources_photos_denied_msg => '請前往設定並允許此應用程式的相片存取權限。';

  @override
  String get video_sources_camera_denied_msg => '請前往設定並允許此應用程式的相機存取權限。';
}

/// The translations for Chinese, as used in Macao (`zh_MO`).
class LocalizationZhMo extends LocalizationZh {
  LocalizationZhMo(): super('zh_MO');

  @override
  String get product_name => '計數器';

  @override
  String get product_desc => '使用電腦視覺同人工智能來計數人員、車輛、寵物等。';

  @override
  String get product_copyright => '版權所有 © 2025';

  @override
  String get video_sources_webcam => '網絡攝影機';

  @override
  String get video_sources_live_stream => '直播串流網址';

  @override
  String get video_sources_file => '檔案';

  @override
  String get video_sources_camera => '相機';

  @override
  String get video_sources_camera_not_found_title => '搵唔到相機';

  @override
  String get video_sources_camera_not_found_message => '使用相機需要授權權限。';

  @override
  String get video_sources_webcam_not_found_title => '搵唔到網絡攝影機';

  @override
  String get video_sources_webcam_not_found_message => '請確認已給予 App 存取攝影機的權限並確認網絡攝影機已正確連接。';

  @override
  String get wizard_screen_desc => '建立新項目開始計數。';

  @override
  String get wizard_screen_new_project_from => '由以下創建新項目';

  @override
  String get wizard_screen_language => '語言';

  @override
  String get wizard_screen_about => '關於';

  @override
  String get wizard_screen_open_projects_tip => '所有項目會自動保存喺本機';

  @override
  String get wizard_screen_open_projects => '開啟現有項目';

  @override
  String get wizard_screen_email_us => '電郵聯絡我們';

  @override
  String get language_screen_language => '語言';

  @override
  String get project_view_no_videos => '冇影像來源。';

  @override
  String get about_screen_title => '關於';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_app_version => '應用程式版本';

  @override
  String get about_screen_models => '物體偵測模型';

  @override
  String get about_screen_benchmark => '基準測試';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 構建資訊';

  @override
  String get benchmark_screen_title => '模型基準測試';

  @override
  String get benchmark_screen_recommended => '推薦模型';

  @override
  String get benchmark_screen_fps => '每秒畫面數';

  @override
  String get benchmark_screen_start_button => '開始基準測試';

  @override
  String get benchmark_screen_start_failed => '基準測試啟動失敗，錯誤代碼為';

  @override
  String get benchmark_screen_models => '物體偵測模型';

  @override
  String get project_screen_title => '項目';

  @override
  String get project_screen_exit_confirm_title => '確認退出項目';

  @override
  String get project_screen_exit_confirm_content => '離開項目將停止計數。你確定要繼續嗎？';

  @override
  String get project_screen_exit_button => '退出';

  @override
  String get project_screen_add_video_button => '新增影片來源';

  @override
  String get project_screen_from_desc => '我哋保留連續24小時嘅記錄，因此你可以查看任何需要嘅時間片段。';

  @override
  String get project_screen_report_settings => '設定';

  @override
  String get filter_screen_title => '篩選';

  @override
  String get filter_screen_desc => '從下列清單中選擇篩選範圍';

  @override
  String get filter_screen_error_title => '篩選';

  @override
  String get filter_screen_error_content => '結束時間必須大於開始時間';

  @override
  String get filter_screen_error_custom => '自訂';

  @override
  String get filter_screen_error_start => '開始';

  @override
  String get filter_screen_error_end => '結束';

  @override
  String get settings_screen_title => '設定';

  @override
  String get settings_screen_desc => '設定項目名稱、偵測參數、計數清除。';

  @override
  String get settings_screen_project_id => '項目 ID';

  @override
  String get settings_screen_project_name => '項目名稱';

  @override
  String get settings_screen_project_name_place_holder => '123 新馬路 或 白鴿巢公園';

  @override
  String get settings_screen_project_error => '項目名稱唔可以為空';

  @override
  String get settings_screen_random_count_button => '新增隨機計數';

  @override
  String get settings_screen_reset_count_header => '重置此項目中嘅所有計數';

  @override
  String get settings_screen_reset_count_button => '重置計數';

  @override
  String get settings_screen_reset_count_content => '你確定要重置所有計數嗎？';

  @override
  String get settings_screen_delete_header => '刪除此項目';

  @override
  String get settings_screen_delete_content => '你確定要刪除此項目嗎？';

  @override
  String get settings_screen_delete_button => '刪除';

  @override
  String get settings_screen_center_point_title => '目標中心點';

  @override
  String get settings_screen_center_point_desc => '中心點可幫助判斷目標是否位於命中區域內。';

  @override
  String get settings_screen_center_point_button => '顯示目標中心點';

  @override
  String get settings_screen_lost_target_title => '遺失目標';

  @override
  String get settings_screen_lost_target_desc => '當物件追蹤遺失目標時，啟用此選項可顯示遺失嘅目標。預設情況下，遺失目標唔會顯示。';

  @override
  String get settings_screen_lost_target_button => '顯示遺失目標';

  @override
  String get detection_screen_title => '偵測設定';

  @override
  String get detection_screen_models => '模型';

  @override
  String get detection_screen_confidence => '置信度';

  @override
  String get detection_screen_confidence_desc => '置信度高於 #0 視為有效偵測';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_nms => '非極大值抑制';

  @override
  String get detection_screen_nms_desc => '#0 較低嘅 NMS 閾值（例如 30%）會更積極咁移除重疊嘅邊界框，而較高嘅 NMS 閾值（例如 0.6）會允許更多重疊';

  @override
  String get detection_screen_match => '匹配';

  @override
  String get detection_screen_match_desc => '匹配度超過 #0 視為同一物體。';

  @override
  String get detection_screen_lost => '丟失';

  @override
  String get detection_screen_lost_desc => '如果物體丟失 #0，追蹤物體將被移除';

  @override
  String get detection_screen_consider_valid => '視為有效時間';

  @override
  String get detection_screen_consider_valid_desc => '追蹤物體喺 #0 後視為有效';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '你確定要重置偵測設定嗎？';

  @override
  String get url_screen_title => '即時串流網址';

  @override
  String get url_screen_desc => '請輸入即時串流網址';

  @override
  String get url_screen_url => '網址';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '新增影片來源';

  @override
  String get add_video_screen_from => '從以下來源新增影片';

  @override
  String get webcam_screen_add_title => '新增網絡攝影機';

  @override
  String get webcam_screen_edit_title => '選擇網絡攝影機';

  @override
  String get webcam_manager_webcam => '網絡攝影機';

  @override
  String get camera_screen_front_camera => '前置相機';

  @override
  String get camera_screen_back_camera => '後置相機';

  @override
  String get camera_screen_add_title => '新增相機';

  @override
  String get camera_screen_edit_title => '選擇相機';

  @override
  String get camera_screen_zoom_level => '縮放級別';

  @override
  String get video_screen_name_empty => '影片來源名稱唔可以為空。';

  @override
  String get video_screen_desc => '管理影片來源，新增或修改偵測區域。';

  @override
  String get video_screen_video_name => '影片來源名稱';

  @override
  String get video_screen_edit_placeholder => '前門攝影機或停車場攝影機';

  @override
  String get video_screen_change_file => '更改檔案';

  @override
  String get video_screen_add_zone => '新增偵測區域';

  @override
  String get video_screen_zones => '偵測區域';

  @override
  String get video_screen_zones_desc => '使用拖放調整區域';

  @override
  String get video_screen_tools => '工具';

  @override
  String get video_screen_move_bottom => '將目前區域移至底部';

  @override
  String get video_screen_add_point => '向目前區域新增點';

  @override
  String get video_screen_remove_point => '從目前區域移除點';

  @override
  String get video_screen_playback_speed => '播放速度';

  @override
  String get video_screen_playback_current => '目前: ';

  @override
  String get video_screen_playback_14x => '1/4倍速';

  @override
  String get video_screen_playback_2x => '2倍速';

  @override
  String get video_screen_delete_header => '刪除此影片來源';

  @override
  String get video_screen_delete_content => '你確定要刪除此影片來源嗎？';

  @override
  String get video_screen_delete_button => '刪除';

  @override
  String get video_screen_sources => '設定影像來源、偵測目標同模型參數';

  @override
  String get video_screen_targets => '偵測目標';

  @override
  String get video_screen_detection => '模型參數';

  @override
  String get color_screen_title => '選擇顏色';

  @override
  String get zone_screen_desc => '偵測區域可以設定要偵測嘅物體類型，並選擇要顯示嘅計數器，如已偵測、已產生同已進入。';

  @override
  String get zone_screen_name_placeholder => '區域名稱，如行人道或停車場';

  @override
  String get zone_screen_zone_color => '區域顏色';

  @override
  String get zone_screen_color => '顏色';

  @override
  String get zone_screen_delete_header => '刪除此區域';

  @override
  String get zone_screen_delete_content => '你確定要刪除此區域嗎？';

  @override
  String get zone_screen_delete_button => '刪除';

  @override
  String get zone_screen_can_not_delete => '無法刪除區域';

  @override
  String get zone_screen_one_zone_required => '至少需要一個區域。';

  @override
  String get zone_screen_zone_name_required => '區域名稱唔可以為空';

  @override
  String get counter_screen_show_on => '喺螢幕上顯示';

  @override
  String get counter_screen_enabled => '已啟用';

  @override
  String get counter_screen_reentry_threshold => '重新進入閾值';

  @override
  String get counter_screen_reentry_desc => '物體必須進入 #0 次，每次退出同重新進入之間有 #1 秒冷卻時間，才能觸發重新進入';

  @override
  String get counter_screen_reentry_title => '重新進入計數';

  @override
  String get counter_screen_cooldown_threshold => '冷卻閾值';

  @override
  String get counter_screen_cooldown_desc => '重新進入需要喺離開偵測區域後有 #0 秒嘅冷卻時間';

  @override
  String get counter_screen_cooldown_time => '冷卻時間';

  @override
  String get counter_screen_cooldown_in_seconds => '單位：秒';

  @override
  String get counter_screen_stagnant_threshold => '停滯閾值';

  @override
  String get counter_screen_stagnant_desc => '物體靜止超過 #0 秒將被視為停滯';

  @override
  String get counter_screen_stagnant_consider => '視為停滯';

  @override
  String get counter_screen_stagnant_in_seconds => '單位：秒';

  @override
  String get counter_screen_stagnant_desc_prefix => '描述前綴';

  @override
  String get counter_screen_stagnant_desc_suffix => '描述後綴';

  @override
  String get counter_screen_name_error => '計數器名稱唔可以為空';

  @override
  String get counter_screen_enabled_error => '錯誤';

  @override
  String get counter_screen_enabled_error_content => '你需要先啟用其他計數器，然後先可以停用此計數器';

  @override
  String get objects_screen_title => '物體';

  @override
  String get objects_screen_desc => '選擇偵測目標，如人員、汽車、巴士等。';

  @override
  String get open_project_screen_title => '開啟項目';

  @override
  String get open_project_screen_desc => '開啟先前創建嘅項目，僅保留最近嘅 20 個。';

  @override
  String get open_project_screen_no_project => '未搵到項目。';

  @override
  String get default_project_name => '項目';

  @override
  String get default_video_name => '影片來源';

  @override
  String get default_zone_name => '偵測區域';

  @override
  String get error_oops => '哎呀，出咗問題';

  @override
  String get error_content => '發生咗意外錯誤。你要提交電子郵件報告嗎？';

  @override
  String get error_report => '電郵聯絡我們';

  @override
  String get submit => '提交';

  @override
  String get ok => '確定';

  @override
  String get cancel => '取消';

  @override
  String get yes => '係';

  @override
  String get no => '唔係';

  @override
  String get close => '關閉';

  @override
  String get back => '返回';

  @override
  String get zone_screen_zone => '區域';

  @override
  String get zone_screen_zone_show_summary => '在螢幕上顯示摘要';

  @override
  String get video_sources_photos_denied => '相片存取被拒';

  @override
  String get video_sources_photos_goto_settings => '前往設定';

  @override
  String get video_sources_camera_denied => '相機存取被拒';

  @override
  String get video_sources_photos_denied_msg => '請前往設定並允許此應用程式嘅相片存取權限。';

  @override
  String get video_sources_camera_denied_msg => '請前往設定並允許此應用程式嘅相機存取權限。';
}

/// The translations for Chinese, as used in Singapore (`zh_SG`).
class LocalizationZhSg extends LocalizationZh {
  LocalizationZhSg(): super('zh_SG');

  @override
  String get product_name => '计数器';

  @override
  String get product_desc => '使用计算机视觉和人工智能来计数人员、车辆、宠物等。';

  @override
  String get product_copyright => '版权所有 © 2025';

  @override
  String get video_sources_webcam => '网络摄像头';

  @override
  String get video_sources_live_stream => '直播流网址';

  @override
  String get video_sources_file => '文件';

  @override
  String get video_sources_camera => '相机';

  @override
  String get video_sources_camera_not_found_title => '找不到相机';

  @override
  String get video_sources_camera_not_found_message => '使用此功能需要相机权限。';

  @override
  String get video_sources_webcam_not_found_title => '找不到网络摄像头';

  @override
  String get video_sources_webcam_not_found_message => '请确认已给予 App 访问摄像头的权限并确认网络摄像头已正确连接。';

  @override
  String get wizard_screen_desc => '创建新项目以开始计数。';

  @override
  String get wizard_screen_new_project_from => '从以下创建新项目';

  @override
  String get wizard_screen_language => '语言';

  @override
  String get wizard_screen_about => '关于';

  @override
  String get wizard_screen_open_projects_tip => '所有项目将自动保存在本机';

  @override
  String get wizard_screen_open_projects => '打开现有项目';

  @override
  String get wizard_screen_email_us => '给我们发电邮';

  @override
  String get language_screen_language => '语言';

  @override
  String get project_view_no_videos => '没有视频源。';

  @override
  String get about_screen_title => '关于';

  @override
  String get about_screen_platform => '平台';

  @override
  String get about_screen_app_version => '应用程序版本';

  @override
  String get about_screen_models => '物体检测模型';

  @override
  String get about_screen_benchmark => '基准测试';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 构建信息';

  @override
  String get benchmark_screen_title => '模型基准测试';

  @override
  String get benchmark_screen_recommended => '推荐模型';

  @override
  String get benchmark_screen_fps => '每秒帧数';

  @override
  String get benchmark_screen_start_button => '开始基准测试';

  @override
  String get benchmark_screen_start_failed => '基准测试启动失败，错误代码为';

  @override
  String get benchmark_screen_models => '物体检测模型';

  @override
  String get project_screen_title => '项目';

  @override
  String get project_screen_exit_confirm_title => '确认退出项目';

  @override
  String get project_screen_exit_confirm_content => '离开项目将停止计数。您确定要继续吗？';

  @override
  String get project_screen_exit_button => '退出';

  @override
  String get project_screen_add_video_button => '添加视频源';

  @override
  String get project_screen_from_desc => '我们保留连续 24 小时的记录，因此您可以查看任何需要的时间段。';

  @override
  String get project_screen_report_settings => '设置';

  @override
  String get filter_screen_title => '筛选';

  @override
  String get filter_screen_desc => '从下列列表中选择筛选范围';

  @override
  String get filter_screen_error_title => '筛选';

  @override
  String get filter_screen_error_content => '结束时间必须大于开始时间';

  @override
  String get filter_screen_error_custom => '自定义';

  @override
  String get filter_screen_error_start => '开始';

  @override
  String get filter_screen_error_end => '结束';

  @override
  String get settings_screen_title => '设置';

  @override
  String get settings_screen_desc => '设置项目名称、检测参数、计数清除。';

  @override
  String get settings_screen_project_id => '项目 ID';

  @override
  String get settings_screen_project_name => '项目名称';

  @override
  String get settings_screen_project_name_place_holder => '实龙岗路123号 或 裕廊东花园';

  @override
  String get settings_screen_project_error => '项目名称不能为空';

  @override
  String get settings_screen_random_count_button => '添加随机计数';

  @override
  String get settings_screen_reset_count_header => '重置此项目中的所有计数';

  @override
  String get settings_screen_reset_count_button => '重置计数';

  @override
  String get settings_screen_reset_count_content => '您确定要重置所有计数吗？';

  @override
  String get settings_screen_delete_header => '删除此项目';

  @override
  String get settings_screen_delete_content => '您确定要删除此项目吗？';

  @override
  String get settings_screen_delete_button => '删除';

  @override
  String get settings_screen_center_point_title => '目标中心点';

  @override
  String get settings_screen_center_point_desc => '中心点可帮助判断目标是否位于命中区域内。';

  @override
  String get settings_screen_center_point_button => '显示目标中心点';

  @override
  String get settings_screen_lost_target_title => '丢失目标';

  @override
  String get settings_screen_lost_target_desc => '当物体跟踪丢失目标时，启用此选项可显示丢失的目标。默认情况下，丢失目标不会显示。';

  @override
  String get settings_screen_lost_target_button => '显示丢失目标';

  @override
  String get detection_screen_title => '检测设置';

  @override
  String get detection_screen_models => '模型';

  @override
  String get detection_screen_confidence => '置信度';

  @override
  String get detection_screen_confidence_desc => '置信度高于 #0 视为有效检测';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_nms => '非极大值抑制';

  @override
  String get detection_screen_nms_desc => '#0 较低的 NMS 阈值（例如 30%）将更积极地移除重叠的边界框，而较高的 NMS 阈值（例如 0.6）将允许更多重叠';

  @override
  String get detection_screen_match => '匹配';

  @override
  String get detection_screen_match_desc => '匹配度超过 #0 视为同一物体。';

  @override
  String get detection_screen_lost => '丢失';

  @override
  String get detection_screen_lost_desc => '如果物体丢失 #0，追踪物体将被移除';

  @override
  String get detection_screen_consider_valid => '视为有效时间';

  @override
  String get detection_screen_consider_valid_desc => '追踪物体在 #0 后视为有效';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您确定要重置检测设置吗？';

  @override
  String get url_screen_title => '直播流网址';

  @override
  String get url_screen_desc => '请输入直播流网址';

  @override
  String get url_screen_url => '网址';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '添加视频源';

  @override
  String get add_video_screen_from => '从以下来源添加视频';

  @override
  String get webcam_screen_add_title => '添加网络摄像头';

  @override
  String get webcam_screen_edit_title => '选择网络摄像头';

  @override
  String get webcam_manager_webcam => '网络摄像头';

  @override
  String get camera_screen_front_camera => '前置相机';

  @override
  String get camera_screen_back_camera => '后置相机';

  @override
  String get camera_screen_add_title => '添加相机';

  @override
  String get camera_screen_edit_title => '选择相机';

  @override
  String get camera_screen_zoom_level => '缩放级别';

  @override
  String get video_screen_name_empty => '视频源名称不能为空。';

  @override
  String get video_screen_desc => '管理视频源，添加或修改检测区域。';

  @override
  String get video_screen_video_name => '视频源名称';

  @override
  String get video_screen_edit_placeholder => '门口摄像头或停车场摄像头';

  @override
  String get video_screen_change_file => '更改文件';

  @override
  String get video_screen_add_zone => '添加检测区域';

  @override
  String get video_screen_zones => '检测区域';

  @override
  String get video_screen_zones_desc => '使用拖放调整区域';

  @override
  String get video_screen_tools => '工具';

  @override
  String get video_screen_move_bottom => '将当前区域移至底部';

  @override
  String get video_screen_add_point => '向当前区域添加点';

  @override
  String get video_screen_remove_point => '从当前区域移除点';

  @override
  String get video_screen_playback_speed => '播放速度';

  @override
  String get video_screen_playback_current => '当前:';

  @override
  String get video_screen_playback_14x => '1/4倍速';

  @override
  String get video_screen_playback_2x => '2倍速';

  @override
  String get video_screen_delete_header => '删除此视频源';

  @override
  String get video_screen_delete_content => '您确定要删除此视频源吗？';

  @override
  String get video_screen_delete_button => '删除';

  @override
  String get video_screen_sources => '设置图像源、检测目标及模型参数';

  @override
  String get video_screen_targets => '检测目标';

  @override
  String get video_screen_detection => '模型参数';

  @override
  String get color_screen_title => '选择颜色';

  @override
  String get zone_screen_desc => '检测区域可以设置要检测的物体类型，并选择要显示的计数器，如已检测、已生成和已进入。';

  @override
  String get zone_screen_name_placeholder => '区域名称，如人行道或停车场';

  @override
  String get zone_screen_zone_color => '区域颜色';

  @override
  String get zone_screen_color => '颜色';

  @override
  String get zone_screen_delete_header => '删除此区域';

  @override
  String get zone_screen_delete_content => '您确定要删除此区域吗？';

  @override
  String get zone_screen_delete_button => '删除';

  @override
  String get zone_screen_can_not_delete => '无法删除区域';

  @override
  String get zone_screen_one_zone_required => '至少需要一个区域。';

  @override
  String get zone_screen_zone_name_required => '区域名称不能为空';

  @override
  String get counter_screen_show_on => '在屏幕上显示';

  @override
  String get counter_screen_enabled => '已启用';

  @override
  String get counter_screen_reentry_threshold => '重新进入阈值';

  @override
  String get counter_screen_reentry_desc => '物体必须进入 #0 次，每次退出和重新进入之间有 #1 秒冷却时间，才能触发重新进入';

  @override
  String get counter_screen_reentry_title => '重新进入计数';

  @override
  String get counter_screen_cooldown_threshold => '冷却阈值';

  @override
  String get counter_screen_cooldown_desc => '重新进入需要在离开检测区域后有 #0 秒的冷却时间';

  @override
  String get counter_screen_cooldown_time => '冷却时间';

  @override
  String get counter_screen_cooldown_in_seconds => '单位：秒';

  @override
  String get counter_screen_stagnant_threshold => '停滞阈值';

  @override
  String get counter_screen_stagnant_desc => '物体静止超过 #0 秒将被视为停滞';

  @override
  String get counter_screen_stagnant_consider => '视为停滞';

  @override
  String get counter_screen_stagnant_in_seconds => '单位：秒';

  @override
  String get counter_screen_stagnant_desc_prefix => '描述前缀';

  @override
  String get counter_screen_stagnant_desc_suffix => '描述后缀';

  @override
  String get counter_screen_name_error => '计数器名称不能为空';

  @override
  String get counter_screen_enabled_error => '错误';

  @override
  String get counter_screen_enabled_error_content => '您需要先启用其他计数器，然后才能禁用此计数器';

  @override
  String get objects_screen_title => '物体';

  @override
  String get objects_screen_desc => '选择检测目标，如人员、汽车、公交车等。';

  @override
  String get open_project_screen_title => '打开项目';

  @override
  String get open_project_screen_desc => '打开之前创建的项目，仅保留最近的 20 个。';

  @override
  String get open_project_screen_no_project => '未找到项目。';

  @override
  String get default_project_name => '项目';

  @override
  String get default_video_name => '视频源';

  @override
  String get default_zone_name => '检测区域';

  @override
  String get error_oops => '糟糕，出现问题了';

  @override
  String get error_content => '发生了意外错误。您要提交电子邮件报告吗？';

  @override
  String get error_report => '邮件联系我们';

  @override
  String get submit => '提交';

  @override
  String get ok => '确定';

  @override
  String get cancel => '取消';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get close => '关闭';

  @override
  String get back => '返回';

  @override
  String get zone_screen_zone => '区域';

  @override
  String get zone_screen_zone_show_summary => '在屏幕上显示摘要';

  @override
  String get video_sources_photos_denied => '照片访问被拒绝';

  @override
  String get video_sources_photos_goto_settings => '前往设置';

  @override
  String get video_sources_camera_denied => '摄像头访问被拒绝';

  @override
  String get video_sources_photos_denied_msg => '请前往设置并允许此应用的照片访问权限。';

  @override
  String get video_sources_camera_denied_msg => '请前往设置并允许此应用的相机访问权限。';
}
