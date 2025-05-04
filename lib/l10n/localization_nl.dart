// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class LocalizationNl extends Localization {
  LocalizationNl([String locale = 'nl']) : super(locale);

  @override
  String get product_name => 'Teller';

  @override
  String get product_desc => 'Computer vision en AI gebruiken om mensen, voertuigen, huisdieren en meer te tellen.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Livestream URL';

  @override
  String get video_sources_file => 'Bestand';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_camera_not_found_title => 'Camera niet gevonden';

  @override
  String get video_sources_camera_not_found_message => 'Cameratoestemming is nodig om de camera te gebruiken';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam niet gevonden';

  @override
  String get video_sources_webcam_not_found_message => 'Controleer app-toestemming en webcamverbinding';

  @override
  String get wizard_screen_desc => 'Maak een nieuw project hieronder om te beginnen met tellen.';

  @override
  String get wizard_screen_new_project_from => 'Nieuw project van';

  @override
  String get wizard_screen_language => 'Taal';

  @override
  String get wizard_screen_about => 'Over';

  @override
  String get wizard_screen_open_projects_tip => 'Alle projecten worden automatisch lokaal opgeslagen';

  @override
  String get wizard_screen_open_projects => 'Bestaand project openen';

  @override
  String get wizard_screen_email_us => 'E-mail ons';

  @override
  String get language_screen_language => 'Taal';

  @override
  String get project_view_no_videos => 'Geen videobron beschikbaar.';

  @override
  String get about_screen_title => 'Over';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'App-versie';

  @override
  String get about_screen_models => 'Objectdetectiemodellen';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build Info';

  @override
  String get benchmark_screen_title => 'Modellen Benchmarks';

  @override
  String get benchmark_screen_recommended => 'Aanbevolen model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start Benchmark';

  @override
  String get benchmark_screen_start_failed => 'Benchmark starten mislukt, de foutcode is';

  @override
  String get benchmark_screen_models => 'Objectdetectiemodellen';

  @override
  String get project_screen_title => 'Project';

  @override
  String get project_screen_exit_confirm_title => 'Bevestig afsluiten van het project';

  @override
  String get project_screen_exit_confirm_content => 'Als u het project verlaat, stopt het tellen. Weet u zeker dat u wilt doorgaan?';

  @override
  String get project_screen_exit_button => 'Afsluiten';

  @override
  String get project_screen_add_video_button => 'Videobron toevoegen';

  @override
  String get project_screen_from_desc => 'We houden een voortdurende registratie van 24 uur bij, zodat u elk gewenst tijdsbestek kunt bekijken.';

  @override
  String get project_screen_report_settings => 'Instellingen';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Selecteer een filterbereik uit de onderstaande lijst';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Eindtijd moet later zijn dan starttijd';

  @override
  String get filter_screen_error_custom => 'Aangepast';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Einde';

  @override
  String get settings_screen_title => 'Instellingen';

  @override
  String get settings_screen_desc => 'Stel projectnaam, detectieparameters en het wissen van tellingen in.';

  @override
  String get settings_screen_project_id => 'Project-ID';

  @override
  String get settings_screen_project_name => 'Projectnaam';

  @override
  String get settings_screen_project_name_place_holder => '123 Hoofdstraat of Vondelpark';

  @override
  String get settings_screen_project_error => 'De projectnaam mag niet leeg zijn';

  @override
  String get settings_screen_random_count_button => 'Willekeurige tellingen toevoegen';

  @override
  String get settings_screen_reset_count_header => 'Alle tellingen in dit project resetten';

  @override
  String get settings_screen_reset_count_button => 'Tellingen resetten';

  @override
  String get settings_screen_reset_count_content => 'Weet u zeker dat u alle tellingen wilt resetten?';

  @override
  String get settings_screen_delete_header => 'Dit project verwijderen';

  @override
  String get settings_screen_delete_content => 'Weet u zeker dat u dit project wilt verwijderen?';

  @override
  String get settings_screen_delete_button => 'Verwijderen';

  @override
  String get settings_screen_center_point_title => 'Middelpunt op doel';

  @override
  String get settings_screen_center_point_desc => 'Het middelpunt helpt bepalen of het doel zich binnen de trefzone bevindt.';

  @override
  String get settings_screen_center_point_button => 'Middelpunt op doel tonen';

  @override
  String get settings_screen_lost_target_title => 'Verloren doel';

  @override
  String get settings_screen_lost_target_desc => 'Wanneer objecttracking een doel verliest, maakt deze optie het zichtbaar. Standaard worden verloren doelen niet getoond.';

  @override
  String get settings_screen_lost_target_button => 'Verloren doel tonen';

  @override
  String get detection_screen_title => 'Detectie-instellingen';

  @override
  String get detection_screen_models => 'Modellen';

  @override
  String get detection_screen_confidence => 'Betrouwbaarheid';

  @override
  String get detection_screen_confidence_desc => 'betrouwbaarheid boven #0 wordt beschouwd als een geldige detectie';

  @override
  String get detection_screen_low => 'Laag';

  @override
  String get detection_screen_high => 'Hoog';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Een lagere NMS-drempel (bijv. 0.3-0.4) verwijdert overlappende boxen strenger en vermindert vals-positieven maar kan overlappende personen missen. Een hogere drempel (0.7-0.9) behoudt meer boxen wat vals-positieven kan verhogen maar overlappende personen beter detecteert.';

  @override
  String get detection_screen_match => 'Overeenkomst';

  @override
  String get detection_screen_match_desc => '#0 matchThreshold is een belangrijke parameter bij objecttracking die de mate van overeenkomst tussen verschillende detectieboxen meet. Een lagere waarde maakt objectassociatie eenvoudiger maar verhoogt het risico op verkeerde associaties. Een hogere waarde is strenger bij objectassociaties maar kan sommige echte matches missen.';

  @override
  String get detection_screen_lost => 'Verloren';

  @override
  String get detection_screen_lost_desc => 'Bepaalt dynamisch de verwijderingstijd voor verloren objecten tussen #0 en #1 op basis van bewegingssnelheid';

  @override
  String get detection_screen_consider_valid => 'Als geldig beschouwen na';

  @override
  String get detection_screen_consider_valid_desc => 'Gevolgd object wordt als geldig beschouwd na #0';

  @override
  String get detection_screen_reset => 'Resetten';

  @override
  String get detection_screen_reset_content => 'Weet u zeker dat u de detectie-instellingen wilt resetten?';

  @override
  String get url_screen_title => 'Livestream URL';

  @override
  String get url_screen_desc => 'Voer de livestream URL in';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://voorbeeld.com/stream of rtsp://voorbeeld.com/stream';

  @override
  String get add_video_screen_title => 'Videobron toevoegen';

  @override
  String get add_video_screen_from => 'Videobron toevoegen van';

  @override
  String get webcam_screen_add_title => 'Webcam toevoegen';

  @override
  String get webcam_screen_edit_title => 'Webcam kiezen';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Camera voorzijde';

  @override
  String get camera_screen_back_camera => 'Camera achterzijde';

  @override
  String get camera_screen_add_title => 'Camera toevoegen';

  @override
  String get camera_screen_edit_title => 'Camera kiezen';

  @override
  String get camera_screen_zoom_level => 'Zoomniveau';

  @override
  String get video_screen_name_empty => 'De videonaam mag niet leeg zijn.';

  @override
  String get video_screen_desc => 'Beheer videobronnen, voeg detectiezones toe of wijzig ze.';

  @override
  String get video_screen_video_name => 'Naam videobron';

  @override
  String get video_screen_edit_placeholder => 'Voordeurcamera of Parkeerplaatscamera';

  @override
  String get video_screen_change_file => 'Bestand wijzigen';

  @override
  String get video_screen_add_zone => 'Detectiezone toevoegen';

  @override
  String get video_screen_zones => 'Detectiezones';

  @override
  String get video_screen_zones_desc => 'Gebruik slepen en neerzetten om zones aan te passen';

  @override
  String get video_screen_tools => 'Hulpmiddelen';

  @override
  String get video_screen_move_bottom => 'Huidige zone naar beneden verplaatsen';

  @override
  String get video_screen_add_point => 'Punt toevoegen aan huidige zone';

  @override
  String get video_screen_remove_point => 'Punt verwijderen uit huidige zone';

  @override
  String get video_screen_playback_speed => 'Afspeelsnelheid';

  @override
  String get video_screen_playback_current => 'huidig: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Deze videobron verwijderen';

  @override
  String get video_screen_delete_content => 'Weet u zeker dat u deze videobron wilt verwijderen?';

  @override
  String get video_screen_delete_button => 'Verwijderen';

  @override
  String get video_screen_sources => 'Configureer beeldbron, detectiedoelen en modelparameters.';

  @override
  String get video_screen_targets => 'Detectiedoelen';

  @override
  String get video_screen_detection => 'Modelparameters';

  @override
  String get color_screen_title => 'Kies een kleur';

  @override
  String get zone_screen_desc => 'De detectiezone kan de soorten objecten instellen die moeten worden gedetecteerd en kiezen welke tellers worden weergegeven, zoals Gedetecteerd, Verschenen en Binnengekomen.';

  @override
  String get zone_screen_name_placeholder => 'De naam van de zone, zoals Stoep of Parkeerplaats';

  @override
  String get zone_screen_zone_color => 'Zonekleur';

  @override
  String get zone_screen_color => 'Kleur';

  @override
  String get zone_screen_delete_header => 'Deze zone verwijderen';

  @override
  String get zone_screen_delete_content => 'Weet u zeker dat u deze zone wilt verwijderen?';

  @override
  String get zone_screen_delete_button => 'Verwijderen';

  @override
  String get zone_screen_can_not_delete => 'Kan zone niet verwijderen';

  @override
  String get zone_screen_one_zone_required => 'Ten minste één zone is vereist.';

  @override
  String get zone_screen_zone_name_required => 'De zonenaam mag niet leeg zijn';

  @override
  String get counter_screen_show_on => 'Toon op scherm';

  @override
  String get counter_screen_enabled => 'Ingeschakeld';

  @override
  String get counter_screen_reentry_threshold => 'Drempel voor herintreding';

  @override
  String get counter_screen_reentry_desc => 'Objecten moeten #0 keer binnenkomen, met een afkoeltijd van #1 seconden tussen elke uitgang en herintreding, om herintreding te activeren';

  @override
  String get counter_screen_reentry_title => 'Telling herintreding';

  @override
  String get counter_screen_cooldown_threshold => 'Afkoeldrempel';

  @override
  String get counter_screen_cooldown_desc => 'Herintreding vereist een afkoeltijd van #0 seconden na het verlaten van de detectiezone';

  @override
  String get counter_screen_cooldown_time => 'Afkoeltijd';

  @override
  String get counter_screen_cooldown_in_seconds => 'in seconden';

  @override
  String get counter_screen_stagnant_threshold => 'Drempel voor stilstand';

  @override
  String get counter_screen_stagnant_desc => 'Objecten die meer dan #0 seconden stilstaan, worden als stilstaand beschouwd';

  @override
  String get counter_screen_stagnant_consider => 'Als stilstaand beschouwen';

  @override
  String get counter_screen_stagnant_in_seconds => 'in seconden';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beschrijving voorvoegsel';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beschrijving achtervoegsel';

  @override
  String get counter_screen_name_error => 'De tellernaam mag niet leeg zijn';

  @override
  String get counter_screen_enabled_error => 'Fout';

  @override
  String get counter_screen_enabled_error_content => 'U moet eerst een andere teller inschakelen, daarna kunt u deze teller uitschakelen';

  @override
  String get objects_screen_title => 'Objecten';

  @override
  String get objects_screen_desc => 'Kies detectiedoelen zoals persoon, auto, bus, enz.';

  @override
  String get open_project_screen_title => 'Project openen';

  @override
  String get open_project_screen_desc => 'Open eerder gemaakte projecten, waarbij alleen de 20 meest recente worden bewaard.';

  @override
  String get open_project_screen_no_project => 'Geen project gevonden.';

  @override
  String get default_project_name => 'Project';

  @override
  String get default_video_name => 'Videobron';

  @override
  String get default_zone_name => 'Detectiezone';

  @override
  String get error_oops => 'Oeps, er is iets misgegaan';

  @override
  String get error_content => 'Er is een onverwachte fout opgetreden. Wilt u een e-mailrapport indienen?';

  @override
  String get error_report => 'E-mail ons';

  @override
  String get submit => 'Verzenden';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuleren';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nee';

  @override
  String get close => 'Sluiten';

  @override
  String get back => 'Terug';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Toon samenvatting op scherm';

  @override
  String get video_sources_photos_denied => 'Toegang tot foto\'s geweigerd';

  @override
  String get video_sources_photos_goto_settings => 'Naar instellingen';

  @override
  String get video_sources_camera_denied => 'Toegang tot camera geweigerd';

  @override
  String get video_sources_photos_denied_msg => 'Ga naar instellingen en geef toestemming voor fototoegang voor deze app.';

  @override
  String get video_sources_camera_denied_msg => 'Ga naar instellingen en geef toestemming voor cameratoegang voor deze app.';
}

