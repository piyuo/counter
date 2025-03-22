// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class LocalizationNb extends Localization {
  LocalizationNb([String locale = 'nb']) : super(locale);

  @override
  String get product_name => 'Teller';

  @override
  String get product_desc => 'Bruk datamaskinsyn og kunstig intelligens for å telle mennesker, kjøretøy, kjæledyr og mer.';

  @override
  String get product_copyright => 'Opphavsrett © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'Direktestrøm URL';

  @override
  String get video_sources_file => 'Fil';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera ikke funnet';

  @override
  String get video_sources_camera_not_found_message => 'Trenger kameratillatelse for å bruke kamera';

  @override
  String get video_sources_webcam_not_found_title => 'Webkamera ikke funnet';

  @override
  String get video_sources_webcam_not_found_message => 'Vennligst sjekk om webkamera er tilkoblet';

  @override
  String get wizard_screen_desc => 'Opprett et nytt prosjekt nedenfor for å begynne å telle.';

  @override
  String get wizard_screen_new_project_from => 'Nytt prosjekt fra';

  @override
  String get wizard_screen_language => 'Språk';

  @override
  String get wizard_screen_about => 'Om';

  @override
  String get wizard_screen_open_projects_tip => 'Alle prosjekter lagres automatisk lokalt';

  @override
  String get wizard_screen_open_projects => 'Åpne eksisterende prosjekt';

  @override
  String get wizard_screen_email_us => 'Send e-post til oss';

  @override
  String get language_screen_language => 'Språk';

  @override
  String get project_view_no_videos => 'Ingen videokilder tilgjengelig.';

  @override
  String get about_screen_title => 'Om';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get about_screen_app_version => 'App-versjon';

  @override
  String get about_screen_models => 'Objektgjenkjenningsmodeller';

  @override
  String get about_screen_benchmark => 'Ytelsestest';

  @override
  String get about_screen_opencv_build_info => 'OpenCV bygginformasjon';

  @override
  String get benchmark_screen_title => 'Modellytelsestester';

  @override
  String get benchmark_screen_recommended => 'Anbefalt modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start ytelsestest';

  @override
  String get benchmark_screen_start_failed => 'Kunne ikke starte ytelsestest, feilkoden er';

  @override
  String get benchmark_screen_models => 'Objektgjenkjenningsmodeller';

  @override
  String get project_screen_title => 'Prosjekt';

  @override
  String get project_screen_exit_confirm_title => 'Bekreft avslutning av prosjekt';

  @override
  String get project_screen_exit_confirm_content => 'Å forlate prosjektet vil stoppe tellingen. Er du sikker på at du vil fortsette?';

  @override
  String get project_screen_exit_button => 'Avslutt';

  @override
  String get project_screen_add_video_button => 'Legg til videokilde';

  @override
  String get project_screen_from_desc => 'Vi beholder en rullerende 24-timers historikk, så du kan se ethvert tidsutsnitt du trenger.';

  @override
  String get project_screen_report_settings => 'Innstillinger';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Velg et filterområde fra listen nedenfor';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Sluttid må være senere enn starttid';

  @override
  String get filter_screen_error_custom => 'Egendefinert';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Slutt';

  @override
  String get settings_screen_title => 'Innstillinger';

  @override
  String get settings_screen_desc => 'Angi prosjektnavn, deteksjonsparametere og nullstilling av tellinger.';

  @override
  String get settings_screen_project_id => 'Prosjekt-ID';

  @override
  String get settings_screen_project_name => 'Prosjektnavn';

  @override
  String get settings_screen_project_name_place_holder => '123 Storgate eller Slottsparken';

  @override
  String get settings_screen_project_error => 'Prosjektnavnet kan ikke være tomt';

  @override
  String get settings_screen_random_count_button => 'Legg til tilfeldige tellinger';

  @override
  String get settings_screen_reset_count_header => 'Nullstill alle tellinger i dette prosjektet';

  @override
  String get settings_screen_reset_count_button => 'Nullstill tellinger';

  @override
  String get settings_screen_reset_count_content => 'Er du sikker på at du vil nullstille alle tellinger?';

  @override
  String get settings_screen_delete_header => 'Slett dette prosjektet';

  @override
  String get settings_screen_delete_content => 'Er du sikker på at du vil slette dette prosjektet?';

  @override
  String get settings_screen_delete_button => 'Slett';

  @override
  String get settings_screen_center_point_title => 'Senterpunkt på mål';

  @override
  String get settings_screen_center_point_desc => 'Senterpunktet hjelper med å bestemme om målet er innenfor treffområdet.';

  @override
  String get settings_screen_center_point_button => 'Vis senterpunkt på mål';

  @override
  String get settings_screen_lost_target_title => 'Tapt mål';

  @override
  String get settings_screen_lost_target_desc => 'Når objektsporing mister et mål, gjør dette valget det synlig. Som standard vises ikke tapte mål.';

  @override
  String get settings_screen_lost_target_button => 'Vis tapte mål';

  @override
  String get detection_screen_title => 'Deteksjonsinnstillinger';

  @override
  String get detection_screen_models => 'Modeller';

  @override
  String get detection_screen_confidence => 'Konfidens';

  @override
  String get detection_screen_confidence_desc => 'konfidens over #0 anses som en gyldig deteksjon';

  @override
  String get detection_screen_low => 'Lav';

  @override
  String get detection_screen_high => 'Høy';

  @override
  String get detection_screen_nms => 'Ikke-maksimum undertrykking';

  @override
  String get detection_screen_nms_desc => '#0 En lavere NMS-terskel (f.eks. 30%) vil mer aggressivt fjerne overlappende avgrensningsbokser, mens en høyere NMS-terskel (f.eks. 0,6) vil tillate mer overlapping';

  @override
  String get detection_screen_match => 'Samsvar';

  @override
  String get detection_screen_match_desc => 'Samsvar over #0 anses som samme objekt.';

  @override
  String get detection_screen_lost => 'Tapt';

  @override
  String get detection_screen_lost_desc => 'Sporingsobjekt vil bli fjernet hvis det er tapt i #0';

  @override
  String get detection_screen_consider_valid => 'Anse som gyldig etter';

  @override
  String get detection_screen_consider_valid_desc => 'Sporingsobjekt vil bli ansett som gyldig etter #0';

  @override
  String get detection_screen_reset => 'Nullstill';

  @override
  String get detection_screen_reset_content => 'Er du sikker på at du vil nullstille deteksjonsinnstillingene?';

  @override
  String get url_screen_title => 'Direktestrøm URL';

  @override
  String get url_screen_desc => 'Vennligst skriv inn direktestrøm URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://eksempel.no/strøm eller rtsp://eksempel.no/strøm';

  @override
  String get add_video_screen_title => 'Legg til videokilde';

  @override
  String get add_video_screen_from => 'Legg til videokilde fra';

  @override
  String get webcam_screen_add_title => 'Legg til webkamera';

  @override
  String get webcam_screen_edit_title => 'Velg webkamera';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Frontkamera';

  @override
  String get camera_screen_back_camera => 'Bakkamera';

  @override
  String get camera_screen_add_title => 'Legg til kamera';

  @override
  String get camera_screen_edit_title => 'Velg kamera';

  @override
  String get camera_screen_zoom_level => 'Zoom-nivå';

  @override
  String get video_screen_name_empty => 'Videokildenavnet kan ikke være tomt.';

  @override
  String get video_screen_desc => 'Administrer videokilder, legg til eller endre deteksjonssoner.';

  @override
  String get video_screen_video_name => 'Videokildenavn';

  @override
  String get video_screen_edit_placeholder => 'Inngangskamera eller Parkeringskamera';

  @override
  String get video_screen_change_file => 'Endre fil';

  @override
  String get video_screen_add_zone => 'Legg til deteksjonssone';

  @override
  String get video_screen_zones => 'Deteksjonssoner';

  @override
  String get video_screen_zones_desc => 'Bruk dra og slipp for å justere soner';

  @override
  String get video_screen_tools => 'Verktøy';

  @override
  String get video_screen_move_bottom => 'Flytt gjeldende sone til bunnen';

  @override
  String get video_screen_add_point => 'Legg til punkt i gjeldende sone';

  @override
  String get video_screen_remove_point => 'Fjern punkt fra gjeldende sone';

  @override
  String get video_screen_playback_speed => 'Avspillingshastighet';

  @override
  String get video_screen_playback_current => 'nåværende: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Slett denne videokilden';

  @override
  String get video_screen_delete_content => 'Er du sikker på at du vil slette denne videokilden?';

  @override
  String get video_screen_delete_button => 'Slett';

  @override
  String get video_screen_sources => 'Konfigurer bildekilde, deteksjonsmål og modellparametere.';

  @override
  String get video_screen_targets => 'Deteksjonsmål';

  @override
  String get video_screen_detection => 'Modellparametere';

  @override
  String get color_screen_title => 'Velg en farge';

  @override
  String get zone_screen_desc => 'Deteksjonssonen kan angi hvilke typer objekter som skal oppdages og velge hvilke tellere som skal vises, som Oppdaget, Opprettet og Kommet inn.';

  @override
  String get zone_screen_name_placeholder => 'Navnet på sonen, som Fortau eller Parkeringsplass';

  @override
  String get zone_screen_zone_color => 'Sonefarge';

  @override
  String get zone_screen_color => 'Farge';

  @override
  String get zone_screen_delete_header => 'Slett denne sonen';

  @override
  String get zone_screen_delete_content => 'Er du sikker på at du vil slette denne sonen?';

  @override
  String get zone_screen_delete_button => 'Slett';

  @override
  String get zone_screen_can_not_delete => 'Kan ikke slette sone';

  @override
  String get zone_screen_one_zone_required => 'Minst én sone er påkrevd.';

  @override
  String get zone_screen_zone_name_required => 'Sonenavnet kan ikke være tomt';

  @override
  String get counter_screen_show_on => 'Vis på skjermen';

  @override
  String get counter_screen_enabled => 'Aktivert';

  @override
  String get counter_screen_reentry_threshold => 'Gjeninntredelsesterskel';

  @override
  String get counter_screen_reentry_desc => 'Objekter må komme inn #0 ganger, med en #1 sekunds nedkjølingstid mellom hver utgang og gjeninntreden, for å utløse gjeninntreden';

  @override
  String get counter_screen_reentry_title => 'Gjeninntredelsestelling';

  @override
  String get counter_screen_cooldown_threshold => 'Nedkjølingsterskel';

  @override
  String get counter_screen_cooldown_desc => 'Gjeninntreden krever en #0 sekunds nedkjølingstid etter å ha forlatt deteksjonssonen';

  @override
  String get counter_screen_cooldown_time => 'Nedkjølingstid';

  @override
  String get counter_screen_cooldown_in_seconds => 'i sekunder';

  @override
  String get counter_screen_stagnant_threshold => 'Stillstandsterskel';

  @override
  String get counter_screen_stagnant_desc => 'Objekter som forblir stasjonære i mer enn #0 sekunder vil bli ansett som stillestående';

  @override
  String get counter_screen_stagnant_consider => 'Anse som stillestående';

  @override
  String get counter_screen_stagnant_in_seconds => 'i sekunder';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beskrivelseprefix';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beskrivelsessuffiks';

  @override
  String get counter_screen_name_error => 'Tellernavnet kan ikke være tomt';

  @override
  String get counter_screen_enabled_error => 'Feil';

  @override
  String get counter_screen_enabled_error_content => 'Du må aktivere en annen teller først, deretter kan du deaktivere denne telleren';

  @override
  String get objects_screen_title => 'Objekter';

  @override
  String get objects_screen_desc => 'Velg deteksjonsmål som person, bil, buss, osv.';

  @override
  String get open_project_screen_title => 'Åpne prosjekt';

  @override
  String get open_project_screen_desc => 'Åpne tidligere opprettede prosjekter, beholder kun de 20 nyeste.';

  @override
  String get open_project_screen_no_project => 'Ingen prosjekter funnet.';

  @override
  String get default_project_name => 'Prosjekt';

  @override
  String get default_video_name => 'Videokilde';

  @override
  String get default_zone_name => 'Deteksjonssone';

  @override
  String get error_oops => 'Ups, noe gikk galt';

  @override
  String get error_content => 'En uventet feil oppstod. Vil du sende en e-postrapport?';

  @override
  String get error_report => 'Send e-post til oss';

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
}
