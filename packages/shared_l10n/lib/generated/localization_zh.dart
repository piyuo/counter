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
  String get about_screen_email_us => '寫信給我們';

  @override
  String get about_screen_platform => '平台';

  @override
  String get appeared => '出现';

  @override
  String get appeared_help =>
      '統計首次偵測位置位於此區域內的人員或車輛數量。\\n\\n可協助了解追蹤目標最初出現的位置。\\n\\n（主要提供進階使用者使用）';

  @override
  String get average_occupancy => '平均人数';

  @override
  String get average_occupancy_help =>
      '顯示目前計數期間內，此區域中的人員或車輛平均數量。\\n\\n可協助了解此區域在整個計數期間內的繁忙程度。';

  @override
  String get average_stay => '平均停留时间';

  @override
  String get average_stay_help =>
      '顯示人員或車輛在此區域內的平均停留時間。\\n\\n較長的平均停留時間，可能表示顧客在此區域停留較久。';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter 使用您的相機與裝置端 AI 來計數人員。首先，讓我們確認您的裝置相容。';

  @override
  String get camera_test_screen_instruction => '將相機對準人群。應用程式會在偵測到的人員周圍畫出方框。';

  @override
  String get camera_test_screen_next => '點一下「下一步」以繼續。';

  @override
  String get camera_test_screen_start => '點一下「開始」。如果系統要求，請允許存取相機。';

  @override
  String get camera_test_screen_test_failed => '測試失敗！';

  @override
  String get camera_test_screen_test_passed => '測試成功！';

  @override
  String get camera_test_screen_title => 'AI 相機測試';

  @override
  String get camera_test_screen_wait => '等待 AI 偵測人員…';

  @override
  String get cta_screen_custom => '使用自己的伺服器';

  @override
  String get cta_screen_custom_help => '將流量資料直接傳送到您自己的後端或資料庫。';

  @override
  String get cta_screen_footer => '繼續操作即表示您同意服務條款、隱私權政策及資料處理協議。';

  @override
  String get cta_screen_invitation => '使用邀請碼';

  @override
  String get cta_screen_invitation_help => '使用管理員提供的邀請加入現有組織。';

  @override
  String get cta_screen_local => '僅限本機';

  @override
  String get cta_screen_local_help => '僅將流量資料儲存在此裝置上。不會上傳任何資料。';

  @override
  String get cta_screen_piyuo => '使用 Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help => '將流量資料儲存在 Piyuo Cloud，並使用儀表板與商業洞察。';

  @override
  String get cta_screen_premium => '進階版';

  @override
  String get cta_screen_title =>
      'Piyuo Counter 每 5 分鐘建立一次匿名統計資料。\\n請選擇您要如何儲存及存取資料。';

  @override
  String get current_occupancy => '目前數量';

  @override
  String get current_occupancy_help =>
      '顯示目前此區域內的人員或車輛數量。\\n\\n此數字會即時更新，可協助確認 AI 偵測結果是否與畫面上看到的情況一致。此數值不會包含在上傳的遙測資料中。';

  @override
  String get custom_server_screen_bearer_saving_action => '儲存中...';

  @override
  String get custom_server_screen_server_url_label => '伺服器網址';

  @override
  String get detection_screen_confidence => '信心門檻';

  @override
  String get detection_screen_confidence_dialog =>
      '控制 AI 在計算行人或車輛之前需要有多確定。\\n數值較低\\n• 偵測更多物體\\n• 較適合遠處或部分遮蔽的物體\\n• 可能增加誤判\\n數值較高\\n• 僅計算高信心度的偵測\\n• 減少誤判\\n• 可能漏掉較小或較難辨識的物體\\n若應用程式漏掉行人或車輛，請調低數值。\\n若應用程式將陰影、反光或其他錯誤物體計入，請調高數值。';

  @override
  String get detection_screen_confidence_help => '物件偵測所需的最低信心值';

  @override
  String get detection_screen_confidence_max_label => '嚴格';

  @override
  String get detection_screen_confidence_min_label => '寬鬆';

  @override
  String get detection_screen_disappear => '消失逾時';

  @override
  String get detection_screen_disappear_dialog =>
      '決定物體不再被偵測到後，AI 要等多久才會將其標記為消失。\\n數值較短\\n• 更快將物體標記為消失\\n• 較適合快速流動的交通\\n• 可能將暫時被遮擋的物體誤標記為消失\\n數值較長\\n• 標記物體消失前等待更久\\n• 較適合物體短暫被阻擋或漏偵測的情況\\n• 延遲消失事件的判定';

  @override
  String get detection_screen_disappear_help => 'AI 在無法再偵測到物件後，等待多久才將其標記為已消失。';

  @override
  String get detection_screen_disappear_max_label => '慢';

  @override
  String get detection_screen_disappear_min_label => '快';

  @override
  String get detection_screen_memory_dialog =>
      '控制物體消失後，AI 會記住它多久。\\n如果行人或車輛經常被其他物體遮擋，請調高此數值。\\n如果物體離開畫面後被錯誤地連結，請調低此數值。';

  @override
  String get detection_screen_min_presence => '最短出現時間';

  @override
  String get detection_screen_min_presence_help =>
      '物件必須保持可見一段時間才會被計數。較長的時間有助於減少短暫的誤判。';

  @override
  String get detection_screen_min_presence_max_label => '較安全';

  @override
  String get detection_screen_min_presence_min_label => '較快';

  @override
  String get detection_screen_minimum_visible =>
      '物體必須持續顯示這麼長時間才會被計數。\\n調高此數值可忽略短暫的誤判。\\n若快速移動的行人或車輛被漏計，請調低此數值。';

  @override
  String get detection_screen_new_track => '新追蹤門檻';

  @override
  String get detection_screen_new_track_help =>
      '開始追蹤新物件所需的最低信心值。較低的值可能會產生重複追蹤。';

  @override
  String get detection_screen_new_track_max_label => '保守';

  @override
  String get detection_screen_new_track_min_label => '積極';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您確定要重置偵測設定嗎？';

  @override
  String get detection_screen_show_track_id => '顯示追蹤識別碼';

  @override
  String get detection_screen_show_track_id_help => '啟用此選項可顯示每個追蹤物體的唯一追蹤 ID。';

  @override
  String get detection_screen_stay => '停留時間';

  @override
  String get detection_screen_stay_help => '物件必須在區域內停留多久才會被計為一次停留。';

  @override
  String get detection_screen_stay_max_label => '延後';

  @override
  String get detection_screen_stay_min_label => '立即';

  @override
  String get detection_screen_stay_threshold =>
      '決定物體何時計入「停留」計數。\\n數值較短\\n• 立即計入停留\\n• 較適合快速分析\\n數值較長\\n• 忽略短暫經過的流量\\n• 較適合佔用率測量';

  @override
  String get detection_screen_subtitle => '調整 AI 偵測與追蹤物件的方式';

  @override
  String get detection_screen_title => '追蹤與計數';

  @override
  String get detection_screen_track_dialog =>
      '控制新偵測到的物體何時成為新的追蹤軌跡。\\n數值較低\\n• 更快開始追蹤\\n• 較適合快速移動的物體\\n• 可能產生重複軌跡\\n數值較高\\n• 需要更強的證據才能建立新軌跡\\n• 減少重複軌跡\\n• 可能延遲追蹤新物體';

  @override
  String get detection_screen_track_memory => '追蹤記憶';

  @override
  String get detection_screen_track_memory_help =>
      '物件暫時消失後仍持續追蹤多久。較長的時間有助於在短暫遮擋後恢復追蹤。';

  @override
  String get detection_screen_track_memory_max_label => '長';

  @override
  String get detection_screen_track_memory_min_label => '短';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter 使用您的相機即時偵測行人與車輛。此裝置沒有可用的相機。';

  @override
  String get device_not_supported_screen_footer_hint => '請嘗試在您的手機上開啟此應用程式';

  @override
  String get device_not_supported_screen_requirement_camera => '具備相機的智慧型手機或平板';

  @override
  String get device_not_supported_screen_requirement_platform =>
      '建議使用 iOS 或 Android 裝置';

  @override
  String get device_not_supported_screen_requirements_title => '您需要什麼';

  @override
  String get device_not_supported_screen_title => '找不到相機';

  @override
  String get disappeared => '消失';

  @override
  String get disappeared_help =>
      '統計最後一次偵測位置仍在此區域內的人員或車輛數量。\\n\\n如果人員或車輛在設定的消失時間內沒有再次被偵測到，追蹤將結束。\\n\\n（主要提供進階使用者使用）';

  @override
  String get dpa => '資料處理協議';

  @override
  String get durationDaysShort => '%s天';

  @override
  String get durationHoursShort => '%s時';

  @override
  String get durationMinutesShort => '%s分';

  @override
  String get durationSecondsShort => '%s秒';

  @override
  String get durationTwoUnit => '%first%second';

  @override
  String get entered => '進入';

  @override
  String get entered_help =>
      '統計目前計數期間內進入此區域的人員或車輛數量。\\n\\n當人員或車輛從區域外移動到區域內時，會計為一次進入。';

  @override
  String get exited => '離開';

  @override
  String get exited_help =>
      '統計目前計數期間內離開此區域的人員或車輛數量。\\n\\n當人員或車輛從區域內移動到區域外時，會計為一次離開。';

  @override
  String get language_screen_language => '語言';

  @override
  String get language_screen_subtitle => '選擇應用程式使用的語言。';

  @override
  String get local_only_screen_body =>
      '「僅限本機裝置」模式讓您可以在不上傳任何資料的情況下，試用 AI 攝影機偵測與追蹤功能。所有人流統計資料都只在此裝置上處理，非常適合在連接伺服器前先行測試。';

  @override
  String get local_only_screen_use_action => '僅使用本機';

  @override
  String get local_screen_text =>
      'Piyuo Counter 將完全在此裝置上運作。\\n流量統計資料只會儲存在此裝置上，不會上傳。\\n之後您可以在「設定」中連接 Piyuo Cloud 或自己的伺服器。';

  @override
  String get maximum_occupancy => '最大人数';

  @override
  String get maximum_occupancy_help =>
      '顯示目前計數期間內，此區域同時存在的人員或車輛最高數量。\\n\\n可協助了解人流或車流的高峰時段。';

  @override
  String get maximum_stay => '最長停留时间';

  @override
  String get maximum_stay_help =>
      '顯示目前計數期間內，人員或車輛在此區域停留的最長時間。\\n\\n可用來發現異常長時間停留或停車的情況。';

  @override
  String get metric_events => '事件';

  @override
  String get metric_live => '即時';

  @override
  String get metric_show_less => '顯示較少';

  @override
  String get metric_show_more => '顯示更多';

  @override
  String get metric_statistics => '統計';

  @override
  String get metrics_counting_all => '全部';

  @override
  String get metrics_counting_done => '完成';

  @override
  String get metrics_counting_in_progress => '進行中';

  @override
  String get metrics_counting_missing => '缺失';

  @override
  String get metrics_counting_window => '每 5 分鐘產生一次的統計資料';

  @override
  String get onboarding_back_action => '返回';

  @override
  String get onboarding_cta_no_server => '不想上傳資料？';

  @override
  String get onboarding_cta_title => '您的資料要傳送到哪裡？';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter 用你手機的相機和內建 AI，即時偵測行人和車輛。\\n透過辨識追蹤技術，自動計算車流量與人流量 — 全部都在你的裝置上完成。';

  @override
  String get onboarding_intro_text2 =>
      '所有 AI 運算都在你的裝置上完成，不會上傳任何影片、照片、臉部或身分資訊。\\n只會分享每 5 分鐘一次的匿名統計摘要，內容包含計數、佔用率、進出人次與停留時間等數據。';

  @override
  String get onboarding_intro_text3 =>
      '只要開啟應用程式並讓它持續運作即可。Piyuo Counter 會自動不間斷地收集並儲存交通數據。\\n數據摘要每 5 分鐘儲存一次，並每小時上傳至 Piyuo Cloud 或你自己的伺服器。';

  @override
  String get onboarding_intro_title1 => 'AI 人流與車流計數';

  @override
  String get onboarding_intro_title2 => '隱私優先設計';

  @override
  String get onboarding_intro_title3 => '全天候 24/7 自動運作';

  @override
  String get onboarding_next_action => '下一步';

  @override
  String get onboarding_skip_action => '跳過介紹';

  @override
  String get onboarding_start_action => '開始';

  @override
  String get passed_by => '經過';

  @override
  String get passed_by_help =>
      '統計目前計數期間內經過此區域的人員或車輛數量。\\n\\n每位人員或每輛車每次經過此區域時，只會計數一次。';

  @override
  String get payloads_screen_area => '區域';

  @override
  String get payloads_screen_confidence => '信心度';

  @override
  String get payloads_screen_coverage => '涵蓋率';

  @override
  String get payloads_screen_delivered => '已送達';

  @override
  String get payloads_screen_failed_load => '無法載入最近資料';

  @override
  String get payloads_screen_frame_processed => '已處理影格';

  @override
  String get payloads_screen_hour_not_exists => '此小時已不存在。';

  @override
  String get payloads_screen_missing_time => '缺失時間';

  @override
  String get payloads_screen_no_payloads => '尚無資料。';

  @override
  String get payloads_screen_partial => '視窗提前結束（部分）';

  @override
  String get payloads_screen_partially => '部分送達';

  @override
  String get payloads_screen_payload_not_exists => '此資料已不存在。';

  @override
  String get payloads_screen_pending => '等待傳送';

  @override
  String get payloads_screen_process_fps => '處理 FPS';

  @override
  String get payloads_screen_resend => '重新傳送';

  @override
  String get payloads_screen_select_first => '請先選擇至少一個日期或小時。';

  @override
  String get payloads_screen_subtitle => '依日期或小時選擇以重新傳送';

  @override
  String get payloads_screen_title => '最近資料';

  @override
  String get personal_custom_screen_build_server =>
      '需要協助設定自己的伺服器嗎？\\n請參閱我們的 API 文件與伺服器範例。';

  @override
  String get personal_custom_screen_help_action => '開啟 API 文件';

  @override
  String get personal_custom_screen_reset_action => '重新開始';

  @override
  String get personal_custom_success_screen_help => '點選下方的 Start 開始計數。';

  @override
  String get personal_custom_success_screen_help1 =>
      '流量統計資料會每小時自動上傳。\\n您也可以從「上傳記錄」畫面手動上傳。';

  @override
  String get personal_custom_success_screen_help2 =>
      '您的伺服器現在不需要上線。\\n您可以先開始計數，再慢慢建置與測試您的伺服器。流量統計資料會保留在此裝置上，直到成功上傳。';

  @override
  String get personal_custom_success_screen_send_to => '流量統計將傳送至';

  @override
  String get personal_custom_success_screen_title => '您的伺服器已準備就緒';

  @override
  String get piyuo_server_screen_cloud_url_label => '您的 Piyuo Cloud 網址';

  @override
  String get piyuo_server_screen_copy_action => '複製網址';

  @override
  String get piyuo_server_screen_copy_success => '已複製網址';

  @override
  String get piyuo_server_screen_saving_action => '儲存中...';

  @override
  String get piyuo_server_screen_start => '按下方「Start」開始計數。';

  @override
  String get piyuo_server_screen_url_help => '您的 Piyuo Cloud 專屬儀表板已可透過此網址使用。';

  @override
  String get piyuo_server_screen_url_remember => '請儲存此網址，以便從其他裝置存取您的流量儀表板。';

  @override
  String get piyuo_server_screen_use_action => '使用 Piyuo 雲端';

  @override
  String get privacy => '隱私權政策';

  @override
  String get product_copyright => '版權所有 © 2026';

  @override
  String get product_desc => 'AI 人員與車輛計數。';

  @override
  String get settings_screen_custom_subtitle => '將流量資料直接傳送到您自己的後端或資料庫。';

  @override
  String get settings_screen_custom_title => '使用自訂伺服器';

  @override
  String get settings_screen_data_server_label => '資料伺服器';

  @override
  String get settings_screen_detection_target => '偵測目標';

  @override
  String get settings_screen_language_title => '語言';

  @override
  String get settings_screen_local_subtitle => '僅將流量資料儲存在此裝置，不會上傳任何資料。';

  @override
  String get settings_screen_local_title => '僅限本機';

  @override
  String get settings_screen_misc_label => '其他';

  @override
  String get settings_screen_object_detection => '物件偵測';

  @override
  String get settings_screen_piyuo_subtitle => '將流量資料儲存在 Piyuo 雲端，並使用儀表板與商業洞察。';

  @override
  String get settings_screen_piyuo_title => 'Piyuo 雲端';

  @override
  String get settings_screen_reset_all_data_body => '這將刪除所有資料並重新開始。此操作無法復原。';

  @override
  String get settings_screen_reset_all_data_title => '重設所有資料？';

  @override
  String get settings_screen_subscription_body => '管理您的訂閱與帳單資訊';

  @override
  String get settings_screen_subscription_title => '訂閱';

  @override
  String get start_screen_about => '關於';

  @override
  String get start_screen_server_none => '資料僅儲存在此裝置上';

  @override
  String get start_screen_server_personal => '資料每小時上傳至';

  @override
  String get start_screen_settings => '設定';

  @override
  String get start_screen_upload_logs => '上傳記錄';

  @override
  String get start_screen_video_sources => '視訊來源';

  @override
  String get stayed => '停留';

  @override
  String get stayed_help =>
      '統計在此區域內停留時間達到設定值的人員或車輛數量。\\n\\n預設停留時間為 15 秒，可在設定中修改。';

  @override
  String get target_pedestrian => '行人';

  @override
  String get target_pedestrian_help => '使用行人偵測模型統計人數';

  @override
  String get target_screen_subtitle => '選擇要使用的偵測模型';

  @override
  String get target_vehicle => '車輛';

  @override
  String get target_vehicle_help => '使用車輛偵測模型統計汽車和其他車輛';

  @override
  String get telemetry_error_connection_refused => '無法連線至伺服器，目前可能處於離線狀態。';

  @override
  String get telemetry_error_connection_reset => '連線已重設，請檢查網路連線後再試一次。';

  @override
  String get telemetry_error_connection_timeout => '連線回應時間過長，請檢查網路連線後再試一次。';

  @override
  String get telemetry_error_dns_lookup_failed => '找不到伺服器位址，請檢查網路連線或伺服器網址。';

  @override
  String get telemetry_error_http_error_status => '伺服器拒絕了此請求，請稍後再試。';

  @override
  String get telemetry_error_http_unknown_error => '與伺服器通訊時發生未預期的錯誤。';

  @override
  String get telemetry_error_invalid_url => '伺服器位址無效，請檢查您的設定。';

  @override
  String get telemetry_error_network_error => '發生網路錯誤，請檢查網路連線後再試一次。';

  @override
  String get telemetry_error_socket_error => '發生網路連線問題，請檢查您的網路連線。';

  @override
  String get telemetry_error_transport_exception => '傳送資料時發生問題，請再試一次。';

  @override
  String get terms => '服務條款';

  @override
  String get upload_screen_attempt_time => '嘗試時間:';

  @override
  String get upload_screen_error => '錯誤:';

  @override
  String get upload_screen_failed => '失敗';

  @override
  String get upload_screen_load_error => '無法載入上傳紀錄。';

  @override
  String get upload_screen_log_not_exists => '上傳紀錄已不存在。';

  @override
  String get upload_screen_next => '下次上傳於 ...';

  @override
  String get upload_screen_next_upload_prefix => '下次上傳於 ';

  @override
  String get upload_screen_no_data_server => '請先設定資料伺服器。';

  @override
  String get upload_screen_no_logs => '尚無上傳紀錄。';

  @override
  String get upload_screen_payload_count => '資料數量';

  @override
  String get upload_screen_payload_count_label => '資料數量:';

  @override
  String get upload_screen_payload_size => '資料大小:';

  @override
  String get upload_screen_result => '結果:';

  @override
  String get upload_screen_retry => '重試次數:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => '成功';

  @override
  String get upload_screen_today => '今天';

  @override
  String get upload_screen_upload_now => '立即上傳';

  @override
  String get upload_screen_upload_success => '上傳成功。';

  @override
  String get upload_screen_uploading => '上傳中...';

  @override
  String get upload_screen_yesterday => '昨天';

  @override
  String get url_screen_invalid_rtsp_error => 'RTSP URL 必須包含主機名稱。';

  @override
  String get url_screen_invalid_url_error => '請輸入使用支援通訊協定的有效 URL。';

  @override
  String get url_screen_subtitle => '請輸入即時串流網址';

  @override
  String get url_screen_title => '即時串流網址';

  @override
  String get url_screen_unsupported_scheme_error => 'Csak HTTP';

  @override
  String get url_screen_url => '網址';

  @override
  String get url_screen_url_empty_error => '請輸入直播 URL。';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => '後置鏡頭';

  @override
  String get video_sources_camera => '相機';

  @override
  String get video_sources_file => '檔案';

  @override
  String get video_sources_front_camera => '前置鏡頭';

  @override
  String get video_sources_live_stream => '直播串流網址';

  @override
  String get video_sources_screen_camera_not_found_message => '使用此功能需要相機權限。';

  @override
  String get video_sources_screen_camera_not_found_title => '找不到相機';

  @override
  String get video_sources_screen_import_error => '無法匯入影片檔案。';

  @override
  String get video_sources_screen_photos_denied_msg => '請前往設定並允許此應用程式的相片存取權限。';

  @override
  String get video_sources_screen_select_camera => '點選以選擇此攝影機';

  @override
  String get video_sources_screen_select_file => '點選以選擇檔案';

  @override
  String get video_sources_screen_select_live => '點選以設定直播串流網址';

  @override
  String get video_sources_webcam => '網路攝影機';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class LocalizationZhCn extends LocalizationZh {
  LocalizationZhCn() : super('zh_CN');

  @override
  String get about_screen_app_version => '应用程序版本';

  @override
  String get about_screen_email_us => '发邮件给我们';

  @override
  String get about_screen_platform => '平台';

  @override
  String get appeared => '出现';

  @override
  String get appeared_help =>
      '统计首次检测位置位于此区域内的人员或车辆数量。\\n\\n有助于了解跟踪从何处开始。\\n\\n（主要供高级用户使用）';

  @override
  String get average_occupancy => '平均人数';

  @override
  String get average_occupancy_help =>
      '显示当前计数窗口期间此区域内人员或车辆的平均数量。\\n\\n有助于了解该区域在整个计数窗口内的繁忙程度。';

  @override
  String get average_stay => '平均停留时间';

  @override
  String get average_stay_help =>
      '显示人员或车辆在此区域内的平均停留时间。\\n\\n较长的平均停留时间可能表示顾客在该区域停留更久。';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter 使用您的摄像头和设备端 AI 来统计人数。首先，请确认您的设备兼容。';

  @override
  String get camera_test_screen_instruction => '将摄像头对准人群。应用会在检测到的人周围绘制方框。';

  @override
  String get camera_test_screen_next => '点击“下一步”继续。';

  @override
  String get camera_test_screen_start => '点击“开始”。如果系统提示，请允许访问摄像头。';

  @override
  String get camera_test_screen_test_failed => '测试失败！';

  @override
  String get camera_test_screen_test_passed => '测试通过！';

  @override
  String get camera_test_screen_title => 'AI 摄像头测试';

  @override
  String get camera_test_screen_wait => '正在等待 AI 检测人员…';

  @override
  String get cta_screen_custom => '使用自己的服务器';

  @override
  String get cta_screen_custom_help => '将流量数据直接发送到您自己的后端或数据库。';

  @override
  String get cta_screen_footer => '继续操作即表示您同意服务条款、隐私政策及数据处理协议。';

  @override
  String get cta_screen_invitation => '使用邀请码';

  @override
  String get cta_screen_invitation_help => '使用管理员提供的邀请加入现有组织。';

  @override
  String get cta_screen_local => '仅限本机';

  @override
  String get cta_screen_local_help => '仅将流量数据保存在此设备上。不会上传任何数据。';

  @override
  String get cta_screen_piyuo => '使用 Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help => '将流量数据存储到 Piyuo Cloud，并使用仪表板和商业洞察。';

  @override
  String get cta_screen_premium => '高级版';

  @override
  String get cta_screen_title =>
      'Piyuo Counter 每 5 分钟生成一次匿名统计数据。\\n请选择您希望如何存储和访问数据。';

  @override
  String get current_occupancy => '当前数量';

  @override
  String get current_occupancy_help =>
      '显示此区域内人员或车辆的当前数量。\\n\\n此数字会实时更新，可帮助您确认 AI 检测结果是否与屏幕上看到的情况一致。此数值不会包含在上传的遥测数据中。';

  @override
  String get custom_server_screen_bearer_saving_action => '正在保存...';

  @override
  String get custom_server_screen_server_url_label => '服务器地址';

  @override
  String get detection_screen_confidence => '置信度阈值';

  @override
  String get detection_screen_confidence_dialog =>
      '控制 AI 在计数行人或车辆之前需要有多确定。\\n数值较低\\n• 检测更多物体\\n• 更适合远处或部分遮挡的物体\\n• 可能增加误检\\n数值较高\\n• 仅计数高置信度的检测\\n• 减少误检\\n• 可能漏掉较小或较难识别的物体\\n如果应用程序漏掉行人或车辆，请调低数值。\\n如果应用程序将阴影、反光或其他错误物体计入，请调高数值。';

  @override
  String get detection_screen_confidence_help => '检测对象所需的最低置信度';

  @override
  String get detection_screen_confidence_max_label => '严格';

  @override
  String get detection_screen_confidence_min_label => '宽松';

  @override
  String get detection_screen_disappear => '消失超时';

  @override
  String get detection_screen_disappear_dialog =>
      '决定物体不再被检测到后，AI 要等多久才会将其标记为消失。\\n数值较短\\n• 更快将物体标记为消失\\n• 更适合快速流动的交通\\n• 可能将暂时被遮挡的物体误标记为消失\\n数值较长\\n• 标记物体消失前等待更久\\n• 更适合物体短暂被阻挡或漏检测的情况\\n• 延迟消失事件的判定';

  @override
  String get detection_screen_disappear_help => 'AI 在无法再检测到对象后，等待多久才将其标记为已消失。';

  @override
  String get detection_screen_disappear_max_label => '慢';

  @override
  String get detection_screen_disappear_min_label => '快';

  @override
  String get detection_screen_memory_dialog =>
      '控制物体消失后，AI 会记住它多久。\\n如果行人或车辆经常被其他物体遮挡，请调高此数值。\\n如果物体离开画面后被错误地连结，请调低此数值。';

  @override
  String get detection_screen_min_presence => '最短出现时间';

  @override
  String get detection_screen_min_presence_help =>
      '对象必须保持可见一段时间才会被计数。较长的时间有助于减少短暂的误检测。';

  @override
  String get detection_screen_min_presence_max_label => '更安全';

  @override
  String get detection_screen_min_presence_min_label => '更快';

  @override
  String get detection_screen_minimum_visible =>
      '物体必须持续显示这么长时间才会被计数。\\n调高此数值可忽略短暂的误判。\\n若快速移动的行人或车辆被漏计，请调低此数值。';

  @override
  String get detection_screen_new_track => '新跟踪阈值';

  @override
  String get detection_screen_new_track_help =>
      '开始跟踪新对象所需的最低置信度。较低的值可能会产生重复跟踪。';

  @override
  String get detection_screen_new_track_max_label => '保守';

  @override
  String get detection_screen_new_track_min_label => '激进';

  @override
  String get detection_screen_reset => '重置';

  @override
  String get detection_screen_reset_content => '您确定要重置检测设置吗？';

  @override
  String get detection_screen_show_track_id => '显示跟踪ID';

  @override
  String get detection_screen_show_track_id_help => '启用此选项以显示每个被跟踪对象的唯一跟踪 ID。';

  @override
  String get detection_screen_stay => '停留时间';

  @override
  String get detection_screen_stay_help => '对象必须在区域内停留多久才会被计为一次停留。';

  @override
  String get detection_screen_stay_max_label => '延迟';

  @override
  String get detection_screen_stay_min_label => '立即';

  @override
  String get detection_screen_stay_threshold =>
      '决定物体何时计入“停留”计数。\\n数值较短\\n• 立即计入停留\\n• 更适合快速分析\\n数值较长\\n• 忽略短暂经过的流量\\n• 更适合占用率测量';

  @override
  String get detection_screen_subtitle => '调整 AI 检测和跟踪对象的方式';

  @override
  String get detection_screen_title => '追踪与计数';

  @override
  String get detection_screen_track_dialog =>
      '控制新检测到的物体何时成为新的追踪轨迹。\\n数值较低\\n• 更快开始追踪\\n• 更适合快速移动的物体\\n• 可能产生重复轨迹\\n数值较高\\n• 需要更强的证据才能建立新轨迹\\n• 减少重复轨迹\\n• 可能延迟追踪新物体';

  @override
  String get detection_screen_track_memory => '跟踪记忆';

  @override
  String get detection_screen_track_memory_help =>
      '对象暂时丢失后继续跟踪的时间。较长的时间有助于在短暂遮挡后恢复跟踪。';

  @override
  String get detection_screen_track_memory_max_label => '长';

  @override
  String get detection_screen_track_memory_min_label => '短';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter 使用您的摄像头实时检测行人和车辆。此设备没有可用的摄像头。';

  @override
  String get device_not_supported_screen_footer_hint => '请在您的手机上打开此应用';

  @override
  String get device_not_supported_screen_requirement_camera => '带摄像头的智能手机或平板';

  @override
  String get device_not_supported_screen_requirement_platform =>
      '建议使用 iOS 或 Android 设备';

  @override
  String get device_not_supported_screen_requirements_title => '您需要什么';

  @override
  String get device_not_supported_screen_title => '找不到摄像头';

  @override
  String get disappeared => '消失';

  @override
  String get disappeared_help =>
      '统计最后一次检测位置位于此区域内的人员或车辆数量。\\n\\n如果人员或车辆在设定的消失时间内未再次被检测到，则跟踪结束。\\n\\n（主要供高级用户使用）';

  @override
  String get dpa => '数据处理协议';

  @override
  String get durationDaysShort => '%s天';

  @override
  String get durationHoursShort => '%s时';

  @override
  String get durationMinutesShort => '%s分';

  @override
  String get durationSecondsShort => '%s秒';

  @override
  String get durationTwoUnit => '%first%second';

  @override
  String get entered => '进入';

  @override
  String get entered_help =>
      '统计当前计数窗口期间进入此区域的人员或车辆数量。\\n\\n当人员或车辆从区域外移动到区域内时，计为一次进入。';

  @override
  String get exited => '离开';

  @override
  String get exited_help =>
      '统计当前计数窗口期间离开此区域的人员或车辆数量。\\n\\n当人员或车辆从区域内移动到区域外时，计为一次离开。';

  @override
  String get language_screen_language => '语言';

  @override
  String get language_screen_subtitle => '选择应用使用的语言。';

  @override
  String get local_only_screen_body =>
      '\'仅限本机设备\'模式让你无需上传任何数据即可试用 AI 摄像头检测与追踪功能。所有客流统计数据都只在本设备上处理，非常适合在连接服务器之前先测试一下。';

  @override
  String get local_only_screen_use_action => '仅使用本机';

  @override
  String get local_screen_text =>
      'Piyuo Counter 将完全在此设备上运行。\\n流量统计数据只会保存在此设备上，不会上传。\\n之后您可以在“设置”中连接 Piyuo Cloud 或自己的服务器。';

  @override
  String get maximum_occupancy => '最大人数';

  @override
  String get maximum_occupancy_help =>
      '显示当前计数窗口期间此区域内同时存在的最高人员或车辆数量。\\n\\n有助于识别人流或车流高峰。';

  @override
  String get maximum_stay => '最长停留时间';

  @override
  String get maximum_stay_help =>
      '显示当前计数窗口期间人员或车辆在此区域内停留的最长时间。\\n\\n有助于识别异常长时间的停留或停车。';

  @override
  String get metric_events => '事件';

  @override
  String get metric_live => '实时';

  @override
  String get metric_show_less => '显示较少';

  @override
  String get metric_show_more => '显示更多';

  @override
  String get metric_statistics => '统计';

  @override
  String get metrics_counting_all => '全部';

  @override
  String get metrics_counting_done => '完成';

  @override
  String get metrics_counting_in_progress => '进行中';

  @override
  String get metrics_counting_missing => '缺失';

  @override
  String get metrics_counting_window => '每 5 分钟生成一次的统计数据';

  @override
  String get onboarding_back_action => '返回';

  @override
  String get onboarding_cta_no_server => '不想上传数据？';

  @override
  String get onboarding_cta_title => '您的数据要发送到哪里？';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter 用你手机的摄像头和内置 AI，实时识别行人和车辆。\\n通过识别追踪技术，自动计算车流量与人流量 — 全部都在你的设备上完成。';

  @override
  String get onboarding_intro_text2 =>
      '所有 AI 运算都在你的设备上完成，不会上传任何视频、照片、面部或身份信息。\\n只会分享每 5 分钟一次的匿名统计摘要，内容包含计数、占用率、进出人次与停留时间等数据。';

  @override
  String get onboarding_intro_text3 =>
      '只要打开应用程序并让它持续运行即可。Piyuo Counter 会自动不间断地收集并存储交通数据。\\n数据摘要每 5 分钟保存一次，并每小时上传至 Piyuo Cloud 或你自己的服务器。';

  @override
  String get onboarding_intro_title1 => 'AI 人流与车流计数';

  @override
  String get onboarding_intro_title2 => '隐私优先设计';

  @override
  String get onboarding_intro_title3 => '全天候 24/7 自动运行';

  @override
  String get onboarding_next_action => '下一步';

  @override
  String get onboarding_skip_action => '跳过介绍';

  @override
  String get onboarding_start_action => '开始';

  @override
  String get passed_by => '经过';

  @override
  String get passed_by_help =>
      '统计当前计数窗口期间经过此区域的人员或车辆数量。\\n\\n每位人员或每辆车辆每次经过该区域时只会计数一次。';

  @override
  String get payloads_screen_area => '区域';

  @override
  String get payloads_screen_confidence => '置信度';

  @override
  String get payloads_screen_coverage => '覆盖率';

  @override
  String get payloads_screen_delivered => '已送达';

  @override
  String get payloads_screen_failed_load => '无法加载最近数据';

  @override
  String get payloads_screen_frame_processed => '已处理帧';

  @override
  String get payloads_screen_hour_not_exists => '此小时已不存在。';

  @override
  String get payloads_screen_missing_time => '缺失时间';

  @override
  String get payloads_screen_no_payloads => '暂无数据。';

  @override
  String get payloads_screen_partial => '窗口提前结束（部分）';

  @override
  String get payloads_screen_partially => '部分送达';

  @override
  String get payloads_screen_payload_not_exists => '此数据已不存在。';

  @override
  String get payloads_screen_pending => '等待发送';

  @override
  String get payloads_screen_process_fps => '处理 FPS';

  @override
  String get payloads_screen_resend => '重新发送';

  @override
  String get payloads_screen_select_first => '请先选择至少一个日期或小时。';

  @override
  String get payloads_screen_subtitle => '按日期或小时选择以重新发送';

  @override
  String get payloads_screen_title => '最近数据';

  @override
  String get personal_custom_screen_build_server =>
      '需要帮助设置自己的服务器吗？\\n请查看我们的 API 文档和服务器示例。';

  @override
  String get personal_custom_screen_help_action => '打开 API 文档';

  @override
  String get personal_custom_screen_reset_action => '重新开始';

  @override
  String get personal_custom_success_screen_help => '点击下方的 Start 开始计数。';

  @override
  String get personal_custom_success_screen_help1 =>
      '流量统计数据会每小时自动上传。\\n您也可以在“上传记录”页面手动上传。';

  @override
  String get personal_custom_success_screen_help2 =>
      '您的服务器现在无需在线。\\n您可以先开始计数，再慢慢搭建和测试您的服务器。流量统计数据会保留在此设备上，直到成功上传。';

  @override
  String get personal_custom_success_screen_send_to => '流量统计将发送至';

  @override
  String get personal_custom_success_screen_title => '您的服务器已准备就绪';

  @override
  String get piyuo_server_screen_cloud_url_label => '您的 Piyuo Cloud 地址';

  @override
  String get piyuo_server_screen_copy_action => '复制地址';

  @override
  String get piyuo_server_screen_copy_success => '已复制地址';

  @override
  String get piyuo_server_screen_saving_action => '正在保存...';

  @override
  String get piyuo_server_screen_start => '点击下方“Start”开始计数。';

  @override
  String get piyuo_server_screen_url_help => '您的 Piyuo Cloud 专属仪表板已可通过此网址使用。';

  @override
  String get piyuo_server_screen_url_remember => '请保存此网址，以便从其他设备访问您的流量仪表板。';

  @override
  String get piyuo_server_screen_use_action => '使用 Piyuo 云端';

  @override
  String get privacy => '隐私政策';

  @override
  String get product_copyright => '版权所有 © 2026';

  @override
  String get product_desc => 'AI 人员与车辆计数。';

  @override
  String get settings_screen_custom_subtitle => '将流量数据直接发送到您自己的后端或数据库。';

  @override
  String get settings_screen_custom_title => '使用自定义服务器';

  @override
  String get settings_screen_data_server_label => '数据服务器';

  @override
  String get settings_screen_detection_target => '检测目标';

  @override
  String get settings_screen_language_title => '语言';

  @override
  String get settings_screen_local_subtitle => '仅将流量数据存储在此设备，不会上传任何数据。';

  @override
  String get settings_screen_local_title => '仅限本机';

  @override
  String get settings_screen_misc_label => '其他';

  @override
  String get settings_screen_object_detection => '对象检测';

  @override
  String get settings_screen_piyuo_subtitle => '将流量数据存储到 Piyuo 云端，并使用仪表板和商业洞察。';

  @override
  String get settings_screen_piyuo_title => 'Piyuo 云端';

  @override
  String get settings_screen_reset_all_data_body => '这将删除所有数据并重新开始。此操作无法撤销。';

  @override
  String get settings_screen_reset_all_data_title => '重置所有数据？';

  @override
  String get settings_screen_subscription_body => '管理您的订阅和账单信息';

  @override
  String get settings_screen_subscription_title => '订阅';

  @override
  String get start_screen_about => '关于';

  @override
  String get start_screen_server_none => '数据仅保存在此设备上';

  @override
  String get start_screen_server_personal => '数据每小时上传至';

  @override
  String get start_screen_settings => '设置';

  @override
  String get start_screen_upload_logs => '上传日志';

  @override
  String get start_screen_video_sources => '视频来源';

  @override
  String get stayed => '停留';

  @override
  String get stayed_help =>
      '统计在此区域内停留时间达到设定停留时间的人员或车辆数量。\\n\\n默认停留时间为15秒，可在设置中修改。';

  @override
  String get target_pedestrian => '行人';

  @override
  String get target_pedestrian_help => '使用行人检测模型统计人数';

  @override
  String get target_screen_subtitle => '选择要使用的检测模型';

  @override
  String get target_vehicle => '车辆';

  @override
  String get target_vehicle_help => '使用车辆检测模型统计汽车和其他车辆';

  @override
  String get telemetry_error_connection_refused => '无法连接到服务器，目前可能处于离线状态。';

  @override
  String get telemetry_error_connection_reset => '连接已重置，请检查网络连接后重试。';

  @override
  String get telemetry_error_connection_timeout => '连接响应时间过长，请检查网络连接后重试。';

  @override
  String get telemetry_error_dns_lookup_failed => '找不到服务器地址，请检查网络连接或服务器网址。';

  @override
  String get telemetry_error_http_error_status => '服务器拒绝了此请求，请稍后重试。';

  @override
  String get telemetry_error_http_unknown_error => '与服务器通信时发生意外错误。';

  @override
  String get telemetry_error_invalid_url => '服务器地址无效，请检查您的设置。';

  @override
  String get telemetry_error_network_error => '发生网络错误，请检查网络连接后重试。';

  @override
  String get telemetry_error_socket_error => '发生网络连接问题，请检查您的网络连接。';

  @override
  String get telemetry_error_transport_exception => '发送数据时出现问题，请重试。';

  @override
  String get terms => '服务条款';

  @override
  String get upload_screen_attempt_time => '尝试时间:';

  @override
  String get upload_screen_error => '错误:';

  @override
  String get upload_screen_failed => '失败';

  @override
  String get upload_screen_load_error => '无法加载上传记录。';

  @override
  String get upload_screen_log_not_exists => '上传记录已不存在。';

  @override
  String get upload_screen_next => '下次上传于 ...';

  @override
  String get upload_screen_next_upload_prefix => '下次上传于';

  @override
  String get upload_screen_no_data_server => '请先设置数据服务器。';

  @override
  String get upload_screen_no_logs => '暂无上传记录。';

  @override
  String get upload_screen_payload_count => '数据数量';

  @override
  String get upload_screen_payload_count_label => '数据数量:';

  @override
  String get upload_screen_payload_size => '数据大小:';

  @override
  String get upload_screen_result => '结果:';

  @override
  String get upload_screen_retry => '重试次数:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => '成功';

  @override
  String get upload_screen_today => '今天';

  @override
  String get upload_screen_upload_now => '立即上传';

  @override
  String get upload_screen_upload_success => '上传成功。';

  @override
  String get upload_screen_uploading => '上传中...';

  @override
  String get upload_screen_yesterday => '昨天';

  @override
  String get url_screen_invalid_rtsp_error => 'RTSP URL 必须包含主机名。';

  @override
  String get url_screen_invalid_url_error => '请输入使用受支持协议的有效 URL。';

  @override
  String get url_screen_subtitle => '请输入直播流网址';

  @override
  String get url_screen_title => '直播流网址';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => '网址';

  @override
  String get url_screen_url_empty_error => '请输入直播 URL。';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream 或 rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => '后置摄像头';

  @override
  String get video_sources_camera => '相机';

  @override
  String get video_sources_file => '文件';

  @override
  String get video_sources_front_camera => '前置摄像头';

  @override
  String get video_sources_live_stream => '直播流网址';

  @override
  String get video_sources_screen_camera_not_found_message => '使用此功能需要相机权限。';

  @override
  String get video_sources_screen_camera_not_found_title => '找不到相机';

  @override
  String get video_sources_screen_import_error => '无法导入视频文件。';

  @override
  String get video_sources_screen_photos_denied_msg => '请前往设置并允许此应用的照片访问权限。';

  @override
  String get video_sources_screen_select_camera => '点击选择此摄像头';

  @override
  String get video_sources_screen_select_file => '点击选择文件';

  @override
  String get video_sources_screen_select_live => '点击设置直播流 URL';

  @override
  String get video_sources_webcam => '网络摄像头';
}
