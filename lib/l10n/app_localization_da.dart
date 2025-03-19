// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationDa extends AppLocalization {
  AppLocalizationDa([String locale = 'da']) : super(locale);

  @override
  String get product_name => 'Vision Counter';

  @override
  String get product_desc => 'Bruger computer vision og AI til at tælle personer, køretøjer, kæledyr og mere.';

  @override
  String get product_copyright => 'Ophavsret © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Live stream URL';

  @override
  String get video_sources_file => 'Fil';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera ikke fundet';

  @override
  String get video_sources_camera_not_found_message => 'Kameratilladelse kræves for at bruge kamera';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam ikke fundet';

  @override
  String get video_sources_webcam_not_found_message => 'Kontroller venligst om der er tilsluttet et webcam';

  @override
  String get wizard_screen_desc => 'Opret et nyt projekt nedenfor for at begynde optælling.';

  @override
  String get wizard_screen_new_project_from => 'Nyt projekt fra';

  @override
  String get wizard_screen_language => 'Sprog';

  @override
  String get wizard_screen_about => 'Om';

  @override
  String get wizard_screen_open_projects_tip => 'Alle projekter gemmes automatisk lokalt';

  @override
  String get wizard_screen_open_projects => 'Åbn eksisterende projekt';

  @override
  String get wizard_screen_email_us => 'E-mail os';

  @override
  String get language_screen_language => 'Sprog';

  @override
  String get project_view_no_videos => 'Ingen videokilde tilgængelig.';

  @override
  String get about_screen_title => 'Om';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'App-version';

  @override
  String get about_screen_models => 'Objektdetekteringsmodeller';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV byggeinfo';

  @override
  String get benchmark_screen_title => 'Model-benchmarks';

  @override
  String get benchmark_screen_recommended => 'Anbefalet model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start benchmark';

  @override
  String get benchmark_screen_start_failed => 'Kunne ikke starte benchmark, fejlkoden er';

  @override
  String get benchmark_screen_models => 'Objektdetekteringsmodeller';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Bekræft afslutning af projekt';

  @override
  String get project_screen_exit_confirm_content => 'Hvis du forlader projektet, stopper optællingen. Er du sikker på, at du vil fortsætte?';

  @override
  String get project_screen_exit_button => 'Afslut';

  @override
  String get project_screen_add_video_button => 'Tilføj videokilde';

  @override
  String get project_screen_from_desc => 'Vi gemmer en rullende 24-timers optagelse, så du kan se ethvert tidsudsnit, du har brug for.';

  @override
  String get project_screen_report_settings => 'Indstillinger';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Vælg et filterområde fra listen nedenfor';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Sluttidspunkt skal være senere end starttidspunkt';

  @override
  String get filter_screen_error_custom => 'Brugerdefineret';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Slut';

  @override
  String get settings_screen_title => 'Indstillinger';

  @override
  String get settings_screen_desc => 'Indstil projektnavn, detekteringsparametre og nulstilling af optællinger.';

  @override
  String get settings_screen_project_id => 'Projekt-ID';

  @override
  String get settings_screen_project_name => 'Projektnavn';

  @override
  String get settings_screen_project_name_place_holder => 'Hovedgaden 123 eller Kongens Have';

  @override
  String get settings_screen_project_error => 'Projektnavnet kan ikke være tomt';

  @override
  String get settings_screen_random_count_button => 'Tilføj tilfældige optællinger';

  @override
  String get settings_screen_reset_count_header => 'Nulstil alle optællinger i dette projekt';

  @override
  String get settings_screen_reset_count_button => 'Nulstil optællinger';

  @override
  String get settings_screen_reset_count_content => 'Er du sikker på, at du vil nulstille alle optællinger?';

  @override
  String get settings_screen_delete_header => 'Slet dette projekt';

  @override
  String get settings_screen_delete_content => 'Er du sikker på, at du vil slette dette projekt?';

  @override
  String get settings_screen_delete_button => 'Slet';

  @override
  String get settings_screen_center_point_title => 'Centerpunkt på mål';

  @override
  String get settings_screen_center_point_desc => 'Centerpunktet hjælper med at afgøre, om målet er inden for træfzonen.';

  @override
  String get settings_screen_center_point_button => 'Vis centerpunkt på mål';

  @override
  String get settings_screen_lost_target_title => 'Tabt mål';

  @override
  String get settings_screen_lost_target_desc => 'Når objektsporing mister et mål, gør denne indstilling det synligt. Som standard vises tabte mål ikke.';

  @override
  String get settings_screen_lost_target_button => 'Vis tabt mål';

  @override
  String get detection_screen_title => 'Detekteringsindstillinger';

  @override
  String get detection_screen_models => 'Modeller';

  @override
  String get detection_screen_confidence => 'Konfidens';

  @override
  String get detection_screen_confidence_desc => 'konfidens over #0 betragtes som en gyldig detektion';

  @override
  String get detection_screen_low => 'Lav';

  @override
  String get detection_screen_high => 'Høj';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 En lavere NMS-tærskel (f.eks. 30%) vil mere aggressivt fjerne overlappende afgrænsningsfelter, mens en højere NMS-tærskel (f.eks. 0,6) vil tillade mere overlap';

  @override
  String get detection_screen_match => 'Match';

  @override
  String get detection_screen_match_desc => 'Match over #0 betragtes som det samme objekt.';

  @override
  String get detection_screen_lost => 'Tabt';

  @override
  String get detection_screen_lost_desc => 'Sporingsobjekt vil blive fjernet, hvis det er tabt i #0';

  @override
  String get detection_screen_consider_valid => 'Betragt som gyldig efter';

  @override
  String get detection_screen_consider_valid_desc => 'Sporingsobjekt vil blive betragtet som gyldigt efter #0';

  @override
  String get detection_screen_reset => 'Nulstil';

  @override
  String get detection_screen_reset_content => 'Er du sikker på, at du vil nulstille detekteringsindstillingerne?';

  @override
  String get url_screen_title => 'Live stream URL';

  @override
  String get url_screen_desc => 'Indtast venligst live stream URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://eksempel.dk/stream eller rtsp://eksempel.dk/stream';

  @override
  String get add_video_screen_title => 'Tilføj videokilde';

  @override
  String get add_video_screen_from => 'Tilføj videokilde fra';

  @override
  String get webcam_screen_add_title => 'Tilføj webcam';

  @override
  String get webcam_screen_edit_title => 'Vælg webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Frontkamera';

  @override
  String get camera_screen_back_camera => 'Bagkamera';

  @override
  String get camera_screen_add_title => 'Tilføj kamera';

  @override
  String get camera_screen_edit_title => 'Vælg kamera';

  @override
  String get camera_screen_zoom_level => 'Zoomniveau';

  @override
  String get video_screen_name_empty => 'Videokildenavnet kan ikke være tomt.';

  @override
  String get video_screen_desc => 'Administrer videokilder, tilføj eller rediger detekteringszoner.';

  @override
  String get video_screen_video_name => 'Videokildenavn';

  @override
  String get video_screen_edit_placeholder => 'Hoveddør-kamera eller Parkeringsplads-kamera';

  @override
  String get video_screen_change_file => 'Skift fil';

  @override
  String get video_screen_add_zone => 'Tilføj detekteringszone';

  @override
  String get video_screen_zones => 'Detekteringszoner';

  @override
  String get video_screen_zones_desc => 'Brug træk og slip til at justere zoner';

  @override
  String get video_screen_tools => 'Værktøjer';

  @override
  String get video_screen_move_bottom => 'Flyt aktuel zone til bunden';

  @override
  String get video_screen_add_point => 'Tilføj punkt til aktuel zone';

  @override
  String get video_screen_remove_point => 'Fjern punkt fra aktuel zone';

  @override
  String get video_screen_playback_speed => 'Afspilningshastighed';

  @override
  String get video_screen_playback_current => 'aktuel: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Slet denne videokilde';

  @override
  String get video_screen_delete_content => 'Er du sikker på, at du vil slette denne videokilde?';

  @override
  String get video_screen_delete_button => 'Slet';

  @override
  String get video_screen_sources => 'Konfigurer billedkilde, detekteringsmål og modelparametre.';

  @override
  String get video_screen_targets => 'Detekteringsmål';

  @override
  String get video_screen_detection => 'Modelparametre';

  @override
  String get color_screen_title => 'Vælg en farve';

  @override
  String get zone_screen_desc => 'Detekteringszonen kan indstille typer af objekter, der skal detekteres, og vælge hvilke tællere der skal vises, såsom Detekteret, Oprettet og Indtrådt.';

  @override
  String get zone_screen_name_placeholder => 'Navnet på zonen, som Fortov eller Parkeringsplads';

  @override
  String get zone_screen_zone_color => 'Zonefarve';

  @override
  String get zone_screen_color => 'Farve';

  @override
  String get zone_screen_delete_header => 'Slet denne zone';

  @override
  String get zone_screen_delete_content => 'Er du sikker på, at du vil slette denne zone?';

  @override
  String get zone_screen_delete_button => 'Slet';

  @override
  String get zone_screen_can_not_delete => 'Kan ikke slette zone';

  @override
  String get zone_screen_one_zone_required => 'Mindst én zone er påkrævet.';

  @override
  String get zone_screen_zone_name_required => 'Zonenavnet kan ikke være tomt';

  @override
  String get counter_screen_show_on => 'Vis på skærmen';

  @override
  String get counter_screen_enabled => 'Aktiveret';

  @override
  String get counter_screen_reentry_threshold => 'Genindtrædelsestærskel';

  @override
  String get counter_screen_reentry_desc => 'Objekter skal komme ind #0 gange, med #1 sekunders nedkøling mellem hver udgang og genindtræden, for at udløse genindtræden';

  @override
  String get counter_screen_reentry_title => 'Genindtrædelsestæller';

  @override
  String get counter_screen_cooldown_threshold => 'Nedkølingstærskel';

  @override
  String get counter_screen_cooldown_desc => 'Genindtræden kræver #0 sekunders nedkøling efter at forlade detekteringszonen';

  @override
  String get counter_screen_cooldown_time => 'Nedkølingstid';

  @override
  String get counter_screen_cooldown_in_seconds => 'i sekunder';

  @override
  String get counter_screen_stagnant_threshold => 'Stillestående tærskel';

  @override
  String get counter_screen_stagnant_desc => 'Objekter, der forbliver stillestående i mere end #0 sekunder, betragtes som stillestående';

  @override
  String get counter_screen_stagnant_consider => 'Betragt som stillestående';

  @override
  String get counter_screen_stagnant_in_seconds => 'i sekunder';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beskrivelsespræfiks';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beskrivelsessuffiks';

  @override
  String get counter_screen_name_error => 'Tællernavnet kan ikke være tomt';

  @override
  String get counter_screen_enabled_error => 'Fejl';

  @override
  String get counter_screen_enabled_error_content => 'Du skal aktivere en anden tæller først, før du kan deaktivere denne tæller';

  @override
  String get objects_screen_title => 'Objekter';

  @override
  String get objects_screen_desc => 'Vælg detekteringsmål som person, bil, bus osv.';

  @override
  String get open_project_screen_title => 'Åbn projekt';

  @override
  String get open_project_screen_desc => 'Åbn tidligere oprettede projekter, hvor kun de seneste 20 beholdes.';

  @override
  String get open_project_screen_no_project => 'Intet projekt fundet.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videokilde';

  @override
  String get default_zone_name => 'Detekteringszone';

  @override
  String get error_oops => 'Ups, noget gik galt';

  @override
  String get error_content => 'Der opstod en uventet fejl. Vil du indsende en e-mailrapport?';

  @override
  String get error_report => 'E-mail os';

  @override
  String get submit => 'Indsend';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuller';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nej';

  @override
  String get close => 'Luk';

  @override
  String get back => 'Tilbage';
}
