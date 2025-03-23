// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Nynorsk (`nn`).
class LocalizationNn extends Localization {
  LocalizationNn([String locale = 'nn']) : super(locale);

  @override
  String get product_name => 'Teljar';

  @override
  String get product_desc => 'Bruk datasyn og kunstig intelligens for å telja personar, køyretøy, kjæledyr og meir.';

  @override
  String get product_copyright => 'Opphavsrett © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'Direkte strøymings-URL';

  @override
  String get video_sources_file => 'Fil';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera ikkje funne';

  @override
  String get video_sources_camera_not_found_message => 'Treng løyve til kamera for å bruka kamera';

  @override
  String get video_sources_webcam_not_found_title => 'Webkamera ikkje funne';

  @override
  String get video_sources_webcam_not_found_message => 'Ver vennleg og sjekk om webkamera er kopla til';

  @override
  String get wizard_screen_desc => 'Lag eit nytt prosjekt nedanfor for å starta teljing.';

  @override
  String get wizard_screen_new_project_from => 'Nytt prosjekt frå';

  @override
  String get wizard_screen_language => 'Språk';

  @override
  String get wizard_screen_about => 'Om';

  @override
  String get wizard_screen_open_projects_tip => 'Alle prosjekt vert automatisk lagra lokalt';

  @override
  String get wizard_screen_open_projects => 'Opne eksisterande prosjekt';

  @override
  String get wizard_screen_email_us => 'E-post oss';

  @override
  String get language_screen_language => 'Språk';

  @override
  String get project_view_no_videos => 'Ingen videokjelder tilgjengelege.';

  @override
  String get about_screen_title => 'Om';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get about_screen_app_version => 'App-versjon';

  @override
  String get about_screen_models => 'Objektdeteksjonsmodellar';

  @override
  String get about_screen_benchmark => 'Ytingstest';

  @override
  String get about_screen_opencv_build_info => 'OpenCV byggeinfo';

  @override
  String get benchmark_screen_title => 'Modellar ytingstest';

  @override
  String get benchmark_screen_recommended => 'Tilrådd modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start ytingstest';

  @override
  String get benchmark_screen_start_failed => 'Kunne ikkje starta ytingstest, feilkoden er';

  @override
  String get benchmark_screen_models => 'Objektdeteksjonsmodellar';

  @override
  String get project_screen_title => 'Prosjekt';

  @override
  String get project_screen_exit_confirm_title => 'Stadfest avslutting av prosjektet';

  @override
  String get project_screen_exit_confirm_content => 'Å forlata prosjektet vil stoppa teljinga. Er du sikker på at du vil fortsetja?';

  @override
  String get project_screen_exit_button => 'Avslutt';

  @override
  String get project_screen_add_video_button => 'Legg til videokjelde';

  @override
  String get project_screen_from_desc => 'Me held ein rullande 24-timars logg, slik at du kan sjå alle tidssegment du treng.';

  @override
  String get project_screen_report_settings => 'Innstillingar';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Vel eit filterområde frå lista nedanfor';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Sluttid må vera større enn starttid';

  @override
  String get filter_screen_error_custom => 'Tilpassa';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Slutt';

  @override
  String get settings_screen_title => 'Innstillingar';

  @override
  String get settings_screen_desc => 'Set prosjektnamn, deteksjonsparametrar, nullstilling av teljing.';

  @override
  String get settings_screen_project_id => 'Prosjekt-ID';

  @override
  String get settings_screen_project_name => 'Prosjektnamn';

  @override
  String get settings_screen_project_name_place_holder => '123 Hovudgata eller Bjerkepark';

  @override
  String get settings_screen_project_error => 'Prosjektnamnet kan ikkje vera tomt';

  @override
  String get settings_screen_random_count_button => 'Legg til tilfeldige teljingar';

  @override
  String get settings_screen_reset_count_header => 'Nullstill alle teljingar i dette prosjektet';

  @override
  String get settings_screen_reset_count_button => 'Nullstill teljingar';

  @override
  String get settings_screen_reset_count_content => 'Er du sikker på at du vil nullstilla alle teljingar?';

  @override
  String get settings_screen_delete_header => 'Slett dette prosjektet';

  @override
  String get settings_screen_delete_content => 'Er du sikker på at du vil sletta dette prosjektet?';