/// The translations for Dutch Flemish, as used in Belgium (`nl_BE`).
class LocalizationNlBe extends LocalizationNl {
  LocalizationNlBe(): super('nl_BE');

  @override
  String get product_name => 'Teller';

  @override
  String get product_desc => 'Gebruik computervision en AI om mensen, voertuigen, huisdieren en meer te tellen.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Livestream URL';

  @override
  String get video_sources_file => 'Bestand';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_camera_not_found_title => 'Camera niet gevonden';

  @override
  String get video_sources_camera_not_found_message => 'Cameratoestemming nodig om de camera te gebruiken';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam niet gevonden';

  @override
  String get video_sources_webcam_not_found_message => 'Controleer app-toestemming en webcamverbinding';

  @override
  String get wizard_screen_desc => 'Maak hieronder een nieuw project aan om te beginnen met tellen.';

  @override
  String get wizard_screen_new_project_from => 'Nieuw project van';

  @override
  String get wizard_screen_language => 'Taal';

  @override
  String get wizard_screen_about => 'Over';

  @override
  String get wizard_screen_open_projects_tip => 'Alle projecten worden automatisch lokaal opgeslagen';

  @override
  String get wizard_screen_open_projects => 'Bestaand project openen';

  @override
  String get wizard_screen_email_us => 'E-mail ons';

