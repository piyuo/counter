// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class LocalizationEt extends Localization {
  LocalizationEt([String locale = 'et']) : super(locale);

  @override
  String get product_name => 'Loendur';

  @override
  String get product_desc => 'Arvutinägemise ja tehisintellekti abil inimeste, sõidukite, lemmikloomade ja muu loendamine.';

  @override
  String get product_copyright => 'Autoriõigus © 2025';

  @override
  String get video_sources_webcam => 'Veebikaamera';

  @override
  String get video_sources_live_stream => 'Otseülekande URL';

  @override
  String get video_sources_file => 'Fail';

  @override
  String get video_sources_camera => 'Kaamera';

  @override
  String get video_sources_camera_not_found_title => 'Kaamerat ei leitud';

  @override
  String get video_sources_camera_not_found_message => 'Kaamera kasutamiseks on vaja kaamerapääsu lubada';

  @override
  String get video_sources_webcam_not_found_title => 'Veebikaamerat ei leitud';

  @override
  String get video_sources_webcam_not_found_message => 'Palun kontrollige rakenduse luba ja kaamera ühendust';

  @override
  String get wizard_screen_desc => 'Loendamise alustamiseks looge uus projekt.';

  @override
  String get wizard_screen_new_project_from => 'Uus projekt allikast';

  @override
  String get wizard_screen_language => 'Keel';

  @override
  String get wizard_screen_about => 'Teave';

  @override
  String get wizard_screen_open_projects_tip => 'Kõik projektid salvestatakse automaatselt kohalikult';

  @override
  String get wizard_screen_open_projects => 'Ava olemasolev projekt';

  @override
  String get wizard_screen_email_us => 'Kirjuta meile';

  @override
  String get language_screen_language => 'Keel';

  @override
  String get project_view_no_videos => 'Videoallikas pole saadaval.';

  @override
  String get about_screen_title => 'Teave';

  @override
  String get about_screen_platform => 'Platvorm';

  @override
  String get about_screen_app_version => 'Rakenduse versioon';

  @override
  String get about_screen_models => 'Objektituvastuse mudelid';

  @override
  String get about_screen_benchmark => 'Jõudlustest';

  @override
  String get about_screen_opencv_build_info => 'OpenCV ehituse info';

  @override
  String get benchmark_screen_title => 'Mudelite jõudlustestid';

  @override
  String get benchmark_screen_recommended => 'Soovitatud mudel';

  @override
  String get benchmark_screen_fps => 'Kaadrit sekundis';

  @override
  String get benchmark_screen_start_button => 'Alusta jõudlustesti';

  @override
  String get benchmark_screen_start_failed => 'Jõudlustesti käivitamine ebaõnnestus, veakood on';

  @override
  String get benchmark_screen_models => 'Objektituvastuse mudelid';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Kinnita projektist väljumine';

  @override
  String get project_screen_exit_confirm_content => 'Projektist lahkumine peatab loendamise. Kas soovite kindlasti jätkata?';

  @override
  String get project_screen_exit_button => 'Välju';

  @override
  String get project_screen_add_video_button => 'Lisa videoallikas';

  @override
  String get project_screen_from_desc => 'Salvestame 24-tunnise liikuva ajalugu, et saaksite vaadata mistahes ajavahemikku.';

  @override
  String get project_screen_report_settings => 'Seaded';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Valige filtrivahemik allolevast loendist';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Lõppaeg peab olema suurem kui algusaeg';

  @override
  String get filter_screen_error_custom => 'Kohandatud';

  @override
  String get filter_screen_error_start => 'Algus';

  @override
  String get filter_screen_error_end => 'Lõpp';

  @override
  String get settings_screen_title => 'Seaded';

  @override
  String get settings_screen_desc => 'Määra projekti nimi, tuvastusparameetrid, loenduste nullimine.';

  @override
  String get settings_screen_project_id => 'Projekti ID';

  @override
  String get settings_screen_project_name => 'Projekti nimi';

  @override
  String get settings_screen_project_name_place_holder => 'Vabaduse tänav 123 või Kadrioru park';

  @override
  String get settings_screen_project_error => 'Projekti nimi ei saa olla tühi';

  @override
  String get settings_screen_random_count_button => 'Lisa juhuslikud loendused';

  @override
  String get settings_screen_reset_count_header => 'Lähtesta kõik loendused selles projektis';

  @override
  String get settings_screen_reset_count_button => 'Lähtesta loendused';

  @override
  String get settings_screen_reset_count_content => 'Kas olete kindel, et soovite kõik loendused lähtestada?';

  @override
  String get settings_screen_delete_header => 'Kustuta see projekt';

  @override
  String get settings_screen_delete_content => 'Kas olete kindel, et soovite selle projekti kustutada?';

  @override
  String get settings_screen_delete_button => 'Kustuta';

  @override
  String get settings_screen_center_point_title => 'Keskpunkt objektil';

  @override
  String get settings_screen_center_point_desc => 'Keskpunkt aitab määrata, kas objekt on tabaamisalas.';

  @override
  String get settings_screen_center_point_button => 'Näita objektil keskpunkti';

  @override
  String get settings_screen_lost_target_title => 'Kadunud objekt';

  @override
  String get settings_screen_lost_target_desc => 'Kui objekti jälgimine kaotab objekti, siis see valik muudab selle nähtavaks. Vaikimisi kadunud objekte ei näidata.';

  @override
  String get settings_screen_lost_target_button => 'Näita kadunud objekti';

  @override
  String get detection_screen_title => 'Tuvastusseaded';

  @override
  String get detection_screen_models => 'Mudelid';

  @override
  String get detection_screen_confidence => 'Kindlus';

  @override
  String get detection_screen_confidence_desc => 'kindlus üle #0 loetakse kehtivaks tuvastuseks';

  @override
  String get detection_screen_low => 'Madal';

  @override
  String get detection_screen_high => 'Kõrge';

  @override
  String get detection_screen_nms => 'Mitte-maksimumide summutamine';

  @override
  String get detection_screen_nms_desc => '#0 Madalam NMS lävi (nt 0.3-0.4) eemaldab kattuvaid kaste rangemalt ja vähendab valepositiivseid tulemusi kuid võib jätta märkamata kattuvad inimesed. Kõrgem lävi (0.7-0.9) säilitab rohkem kaste mis võib suurendada valepositiivseid tulemusi kuid tuvastab kattuvaid inimesi paremini.';

  @override
  String get detection_screen_match => 'Vaste';

  @override
  String get detection_screen_match_desc => '#0 matchThreshold on objekti jälgimisel oluline parameeter mis mõõdab erinevate tuvastuskastide vahelise sobivuse taset. Madalam väärtus lihtsustab objektide seostamist kuid suurendab valede ühenduste riski. Kõrgem väärtus on objektide seostamisel rangem kuid võib mõned tõelised vastavused maha jätta.';

  @override
  String get detection_screen_lost => 'Kadunud';

  @override
  String get detection_screen_lost_desc => 'Jälgitav objekt eemaldatakse, kui see on kadunud #0';

  @override
  String get detection_screen_consider_valid => 'Loe kehtivaks pärast';

  @override
  String get detection_screen_consider_valid_desc => 'Jälgitavat objekti loetakse kehtivaks pärast #0';

  @override
  String get detection_screen_reset => 'Lähtesta';

  @override
  String get detection_screen_reset_content => 'Kas olete kindel, et soovite tuvastusseaded lähtestada?';

  @override
  String get url_screen_title => 'Otseülekande URL';

  @override
  String get url_screen_desc => 'Palun sisestage otseülekande URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://näide.com/voog või rtsp://näide.com/voog';

  @override
  String get add_video_screen_title => 'Lisa videoallikas';

  @override
  String get add_video_screen_from => 'Lisa videoallikas allikast';

  @override
  String get webcam_screen_add_title => 'Lisa veebikaamera';

  @override
  String get webcam_screen_edit_title => 'Vali veebikaamera';

  @override
  String get webcam_manager_webcam => 'Veebikaamera';

  @override
  String get camera_screen_front_camera => 'Eesmine kaamera';

  @override
  String get camera_screen_back_camera => 'Tagumine kaamera';

  @override
  String get camera_screen_add_title => 'Lisa kaamera';

  @override
  String get camera_screen_edit_title => 'Vali kaamera';

  @override
  String get camera_screen_zoom_level => 'Suumi tase';

  @override
  String get video_screen_name_empty => 'Video nimi ei saa olla tühi.';

  @override
  String get video_screen_desc => 'Halda videoallikaid, lisa või muuda tuvastusalasid.';

  @override
  String get video_screen_video_name => 'Videoallika nimi';

  @override
  String get video_screen_edit_placeholder => 'Esiukse kaamera või Parkla kaamera';

  @override
  String get video_screen_change_file => 'Muuda faili';

  @override
  String get video_screen_add_zone => 'Lisa tuvastusala';

  @override
  String get video_screen_zones => 'Tuvastusalad';

  @override
  String get video_screen_zones_desc => 'Kasuta lohistamist alade kohandamiseks';

  @override
  String get video_screen_tools => 'Tööriistad';

  @override
  String get video_screen_move_bottom => 'Liiguta praegune ala alla';

  @override
  String get video_screen_add_point => 'Lisa punkt praegusele alale';

  @override
  String get video_screen_remove_point => 'Eemalda punkt praeguselt alalt';

  @override
  String get video_screen_playback_speed => 'Taasesituse kiirus';

  @override
  String get video_screen_playback_current => 'praegune: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Kustuta see videoallikas';

  @override
  String get video_screen_delete_content => 'Kas olete kindel, et soovite selle videoallika kustutada?';

  @override
  String get video_screen_delete_button => 'Kustuta';

  @override
  String get video_screen_sources => 'Seadista pildialllikas, tuvastatavad objektid ja mudeli parameetrid.';

  @override
  String get video_screen_targets => 'Tuvastatavad objektid';

  @override
  String get video_screen_detection => 'Mudeli parameetrid';

  @override
  String get color_screen_title => 'Vali värv';

  @override
  String get zone_screen_desc => 'Tuvastusalale saab määrata tuvastatavad objektitüübid ja valida, milliseid loendustulemusi kuvada, näiteks tuvastatud, ilmunud ja sisenenud.';

  @override
  String get zone_screen_name_placeholder => 'Ala nimi, nagu Kõnnitee või Parkla';

  @override
  String get zone_screen_zone_color => 'Ala värv';

  @override
  String get zone_screen_color => 'Värv';

  @override
  String get zone_screen_delete_header => 'Kustuta see ala';

  @override
  String get zone_screen_delete_content => 'Kas olete kindel, et soovite selle ala kustutada?';

  @override
  String get zone_screen_delete_button => 'Kustuta';

  @override
  String get zone_screen_can_not_delete => 'Ei saa ala kustutada';

  @override
  String get zone_screen_one_zone_required => 'Vähemalt üks ala on vajalik.';

  @override
  String get zone_screen_zone_name_required => 'Ala nimi ei saa olla tühi';

  @override
  String get counter_screen_show_on => 'Näita ekraanil';

  @override
  String get counter_screen_enabled => 'Lubatud';

  @override
  String get counter_screen_reentry_threshold => 'Taassisenemise lävi';

  @override
  String get counter_screen_reentry_desc => 'Objektid peavad sisenema #0 korda, iga väljumise ja taassisenemise vahel peab olema #1 sekundi pikkune jahutusaeg, et käivitada taassisenemine';

  @override
  String get counter_screen_reentry_title => 'Taassisenemise loendus';

  @override
  String get counter_screen_cooldown_threshold => 'Jahutusaja lävi';

  @override
  String get counter_screen_cooldown_desc => 'Taassisenemine nõuab #0 sekundi pikkust jahutusaega pärast tuvastusalalt lahkumist';

  @override
  String get counter_screen_cooldown_time => 'Jahutusaeg';

  @override
  String get counter_screen_cooldown_in_seconds => 'sekundites';

  @override
  String get counter_screen_stagnant_threshold => 'Paigalseisu lävi';

  @override
  String get counter_screen_stagnant_desc => 'Objekte, mis jäävad paigale rohkem kui #0 sekundiks, loetakse paigalseisvaks';

  @override
  String get counter_screen_stagnant_consider => 'Loe paigalseisvaks';

  @override
  String get counter_screen_stagnant_in_seconds => 'sekundites';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Kirjelduse eesliide';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Kirjelduse järelliide';

  @override
  String get counter_screen_name_error => 'Loenduri nimi ei saa olla tühi';

  @override
  String get counter_screen_enabled_error => 'Viga';

  @override
  String get counter_screen_enabled_error_content => 'Peate esmalt lubama teise loenduri, alles siis saate selle loenduri keelata';

  @override
  String get objects_screen_title => 'Objektid';

  @override
  String get objects_screen_desc => 'Valige tuvastatavad objektid nagu inimene, auto, buss jne.';

  @override
  String get open_project_screen_title => 'Ava projekt';

  @override
  String get open_project_screen_desc => 'Ava varem loodud projektid, säilitatakse ainult 20 viimast.';

  @override
  String get open_project_screen_no_project => 'Projekte ei leitud.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videoallikas';

  @override
  String get default_zone_name => 'Tuvastusala';

  @override
  String get error_oops => 'Ups, midagi läks valesti';

  @override
  String get error_content => 'Ilmnes ootamatu viga. Kas soovite saata e-kirja aruande?';

  @override
  String get error_report => 'Kirjuta meile';

  @override
  String get submit => 'Esita';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Tühista';

  @override
  String get yes => 'Jah';

  @override
  String get no => 'Ei';

  @override
  String get close => 'Sulge';

  @override
  String get back => 'Tagasi';

  @override
  String get zone_screen_zone => 'Ala';

  @override
  String get zone_screen_zone_show_summary => 'Näita kokkuvõtet ekraanil';

  @override
  String get video_sources_photos_denied => 'Juurdepääs fotodele keelatud';

  @override
  String get video_sources_photos_goto_settings => 'Mine seadetesse';

  @override
  String get video_sources_camera_denied => 'Juurdepääs kaamerale keelatud';

  @override
  String get video_sources_photos_denied_msg => 'Mine seadetesse ja luba sellele rakendusele juurdepääs fotodele.';

  @override
  String get video_sources_camera_denied_msg => 'Mine seadetesse ja luba sellele rakendusele juurdepääs kaamerale.';
}
