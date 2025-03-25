// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class LocalizationSw extends Localization {
  LocalizationSw([String locale = 'sw']) : super(locale);

  @override
  String get product_name => 'Kihesabu';

  @override
  String get product_desc => 'Kutumia maono ya kompyuta na akili bandia kuhesabu watu, magari, wanyama vipenzi, na zaidi.';

  @override
  String get product_copyright => 'Hakimiliki © 2025';

  @override
  String get video_sources_webcam => 'Kamera ya wavuti';

  @override
  String get video_sources_live_stream => 'URL ya mubashara';

  @override
  String get video_sources_file => 'Faili';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera haijapatikana';

  @override
  String get video_sources_camera_not_found_message => 'Unahitaji kutoa ruhusa ya kamera kutumia kamera';

  @override
  String get video_sources_webcam_not_found_title => 'Kamera ya wavuti haijapatikana';

  @override
  String get video_sources_webcam_not_found_message => 'Tafadhali angalia kama kamera ya wavuti imeunganishwa';

  @override
  String get wizard_screen_desc => 'Unda mradi mpya hapa chini ili kuanza kuhesabu.';

  @override
  String get wizard_screen_new_project_from => 'Mradi Mpya kutoka';

  @override
  String get wizard_screen_language => 'Lugha';

  @override
  String get wizard_screen_about => 'Kuhusu';

  @override
  String get wizard_screen_open_projects_tip => 'Miradi yote itahifadhiwa kiotomatiki kwenye kifaa';

  @override
  String get wizard_screen_open_projects => 'Fungua mradi uliopo';

  @override
  String get wizard_screen_email_us => 'Tutumie barua pepe';

  @override
  String get language_screen_language => 'Lugha';

  @override
  String get project_view_no_videos => 'Hakuna chanzo cha video kilichopatikana.';

  @override
  String get about_screen_title => 'Kuhusu';

  @override
  String get about_screen_platform => 'Jukwaa';

  @override
  String get about_screen_app_version => 'Toleo la Programu';

  @override
  String get about_screen_models => 'Modeli za kutambua vitu';

  @override
  String get about_screen_benchmark => 'Vigezo vya utendaji';

  @override
  String get about_screen_opencv_build_info => 'Maelezo ya Ujenzi wa OpenCV';

  @override
  String get benchmark_screen_title => 'Vigezo vya Utendaji wa Modeli';

  @override
  String get benchmark_screen_recommended => 'Modeli Inayopendekezwa';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Anza Upimaji wa Vigezo';

  @override
  String get benchmark_screen_start_failed => 'Imeshindwa kuanza upimaji, msimbo wa hitilafu ni';

  @override
  String get benchmark_screen_models => 'Modeli za kutambua vitu';

  @override
  String get project_screen_title => 'Mradi';

  @override
  String get project_screen_exit_confirm_title => 'Thibitisha kutoka kwenye mradi';

  @override
  String get project_screen_exit_confirm_content => 'Kuondoka kwenye mradi kutasimamisha uhesabuji. Je, una uhakika unataka kuendelea?';

  @override
  String get project_screen_exit_button => 'Toka';

  @override
  String get project_screen_add_video_button => 'Ongeza chanzo cha video';

  @override
  String get project_screen_from_desc => 'Tunahifadhi rekodi ya masaa 24 inayoendelea, ili uweze kuona kipindi chochote unachohitaji.';

  @override
  String get project_screen_report_settings => 'Mipangilio';

  @override
  String get filter_screen_title => 'Chuja';

  @override
  String get filter_screen_desc => 'Chagua masafa ya kuchuja kutoka orodha hapa chini';

  @override
  String get filter_screen_error_title => 'Chuja';

  @override
  String get filter_screen_error_content => 'Muda wa kumaliza lazima uwe zaidi ya muda wa kuanza';

  @override
  String get filter_screen_error_custom => 'Desturi';

  @override
  String get filter_screen_error_start => 'Anza';

  @override
  String get filter_screen_error_end => 'Mwisho';

  @override
  String get settings_screen_title => 'Mipangilio';

  @override
  String get settings_screen_desc => 'Weka jina la mradi, vigezo vya kutambua, kusafisha hesabu.';

  @override
  String get settings_screen_project_id => 'Kitambulisho cha Mradi';

  @override
  String get settings_screen_project_name => 'Jina la Mradi';

  @override
  String get settings_screen_project_name_place_holder => '123 Mtaa wa Moi au Bustani ya Uhuru';

  @override
  String get settings_screen_project_error => 'Jina la mradi haliwezi kuwa tupu';

  @override
  String get settings_screen_random_count_button => 'Ongeza hesabu za nasibu';

  @override
  String get settings_screen_reset_count_header => 'Weka upya hesabu zote katika mradi huu';

  @override
  String get settings_screen_reset_count_button => 'Weka upya hesabu';

  @override
  String get settings_screen_reset_count_content => 'Je, una uhakika unataka kuweka upya hesabu zote?';

  @override
  String get settings_screen_delete_header => 'Futa mradi huu';

  @override
  String get settings_screen_delete_content => 'Je, una uhakika unataka kufuta mradi huu?';

  @override
  String get settings_screen_delete_button => 'Futa';

  @override
  String get settings_screen_center_point_title => 'Nukta ya Katikati kwenye Lengo';

  @override
  String get settings_screen_center_point_desc => 'Nukta ya katikati husaidia kuamua ikiwa lengo liko ndani ya eneo la kupatia.';

  @override
  String get settings_screen_center_point_button => 'Onyesha Nukta ya Katikati kwenye Lengo';

  @override
  String get settings_screen_lost_target_title => 'Lengo Lililopotea';

  @override
  String get settings_screen_lost_target_desc => 'Wakati ufuatiliaji wa vitu unapopoteza lengo, chaguo hili hulifanya lionekane. Kwa kawaida, malengo yaliyopotea hayaonyeshwi.';

  @override
  String get settings_screen_lost_target_button => 'Onyesha Lengo Lililopotea';

  @override
  String get detection_screen_title => 'Mipangilio ya Utambuzi';

  @override
  String get detection_screen_models => 'Modeli';

  @override
  String get detection_screen_confidence => 'Uhakika';

  @override
  String get detection_screen_confidence_desc => 'uhakika zaidi ya #0 unachukuliwa kama utambuzi halali';

  @override
  String get detection_screen_low => 'Chini';

  @override
  String get detection_screen_high => 'Juu';

  @override
  String get detection_screen_nms => 'Kutokomeza Yasiyo ya Juu Zaidi';

  @override
  String get detection_screen_nms_desc => '#0 Kizingiti cha NMS cha chini zaidi (k.m., 30%) kitaondoa kwa nguvu zaidi masanduku yanayoingiliana, wakati kizingiti cha NMS cha juu zaidi (k.m., 0.6) kitaruhusu kuingiliana zaidi';

  @override
  String get detection_screen_match => 'Lingana';

  @override
  String get detection_screen_match_desc => 'Kulingana zaidi ya #0 inachukuliwa kuwa kitu hicho hicho.';

  @override
  String get detection_screen_lost => 'Potea';

  @override
  String get detection_screen_lost_desc => 'Ufuatiliaji wa kitu utaondolewa ikiwa kimepotea kwa #0';

  @override
  String get detection_screen_consider_valid => 'Chukulia kuwa halali baada ya';

  @override
  String get detection_screen_consider_valid_desc => 'Ufuatiliaji wa kitu utachukuliwa kuwa halali baada ya #0';

  @override
  String get detection_screen_reset => 'Weka upya';

  @override
  String get detection_screen_reset_content => 'Je, una uhakika unataka kuweka upya mipangilio ya utambuzi?';

  @override
  String get url_screen_title => 'URL ya mubashara';

  @override
  String get url_screen_desc => 'Tafadhali ingiza URL ya mubashara';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream au rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Ongeza chanzo cha Video';

  @override
  String get add_video_screen_from => 'Ongeza chanzo cha video kutoka';

  @override
  String get webcam_screen_add_title => 'Ongeza Kamera ya Wavuti';

  @override
  String get webcam_screen_edit_title => 'Chagua Kamera ya Wavuti';

  @override
  String get webcam_manager_webcam => 'Kamera ya Wavuti';

  @override
  String get camera_screen_front_camera => 'Kamera ya Mbele';

  @override
  String get camera_screen_back_camera => 'Kamera ya Nyuma';

  @override
  String get camera_screen_add_title => 'Ongeza Kamera';

  @override
  String get camera_screen_edit_title => 'Chagua Kamera';

  @override
  String get camera_screen_zoom_level => 'Kiwango cha Kukuza';

  @override
  String get video_screen_name_empty => 'Jina la video haliwezi kuwa tupu.';

  @override
  String get video_screen_desc => 'Simamia vyanzo vya video, ongeza au rekebisha maeneo ya utambuzi.';

  @override
  String get video_screen_video_name => 'Jina la chanzo cha video';

  @override
  String get video_screen_edit_placeholder => 'Kamera ya Mlango wa Mbele au Kamera ya Eneo la Maegesho';

  @override
  String get video_screen_change_file => 'Badilisha Faili';

  @override
  String get video_screen_add_zone => 'Ongeza eneo la utambuzi';

  @override
  String get video_screen_zones => 'Maeneo ya utambuzi';

  @override
  String get video_screen_zones_desc => 'Tumia buruta na achilia kurekebisha maeneo';

  @override
  String get video_screen_tools => 'Zana';

  @override
  String get video_screen_move_bottom => 'Hamisha eneo la sasa hadi chini';

  @override
  String get video_screen_add_point => 'Ongeza nukta kwa eneo la sasa';

  @override
  String get video_screen_remove_point => 'Ondoa nukta kutoka eneo la sasa';

  @override
  String get video_screen_playback_speed => 'Kasi ya Kucheza';

  @override
  String get video_screen_playback_current => 'ya sasa: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Futa chanzo hiki cha video';

  @override
  String get video_screen_delete_content => 'Je, una uhakika unataka kufuta chanzo hiki cha video?';

  @override
  String get video_screen_delete_button => 'Futa';

  @override
  String get video_screen_sources => 'Sanidi chanzo cha picha, malengo ya utambuzi, na vigezo vya modeli.';

  @override
  String get video_screen_targets => 'Malengo ya utambuzi';

  @override
  String get video_screen_detection => 'Vigezo vya modeli';

  @override
  String get color_screen_title => 'Chagua rangi';

  @override
  String get zone_screen_desc => 'Eneo la utambuzi linaweza kuweka aina za vitu vya kutambua na kuchagua vihesabuji vya kuonyesha, kama Vilivyotambuliwa, Vilivyoanzishwa, na Vilivyoingia.';

  @override
  String get zone_screen_name_placeholder => 'Jina la eneo, kama Njia ya Waenda kwa Miguu au Eneo la Maegesho';

  @override
  String get zone_screen_zone_color => 'Rangi ya eneo';

  @override
  String get zone_screen_color => 'Rangi';

  @override
  String get zone_screen_delete_header => 'Futa eneo hili';

  @override
  String get zone_screen_delete_content => 'Je, una uhakika unataka kufuta eneo hili?';

  @override
  String get zone_screen_delete_button => 'Futa';

  @override
  String get zone_screen_can_not_delete => 'Haiwezi kufuta eneo';

  @override
  String get zone_screen_one_zone_required => 'Angalau eneo moja linahitajika.';

  @override
  String get zone_screen_zone_name_required => 'Jina la eneo haliwezi kuwa tupu';

  @override
  String get counter_screen_show_on => 'Onyesha kwenye skrini';

  @override
  String get counter_screen_enabled => 'Imewezeshwa';

  @override
  String get counter_screen_reentry_threshold => 'Kizingiti cha Kuingia Tena';

  @override
  String get counter_screen_reentry_desc => 'Vitu lazima viingie mara #0, na kupumzika kwa sekunde #1 kati ya kila kutoka na kuingia tena, ili kuanzisha kuingia tena';

  @override
  String get counter_screen_reentry_title => 'Hesabu ya kuingia tena';

  @override
  String get counter_screen_cooldown_threshold => 'Kizingiti cha Kupumzika';

  @override
  String get counter_screen_cooldown_desc => 'Kuingia tena kunahitaji kupumzika kwa sekunde #0 baada ya kutoka eneo la utambuzi';

  @override
  String get counter_screen_cooldown_time => 'Muda wa Kupumzika';

  @override
  String get counter_screen_cooldown_in_seconds => 'katika sekunde';

  @override
  String get counter_screen_stagnant_threshold => 'Kizingiti cha Kusimama';

  @override
  String get counter_screen_stagnant_desc => 'Vitu vinavyobaki visivyosogea kwa zaidi ya sekunde #0 vitachukuliwa kuwa vimesimama';

  @override
  String get counter_screen_stagnant_consider => 'Chukulia kama kimesimama';

  @override
  String get counter_screen_stagnant_in_seconds => 'katika sekunde';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Kiambishi cha Maelezo';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Kiambishi cha Mwisho cha Maelezo';

  @override
  String get counter_screen_name_error => 'Jina la kihesabuji haliwezi kuwa tupu';

  @override
  String get counter_screen_enabled_error => 'Hitilafu';

  @override
  String get counter_screen_enabled_error_content => 'Unahitaji kuwezesha kihesabuji kingine kwanza, ndipo uweze kuzima kihesabuji hiki';

  @override
  String get objects_screen_title => 'Vitu';

  @override
  String get objects_screen_desc => 'Chagua malengo ya utambuzi kama mtu, gari, basi, n.k.';

  @override
  String get open_project_screen_title => 'Fungua Mradi';

  @override
  String get open_project_screen_desc => 'Fungua miradi iliyoundwa awali, ukiweka tu miradi 20 ya hivi karibuni.';

  @override
  String get open_project_screen_no_project => 'Hakuna mradi uliopatikana.';

  @override
  String get default_project_name => 'Mradi';

  @override
  String get default_video_name => 'Chanzo cha video';

  @override
  String get default_zone_name => 'Eneo la utambuzi';

  @override
  String get error_oops => 'Samahani, kuna hitilafu imetokea';

  @override
  String get error_content => 'Hitilafu isiyotarajiwa imetokea. Je, ungependa kutuma ripoti kwa barua pepe?';

  @override
  String get error_report => 'Tutumie barua pepe';

  @override
  String get submit => 'Wasilisha';

  @override
  String get ok => 'Sawa';

  @override
  String get cancel => 'Ghairi';

  @override
  String get yes => 'Ndio';

  @override
  String get no => 'Hapana';

  @override
  String get close => 'Funga';

  @override
  String get back => 'Rudi';

  @override
  String get zone_screen_zone => 'Eneo';

  @override
  String get zone_screen_zone_show_summary => 'Onyesha muhtasari kwenye skrini';

  @override
  String get video_sources_photos_denied => 'Ruhusa ya picha imekataliwa';
}
