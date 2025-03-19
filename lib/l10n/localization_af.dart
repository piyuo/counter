// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class LocalizationAf extends Localization {
  LocalizationAf([String locale = 'af']) : super(locale);

  @override
  String get product_name => 'Visie Teller';

  @override
  String get product_desc => 'Gebruik rekenaarsigbaarheid en KI om mense, voertuie, troeteldiere en meer te tel.';

  @override
  String get product_copyright => 'Kopiereg © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'Regstreekse stroom-URL';

  @override
  String get video_sources_file => 'Lêer';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nie gevind nie';

  @override
  String get video_sources_camera_not_found_message => 'Moet kamera-toestemming verleen om kamera te gebruik';

  @override
  String get video_sources_webcam_not_found_title => 'Webkamera nie gevind nie';

  @override
  String get video_sources_webcam_not_found_message => 'Kontroleer asseblief of enige webkamera gekoppel is';

  @override
  String get wizard_screen_desc => 'Skep \'n nuwe projek hieronder om te begin tel.';

  @override
  String get wizard_screen_new_project_from => 'Nuwe Projek vanaf';

  @override
  String get wizard_screen_language => 'Taal';

  @override
  String get wizard_screen_about => 'Oor';

  @override
  String get wizard_screen_open_projects_tip => 'Alle projekte sal outomaties plaaslik gestoor word';

  @override
  String get wizard_screen_open_projects => 'Maak bestaande projek oop';

  @override
  String get wizard_screen_email_us => 'E-pos ons';

  @override
  String get language_screen_language => 'Taal';

  @override
  String get project_view_no_videos => 'Geen videobron beskikbaar nie.';

  @override
  String get about_screen_title => 'Oor';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'App Weergawe';

  @override
  String get about_screen_models => 'Objekopsporing modelle';

  @override
  String get about_screen_benchmark => 'Toetssteen';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Bou-inligting';

  @override
  String get benchmark_screen_title => 'Modelle Toetssteen';

  @override
  String get benchmark_screen_recommended => 'Aanbevole Model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Begin Toetssteen';

  @override
  String get benchmark_screen_start_failed => 'Kon nie die toetssteen begin nie, die foutkode is';

  @override
  String get benchmark_screen_models => 'Objekopsporing modelle';

  @override
  String get project_screen_title => 'Projek';

  @override
  String get project_screen_exit_confirm_title => 'Bevestig verlating van die projek';

  @override
  String get project_screen_exit_confirm_content => 'Die projek verlaat sal die tel stop. Is jy seker jy wil voortgaan?';

  @override
  String get project_screen_exit_button => 'Verlaat';

  @override
  String get project_screen_add_video_button => 'Voeg videobron by';

  @override
  String get project_screen_from_desc => 'Ons hou \'n rollende 24-uur rekord, sodat jy enige tydsgleuf kan sien wat jy nodig het.';

  @override
  String get project_screen_report_settings => 'Instellings';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Kies \'n filterreeks uit die lys hieronder';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Eindtyd moet groter wees as begintyd';

  @override
  String get filter_screen_error_custom => 'Pasgemaak';

  @override
  String get filter_screen_error_start => 'Begin';

  @override
  String get filter_screen_error_end => 'Einde';

  @override
  String get settings_screen_title => 'Instellings';

  @override
  String get settings_screen_desc => 'Stel Projeknaam, opsporingsparameters, telklarings in.';

  @override
  String get settings_screen_project_id => 'Projek ID';

  @override
  String get settings_screen_project_name => 'Projeknaam';

  @override
  String get settings_screen_project_name_place_holder => '123 Hoofstraat of Parkweg';

  @override
  String get settings_screen_project_error => 'Die projeknaam kan nie leeg wees nie';

  @override
  String get settings_screen_random_count_button => 'Voeg ewekansige tellings by';

  @override
  String get settings_screen_reset_count_header => 'Herstel alle tellings in hierdie projek';

  @override
  String get settings_screen_reset_count_button => 'Herstel tellings';

  @override
  String get settings_screen_reset_count_content => 'Is jy seker jy wil alle tellings herstel?';

  @override
  String get settings_screen_delete_header => 'Verwyder hierdie projek';

  @override
  String get settings_screen_delete_content => 'Is jy seker jy wil hierdie projek verwyder?';

  @override
  String get settings_screen_delete_button => 'Verwyder';

  @override
  String get settings_screen_center_point_title => 'Middelpunt op Teiken';

  @override
  String get settings_screen_center_point_desc => 'Die middelpunt help bepaal of die teiken binne die trefgebied is.';

  @override
  String get settings_screen_center_point_button => 'Wys Middelpunt op Teiken';

  @override
  String get settings_screen_lost_target_title => 'Verlore Teiken';

  @override
  String get settings_screen_lost_target_desc => 'Wanneer objekopsporing \'n teiken verloor, maak hierdie opsie dit sigbaar. Verlore teikens word standaard nie gewys nie.';

  @override
  String get settings_screen_lost_target_button => 'Wys Verlore Teiken';

  @override
  String get detection_screen_title => 'Opsporingsinstellings';

  @override
  String get detection_screen_models => 'Modelle';

  @override
  String get detection_screen_confidence => 'Vertroue';

  @override
  String get detection_screen_confidence_desc => 'vertroue bo #0 word beskou as \'n geldige opsporing';

  @override
  String get detection_screen_low => 'Laag';

  @override
  String get detection_screen_high => 'Hoog';

  @override
  String get detection_screen_nms => 'Nie-Maksimum Onderdrukking';

  @override
  String get detection_screen_nms_desc => '#0 \'n Laer NMS drempel (bv. 30%) sal oorvleuelende grensraamwerke meer aggressief verwyder, terwyl \'n hoër NMS drempel (bv. 0.6) meer oorvleueling sal toelaat';

  @override
  String get detection_screen_match => 'Pas';

  @override
  String get detection_screen_match_desc => 'Pas oor #0 word beskou as dieselfde objek.';

  @override
  String get detection_screen_lost => 'Verlore';

  @override
  String get detection_screen_lost_desc => 'Opgespoorde objek sal verwyder word as dit verlore raak vir #0';

  @override
  String get detection_screen_consider_valid => 'Beskou geldig na';

  @override
  String get detection_screen_consider_valid_desc => 'Opgespoorde objek sal as geldig beskou word na #0';

  @override
  String get detection_screen_reset => 'Herstel';

  @override
  String get detection_screen_reset_content => 'Is jy seker jy wil die opsporingsinstellings herstel?';

  @override
  String get url_screen_title => 'Regstreekse stroom-URL';

  @override
  String get url_screen_desc => 'Voer asseblief die regstreekse stroom-URL in';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://voorbeeld.com/stroom of rtsp://voorbeeld.com/stroom';

  @override
  String get add_video_screen_title => 'Voeg Videobron by';

  @override
  String get add_video_screen_from => 'Voeg videobron by vanaf';

  @override
  String get webcam_screen_add_title => 'Voeg Webkamera by';

  @override
  String get webcam_screen_edit_title => 'Kies Webkamera';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Voorkamera';

  @override
  String get camera_screen_back_camera => 'Agterkamera';

  @override
  String get camera_screen_add_title => 'Voeg Kamera by';

  @override
  String get camera_screen_edit_title => 'Kies Kamera';

  @override
  String get camera_screen_zoom_level => 'Zoem Vlak';

  @override
  String get video_screen_name_empty => 'Die videonaam kan nie leeg wees nie.';

  @override
  String get video_screen_desc => 'Bestuur videobronne, voeg by of wysig opsporingsones.';

  @override
  String get video_screen_video_name => 'Videobronnaam';

  @override
  String get video_screen_edit_placeholder => 'Voordeurkamera of Parkeerterreinkamera';

  @override
  String get video_screen_change_file => 'Verander Lêer';

  @override
  String get video_screen_add_zone => 'Voeg opsporingsone by';

  @override
  String get video_screen_zones => 'Opsporingsones';

  @override
  String get video_screen_zones_desc => 'Gebruik sleep-en-los om sones aan te pas';

  @override
  String get video_screen_tools => 'Gereedskap';

  @override
  String get video_screen_move_bottom => 'Skuif huidige sone na onder';

  @override
  String get video_screen_add_point => 'Voeg punt by huidige sone';

  @override
  String get video_screen_remove_point => 'Verwyder punt van huidige sone';

  @override
  String get video_screen_playback_speed => 'Terugspeelspoed';

  @override
  String get video_screen_playback_current => 'huidige: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Verwyder hierdie videobron';

  @override
  String get video_screen_delete_content => 'Is jy seker jy wil hierdie videobron verwyder?';

  @override
  String get video_screen_delete_button => 'Verwyder';

  @override
  String get video_screen_sources => 'Stel beeldbron, opsporingsteikens, en model parameters op.';

  @override
  String get video_screen_targets => 'Opsporingsteikens';

  @override
  String get video_screen_detection => 'Model parameters';

  @override
  String get color_screen_title => 'Kies \'n kleur';

  @override
  String get zone_screen_desc => 'Die opsporingsone kan die tipes objekte wat opgespoor moet word instel en kies watter tellers om te vertoon, soos Opgespoor, Verskyn, en Binnegekom.';

  @override
  String get zone_screen_name_placeholder => 'Die naam van die sone, soos Sypaadjie of Parkeerterrein';

  @override
  String get zone_screen_zone_color => 'Sonekleur';

  @override
  String get zone_screen_color => 'Kleur';

  @override
  String get zone_screen_delete_header => 'Verwyder hierdie sone';

  @override
  String get zone_screen_delete_content => 'Is jy seker jy wil hierdie sone verwyder?';

  @override
  String get zone_screen_delete_button => 'Verwyder';

  @override
  String get zone_screen_can_not_delete => 'Kan nie sone verwyder nie';

  @override
  String get zone_screen_one_zone_required => 'Ten minste een sone word benodig.';

  @override
  String get zone_screen_zone_name_required => 'Die sonenaam kan nie leeg wees nie';

  @override
  String get counter_screen_show_on => 'Wys op skerm';

  @override
  String get counter_screen_enabled => 'Geaktiveer';

  @override
  String get counter_screen_reentry_threshold => 'Herbinnekoms Drempel';

  @override
  String get counter_screen_reentry_desc => 'Objekte moet #0 keer binnekom, met \'n #1-sekonde afkoeltyd tussen elke uitgang en herbinnekoms, om herbinnekoms te aktiveer';

  @override
  String get counter_screen_reentry_title => 'Herbinnekoms telling';

  @override
  String get counter_screen_cooldown_threshold => 'Afkoeldrempel';

  @override
  String get counter_screen_cooldown_desc => 'Herbinnekoms vereis \'n #0-sekonde afkoeltyd na die verlating van die opsporingsone';

  @override
  String get counter_screen_cooldown_time => 'Afkoeltyd';

  @override
  String get counter_screen_cooldown_in_seconds => 'in sekondes';

  @override
  String get counter_screen_stagnant_threshold => 'Stilstaande Drempel';

  @override
  String get counter_screen_stagnant_desc => 'Objekte wat vir meer as #0 sekondes stilstaan, sal as stilstaande beskou word';

  @override
  String get counter_screen_stagnant_consider => 'Beskou as stilstaande';

  @override
  String get counter_screen_stagnant_in_seconds => 'in sekondes';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beskrywing Voorvoegsel';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beskrywing Agtervoegsel';

  @override
  String get counter_screen_name_error => 'Die tellernaam kan nie leeg wees nie';

  @override
  String get counter_screen_enabled_error => 'Fout';

  @override
  String get counter_screen_enabled_error_content => 'Jy moet eers \'n ander teller aktiveer, dan kan jy hierdie teller deaktiveer';

  @override
  String get objects_screen_title => 'Objekte';

  @override
  String get objects_screen_desc => 'Kies opsporingsteikens soos persoon, motor, bus, ens.';

  @override
  String get open_project_screen_title => 'Maak Projek Oop';

  @override
  String get open_project_screen_desc => 'Maak voorheen geskepte projekte oop, behou slegs die mees onlangse 20.';

  @override
  String get open_project_screen_no_project => 'Geen projek gevind nie.';

  @override
  String get default_project_name => 'Projek';

  @override
  String get default_video_name => 'Videobron';

  @override
  String get default_zone_name => 'Opsporingsone';

  @override
  String get error_oops => 'Oeps, iets het verkeerd gegaan';

  @override
  String get error_content => '\'n Onverwagse fout het voorgekom. Wil jy \'n e-pos verslag indien?';

  @override
  String get error_report => 'E-pos ons';

  @override
  String get submit => 'Dien in';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Kanselleer';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nee';

  @override
  String get close => 'Sluit';

  @override
  String get back => 'Terug';
}