  @override
  String get settings_screen_delete_button => 'Slett';

  @override
  String get settings_screen_center_point_title => 'Senterpunkt på mål';

  @override
  String get settings_screen_center_point_desc => 'Senterpunktet hjelper til med å avgjera om målet er innanfor treffsona.';

  @override
  String get settings_screen_center_point_button => 'Vis senterpunkt på mål';

  @override
  String get settings_screen_lost_target_title => 'Tapt mål';

  @override
  String get settings_screen_lost_target_desc => 'Når objektsporing mistar eit mål, gjer dette valet det synleg. Som standard vert ikkje tapte mål viste.';

  @override
  String get settings_screen_lost_target_button => 'Vis tapte mål';

  @override
  String get detection_screen_title => 'Deteksjonsinnstillingar';

  @override
  String get detection_screen_models => 'Modellar';

  @override
  String get detection_screen_confidence => 'Tillit';

  @override
  String get detection_screen_confidence_desc => 'tillit over #0 vert rekna som ein gyldig deteksjon';

  @override
  String get detection_screen_low => 'Låg';

  @override
  String get detection_screen_high => 'Høg';

  @override
  String get detection_screen_nms => 'Ikkje-maksimum suppresjon';

  @override
  String get detection_screen_nms_desc => '#0 Ein lågare NMS-terskel (t.d. 30%) vil meir aggressivt fjerna overlappande grenserammar, medan ein høgare NMS-terskel (t.d. 0,6) vil tillata meir overlapping';

  @override
  String get detection_screen_match => 'Match';

  @override
  String get detection_screen_match_desc => 'Match over #0 vert rekna for å vera same objekt.';

  @override
  String get detection_screen_lost => 'Tapt';

  @override
  String get detection_screen_lost_desc => 'Sporingsobjekt vil verta fjerna viss det er tapt i #0';

  @override
  String get detection_screen_consider_valid => 'Reknast som gyldig etter';

  @override
  String get detection_screen_consider_valid_desc => 'Sporingsobjekt vil verta rekna som gyldig etter #0';

  @override
  String get detection_screen_reset => 'Nullstill';

  @override
  String get detection_screen_reset_content => 'Er du sikker på at du vil nullstilla deteksjonsinnstillingane?';

  @override
  String get url_screen_title => 'Direkte strøymings-URL';

  @override
  String get url_screen_desc => 'Ver vennleg og skriv inn direkte strøymings-URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream eller rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Legg til videokjelde';

  @override
  String get add_video_screen_from => 'Legg til videokjelde frå';

  @override
  String get webcam_screen_add_title => 'Legg til webkamera';

  @override
  String get webcam_screen_edit_title => 'Vel webkamera';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Frontkamera';

  @override
  String get camera_screen_back_camera => 'Bakkamera';

  @override
  String get camera_screen_add_title => 'Legg til kamera';

  @override
  String get camera_screen_edit_title => 'Vel kamera';

  @override
  String get camera_screen_zoom_level => 'Zoomnivå';

  @override
  String get video_screen_name_empty => 'Videonamnet kan ikkje vera tomt.';

  @override
  String get video_screen_desc => 'Administrer videokjelder, legg til eller endre deteksjonssoner.';

  @override
  String get video_screen_video_name => 'Videokjeldenamn';

  @override
  String get video_screen_edit_placeholder => 'Inngangsdørkamera eller Parkeringsplass-kamera';

  @override
  String get video_screen_change_file => 'Endre fil';

  @override
  String get video_screen_add_zone => 'Legg til deteksjonssone';

  @override
  String get video_screen_zones => 'Deteksjonssoner';

  @override
  String get video_screen_zones_desc => 'Bruk dra og slepp for å justera soner';

  @override
  String get video_screen_tools => 'Verktøy';

  @override
  String get video_screen_move_bottom => 'Flytt gjeldande sone til botnen';

  @override
  String get video_screen_add_point => 'Legg til punkt til gjeldande sone';

  @override
  String get video_screen_remove_point => 'Fjern punkt frå gjeldande sone';

  @override
  String get video_screen_playback_speed => 'Avspelingshastigheit';

  @override
  String get video_screen_playback_current => 'gjeldande: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Slett denne videokjelda';

