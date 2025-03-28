// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class LocalizationSv extends Localization {
  LocalizationSv([String locale = 'sv']) : super(locale);

  @override
  String get product_name => 'Räknare';

  @override
  String get product_desc => 'Använder datorseende och AI för att räkna personer, fordon, husdjur och mer.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webbkamera';

  @override
  String get video_sources_live_stream => 'Direktsändnings-URL';

  @override
  String get video_sources_file => 'Fil';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera hittades inte';

  @override
  String get video_sources_camera_not_found_message => 'Du behöver ge kamerabehörighet för att använda kameran';

  @override
  String get video_sources_webcam_not_found_title => 'Webbkamera hittades inte';

  @override
  String get video_sources_webcam_not_found_message => 'Kontrollera appbehörighet och webbkameraanslutning';

  @override
  String get wizard_screen_desc => 'Skapa ett nytt projekt nedan för att börja räkna.';

  @override
  String get wizard_screen_new_project_from => 'Nytt projekt från';

  @override
  String get wizard_screen_language => 'Språk';

  @override
  String get wizard_screen_about => 'Om';

  @override
  String get wizard_screen_open_projects_tip => 'Alla projekt sparas lokalt automatiskt';

  @override
  String get wizard_screen_open_projects => 'Öppna befintligt projekt';

  @override
  String get wizard_screen_email_us => 'Mejla oss';

  @override
  String get language_screen_language => 'Språk';

  @override
  String get project_view_no_videos => 'Ingen videokälla tillgänglig.';

  @override
  String get about_screen_title => 'Om';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get about_screen_app_version => 'App-version';

  @override
  String get about_screen_models => 'Objektdetekteringsmodeller';

  @override
  String get about_screen_benchmark => 'Prestandatest';

  @override
  String get about_screen_opencv_build_info => 'OpenCV bygginformation';

  @override
  String get benchmark_screen_title => 'Modellprestandatest';

  @override
  String get benchmark_screen_recommended => 'Rekommenderad modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Starta prestandatest';

  @override
  String get benchmark_screen_start_failed => 'Misslyckades med att starta prestandatest, felkoden är';

  @override
  String get benchmark_screen_models => 'Objektdetekteringsmodeller';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Bekräfta avslut av projektet';

  @override
  String get project_screen_exit_confirm_content => 'Om du lämnar projektet kommer räkningen att stoppas. Är du säker på att du vill fortsätta?';

  @override
  String get project_screen_exit_button => 'Avsluta';

  @override
  String get project_screen_add_video_button => 'Lägg till videokälla';

  @override
  String get project_screen_from_desc => 'Vi sparar en rullande 24-timmarsperiod, så du kan granska valfri tidsperiod vid behov.';

  @override
  String get project_screen_report_settings => 'Inställningar';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Välj ett filterintervall från listan nedan';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Sluttiden måste vara senare än starttiden';

  @override
  String get filter_screen_error_custom => 'Anpassad';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Slut';

  @override
  String get settings_screen_title => 'Inställningar';

  @override
  String get settings_screen_desc => 'Ställ in projektnamn, detekteringsparametrar, räkningsåterställning.';

  @override
  String get settings_screen_project_id => 'Projekt-ID';

  @override
  String get settings_screen_project_name => 'Projektnamn';

  @override
  String get settings_screen_project_name_place_holder => 'Storgatan 123 eller Folkets Park';

  @override
  String get settings_screen_project_error => 'Projektnamnet får inte vara tomt';

  @override
  String get settings_screen_random_count_button => 'Lägg till slumpmässiga räkningar';

  @override
  String get settings_screen_reset_count_header => 'Återställ alla räkningar i detta projekt';

  @override
  String get settings_screen_reset_count_button => 'Återställ räkningar';

  @override
  String get settings_screen_reset_count_content => 'Är du säker på att du vill återställa alla räkningar?';

  @override
  String get settings_screen_delete_header => 'Ta bort detta projekt';

  @override
  String get settings_screen_delete_content => 'Är du säker på att du vill ta bort detta projekt?';

  @override
  String get settings_screen_delete_button => 'Ta bort';

  @override
  String get settings_screen_center_point_title => 'Centralpunkt på målet';

  @override
  String get settings_screen_center_point_desc => 'Centralpunkten hjälper till att avgöra om målet befinner sig inom träffzonen.';

  @override
  String get settings_screen_center_point_button => 'Visa centralpunkt på målet';

  @override
  String get settings_screen_lost_target_title => 'Förlorat mål';

  @override
  String get settings_screen_lost_target_desc => 'När objektspårningen tappar ett mål gör detta alternativ det synligt. Som standard visas inte förlorade mål.';

  @override
  String get settings_screen_lost_target_button => 'Visa förlorat mål';

  @override
  String get detection_screen_title => 'Detekteringsinställningar';

  @override
  String get detection_screen_models => 'Modeller';

  @override
  String get detection_screen_confidence => 'Konfidensgrad';

  @override
  String get detection_screen_confidence_desc => 'konfidensgrad över #0 betraktas som en giltig detektering';

  @override
  String get detection_screen_low => 'Låg';

  @override
  String get detection_screen_high => 'Hög';

  @override
  String get detection_screen_nms => 'Icke-maximal eliminering';

  @override
  String get detection_screen_nms_desc => '#0 Ett lägre NMS-tröskelvärde (t.ex. 30%) tar bort överlappande avgränsningsrutor mer aggressivt, medan ett högre NMS-tröskelvärde (t.ex. 0,6) tillåter mer överlappning';

  @override
  String get detection_screen_match => 'Matchning';

  @override
  String get detection_screen_match_desc => 'Matchning över #0 anses vara samma objekt.';

  @override
  String get detection_screen_lost => 'Förlorad';

  @override
  String get detection_screen_lost_desc => 'Spårat objekt tas bort om det har förlorats i #0';

  @override
  String get detection_screen_consider_valid => 'Betrakta som giltig efter';

  @override
  String get detection_screen_consider_valid_desc => 'Spårat objekt betraktas som giltigt efter #0';

  @override
  String get detection_screen_reset => 'Återställ';

  @override
  String get detection_screen_reset_content => 'Är du säker på att du vill återställa detekteringsinställningarna?';

  @override
  String get url_screen_title => 'Direktsändnings-URL';

  @override
  String get url_screen_desc => 'Ange URL:en för direktsändningen';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exempel.com/stream eller rtsp://exempel.com/stream';

  @override
  String get add_video_screen_title => 'Lägg till videokälla';

  @override
  String get add_video_screen_from => 'Lägg till videokälla från';

  @override
  String get webcam_screen_add_title => 'Lägg till webbkamera';

  @override
  String get webcam_screen_edit_title => 'Välj webbkamera';

  @override
  String get webcam_manager_webcam => 'Webbkamera';

  @override
  String get camera_screen_front_camera => 'Främre kamera';

  @override
  String get camera_screen_back_camera => 'Bakre kamera';

  @override
  String get camera_screen_add_title => 'Lägg till kamera';

  @override
  String get camera_screen_edit_title => 'Välj kamera';

  @override
  String get camera_screen_zoom_level => 'Zoomnivå';

  @override
  String get video_screen_name_empty => 'Videonamnet får inte vara tomt.';

  @override
  String get video_screen_desc => 'Hantera videokällor, lägg till eller ändra detekteringszoner.';

  @override
  String get video_screen_video_name => 'Videokällans namn';

  @override
  String get video_screen_edit_placeholder => 'Ytterdörrskamera eller Parkeringsplatskamera';

  @override
  String get video_screen_change_file => 'Byt fil';

  @override
  String get video_screen_add_zone => 'Lägg till detekteringszon';

  @override
  String get video_screen_zones => 'Detekteringszoner';

  @override
  String get video_screen_zones_desc => 'Använd dra och släpp för att justera zoner';

  @override
  String get video_screen_tools => 'Verktyg';

  @override
  String get video_screen_move_bottom => 'Flytta aktuell zon till botten';

  @override
  String get video_screen_add_point => 'Lägg till punkt i aktuell zon';

  @override
  String get video_screen_remove_point => 'Ta bort punkt från aktuell zon';

  @override
  String get video_screen_playback_speed => 'Uppspelningshastighet';

  @override
  String get video_screen_playback_current => 'nuvarande: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Ta bort denna videokälla';

  @override
  String get video_screen_delete_content => 'Är du säker på att du vill ta bort denna videokälla?';

  @override
  String get video_screen_delete_button => 'Ta bort';

  @override
  String get video_screen_sources => 'Konfigurera bildkälla, detekteringsmål och modellparametrar.';

  @override
  String get video_screen_targets => 'Detekteringsmål';

  @override
  String get video_screen_detection => 'Modellparametrar';

  @override
  String get color_screen_title => 'Välj en färg';

  @override
  String get zone_screen_desc => 'Detekteringszonen kan ställa in vilka typer av objekt som ska detekteras och välja vilka räknare som ska visas, såsom Detekterade, Skapade och Inkomna.';

  @override
  String get zone_screen_name_placeholder => 'Zonens namn, som Trottoar eller Parkering';

  @override
  String get zone_screen_zone_color => 'Zonfärg';

  @override
  String get zone_screen_color => 'Färg';

  @override
  String get zone_screen_delete_header => 'Ta bort denna zon';

  @override
  String get zone_screen_delete_content => 'Är du säker på att du vill ta bort denna zon?';

  @override
  String get zone_screen_delete_button => 'Ta bort';

  @override
  String get zone_screen_can_not_delete => 'Kan inte ta bort zon';

  @override
  String get zone_screen_one_zone_required => 'Minst en zon krävs.';

  @override
  String get zone_screen_zone_name_required => 'Zonnamnet får inte vara tomt';

  @override
  String get counter_screen_show_on => 'Visa på skärmen';

  @override
  String get counter_screen_enabled => 'Aktiverad';

  @override
  String get counter_screen_reentry_threshold => 'Återinträdeströskel';

  @override
  String get counter_screen_reentry_desc => 'Objekt måste komma in #0 gånger, med #1 sekunders nedkylningstid mellan varje utgång och återinträde, för att utlösa återinträde';

  @override
  String get counter_screen_reentry_title => 'Återinträdesräkning';

  @override
  String get counter_screen_cooldown_threshold => 'Nedkylningströskel';

  @override
  String get counter_screen_cooldown_desc => 'Återinträde kräver #0 sekunders nedkylning efter att ha lämnat detekteringszonen';

  @override
  String get counter_screen_cooldown_time => 'Nedkylningstid';

  @override
  String get counter_screen_cooldown_in_seconds => 'i sekunder';

  @override
  String get counter_screen_stagnant_threshold => 'Stillastående tröskel';

  @override
  String get counter_screen_stagnant_desc => 'Objekt som förblir stillastående i mer än #0 sekunder kommer att betraktas som stillastående';

  @override
  String get counter_screen_stagnant_consider => 'Betrakta som stillastående';

  @override
  String get counter_screen_stagnant_in_seconds => 'i sekunder';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beskrivningsprefix';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beskrivningssuffix';

  @override
  String get counter_screen_name_error => 'Räknarnamnet får inte vara tomt';

  @override
  String get counter_screen_enabled_error => 'Fel';

  @override
  String get counter_screen_enabled_error_content => 'Du måste aktivera en annan räknare först, sedan kan du inaktivera denna räknare';

  @override
  String get objects_screen_title => 'Objekt';

  @override
  String get objects_screen_desc => 'Välj detekteringsmål som person, bil, buss, etc.';

  @override
  String get open_project_screen_title => 'Öppna projekt';

  @override
  String get open_project_screen_desc => 'Öppna tidigare skapade projekt, behåller endast de senaste 20.';

  @override
  String get open_project_screen_no_project => 'Inget projekt hittades.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videokälla';

  @override
  String get default_zone_name => 'Detekteringszon';

  @override
  String get error_oops => 'Hoppsan, något gick fel';

  @override
  String get error_content => 'Ett oväntat fel uppstod. Vill du skicka en e-postrapport?';

  @override
  String get error_report => 'Mejla oss';

  @override
  String get submit => 'Skicka';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Avbryt';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nej';

  @override
  String get close => 'Stäng';

  @override
  String get back => 'Tillbaka';

  @override
  String get zone_screen_zone => 'Zon';

  @override
  String get zone_screen_zone_show_summary => 'Visa sammanfattning på skärmen';

  @override
  String get video_sources_photos_denied => 'Åtkomst till foton nekad';

  @override
  String get video_sources_photos_goto_settings => 'Gå till inställningar';

  @override
  String get video_sources_camera_denied => 'Åtkomst till kamera nekad';

  @override
  String get video_sources_photos_denied_msg => 'Gå till inställningar och tillåt bildåtkomst för den här appen.';

  @override
  String get video_sources_camera_denied_msg => 'Gå till inställningar och tillåt kameraåtkomst för den här appen.';
}