  @override
  String get language_screen_language => 'Taal';

  @override
  String get project_view_no_videos => 'Geen videobron beschikbaar.';

  @override
  String get about_screen_title => 'Over';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'App-versie';

  @override
  String get about_screen_models => 'Objectdetectiemodellen';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build Info';

  @override
  String get benchmark_screen_title => 'Modelbenchmarks';

  @override
  String get benchmark_screen_recommended => 'Aanbevolen model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start benchmark';

  @override
  String get benchmark_screen_start_failed => 'Benchmark starten mislukt, de foutcode is';

  @override
  String get benchmark_screen_models => 'Objectdetectiemodellen';

  @override
  String get project_screen_title => 'Project';

  @override
  String get project_screen_exit_confirm_title => 'Bevestig het verlaten van het project';

  @override
  String get project_screen_exit_confirm_content => 'Bij het verlaten van het project stopt het tellen. Wilt u zeker doorgaan?';

  @override
  String get project_screen_exit_button => 'Afsluiten';

  @override
  String get project_screen_add_video_button => 'Videobron toevoegen';

  @override
  String get project_screen_from_desc => 'We bewaren een voortschrijdende periode van 24 uur, zodat u elk tijdsegment kunt bekijken dat u nodig hebt.';

  @override
  String get project_screen_report_settings => 'Instellingen';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Selecteer een filterbereik uit onderstaande lijst';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Eindtijd moet later zijn dan starttijd';

