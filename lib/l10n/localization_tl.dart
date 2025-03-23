// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class LocalizationTl extends Localization {
  LocalizationTl([String locale = 'tl']) : super(locale);

  @override
  String get product_name => 'Counter';

  @override
  String get product_desc => 'Gumagamit ng computer vision at AI para mag-bilang ng tao, sasakyan, alagang hayop, at iba pa.';

  @override
  String get product_copyright => 'Karapatang-ari © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Live stream URL';

  @override
  String get video_sources_file => 'File';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_camera_not_found_title => 'Hindi nahanap ang camera';

  @override
  String get video_sources_camera_not_found_message => 'Kailangan ng permiso sa camera para magamit ito';

  @override
  String get video_sources_webcam_not_found_title => 'Hindi nahanap ang webcam';

  @override
  String get video_sources_webcam_not_found_message => 'Pakisuri kung may nakakonektang webcam';

  @override
  String get wizard_screen_desc => 'Gumawa ng bagong proyekto sa ibaba para magsimulang mag-bilang.';

  @override
  String get wizard_screen_new_project_from => 'Bagong Proyekto mula sa';

  @override
  String get wizard_screen_language => 'Wika';

  @override
  String get wizard_screen_about => 'Tungkol Sa';

  @override
  String get wizard_screen_open_projects_tip => 'Ang lahat ng proyekto ay awtomatikong ise-save sa lokal';

  @override
  String get wizard_screen_open_projects => 'Buksan ang umiiral na proyekto';

  @override
  String get wizard_screen_email_us => 'Mag-email sa amin';

  @override
  String get language_screen_language => 'Wika';

  @override
  String get project_view_no_videos => 'Walang available na pinagkukunan ng video.';

  @override
  String get about_screen_title => 'Tungkol Sa';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'Bersyon ng App';

  @override
  String get about_screen_models => 'Mga modelo ng object detection';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build Info';

  @override
  String get benchmark_screen_title => 'Mga Benchmark ng Model';

  @override
  String get benchmark_screen_recommended => 'Inirerekomendang Model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Simulan ang Benchmark';

  @override
  String get benchmark_screen_start_failed => 'Hindi masimulan ang benchmark, ang error code ay';

  @override
  String get benchmark_screen_models => 'Mga modelo ng object detection';

  @override
  String get project_screen_title => 'Proyekto';

  @override
  String get project_screen_exit_confirm_title => 'Kumpirmahin ang pag-alis sa proyekto';

  @override
  String get project_screen_exit_confirm_content => 'Ang pag-alis sa proyekto ay ihihinto ang Pagbibilang. Sigurado ka bang gusto mong magpatuloy?';

  @override
  String get project_screen_exit_button => 'Lumabas';

  @override
  String get project_screen_add_video_button => 'Magdagdag ng pinagkukunan ng video';

  @override
  String get project_screen_from_desc => 'Nagtatago kami ng 24-oras na record, para makita mo ang anumang time slice na kailangan mo.';

  @override
  String get project_screen_report_settings => 'Mga Setting';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Pumili ng hanay ng filter mula sa listahan sa ibaba';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Ang oras ng pagtatapos ay dapat na mas malaki kaysa sa oras ng pagsisimula';

  @override
  String get filter_screen_error_custom => 'Custom';

  @override
  String get filter_screen_error_start => 'Simula';

  @override
  String get filter_screen_error_end => 'Wakas';

  @override
  String get settings_screen_title => 'Mga Setting';

  @override
  String get settings_screen_desc => 'Itakda ang pangalan ng Proyekto, mga parameter ng pagtuklas, at pag-clear ng bilang.';

  @override
  String get settings_screen_project_id => 'Project Id';

  @override
  String get settings_screen_project_name => 'Pangalan ng Proyekto';

  @override
  String get settings_screen_project_name_place_holder => '123 EDSA o Luneta Park';

  @override
  String get settings_screen_project_error => 'Hindi maaaring walang laman ang pangalan ng proyekto';

  @override
  String get settings_screen_random_count_button => 'Magdagdag ng random na bilang';

  @override
  String get settings_screen_reset_count_header => 'I-reset ang lahat ng bilang sa proyektong ito';

  @override
  String get settings_screen_reset_count_button => 'I-reset ang mga bilang';

  @override
  String get settings_screen_reset_count_content => 'Sigurado ka bang gusto mong i-reset ang lahat ng bilang?';

  @override
  String get settings_screen_delete_header => 'Burahin ang proyektong ito';

  @override
  String get settings_screen_delete_content => 'Sigurado ka bang gusto mong burahin ang proyektong ito?';

  @override
  String get settings_screen_delete_button => 'Burahin';

  @override
  String get settings_screen_center_point_title => 'Center Point sa Target';

  @override
  String get settings_screen_center_point_desc => 'Ang center point ay tumutulong na matukoy kung ang target ay nasa loob ng hit zone.';

  @override
  String get settings_screen_center_point_button => 'Ipakita ang Center Point sa Target';

  @override
  String get settings_screen_lost_target_title => 'Nawala ang Target';

  @override
  String get settings_screen_lost_target_desc => 'Kapag nawala ng object tracking ang isang target, ginagawang nakikita ng opsyong ito. Sa default, hindi ipinapakita ang mga nawala na target.';

  @override
  String get settings_screen_lost_target_button => 'Ipakita ang Nawala na Target';

  @override
  String get detection_screen_title => 'Mga Setting ng Pagtuklas';

  @override
  String get detection_screen_models => 'Mga Model';

  @override
  String get detection_screen_confidence => 'Confidence';

  @override
  String get detection_screen_confidence_desc => 'confidence na mahigit sa #0 ay itinuturing na valid na pagtuklas';

  @override
  String get detection_screen_low => 'Mababa';

  @override
  String get detection_screen_high => 'Mataas';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Ang mas mababang NMS threshold (hal., 30%) ay mas agresibong mag-aalis ng magkakapatong na bounding box, habang ang mas mataas na NMS threshold (hal., 0.6) ay magpapahintulot ng mas maraming overlap';

  @override
  String get detection_screen_match => 'Match';

  @override
  String get detection_screen_match_desc => 'Match na mahigit sa #0 ay itinuturing na parehong bagay.';

  @override
  String get detection_screen_lost => 'Nawala';

  @override
  String get detection_screen_lost_desc => 'Ang naka-track na object ay aalisin kung ito ay nawala sa loob ng #0';

  @override
  String get detection_screen_consider_valid => 'Ituring na valid pagkatapos ng';

  @override
  String get detection_screen_consider_valid_desc => 'Ang naka-track na object ay ituturing na valid pagkatapos ng #0';

  @override
  String get detection_screen_reset => 'I-reset';

  @override
  String get detection_screen_reset_content => 'Sigurado ka bang gusto mong i-reset ang mga setting ng pagtuklas?';

  @override
  String get url_screen_title => 'Live stream URL';

  @override
  String get url_screen_desc => 'Mangyaring ilagay ang live stream URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream o rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Magdagdag ng pinagmulan ng Video';

  @override
  String get add_video_screen_from => 'Magdagdag ng pinagmulan ng video mula sa';

  @override
  String get webcam_screen_add_title => 'Magdagdag ng Webcam';

  @override
  String get webcam_screen_edit_title => 'Pumili ng Webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Front Camera';

  @override
  String get camera_screen_back_camera => 'Back Camera';

  @override
  String get camera_screen_add_title => 'Magdagdag ng Camera';

  @override
  String get camera_screen_edit_title => 'Pumili ng Camera';

  @override
  String get camera_screen_zoom_level => 'Antas ng Zoom';

  @override
  String get video_screen_name_empty => 'Hindi maaaring walang laman ang pangalan ng video.';

  @override
  String get video_screen_desc => 'Pamahalaan ang mga pinagmulan ng video, magdagdag o magbago ng mga detection zone.';

  @override
  String get video_screen_video_name => 'Pangalan ng pinagmulan ng video';

  @override
  String get video_screen_edit_placeholder => 'Front Door Cam o Parking Lot Cam';

  @override
  String get video_screen_change_file => 'Palitan ang File';

  @override
  String get video_screen_add_zone => 'Magdagdag ng detection zone';

  @override
  String get video_screen_zones => 'Mga detection zone';

  @override
  String get video_screen_zones_desc => 'Gamitin ang drag and drop para ayusin ang mga zone';

  @override
  String get video_screen_tools => 'Mga Kagamitan';

  @override
  String get video_screen_move_bottom => 'Ilipat ang kasalukuyang zone sa ilalim';

  @override
  String get video_screen_add_point => 'Magdagdag ng punto sa kasalukuyang zone';

  @override
  String get video_screen_remove_point => 'Alisin ang punto mula sa kasalukuyang zone';

  @override
  String get video_screen_playback_speed => 'Bilis ng Playback';

  @override
  String get video_screen_playback_current => 'kasalukuyan: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Burahin ang pinagmulan ng video na ito';

  @override
  String get video_screen_delete_content => 'Sigurado ka bang gusto mong burahin ang pinagmulan ng video na ito?';

  @override
  String get video_screen_delete_button => 'Burahin';

  @override
  String get video_screen_sources => 'I-configure ang pinagmulan ng larawan, mga target ng pagtuklas, at mga parameter ng model.';

  @override
  String get video_screen_targets => 'Mga target ng pagtuklas';

  @override
  String get video_screen_detection => 'Mga parameter ng model';

  @override
  String get color_screen_title => 'Pumili ng kulay';

  @override
  String get zone_screen_desc => 'Ang detection zone ay maaaring magtakda ng mga uri ng mga bagay na dapat matuklas at pumili kung aling mga counter ang ipapakita, tulad ng Natuklas, Lumitaw, at Pumasok.';

  @override
  String get zone_screen_name_placeholder => 'Ang pangalan ng zone, tulad ng Bangketa o Parking Lot';

  @override
  String get zone_screen_zone_color => 'Kulay ng zone';

  @override
  String get zone_screen_color => 'Kulay';

  @override
  String get zone_screen_delete_header => 'Burahin ang zone na ito';

  @override
  String get zone_screen_delete_content => 'Sigurado ka bang gusto mong burahin ang zone na ito?';

  @override
  String get zone_screen_delete_button => 'Burahin';

  @override
  String get zone_screen_can_not_delete => 'Hindi maaaring burahin ang zone';

  @override
  String get zone_screen_one_zone_required => 'Hindi bababa sa isang zone ang kailangan.';

  @override
  String get zone_screen_zone_name_required => 'Hindi maaaring walang laman ang pangalan ng zone';

  @override
  String get counter_screen_show_on => 'Ipakita sa screen';

  @override
  String get counter_screen_enabled => 'Naka-enable';

  @override
  String get counter_screen_reentry_threshold => 'Re-entry Threshold';

  @override
  String get counter_screen_reentry_desc => 'Ang mga bagay ay dapat pumasok ng #0 beses, na may #1 segundo na cooldown sa pagitan ng bawat labas at muling pagpasok, upang ma-trigger ang muling pagpasok';

  @override
  String get counter_screen_reentry_title => 'Bilang ng muling pagpasok';

  @override
  String get counter_screen_cooldown_threshold => 'Cooldown Threshold';

  @override
  String get counter_screen_cooldown_desc => 'Ang muling pagpasok ay nangangailangan ng #0 segundo na cooldown pagkatapos lumabas sa detection zone';

  @override
  String get counter_screen_cooldown_time => 'Oras ng Cooldown';

  @override
  String get counter_screen_cooldown_in_seconds => 'sa segundo';

  @override
  String get counter_screen_stagnant_threshold => 'Stagnant Threshold';

  @override
  String get counter_screen_stagnant_desc => 'Ang mga bagay na nananatiling hindi gumagalaw nang higit sa #0 segundo ay ituturing na hindi gumagalaw';

  @override
  String get counter_screen_stagnant_consider => 'Ituring na hindi gumagalaw';

  @override
  String get counter_screen_stagnant_in_seconds => 'sa segundo';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefix ng Paglalarawan';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Suffix ng Paglalarawan';

  @override
  String get counter_screen_name_error => 'Hindi maaaring walang laman ang pangalan ng counter';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content => 'Kailangan mong i-enable muna ang ibang counter, pagkatapos ay maaari mong i-disable ang counter na ito';

  @override
  String get objects_screen_title => 'Mga Bagay';

  @override
  String get objects_screen_desc => 'Pumili ng mga target ng pagtuklas tulad ng tao, kotse, bus, atbp.';

  @override
  String get open_project_screen_title => 'Buksan ang Proyekto';

  @override
  String get open_project_screen_desc => 'Buksan ang mga dating nilikha na proyekto, pinapanatili lamang ang pinakabagong 20.';

  @override
  String get open_project_screen_no_project => 'Walang nahanap na proyekto.';

  @override
  String get default_project_name => 'Proyekto';

  @override
  String get default_video_name => 'Pinagmulan ng video';

  @override
  String get default_zone_name => 'Detection zone';

  @override
  String get error_oops => 'Naku, may nangyaring mali';

  @override
  String get error_content => 'Nagkaroon ng hindi inaasahang error. Gusto mo bang magsumite ng email report?';

  @override
  String get error_report => 'Mag-email sa amin';

  @override
  String get submit => 'Isumite';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get yes => 'Oo';

  @override
  String get no => 'Hindi';

  @override
  String get close => 'Isara';

  @override
  String get back => 'Bumalik';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Ipakita ang buod sa screen';
}
