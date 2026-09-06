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
  String get about_screen_email_us => 'メールでのお問い合わせ';

  @override
  String get about_screen_platform => 'プラットフォーム';

  @override
  String get appeared => '出現';

  @override
  String get appeared_help =>
      '最初に検出された位置がこのエリア内だった人や車両をカウントします。\\n\\nトラッキングがどこから始まったかを確認するのに役立ちます。\\n\\n（主に上級ユーザー向け）';

  @override
  String get average_occupancy => '平均人数';

  @override
  String get average_occupancy_help =>
      '現在の集計時間における、このエリア内の平均人数または車両数を表示します。\\n\\n集計時間全体を通して、このエリアがどれくらい混雑していたかを把握できます。';

  @override
  String get average_stay => '平均滞在時間';

  @override
  String get average_stay_help =>
      'このエリア内に人や車両が滞在した平均時間を表示します。\\n\\n平均滞在時間が長いほど、利用者がこのエリアでより長く過ごしていることを示す場合があります。';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter はカメラとデバイス上のAIを使用して人をカウントします。まず、お使いの端末が対応しているか確認しましょう。';

  @override
  String get camera_test_screen_instruction =>
      'カメラを人に向けてください。検出した人の周りに枠が表示されます。';

  @override
  String get camera_test_screen_next => '続けるには［次へ］をタップしてください。';

  @override
  String get camera_test_screen_start =>
      '［開始］をタップしてください。求められた場合はカメラへのアクセスを許可してください。';

  @override
  String get camera_test_screen_test_failed => 'テストに失敗しました！';

  @override
  String get camera_test_screen_test_passed => 'テストに合格しました！';

  @override
  String get camera_test_screen_title => 'AIカメラテスト';

  @override
  String get camera_test_screen_wait => 'AIが人を検出するのを待っています…';

  @override
  String get cta_screen_custom => '自分のサーバーを使用';

  @override
  String get cta_screen_custom_help => '交通データを自分のバックエンドまたはデータベースへ直接送信します。';

  @override
  String get cta_screen_footer =>
      '続行することで、利用規約、プライバシーポリシー、およびデータ処理契約に同意したものとみなされます。';

  @override
  String get cta_screen_invitation => '招待コードを使用';

  @override
  String get cta_screen_invitation_help => '管理者からの招待を使って既存の組織に参加します。';

  @override
  String get cta_screen_local => 'この端末のみ';

  @override
  String get cta_screen_local_help => '交通データはこの端末のみに保存されます。データはアップロードされません。';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud を使用';

  @override
  String get cta_screen_piyuo_help =>
      'Piyuo Cloud に交通データを保存し、ダッシュボードやビジネス分析を利用できます。';

  @override
  String get cta_screen_premium => 'プレミアム';

  @override
  String get cta_screen_title =>
      'Piyuo Counter は5分ごとに匿名の交通統計データを作成します。\\nデータの保存方法とアクセス方法を選択してください。';

  @override
  String get current_occupancy => '現在の数';

  @override
  String get current_occupancy_help =>
      'このエリア内の人や車両の現在の数を表示します。\\n\\nこの数値はリアルタイムで更新され、AI検出が画面に表示されている内容と一致しているか確認するのに役立ちます。この数値はアップロードされるテレメトリデータには含まれません。';

  @override
  String get custom_server_screen_bearer_saving_action => '保存中...';

  @override
  String get custom_server_screen_server_url_label => 'サーバーURL';

  @override
  String get detection_screen_confidence => '信頼度しきい値';

  @override
  String get detection_screen_confidence_dialog =>
      '人や車両をカウントする前に、AIがどれだけ確信を持つ必要があるかを設定します。\\n値を低くすると\\n• より多くの物体を検出\\n• 遠くや一部隠れた物体に有効\\n• 誤検出が増える場合がある\\n値を高くすると\\n• 信頼度の高い検出のみカウント\\n• 誤検出を減らす\\n• 小さい物体や難しい物体を見逃す場合がある\\n人や車両を見逃す場合は、値を低くしてください。\\n影や反射などの誤検出が多い場合は、値を高くしてください。';

  @override
  String get detection_screen_confidence_help => '物体を検出するために必要な最小信頼度。';

  @override
  String get detection_screen_confidence_max_label => '厳格';

  @override
  String get detection_screen_confidence_min_label => '緩い';

  @override
  String get detection_screen_disappear => '消失タイムアウト';

  @override
  String get detection_screen_disappear_dialog =>
      '物体が検出されなくなってから、AIが「消失」と判断するまでの待機時間を設定します。\\n値を短くすると\\n• 物体をより早く消失と判断\\n• 速い交通に有効\\n• 一時的に隠れた物体を誤って消失と判断する場合がある\\n値を長くすると\\n• 消失と判断するまで長く待機\\n• 物体が短時間遮られたり見逃されたりする場合に有効\\n• 消失イベントが遅延';

  @override
  String get detection_screen_disappear_help =>
      'AIが物体を検出できなくなってから、消失と判断するまでの待機時間です。';

  @override
  String get detection_screen_disappear_max_label => '遅い';

  @override
  String get detection_screen_disappear_min_label => '速い';

  @override
  String get detection_screen_memory_dialog =>
      '物体が消えた後、AIがどれくらいの時間それを覚えているかを設定します。\\n人や車両が他の物体の後ろに隠れることが多い場合は、この値を上げてください。\\nシーンを離れた後に物体が誤って結び付けられる場合は、この値を下げてください。';

  @override
  String get detection_screen_min_presence => '最小表示時間';

  @override
  String get detection_screen_min_presence_help =>
      '物体は一定時間見えてからカウントされます。長い値ほど一時的な誤検出を減らせます。';

  @override
  String get detection_screen_min_presence_max_label => '安全重視';

  @override
  String get detection_screen_min_presence_min_label => '速い';

  @override
  String get detection_screen_minimum_visible =>
      '物体はカウントされる前に、この時間だけ表示され続ける必要があります。\\n短い誤検出を無視するには、この値を上げてください。\\n速く動く人や車両が見逃される場合は、この値を下げてください。';

  @override
  String get detection_screen_new_track => '新しい追跡のしきい値';

  @override
  String get detection_screen_new_track_help =>
      '新しい物体の追跡を開始するために必要な最小信頼度です。低い値では重複した追跡が作成される場合があります。';

  @override
  String get detection_screen_new_track_max_label => '慎重';

  @override
  String get detection_screen_new_track_min_label => '積極的';

  @override
  String get detection_screen_reset => 'リセット';

  @override
  String get detection_screen_reset_content => '検出設定をリセットしてもよろしいですか？';

  @override
  String get detection_screen_show_track_id => 'トラック ID を表示';

  @override
  String get detection_screen_show_track_id_help =>
      'このオプションを有効にして、追跡される各オブジェクトの一意なトラック ID を表示します。';

  @override
  String get detection_screen_stay => '滞在時間';

  @override
  String get detection_screen_stay_help =>
      '物体が滞在としてカウントされるまでにエリア内に留まる必要がある時間です。';

  @override
  String get detection_screen_stay_max_label => '遅延';

  @override
  String get detection_screen_stay_min_label => '即時';

  @override
  String get detection_screen_stay_threshold =>
      '物体が「滞在」カウントに寄与するタイミングを決定します。\\n値を短くすると\\n• 滞在をすぐにカウント\\n• 迅速な分析に有効\\n値を長くすると\\n• 短時間の通過を無視\\n• 滞在人数の測定に有効';

  @override
  String get detection_screen_subtitle => 'AIが物体を検出・追跡する方法を調整します。';

  @override
  String get detection_screen_title => '追跡とカウント';

  @override
  String get detection_screen_track_dialog =>
      '新しく検出された物体がいつ新しいトラックになるかを設定します。\\n値を低くすると\\n• 追跡がより早く始まる\\n• 速く動く物体に有効\\n• 重複したトラックが発生する場合がある\\n値を高くすると\\n• 新しいトラック作成前により強い証拠が必要\\n• 重複トラックを減らす\\n• 新しい物体の追跡が遅れる場合がある';

  @override
  String get detection_screen_track_memory => '追跡保持時間';

  @override
  String get detection_screen_track_memory_help =>
      '一時的に見失った後も、どれくらい追跡を維持するかを設定します。長いほど短時間の遮蔽から復帰しやすくなります。';

  @override
  String get detection_screen_track_memory_max_label => '長い';

  @override
  String get detection_screen_track_memory_min_label => '短い';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter はカメラを使用して歩行者や車両をリアルタイムで検出します。このデバイスではカメラを利用できません。';

  @override
  String get device_not_supported_screen_footer_hint =>
      'お使いのスマートフォンでこのアプリを開いてみてください';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'カメラ付きのスマートフォンまたはタブレット';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'iOSまたはAndroid端末を推奨';

  @override
  String get device_not_supported_screen_requirements_title => '必要なもの';

  @override
  String get device_not_supported_screen_title => 'カメラが見つかりません';

  @override
  String get disappeared => '消失';

  @override
  String get disappeared_help =>
      '最後に検出された位置がこのエリア内だった人や車両をカウントします。\\n\\n設定された消失時間を過ぎても検出されない場合、トラッキングは終了します。\\n\\n（主に上級ユーザー向け）';

  @override
  String get dpa => 'データ処理契約';

  @override
  String get durationDaysShort => '%s日';

  @override
  String get durationHoursShort => '%s時';

  @override
  String get durationMinutesShort => '%s分';

  @override
  String get durationSecondsShort => '%s秒';

  @override
  String get durationTwoUnit => '%first%second';

  @override
  String get entered => '入場';

  @override
  String get entered_help =>
      '現在の集計時間内にこのエリアへ入った人や車両をカウントします。\\n\\n人や車両がエリアの外から内へ移動したときに1回カウントされます。';

  @override
  String get exited => '退出';

  @override
  String get exited_help =>
      '現在の集計時間内にこのエリアから出た人や車両をカウントします。\\n\\n人や車両がエリア内から外へ移動したときに1回カウントされます。';

  @override
  String get language_screen_language => '言語';

  @override
  String get language_screen_subtitle => 'アプリで使用する言語を選択します。';

  @override
  String get local_only_screen_body =>
      '「ローカルデバイスのみ」モードでは、データをアップロードせずにAIカメラの検出・追跡を試せます。来訪者統計はすべてこの端末内だけで処理されます。サーバーに接続する前のお試しに最適です。';

  @override
  String get local_only_screen_use_action => 'この端末のみ使用';

  @override
  String get local_screen_text =>
      'Piyuo Counter はこの端末だけで動作します。\\n交通統計データはこの端末のみに保存され、アップロードされません。\\n後から設定で Piyuo Cloud またはご自身のサーバーに接続できます。';

  @override
  String get maximum_occupancy => '最大人数';

  @override
  String get maximum_occupancy_help =>
      '現在の集計時間内で、このエリア内に同時に存在した人や車両の最大数を表示します。\\n\\n混雑や交通量のピークを把握するのに役立ちます。';

  @override
  String get maximum_stay => '最大滞在時間';

  @override
  String get maximum_stay_help =>
      '現在の集計時間内で、このエリア内に人や車両が滞在した最長時間を表示します。\\n\\n通常より長い滞在や停止を把握するのに役立ちます。';

  @override
  String get metric_events => 'イベント';

  @override
  String get metric_live => 'ライブ';

  @override
  String get metric_show_less => '表示を減らす';

  @override
  String get metric_show_more => 'もっと表示';

  @override
  String get metric_statistics => '統計';

  @override
  String get metrics_counting_all => 'すべて';

  @override
  String get metrics_counting_done => '完了';

  @override
  String get metrics_counting_in_progress => '進行中';

  @override
  String get metrics_counting_missing => '欠落';

  @override
  String get metrics_counting_window => '5分ごとの統計データ';

  @override
  String get onboarding_back_action => '戻る';

  @override
  String get onboarding_cta_no_server => 'データをアップロードしたくないですか？';

  @override
  String get onboarding_cta_title => 'データの送信先を選んでください';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counterは端末のカメラと内蔵AIで、人や車をその場で見分けます。\\n検出・追跡技術により、歩行者と車両の通行量を自動でカウント — すべてお使いの端末だけで完結します。';

  @override
  String get onboarding_intro_text2 =>
      'AIのすべての処理は端末内で完結します。動画、画像、顔、個人情報がアップロードされることはありません。\\n5分ごとの匿名の集計データのみ共有されます。内容はカウント数、滞在人数、入場・退場数、滞在時間の統計です。';

  @override
  String get onboarding_intro_text3 =>
      'アプリを起動したままにしておくだけです。Piyuo Counterが交通データを自動で継続的に収集・保存します。\\n5分ごとにデータをまとめて保存し、1時間ごとにPiyuo Cloudまたはご自身のサーバーにアップロードします。';

  @override
  String get onboarding_intro_title1 => 'AI交通カウント';

  @override
  String get onboarding_intro_title2 => 'プライバシーを最優先';

  @override
  String get onboarding_intro_title3 => '24時間365日自動で動作';

  @override
  String get onboarding_next_action => '次へ';

  @override
  String get onboarding_skip_action => 'イントロをスキップ';

  @override
  String get onboarding_start_action => '開始';

  @override
  String get passed_by => '通過';

  @override
  String get passed_by_help =>
      '現在の集計時間内にこのエリアを通過した人や車両をカウントします。\\n\\n人や車両は、このエリアを通過するたびに1回だけカウントされます。';

  @override
  String get payloads_screen_area => 'エリア';

  @override
  String get payloads_screen_confidence => '信頼度';

  @override
  String get payloads_screen_coverage => 'カバー率';

  @override
  String get payloads_screen_delivered => '配信済み';

  @override
  String get payloads_screen_failed_load => '最近のペイロードを読み込めませんでした';

  @override
  String get payloads_screen_frame_processed => '処理済みフレーム';

  @override
  String get payloads_screen_hour_not_exists => 'この時間は存在しません。';

  @override
  String get payloads_screen_missing_time => '不足時間';

  @override
  String get payloads_screen_no_payloads => 'まだペイロードはありません。';

  @override
  String get payloads_screen_partial => 'ウィンドウが早く終了しました（一部）';

  @override
  String get payloads_screen_partially => '一部配信済み';

  @override
  String get payloads_screen_payload_not_exists => 'このペイロードは存在しません。';

  @override
  String get payloads_screen_pending => '配信待ち';

  @override
  String get payloads_screen_process_fps => '処理FPS';

  @override
  String get payloads_screen_resend => '再送信';

  @override
  String get payloads_screen_select_first => '最初に少なくとも1つの日付または時間を選択してください。';

  @override
  String get payloads_screen_subtitle => '日付または時間を選択して再送信';

  @override
  String get payloads_screen_title => '最近のペイロード';

  @override
  String get personal_custom_screen_build_server =>
      '独自サーバーの設定でお困りですか？\\nAPIドキュメントとサーバーのサンプルをご覧ください。';

  @override
  String get personal_custom_screen_help_action => 'APIドキュメントを開く';

  @override
  String get personal_custom_screen_reset_action => '最初からやり直す';

  @override
  String get personal_custom_success_screen_help => '下の Start をタップして計測を開始します。';

  @override
  String get personal_custom_success_screen_help1 =>
      '交通統計データは1時間ごとに自動送信されます。\\nアップロードログ画面から手動送信することもできます。';

  @override
  String get personal_custom_success_screen_help2 =>
      'サーバーはまだオンラインである必要はありません。\\n今すぐ計測を開始できます。サーバーの構築やテストは後から行えます。交通統計データはアップロードが成功するまで、この端末に保存されます。';

  @override
  String get personal_custom_success_screen_send_to => 'トラフィック統計の送信先';

  @override
  String get personal_custom_success_screen_title => 'サーバーの準備ができました';

  @override
  String get piyuo_server_screen_cloud_url_label => 'あなたのPiyuo Cloud URL';

  @override
  String get piyuo_server_screen_copy_action => 'URLをコピー';

  @override
  String get piyuo_server_screen_copy_success => 'URLをコピーしました';

  @override
  String get piyuo_server_screen_saving_action => '保存中...';

  @override
  String get piyuo_server_screen_start => '下の「Start」を押してカウントを開始してください。';

  @override
  String get piyuo_server_screen_url_help =>
      'あなた専用の Piyuo Cloud ダッシュボードはこちらのURLで利用できます。';

  @override
  String get piyuo_server_screen_url_remember =>
      '別のデバイスからダッシュボードにアクセスできるよう、このURLを保存してください。';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloudを使用';

  @override
  String get privacy => 'プライバシーポリシー';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'AIによる人物・車両カウント.';

  @override
  String get settings_screen_custom_subtitle =>
      'トラフィックデータを独自のバックエンドまたはデータベースへ直接送信します。';

  @override
  String get settings_screen_custom_title => 'カスタムサーバーを使用';

  @override
  String get settings_screen_data_server_label => 'データサーバー';

  @override
  String get settings_screen_detection_target => '検出対象';

  @override
  String get settings_screen_language_title => '言語';

  @override
  String get settings_screen_local_subtitle =>
      'トラフィックデータはこの端末のみに保存されます。アップロードは行われません。';

  @override
  String get settings_screen_local_title => 'この端末のみ';

  @override
  String get settings_screen_misc_label => 'その他';

  @override
  String get settings_screen_object_detection => '物体検出';

  @override
  String get settings_screen_piyuo_subtitle =>
      'トラフィックデータをPiyuo Cloudに保存し、ダッシュボードやビジネス分析を利用できます。';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'すべてのデータが削除され、最初からやり直します。この操作は元に戻せません。';

  @override
  String get settings_screen_reset_all_data_title => 'すべてのデータをリセットしますか？';

  @override
  String get settings_screen_subscription_body => 'サブスクリプションと請求情報を管理します';

  @override
  String get settings_screen_subscription_title => 'サブスクリプション';

  @override
  String get start_screen_about => 'アプリについて';

  @override
  String get start_screen_server_none => 'データはこの端末にのみ保存されます';

  @override
  String get start_screen_server_personal => 'データは1時間ごとにアップロードされます';

  @override
  String get start_screen_settings => '設定';

  @override
  String get start_screen_upload_logs => 'ログをアップロード';

  @override
  String get start_screen_video_sources => 'ビデオソース';

  @override
  String get stayed => '滞在';

  @override
  String get stayed_help =>
      '設定された滞在時間以上、このエリア内にとどまった人や車両をカウントします。\\n\\n初期設定の滞在時間は15秒で、設定から変更できます。';

  @override
  String get target_pedestrian => '歩行者';

  @override
  String get target_pedestrian_help => '歩行者検出モデルで人数をカウントします';

  @override
  String get target_screen_subtitle => '使用する検出モデルを選択';

  @override
  String get target_vehicle => '車両';

  @override
  String get target_vehicle_help => '車両検出モデルで車やその他の車両をカウントします';

  @override
  String get telemetry_error_connection_refused =>
      'サーバーに接続できませんでした。現在オフラインの可能性があります。';

  @override
  String get telemetry_error_connection_reset =>
      '接続がリセットされました。インターネット接続を確認して、もう一度お試しください。';

  @override
  String get telemetry_error_connection_timeout =>
      '接続の応答に時間がかかりすぎました。インターネット接続を確認して、もう一度お試しください。';

  @override
  String get telemetry_error_database_error => 'データベースへの書き込みに失敗しました。';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'サーバーのアドレスが見つかりませんでした。インターネット接続またはサーバーURLを確認してください。';

  @override
  String get telemetry_error_http_error_status =>
      'サーバーがリクエストを拒否しました。しばらくしてからもう一度お試しください。';

  @override
  String get telemetry_error_http_unknown_error => 'サーバーとの通信中に予期しないエラーが発生しました。';

  @override
  String get telemetry_error_invalid_url => 'サーバーのアドレスが無効です。設定を確認してください。';

  @override
  String get telemetry_error_network_error =>
      'ネットワークエラーが発生しました。インターネット接続を確認して、もう一度お試しください。';

  @override
  String get telemetry_error_socket_error =>
      'ネットワーク接続の問題が発生しました。インターネット接続を確認してください。';

  @override
  String get telemetry_error_transport_exception =>
      'データの送信中に問題が発生しました。もう一度お試しください。';

  @override
  String get telemetry_error_unknown_error => '予期しないエラーが発生しました。';

  @override
  String get terms => '利用規約';

  @override
  String get upload_screen_attempt_time => '試行時刻:';

  @override
  String get upload_screen_error => 'エラー:';

  @override
  String get upload_screen_failed => '失敗';

  @override
  String get upload_screen_load_error => 'アップロード履歴を読み込めませんでした。';

  @override
  String get upload_screen_log_not_exists => 'アップロード履歴は利用できません。';

  @override
  String get upload_screen_next => '次回アップロード ...';

  @override
  String get upload_screen_next_upload_prefix => '次回アップロード ';

  @override
  String get upload_screen_no_data_server => '先にデータサーバーを設定してください。';

  @override
  String get upload_screen_no_logs => 'アップロード履歴はありません。';

  @override
  String get upload_screen_payload_count => 'ペイロード数';

  @override
  String get upload_screen_payload_count_label => 'ペイロード数:';

  @override
  String get upload_screen_payload_size => 'ペイロードサイズ:';

  @override
  String get upload_screen_result => '結果:';

  @override
  String get upload_screen_retry => '再試行回数:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => '成功';

  @override
  String get upload_screen_today => '今日';

  @override
  String get upload_screen_upload_now => '今すぐアップロード';

  @override
  String get upload_screen_upload_success => 'アップロードしました。';

  @override
  String get upload_screen_uploading => 'アップロード中...';

  @override
  String get upload_screen_yesterday => '昨日';

  @override
  String get url_screen_invalid_rtsp_error => 'RTSP URLにはホスト名が必要です。';

  @override
  String get url_screen_invalid_url_error => 'サポートされているスキームの有効なURLを入力してください。';

  @override
  String get url_screen_subtitle => 'ライブストリームURLを入力してください';

  @override
  String get url_screen_title => 'ライブストリームURL';

  @override
  String get url_screen_unsupported_scheme_error =>
      ' and RTSPS URLs are supported.';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'ライブ配信URLを入力してください。';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream または rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => '背面カメラ';

  @override
  String get video_sources_camera => 'カメラ';

  @override
  String get video_sources_file => 'ファイル';

  @override
  String get video_sources_front_camera => 'フロントカメラ';

  @override
  String get video_sources_live_stream => 'ライブストリームURL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'カメラを使用するには権限の許可が必要です';

  @override
  String get video_sources_screen_camera_not_found_title => 'カメラが見つかりません';

  @override
  String get video_sources_screen_import_error => '動画ファイルをインポートできませんでした。';

  @override
  String get video_sources_screen_photos_denied_msg =>
      '設定に移動して、このアプリの写真へのアクセスを許可してください。';

  @override
  String get video_sources_screen_select_camera => 'このカメラを選択';

  @override
  String get video_sources_screen_select_file => 'ファイルを選択';

  @override
  String get video_sources_screen_select_live => 'ライブ配信URLを設定';

  @override
  String get video_sources_webcam => 'ウェブカメラ';
}