  @override
  String get filter_screen_error_custom => 'Aangepast';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Einde';

  @override
  String get settings_screen_title => 'Instellingen';

  @override
  String get settings_screen_desc => 'Stel projectnaam, detectieparameters en tellen wissen in.';

  @override
  String get settings_screen_project_id => 'Project-ID';

  @override
  String get settings_screen_project_name => 'Projectnaam';

  @override
  String get settings_screen_project_name_place_holder => 'Kerkstraat 123 of Grote Markt';

  @override
  String get settings_screen_project_error => 'De projectnaam mag niet leeg zijn';

  @override
  String get settings_screen_random_count_button => 'Willekeurige tellingen toevoegen';

  @override
  String get settings_screen_reset_count_header => 'Alle tellingen in dit project resetten';

  @override
  String get settings_screen_reset_count_button => 'Tellingen resetten';

  @override
  String get settings_screen_reset_count_content => 'Bent u zeker dat u alle tellingen wilt resetten?';

  @override
  String get settings_screen_delete_header => 'Dit project verwijderen';

  @override
  String get settings_screen_delete_content => 'Bent u zeker dat u dit project wilt verwijderen?';

  @override
  String get settings_screen_delete_button => 'Verwijderen';

  @override
  String get settings_screen_center_point_title => 'Middelpunt op doel';

  @override
  String get settings_screen_center_point_desc => 'Het middelpunt helpt te bepalen of het doel zich binnen de trefzone bevindt.';

  @override
  String get settings_screen_center_point_button => 'Middelpunt op doel tonen';

  @override
  String get settings_screen_lost_target_title => 'Verloren doel';

  @override
  String get settings_screen_lost_target_desc => 'Wanneer objecttracking een doel verliest, maakt deze optie het zichtbaar. Standaard worden verloren doelen niet getoond.';