  @override
  String get video_screen_delete_content => 'Er du sikker på at du vil sletta denne videokjelda?';

  @override
  String get video_screen_delete_button => 'Slett';

  @override
  String get video_screen_sources => 'Konfigurer bildekjelde, deteksjonsmål og modellparametrar.';

  @override
  String get video_screen_targets => 'Deteksjonsmål';

  @override
  String get video_screen_detection => 'Modellparametrar';

  @override
  String get color_screen_title => 'Vel ein farge';

  @override
  String get zone_screen_desc => 'Deteksjonssona kan setja typane objekt å detektera og velja kva teljarar som skal visast, som Oppdaga, Oppstått og Gått inn.';

  @override
  String get zone_screen_name_placeholder => 'Namnet på sona, som Fortau eller Parkeringsplass';

  @override
  String get zone_screen_zone_color => 'Sonefarge';

  @override
  String get zone_screen_color => 'Farge';

  @override
  String get zone_screen_delete_header => 'Slett denne sona';

  @override
  String get zone_screen_delete_content => 'Er du sikker på at du vil sletta denne sona?';

  @override
  String get zone_screen_delete_button => 'Slett';

  @override
  String get zone_screen_can_not_delete => 'Kan ikkje sletta sone';

  @override
  String get zone_screen_one_zone_required => 'Minst éi sone er påkravd.';

  @override
  String get zone_screen_zone_name_required => 'Sonenamnet kan ikkje vera tomt';

  @override
  String get counter_screen_show_on => 'Vis på skjerm';

  @override
  String get counter_screen_enabled => 'Aktivert';

  @override
  String get counter_screen_reentry_threshold => 'Reinngangsterskel';

  @override
  String get counter_screen_reentry_desc => 'Objekt må gå inn #0 gonger, med #1 sekunds nedkjølingstid mellom kvar utgang og reinngang, for å utløysa reinngang';

  @override
  String get counter_screen_reentry_title => 'Reinngangsteljing';

  @override
  String get counter_screen_cooldown_threshold => 'Nedkjølingsterskel';

  @override
  String get counter_screen_cooldown_desc => 'Reinngang krev #0 sekunds nedkjølingstid etter å ha forlate deteksjonssona';

  @override
  String get counter_screen_cooldown_time => 'Nedkjølingstid';

  @override
  String get counter_screen_cooldown_in_seconds => 'i sekund';

  @override
  String get counter_screen_stagnant_threshold => 'Stagnasjonsterskel';

  @override
  String get counter_screen_stagnant_desc => 'Objekt som står stille i meir enn #0 sekund vil verta rekna som stagnert';

  @override
  String get counter_screen_stagnant_consider => 'Rekn som stagnert';

  @override
  String get counter_screen_stagnant_in_seconds => 'i sekund';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Skildringsprefiks';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Skildringssuffiks';

  @override
  String get counter_screen_name_error => 'Teljarnamnet kan ikkje vera tomt';

  @override
  String get counter_screen_enabled_error => 'Feil';

  @override
  String get counter_screen_enabled_error_content => 'Du må aktivera ein annan teljar først, deretter kan du deaktivera denne teljaren';

  @override
  String get objects_screen_title => 'Objekt';

  @override
  String get objects_screen_desc => 'Vel deteksjonsmål som person, bil, buss, osb.';

  @override
  String get open_project_screen_title => 'Opne prosjekt';

  @override
  String get open_project_screen_desc => 'Opne tidlegare oppretta prosjekt, behaldar berre dei 20 nyaste.';

  @override
  String get open_project_screen_no_project => 'Ingen prosjekt funne.';

  @override
  String get default_project_name => 'Prosjekt';

  @override
  String get default_video_name => 'Videokjelde';

  @override
  String get default_zone_name => 'Deteksjonssone';

  @override
  String get error_oops => 'Oi, noko gjekk gale';

  @override
  String get error_content => 'Ein uventa feil oppstod. Vil du senda ein e-postrapport?';

  @override
  String get error_report => 'E-post oss';

  @override
  String get submit => 'Send inn';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Avbryt';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nei';

  @override
  String get close => 'Lukk';

  @override
  String get back => 'Tilbake';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Sone';

  @override
  String get zone_screen_zone_show_summary => 'Vis samandrag på skjerm';
}
