// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class LocalizationJa extends Localization {
  LocalizationJa([String locale = 'ja']) : super(locale);

  @override
  String get about_screen_app_version => 'アプリバージョン';

  @override
  String get about_screen_benchmark => 'ベンチマーク';

  @override
  String get about_screen_models => '物体検出モデル';

  @override
  String get about_screen_opencv_build_info => 'OpenCV ビルド情報';

  @override
  String get about_screen_platform => 'プラットフォーム';

  @override
  String get about_screen_title => 'アプリについて';

  @override
  String get add_video_screen_from => '以下から映像ソースを追加';

  @override
  String get add_video_screen_title => '映像ソースを追加';

  @override
  String get back => '戻る';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => '物体検出モデル';

  @override
  String get benchmark_screen_recommended => '推奨モデル';

  @override
  String get benchmark_screen_start_button => 'ベンチマーク開始';

  @override
  String get benchmark_screen_start_failed => 'ベンチマークの開始に失敗しました。エラーコード：';

  @override
  String get benchmark_screen_title => 'モデルベンチマーク';

  @override
  String get camera_screen_add_title => 'カメラを追加';

  @override
  String get camera_screen_back_camera => 'バックカメラ';

  @override
  String get camera_screen_edit_title => 'カメラを選択';

  @override
  String get camera_screen_front_camera => 'フロントカメラ';

  @override
  String get camera_screen_zoom_level => 'ズームレベル';

  @override
  String get cancel => 'キャンセル';

  @override
  String get close => '閉じる';

  @override
  String get color_screen_title => '色を選択';

  @override
  String get counter_screen_cooldown_desc =>
      '検出ゾーンを退出した後、再入場するには #0 秒のクールダウンが必要です';

  @override
  String get counter_screen_cooldown_in_seconds => '秒単位';

  @override
  String get counter_screen_cooldown_threshold => 'クールダウンしきい値';

  @override
  String get counter_screen_cooldown_time => 'クールダウン時間';

  @override
  String get counter_screen_enabled => '有効';

  @override
  String get counter_screen_enabled_error => 'エラー';

  @override
  String get counter_screen_enabled_error_content =>
      '先に他のカウンターを有効にする必要があります。その後、このカウンターを無効にできます';

  @override
  String get counter_screen_name_error => 'カウンター名は空にできません';

  @override
  String get counter_screen_reentry_desc =>
      'オブジェクトが検出ゾーンを退出してから再入場するまでに #1 秒のクールダウン時間で #0 回入場すると、再入場としてカウントされます';

  @override
  String get counter_screen_reentry_threshold => '再入場しきい値';

  @override
  String get counter_screen_reentry_title => '再入場カウント';

  @override
  String get counter_screen_show_on => '画面に表示';

  @override
  String get counter_screen_stagnant_consider => '滞留と見なす';

  @override
  String get counter_screen_stagnant_desc => '#0 秒以上静止している物体は滞留と見なされます';

  @override
  String get counter_screen_stagnant_desc_prefix => '説明の接頭辞';

  @override
  String get counter_screen_stagnant_desc_suffix => '説明の接尾辞';

  @override
  String get counter_screen_stagnant_in_seconds => '秒単位';

  @override
  String get counter_screen_stagnant_threshold => '滞留しきい値';

  @override
  String get default_project_name => 'プロジェクト';

  @override
  String get default_video_name => '映像ソース';

  @override
  String get default_zone_name => '検出ゾーン';

  @override
  String get detection_screen_confidence => '信頼度';

  @override
  String get detection_screen_confidence_desc => '信頼度が #0 を超えると有効な検出と見なされます';

  @override
  String get detection_screen_consider_valid => '有効とみなす期間';

  @override
  String get detection_screen_consider_valid_desc => '追跡対象は #0 後に有効と見なされます';

  @override
  String get detection_screen_high => '高';

  @override
  String get detection_screen_lost => 'ロスト';

  @override
  String get detection_screen_lost_desc =>
      '動きの速さに基づいて、失われたオブジェクトの削除時間を#0から#1の間で動的に決定します';

  @override
  String get detection_screen_low => '低';

  @override
  String get detection_screen_match => 'マッチ';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThresholdは物体追跡における重要なパラメータで異なる検出ボックス間の一致度を測定します。低い値は物体の関連付けを容易にしますが誤った関連付けのリスクが高まります。高い値は物体の関連付けにより厳格ですが一部の真の一致を見逃す可能性があります。';

  @override
  String get detection_screen_models => 'モデル';

  @override
  String get detection_screen_nms => '非最大値抑制';

  @override
  String get detection_screen_nms_desc =>
      '#0 低いNMSしきい値(例:0.3-0.4)は重複するボックスをより厳格に削除し偽陽性を減らしますが重複する人物を見逃す可能性があります。高いしきい値(0.7-0.9)はより多くのボックスを保持し偽陽性が増える可能性がありますが重複する人物をより良く検出します。';

  @override
  String get detection_screen_reset => 'リセット';

  @override
  String get detection_screen_reset_content => '検出設定をリセットしてもよろしいですか？';

  @override
  String get detection_screen_title => '検出設定';

  @override
  String get error_content => '予期しないエラーが発生しました。メールでレポートを送信しますか？';

  @override
  String get error_oops => '申し訳ありません、問題が発生しました';

  @override
  String get error_report => 'メールでお問い合わせ';

  @override
  String get filter_screen_desc => '以下のリストからフィルター範囲を選択してください';

  @override
  String get filter_screen_error_content => '終了時間は開始時間より後である必要があります';

  @override
  String get filter_screen_error_custom => 'カスタム';

  @override
  String get filter_screen_error_end => '終了';

  @override
  String get filter_screen_error_start => '開始';

  @override
  String get filter_screen_error_title => 'フィルター';

  @override
  String get filter_screen_title => 'フィルター';

  @override
  String get language_screen_language => '言語';

  @override
  String get no => 'いいえ';

  @override
  String get objects_screen_desc => '人、車、バスなどの検出対象を選択します。';

  @override
  String get objects_screen_title => 'オブジェクト';

  @override
  String get ok => 'OK';

  @override
  String get open_project_screen_desc => '以前に作成したプロジェクトを開きます。最新の20件のみ保持されます。';

  @override
  String get open_project_screen_no_project => 'プロジェクトが見つかりません。';

  @override
  String get open_project_screen_title => 'プロジェクトを開く';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get product_desc => 'コンピュータービジョンとAIを使用して、人、車両、ペットなどをカウントします。';

  @override
  String get product_name => 'カウンター';

  @override
  String get project_screen_add_video_button => '映像ソースを追加';

  @override
  String get project_screen_exit_button => '終了';

  @override
  String get project_screen_exit_confirm_content =>
      'プロジェクトを終了するとカウントが停止します。続行しますか？';

  @override
  String get project_screen_exit_confirm_title => 'プロジェクト終了の確認';

  @override
  String get project_screen_from_desc =>
      '24時間のローリング記録を保持しているため、必要な時間帯をいつでも確認できます。';

  @override
  String get project_screen_report_settings => '設定';

  @override
  String get project_screen_title => 'プロジェクト';

  @override
  String get project_view_no_videos => '利用可能な映像ソースがありません。';

  @override
  String get settings_screen_center_point_button => '対象物の中心点を表示';

  @override
  String get settings_screen_center_point_desc =>
      '中心点は対象物がヒットゾーン内にあるかどうかを判断するのに役立ちます。';

  @override
  String get settings_screen_center_point_title => '対象物の中心点';

  @override
  String get settings_screen_delete_button => '削除';

  @override
  String get settings_screen_delete_content => 'このプロジェクトを削除してもよろしいですか？';

  @override
  String get settings_screen_delete_header => 'このプロジェクトを削除';

  @override
  String get settings_screen_desc => 'プロジェクト名、検出パラメーター、カウントのクリアを設定します。';

  @override
  String get settings_screen_lost_target_button => 'ロストターゲットを表示';

  @override
  String get settings_screen_lost_target_desc =>
      '物体追跡が対象物を見失った場合、このオプションで表示できます。デフォルトでは、ロストターゲットは表示されません。';

  @override
  String get settings_screen_lost_target_title => 'ロストターゲット';

  @override
  String get settings_screen_project_error => 'プロジェクト名は空にできません';

  @override
  String get settings_screen_project_id => 'プロジェクトID';

  @override
  String get settings_screen_project_name => 'プロジェクト名';

  @override
  String get settings_screen_project_name_place_holder => '渋谷交差点 または 新宿駅南口';

  @override
  String get settings_screen_random_count_button => 'ランダムカウントを追加';

  @override
  String get settings_screen_reset_count_button => 'カウントをリセット';

  @override
  String get settings_screen_reset_count_content => 'すべてのカウントをリセットしてもよろしいですか？';

  @override
  String get settings_screen_reset_count_header => 'このプロジェクト内のすべてのカウントをリセット';

  @override
  String get settings_screen_title => '設定';

  @override
  String get submit => '送信';

  @override
  String get url_screen_desc => 'ライブストリームURLを入力してください';

  @override
  String get url_screen_title => 'ライブストリームURL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream または rtsp://example.com/stream';

  @override
  String get video_screen_add_point => '現在のゾーンにポイントを追加';

  @override
  String get video_screen_add_zone => '検出ゾーンを追加';

  @override
  String get video_screen_change_file => 'ファイルを変更';

  @override
  String get video_screen_delete_button => '削除';

  @override
  String get video_screen_delete_content => 'この映像ソースを削除してもよろしいですか？';

  @override
  String get video_screen_delete_header => 'この映像ソースを削除';

  @override
  String get video_screen_desc => '映像ソースの管理、検出ゾーンの追加または変更を行います。';

  @override
  String get video_screen_detection => 'モデルパラメータ';

  @override
  String get video_screen_edit_placeholder => '正面玄関カメラ または 駐車場カメラ';

  @override
  String get video_screen_move_bottom => '現在のゾーンを一番下に移動';

  @override
  String get video_screen_name_empty => '映像名を空にすることはできません。';

  @override
  String get video_screen_playback_14x => '1/4倍速';

  @override
  String get video_screen_playback_2x => '2倍速';

  @override
  String get video_screen_playback_current => '現在: ';

  @override
  String get video_screen_playback_speed => '再生速度';

  @override
  String get video_screen_remove_point => '現在のゾーンからポイントを削除';

  @override
  String get video_screen_sources => '画像ソース、検出対象、モデルパラメータを設定します。';

  @override
  String get video_screen_targets => '検出対象';

  @override
  String get video_screen_tools => 'ツール';

  @override
  String get video_screen_video_name => '映像ソース名';

  @override
  String get video_screen_zones => '検出ゾーン';

  @override
  String get video_screen_zones_desc => 'ドラッグ＆ドロップでゾーンを調整';

  @override
  String get video_sources_camera => 'カメラ';

  @override
  String get video_sources_camera_denied => 'カメラへのアクセスが拒否されました';

  @override
  String get video_sources_camera_denied_msg =>
      '設定に移動して、このアプリのカメラへのアクセスを許可してください。';

  @override
  String get video_sources_camera_not_found_message => 'カメラを使用するには権限の許可が必要です';

  @override
  String get video_sources_camera_not_found_title => 'カメラが見つかりません';

  @override
  String get video_sources_file => 'ファイル';

  @override
  String get video_sources_live_stream => 'ライブストリームURL';

  @override
  String get video_sources_photos_denied => '写真へのアクセスが拒否されました';

  @override
  String get video_sources_photos_denied_msg =>
      '設定に移動して、このアプリの写真へのアクセスを許可してください。';

  @override
  String get video_sources_photos_goto_settings => '設定に移動';

  @override
  String get video_sources_webcam => 'ウェブカメラ';

  @override
  String get video_sources_webcam_not_found_message =>
      'アプリの権限とウェブカメラの接続を確認してください';

  @override
  String get video_sources_webcam_not_found_title => 'ウェブカメラが見つかりません';

  @override
  String get webcam_manager_webcam => 'ウェブカメラ';

  @override
  String get webcam_screen_add_title => 'ウェブカメラを追加';

  @override
  String get webcam_screen_edit_title => 'ウェブカメラを選択';

  @override
  String get wizard_screen_about => 'アプリについて';

  @override
  String get wizard_screen_desc => '以下から新しいプロジェクトを作成してカウントを開始します。';

  @override
  String get wizard_screen_email_us => 'メールでのお問い合わせ';

  @override
  String get wizard_screen_language => '言語';

  @override
  String get wizard_screen_new_project_from => '以下から新規プロジェクト';

  @override
  String get wizard_screen_open_projects => '既存のプロジェクトを開く';

  @override
  String get wizard_screen_open_projects_tip => 'すべてのプロジェクトは自動的にローカルに保存されます';

  @override
  String get yes => 'はい';

  @override
  String get zone_screen_can_not_delete => 'ゾーンを削除できません';

  @override
  String get zone_screen_color => '色';

  @override
  String get zone_screen_delete_button => '削除';

  @override
  String get zone_screen_delete_content => 'このゾーンを削除してもよろしいですか？';

  @override
  String get zone_screen_delete_header => 'このゾーンを削除';

  @override
  String get zone_screen_desc =>
      '検出ゾーンでは、検出する物体の種類を設定し、検出済み、発生、入場などの表示するカウンターを選択できます。';

  @override
  String get zone_screen_name_placeholder => '歩道や駐車場など、ゾーンの名前';

  @override
  String get zone_screen_one_zone_required => '少なくとも1つのゾーンが必要です。';

  @override
  String get zone_screen_zone => 'ゾーン';

  @override
  String get zone_screen_zone_color => 'ゾーンの色';

  @override
  String get zone_screen_zone_name_required => 'ゾーン名は空にできません';

  @override
  String get zone_screen_zone_show_summary => '画面に概要を表示';
}