  @override
  String get settings_screen_lost_target_button => 'Verloren doel tonen';

  @override
  String get detection_screen_title => 'Detectie-instellingen';

  @override
  String get detection_screen_models => 'Modellen';

  @override
  String get detection_screen_confidence => 'Betrouwbaarheid';

  @override
  String get detection_screen_confidence_desc => 'betrouwbaarheid boven #0 wordt beschouwd als een geldige detectie';

  @override
  String get detection_screen_low => 'Laag';

  @override
  String get detection_screen_high => 'Hoog';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppressie';

  @override
  String get detection_screen_nms_desc => '#0 Een lagere NMS-drempel (bijv. 0.3-0.4) verwijdert overlappende kaders strenger en vermindert vals-positieven maar kan overlappende personen missen. Een hogere drempel (0.7-0.9) behoudt meer kaders wat vals-positieven kan verhogen maar overlappende personen beter detecteert.';

  @override
  String get detection_screen_match => 'Overeenkomst';

  @override
  String get detection_screen_match_desc => '#0 matchThreshold is een belangrijke parameter bij objecttracking die de mate van overeenkomst tussen verschillende detectiekaders meet. Een lagere waarde maakt objectkoppeling eenvoudiger maar verhoogt het risico op foute koppelingen. Een hogere waarde is strenger bij objectkoppelingen maar kan echte overeenkomsten missen.';

  @override
  String get detection_screen_lost => 'Verloren';

  @override
  String get detection_screen_lost_desc => 'Bepaalt dynamisch de verwijderingstijd voor verloren objecten tussen #0 en #1 op basis van bewegingssnelheid';

  @override
  String get detection_screen_consider_valid => 'Als geldig beschouwen na';

  @override
  String get detection_screen_consider_valid_desc => 'Object wordt als geldig beschouwd na #0';

  @override
  String get detection_screen_reset => 'Resetten';

  @override
  String get detection_screen_reset_content => 'Bent u zeker dat u de detectie-instellingen wilt resetten?';

  @override
  String get url_screen_title => 'Livestream URL';

  @override
  String get url_screen_desc => 'Voer de livestream URL in';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://voorbeeld.com/stream of rtsp://voorbeeld.com/stream';

  @override
  String get add_video_screen_title => 'Videobron toevoegen';

  @override
  String get add_video_screen_from => 'Videobron toevoegen van';

  @override
  String get webcam_screen_add_title => 'Webcam toevoegen';

  @override
  String get webcam_screen_edit_title => 'Webcam kiezen';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Frontcamera';

  @override
  String get camera_screen_back_camera => 'Achtercamera';

  @override
  String get camera_screen_add_title => 'Camera toevoegen';

  @override
  String get camera_screen_edit_title => 'Camera kiezen';

  @override
  String get camera_screen_zoom_level => 'Zoomniveau';

  @override
  String get video_screen_name_empty => 'De videonaam mag niet leeg zijn.';

  @override
  String get video_screen_desc => 'Beheer videobronnen, voeg detectiezones toe of wijzig ze.';

  @override
  String get video_screen_video_name => 'Naam videobron';

  @override
  String get video_screen_edit_placeholder => 'Voordeurcamera of Parkeercamera';

  @override
  String get video_screen_change_file => 'Bestand wijzigen';

  @override
  String get video_screen_add_zone => 'Detectiezone toevoegen';

  @override
  String get video_screen_zones => 'Detectiezones';

  @override
  String get video_screen_zones_desc => 'Gebruik slepen en neerzetten om zones aan te passen';

  @override
  String get video_screen_tools => 'Gereedschap';

  @override
  String get video_screen_move_bottom => 'Huidige zone naar onder verplaatsen';

  @override
  String get video_screen_add_point => 'Punt toevoegen aan huidige zone';

  @override
  String get video_screen_remove_point => 'Punt verwijderen uit huidige zone';

  @override
  String get video_screen_playback_speed => 'Afspeelsnelheid';

  @override
  String get video_screen_playback_current => 'huidig: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Deze videobron verwijderen';

  @override
  String get video_screen_delete_content => 'Bent u zeker dat u deze videobron wilt verwijderen?';

  @override
  String get video_screen_delete_button => 'Verwijderen';

  @override
  String get video_screen_sources => 'Configureer beeldbron, detectiedoelen en modelparameters.';

  @override
  String get video_screen_targets => 'Detectiedoelen';

  @override
  String get video_screen_detection => 'Modelparameters';

  @override
  String get color_screen_title => 'Kies een kleur';

  @override
  String get zone_screen_desc => 'De detectiezone kan instellen welke objecttypes gedetecteerd moeten worden en welke tellers getoond moeten worden, zoals Gedetecteerd, Verschenen en Binnengekomen.';

  @override
  String get zone_screen_name_placeholder => 'Naam van de zone, zoals Voetpad of Parking';

  @override
  String get zone_screen_zone_color => 'Zonekleur';

  @override
  String get zone_screen_color => 'Kleur';

  @override
  String get zone_screen_delete_header => 'Deze zone verwijderen';

  @override
  String get zone_screen_delete_content => 'Bent u zeker dat u deze zone wilt verwijderen?';

  @override
  String get zone_screen_delete_button => 'Verwijderen';

  @override
  String get zone_screen_can_not_delete => 'Kan zone niet verwijderen';

  @override
  String get zone_screen_one_zone_required => 'Minstens één zone is vereist.';

  @override
  String get zone_screen_zone_name_required => 'De zonenaam mag niet leeg zijn';

  @override
  String get counter_screen_show_on => 'Toon op scherm';

  @override
  String get counter_screen_enabled => 'Ingeschakeld';

  @override
  String get counter_screen_reentry_threshold => 'Drempel voor herintreding';

  @override
  String get counter_screen_reentry_desc => 'Objecten moeten #0 keer binnenkomen, met een afkoeltijd van #1 seconden tussen elke uitgang en herintreding, om herintreding te activeren';

  @override
  String get counter_screen_reentry_title => 'Telling herintreding';

  @override
  String get counter_screen_cooldown_threshold => 'Afkoeldrempel';

  @override
  String get counter_screen_cooldown_desc => 'Herintreding vereist een afkoeltijd van #0 seconden na het verlaten van de detectiezone';

  @override
  String get counter_screen_cooldown_time => 'Afkoeltijd';

  @override
  String get counter_screen_cooldown_in_seconds => 'in seconden';

  @override
  String get counter_screen_stagnant_threshold => 'Stilstanddrempel';

  @override
  String get counter_screen_stagnant_desc => 'Objecten die langer dan #0 seconden stilstaan worden als stilstaand beschouwd';

  @override
  String get counter_screen_stagnant_consider => 'Als stilstaand beschouwen';

  @override
  String get counter_screen_stagnant_in_seconds => 'in seconden';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beschrijvingsvoorvoegsel';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beschrijvingsachtervoegsel';

  @override
  String get counter_screen_name_error => 'De tellernaam mag niet leeg zijn';

  @override
  String get counter_screen_enabled_error => 'Fout';

  @override
  String get counter_screen_enabled_error_content => 'U moet eerst een andere teller inschakelen, dan kunt u deze teller uitschakelen';

  @override
  String get objects_screen_title => 'Objecten';

  @override
  String get objects_screen_desc => 'Kies detectiedoelen zoals personen, auto\'s, bussen, enz.';

  @override
  String get open_project_screen_title => 'Project openen';

  @override
  String get open_project_screen_desc => 'Open eerder gemaakte projecten, waarbij alleen de 20 meest recente bewaard blijven.';

  @override
  String get open_project_screen_no_project => 'Geen project gevonden.';

  @override
  String get default_project_name => 'Project';

  @override
  String get default_video_name => 'Videobron';

  @override
  String get default_zone_name => 'Detectiezone';

  @override
  String get error_oops => 'Oeps, er is iets misgegaan';

  @override
  String get error_content => 'Er is een onverwachte fout opgetreden. Wilt u een e-mailrapport indienen?';

  @override
  String get error_report => 'E-mail ons';

  @override
  String get submit => 'Verzenden';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuleren';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nee';

  @override
  String get close => 'Sluiten';

  @override
  String get back => 'Terug';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Toon samenvatting op scherm';

  @override
  String get video_sources_photos_denied => 'Toegang tot foto\'s geweigerd';

  @override
  String get video_sources_photos_goto_settings => 'Naar instellingen';

  @override
  String get video_sources_camera_denied => 'Toegang tot camera geweigerd';

  @override
  String get video_sources_photos_denied_msg => 'Ga naar instellingen en geef toestemming voor fototoegang voor deze app.';

  @override
  String get video_sources_camera_denied_msg => 'Ga naar instellingen en geef toestemming voor cameratoegang voor deze app.';
}
