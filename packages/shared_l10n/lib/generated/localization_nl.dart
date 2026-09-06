// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class LocalizationNl extends Localization {
  LocalizationNl([String locale = 'nl']) : super(locale);

  @override
  String get about_screen_app_version => 'App-versie';

  @override
  String get about_screen_email_us => 'E-mail ons';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get appeared => 'Verschenen';

  @override
  String get appeared_help =>
      'Telt mensen of voertuigen waarvan de eerste gedetecteerde positie zich binnen dit gebied bevond.\\n\\nHandig om te begrijpen waar de tracking begint.\\n\\n(Voornamelijk bedoeld voor gevorderde gebruikers)';

  @override
  String get average_occupancy => 'Gemiddelde bezetting';

  @override
  String get average_occupancy_help =>
      'Toont het gemiddelde aantal mensen of voertuigen in dit gebied tijdens het huidige telvenster.\\n\\nHiermee zie je hoe druk het gebied was gedurende het hele telvenster.';

  @override
  String get average_stay => 'Gemiddelde verblijftijd';

  @override
  String get average_stay_help =>
      'Toont de gemiddelde tijd dat mensen of voertuigen in dit gebied verbleven.\\n\\nEen langere gemiddelde verblijftijd kan erop wijzen dat klanten meer tijd in dit gebied doorbrengen.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter gebruikt uw camera en AI op het apparaat om mensen te tellen. Laten we eerst controleren of uw apparaat compatibel is.';

  @override
  String get camera_test_screen_instruction =>
      'Richt de camera op mensen. De app tekent vakken rond gedetecteerde personen.';

  @override
  String get camera_test_screen_next => 'Tik op Volgende om door te gaan.';

  @override
  String get camera_test_screen_start =>
      'Tik op Start. Geef indien gevraagd toegang tot de camera.';

  @override
  String get camera_test_screen_test_failed => 'Test mislukt!';

  @override
  String get camera_test_screen_test_passed => 'Test geslaagd!';

  @override
  String get camera_test_screen_title => 'AI-cameratest';

  @override
  String get camera_test_screen_wait => 'Wachten tot AI mensen detecteert…';

  @override
  String get cta_screen_custom => 'Eigen server gebruiken';

  @override
  String get cta_screen_custom_help =>
      'Verstuur verkeersgegevens rechtstreeks naar uw eigen backend of database.';

  @override
  String get cta_screen_footer =>
      'Door door te gaan, ga je akkoord met de Servicevoorwaarden, het Privacybeleid en de Verwerkersovereenkomst.';

  @override
  String get cta_screen_invitation => 'Gebruik een uitnodigingscode';

  @override
  String get cta_screen_invitation_help =>
      'Word lid van een bestaande organisatie met een uitnodiging van uw beheerder.';

  @override
  String get cta_screen_local => 'Alleen op dit apparaat';

  @override
  String get cta_screen_local_help =>
      'Sla verkeersgegevens alleen op dit apparaat op. Er wordt niets geüpload.';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud gebruiken';

  @override
  String get cta_screen_piyuo_help =>
      'Sla verkeersgegevens op in Piyuo Cloud met dashboards en bedrijfsinzichten.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter maakt elke 5 minuten anonieme verkeersstatistieken.\\nKies hoe u uw gegevens wilt opslaan en openen.';

  @override
  String get current_occupancy => 'Huidig aantal';

  @override
  String get current_occupancy_help =>
      'Toont het huidige aantal mensen of voertuigen in dit gebied.\\n\\nDit aantal wordt in realtime bijgewerkt en helpt te controleren of de AI-detectie overeenkomt met wat je op het scherm ziet. Het wordt niet opgenomen in de geüploade telemetriegegevens.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Opslaan...';

  @override
  String get custom_server_screen_server_url_label => 'Server-URL';

  @override
  String get detection_screen_confidence => 'Vertrouwensdrempel';

  @override
  String get detection_screen_confidence_dialog =>
      'Bepaalt hoe zeker de AI moet zijn voordat een persoon of voertuig wordt geteld.\\nLagere waarden\\n• Detecteren meer objecten\\n• Beter voor verre of gedeeltelijk verborgen objecten\\n• Kunnen meer foutieve detecties veroorzaken\\nHogere waarden\\n• Tellen alleen detecties met hoge zekerheid\\n• Verminderen foutieve detecties\\n• Kunnen kleine of moeilijke objecten missen\\nGebruik een lagere waarde als de app mensen of voertuigen mist.\\nGebruik een hogere waarde als de app schaduwen, reflecties of andere foutieve objecten telt.';

  @override
  String get detection_screen_confidence_help =>
      'Minimale betrouwbaarheid die nodig is om een object te detecteren.';

  @override
  String get detection_screen_confidence_max_label => 'Strikt';

  @override
  String get detection_screen_confidence_min_label => 'Los';

  @override
  String get detection_screen_disappear => 'Time-out voor verdwijnen';

  @override
  String get detection_screen_disappear_dialog =>
      'Bepaalt hoe lang de AI wacht voordat een object als verdwenen wordt gemarkeerd nadat het niet meer wordt gedetecteerd.\\nKortere waarden\\n• Markeren objecten sneller als verdwenen\\n• Beter voor snel verkeer\\n• Kunnen tijdelijk verborgen objecten ten onrechte als verdwenen markeren\\nLangere waarden\\n• Wachten langer voordat objecten als verdwenen worden gemarkeerd\\n• Beter wanneer objecten kort geblokkeerd of gemist worden\\n• Vertragen verdwijn-gebeurtenissen';

  @override
  String get detection_screen_disappear_help =>
      'Hoe lang de AI wacht voordat een object als verdwenen wordt gemarkeerd nadat het niet meer wordt gedetecteerd.';

  @override
  String get detection_screen_disappear_max_label => 'Langzaam';

  @override
  String get detection_screen_disappear_min_label => 'Snel';

  @override
  String get detection_screen_memory_dialog =>
      'Bepaalt hoe lang de AI een object onthoudt nadat het verdwijnt.\\nVerhoog deze waarde als mensen of voertuigen vaak achter andere objecten verborgen zijn.\\nVerlaag deze waarde als objecten onterecht worden gekoppeld nadat ze de scène hebben verlaten.';

  @override
  String get detection_screen_min_presence => 'Minimale aanwezigheidstijd';

  @override
  String get detection_screen_min_presence_help =>
      'Een object moet zichtbaar blijven voordat het wordt geteld. Hogere waarden helpen korte foutdetecties te verminderen.';

  @override
  String get detection_screen_min_presence_max_label => 'Veiliger';

  @override
  String get detection_screen_min_presence_min_label => 'Sneller';

  @override
  String get detection_screen_minimum_visible =>
      'Objecten moeten zo lang zichtbaar blijven voordat ze worden geteld.\\nVerhoog deze waarde om korte foutieve detecties te negeren.\\nVerlaag deze waarde als snel bewegende mensen of voertuigen worden gemist.';

  @override
  String get detection_screen_new_track => 'Drempel voor nieuwe tracking';

  @override
  String get detection_screen_new_track_help =>
      'Minimale betrouwbaarheid om een nieuw object te gaan volgen. Lagere waarden kunnen dubbele tracks maken.';

  @override
  String get detection_screen_new_track_max_label => 'Conservatief';

  @override
  String get detection_screen_new_track_min_label => 'Agressief';

  @override
  String get detection_screen_reset => 'Resetten';

  @override
  String get detection_screen_reset_content =>
      'Weet u zeker dat u de detectie-instellingen wilt resetten?';

  @override
  String get detection_screen_show_track_id => 'Track-ID weergeven';

  @override
  String get detection_screen_show_track_id_help =>
      'Schakel deze optie in om unieke track-ID\'s weer te geven voor elk gevolgd object.';

  @override
  String get detection_screen_stay => 'Verblijftijd';

  @override
  String get detection_screen_stay_help =>
      'Hoe lang een object in het gebied moet blijven voordat het als verblijf wordt geteld.';

  @override
  String get detection_screen_stay_max_label => 'Vertraagd';

  @override
  String get detection_screen_stay_min_label => 'Direct';

  @override
  String get detection_screen_stay_threshold =>
      'Bepaalt wanneer een object bijdraagt aan de Verblijf-telling.\\nKortere waarden\\n• Tellen verblijf onmiddellijk\\n• Beter voor snelle analyse\\nLangere waarden\\n• Negeren kort doorgaand verkeer\\n• Beter voor bezettingsmeting';

  @override
  String get detection_screen_subtitle =>
      'Pas aan hoe AI objecten detecteert en volgt.';

  @override
  String get detection_screen_title => 'Volgen en tellen';

  @override
  String get detection_screen_track_dialog =>
      'Bepaalt wanneer een nieuw gedetecteerd object een nieuw spoor wordt.\\nLagere waarden\\n• Tracking begint eerder\\n• Beter voor snelbewegende objecten\\n• Kunnen dubbele sporen veroorzaken\\nHogere waarden\\n• Vereisen sterker bewijs voordat een nieuw spoor wordt aangemaakt\\n• Verminderen dubbele sporen\\n• Kunnen het volgen van nieuwe objecten vertragen';

  @override
  String get detection_screen_track_memory => 'Trackinggeheugen';

  @override
  String get detection_screen_track_memory_help =>
      'Hoe lang een object gevolgd blijft nadat het tijdelijk uit beeld is verdwenen. Hogere waarden helpen na korte afdekkingen.';

  @override
  String get detection_screen_track_memory_max_label => 'Lang';

  @override
  String get detection_screen_track_memory_min_label => 'Kort';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter gebruikt de camera om voetgangers en voertuigen in realtime te detecteren. Op dit apparaat is geen camera beschikbaar.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Probeer deze app op je telefoon te openen';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Een smartphone of tablet met camera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'iOS- of Android-apparaat aanbevolen';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Wat je nodig hebt';

  @override
  String get device_not_supported_screen_title => 'Camera niet gevonden';

  @override
  String get disappeared => 'Verdwenen';

  @override
  String get disappeared_help =>
      'Telt mensen of voertuigen waarvan de laatste gedetecteerde positie zich binnen dit gebied bevond.\\n\\nDe tracking eindigt na de ingestelde verdwijntijd als de persoon of het voertuig niet meer wordt gedetecteerd.\\n\\n(Voornamelijk bedoeld voor gevorderde gebruikers)';

  @override
  String get dpa => 'Verwerkersovereenkomst';

  @override
  String get durationDaysShort => '%sd';

  @override
  String get durationHoursShort => '%su';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ssec';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Binnengekomen';

  @override
  String get entered_help =>
      'Telt mensen of voertuigen die tijdens het huidige telvenster dit gebied zijn binnengekomen.\\n\\nEen binnenkomst wordt geteld wanneer een persoon of voertuig van buiten het gebied naar binnen beweegt.';

  @override
  String get exited => 'Verlaten';

  @override
  String get exited_help =>
      'Telt mensen of voertuigen die tijdens het huidige telvenster dit gebied hebben verlaten.\\n\\nEen vertrek wordt geteld wanneer een persoon of voertuig van binnen het gebied naar buiten beweegt.';

  @override
  String get language_screen_language => 'Taal';

  @override
  String get language_screen_subtitle =>
      'Kies de taal die in de app wordt gebruikt.';

  @override
  String get local_only_screen_body =>
      'Met de modus Alleen lokaal apparaat kun je AI-cameradetectie en -tracking uitproberen zonder gegevens te uploaden. Alle bezoekersstatistieken worden alleen op dit apparaat verwerkt, ideaal om te testen voordat je verbinding maakt met een server.';

  @override
  String get local_only_screen_use_action => 'Alleen lokaal apparaat gebruiken';

  @override
  String get local_screen_text =>
      'Piyuo Counter werkt volledig op dit apparaat.\\nVerkeersstatistieken worden alleen op dit apparaat opgeslagen en niet geüpload.\\nU kunt later via Instellingen verbinding maken met Piyuo Cloud of uw eigen server.';

  @override
  String get maximum_occupancy => 'Maximale bezetting';

  @override
  String get maximum_occupancy_help =>
      'Toont het hoogste aantal mensen of voertuigen dat zich tegelijkertijd in dit gebied bevond tijdens het huidige telvenster.\\n\\nHandig om piekmomenten van drukte of verkeer te bepalen.';

  @override
  String get maximum_stay => 'Maximale verblijftijd';

  @override
  String get maximum_stay_help =>
      'Toont de langste tijd dat een persoon of voertuig tijdens het huidige telvenster in dit gebied verbleef.\\n\\nHandig om ongewoon lange bezoeken of stops te herkennen.';

  @override
  String get metric_events => 'Gebeurtenissen';

  @override
  String get metric_live => 'Live';

  @override
  String get metric_show_less => 'Minder tonen';

  @override
  String get metric_show_more => 'Meer tonen';

  @override
  String get metric_statistics => 'Statistieken';

  @override
  String get metrics_counting_all => 'Alles';

  @override
  String get metrics_counting_done => 'Voltooid';

  @override
  String get metrics_counting_in_progress => 'Bezig';

  @override
  String get metrics_counting_missing => 'Ontbrekend';

  @override
  String get metrics_counting_window =>
      'Statistieken voor elke periode van 5 minuten';

  @override
  String get onboarding_back_action => 'Terug';

  @override
  String get onboarding_cta_no_server => 'Wilt u geen gegevens uploaden?';

  @override
  String get onboarding_cta_title => 'Waar moeten uw gegevens naartoe?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter gebruikt de camera van je toestel en ingebouwde AI om mensen en voertuigen direct te herkennen.\\nMet detectie- en trackingtechnologie telt de app automatisch het aantal voetgangers en voertuigen — alles wordt verwerkt op je eigen toestel.';

  @override
  String get onboarding_intro_text2 =>
      'Alle AI-verwerking gebeurt lokaal op je toestel. Er worden geen video\'s, afbeeldingen, gezichten of identiteiten geüpload.\\nAlleen anonieme samenvattingen van 5 minuten worden gedeeld, met statistieken over aantallen, bezetting, in- en uitgangen en verblijfsduur.';

  @override
  String get onboarding_intro_text3 =>
      'Start gewoon de app en laat hem draaien. Piyuo Counter verzamelt en bewaart automatisch en continu verkeersgegevens.\\nGegevenssamenvattingen worden elke 5 minuten opgeslagen en elk uur geüpload naar Piyuo Cloud of je eigen server.';

  @override
  String get onboarding_intro_title1 => 'AI-verkeerstelling';

  @override
  String get onboarding_intro_title2 => 'Privacy vanaf het begin';

  @override
  String get onboarding_intro_title3 => 'Draait automatisch 24/7';

  @override
  String get onboarding_next_action => 'Volgende';

  @override
  String get onboarding_skip_action => 'Intro overslaan';

  @override
  String get onboarding_start_action => 'Start';

  @override
  String get passed_by => 'Voorbijgegaan';

  @override
  String get passed_by_help =>
      'Telt het aantal mensen of voertuigen dat tijdens het huidige telvenster door dit gebied is gegaan.\\n\\nIedere persoon of ieder voertuig wordt per passage slechts één keer geteld.';

  @override
  String get payloads_screen_area => 'Gebied';

  @override
  String get payloads_screen_confidence => 'Dekking';

  @override
  String get payloads_screen_coverage => 'Dekking';

  @override
  String get payloads_screen_delivered => 'Geleverd';

  @override
  String get payloads_screen_failed_load =>
      'Recente payloads konden niet worden geladen';

  @override
  String get payloads_screen_frame_processed => 'Verwerkte frames';

  @override
  String get payloads_screen_hour_not_exists => 'Dit uur bestaat niet meer.';

  @override
  String get payloads_screen_missing_time => 'Ontbrekende tijd';

  @override
  String get payloads_screen_no_payloads => 'Nog geen payloads.';

  @override
  String get payloads_screen_partial =>
      'Venster vroeg beëindigd (gedeeltelijk)';

  @override
  String get payloads_screen_partially => 'Gedeeltelijk geleverd';

  @override
  String get payloads_screen_payload_not_exists =>
      'Deze payload bestaat niet meer.';

  @override
  String get payloads_screen_pending => 'In afwachting van levering';

  @override
  String get payloads_screen_process_fps => 'Verwerkings-FPS';

  @override
  String get payloads_screen_resend => 'Opnieuw verzenden';

  @override
  String get payloads_screen_select_first =>
      'Selecteer eerst minimaal één datum of uur.';

  @override
  String get payloads_screen_subtitle =>
      'Selecteer op datum of uur om opnieuw te verzenden';

  @override
  String get payloads_screen_title => 'Recente payloads';

  @override
  String get personal_custom_screen_build_server =>
      'Hulp nodig bij het instellen van uw eigen server?\\nBekijk onze API-documentatie en servervoorbeelden.';

  @override
  String get personal_custom_screen_help_action => 'API-documentatie openen';

  @override
  String get personal_custom_screen_reset_action => 'Opnieuw beginnen';

  @override
  String get personal_custom_success_screen_help =>
      'Tik hieronder op Start om te beginnen met tellen.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Verkeersstatistieken worden elk uur automatisch geüpload.\\nU kunt ze ook handmatig uploaden via het scherm Uploadlogboeken.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Uw server hoeft nog niet online te zijn.\\nBegin nu met tellen. U kunt uw server later verder bouwen en testen. De verkeersstatistieken blijven op dit apparaat totdat ze succesvol zijn geüpload.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Verkeersstatistieken worden verzonden naar';

  @override
  String get personal_custom_success_screen_title => 'Uw server is klaar';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Uw Piyuo Cloud-URL';

  @override
  String get piyuo_server_screen_copy_action => 'URL kopiëren';

  @override
  String get piyuo_server_screen_copy_success => 'URL gekopieerd';

  @override
  String get piyuo_server_screen_saving_action => 'Opslaan...';

  @override
  String get piyuo_server_screen_start =>
      'Druk hieronder op \"Start\" om te beginnen met tellen.';

  @override
  String get piyuo_server_screen_url_help =>
      'Je persoonlijke Piyuo Cloud-dashboard is beschikbaar via deze URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Sla deze URL op om vanaf een ander apparaat toegang te krijgen tot je verkeersdashboard.';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloud gebruiken';

  @override
  String get privacy => 'Privacybeleid';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'AI-gestuurde personen- en voertuigentelling.';

  @override
  String get settings_screen_custom_subtitle =>
      'Verstuur verkeersgegevens rechtstreeks naar uw eigen backend of database.';

  @override
  String get settings_screen_custom_title => 'Aangepaste server gebruiken';

  @override
  String get settings_screen_data_server_label => 'Gegevensserver';

  @override
  String get settings_screen_detection_target => 'Detectiedoel';

  @override
  String get settings_screen_language_title => 'Taal';

  @override
  String get settings_screen_local_subtitle =>
      'Sla verkeersgegevens alleen op dit apparaat op. Er wordt niets geüpload.';

  @override
  String get settings_screen_local_title => 'Alleen lokaal apparaat';

  @override
  String get settings_screen_misc_label => 'Overig';

  @override
  String get settings_screen_object_detection => 'Objectdetectie';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Sla verkeersgegevens op in Piyuo Cloud met dashboards en zakelijke inzichten.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Hiermee worden alle gegevens gewist en begint u opnieuw. Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get settings_screen_reset_all_data_title => 'Alle gegevens resetten?';

  @override
  String get settings_screen_subscription_body =>
      'Beheer uw abonnement en factuurgegevens';

  @override
  String get settings_screen_subscription_title => 'Abonnement';

  @override
  String get start_screen_about => 'Over';

  @override
  String get start_screen_server_none =>
      'Gegevens worden alleen op dit apparaat opgeslagen';

  @override
  String get start_screen_server_personal =>
      'Gegevens worden elk uur geüpload naar';

  @override
  String get start_screen_settings => 'Instellingen';

  @override
  String get start_screen_upload_logs => 'Logboeken uploaden';

  @override
  String get start_screen_video_sources => 'Videobronnen';

  @override
  String get stayed => 'Verbleven';

  @override
  String get stayed_help =>
      'Telt mensen of voertuigen die ten minste de ingestelde verblijftijd in dit gebied zijn gebleven.\\n\\nDe standaard verblijftijd is 15 seconden en kan worden gewijzigd in Instellingen.';

  @override
  String get target_pedestrian => 'Voetganger';

  @override
  String get target_pedestrian_help =>
      'Tel mensen met het voetgangersdetectiemodel';

  @override
  String get target_screen_subtitle =>
      'Kies welk detectiemodel u wilt gebruiken';

  @override
  String get target_vehicle => 'Voertuig';

  @override
  String get target_vehicle_help =>
      'Tel auto\'s en andere voertuigen met het voertuigdetectiemodel';

  @override
  String get telemetry_error_connection_refused =>
      'Kan geen verbinding maken met de server. Deze is mogelijk offline.';

  @override
  String get telemetry_error_connection_reset =>
      'De verbinding is gereset. Controleer je internetverbinding en probeer het opnieuw.';

  @override
  String get telemetry_error_connection_timeout =>
      'De verbinding reageerde te traag. Controleer je internetverbinding en probeer het opnieuw.';

  @override
  String get telemetry_error_database_error =>
      'Schrijven naar de database is mislukt.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Serveradres niet gevonden. Controleer je internetverbinding of de server-URL.';

  @override
  String get telemetry_error_http_error_status =>
      'De server heeft het verzoek geweigerd. Probeer het later opnieuw.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Er is een onverwachte fout opgetreden tijdens de communicatie met de server.';

  @override
  String get telemetry_error_invalid_url =>
      'Het serveradres is ongeldig. Controleer je instellingen.';

  @override
  String get telemetry_error_network_error =>
      'Er is een netwerkfout opgetreden. Controleer je internetverbinding en probeer het opnieuw.';

  @override
  String get telemetry_error_socket_error =>
      'Er is een netwerkverbindingsprobleem opgetreden. Controleer je internetverbinding.';

  @override
  String get telemetry_error_transport_exception =>
      'Er is iets misgegaan bij het verzenden van gegevens. Probeer het opnieuw.';

  @override
  String get telemetry_error_unknown_error =>
      'Er is een onverwachte fout opgetreden.';

  @override
  String get terms => 'Servicevoorwaarden';

  @override
  String get upload_screen_attempt_time => 'Tijd van poging:';

  @override
  String get upload_screen_error => 'Fout:';

  @override
  String get upload_screen_failed => 'Mislukt';

  @override
  String get upload_screen_load_error =>
      'Uploadlogboeken konden niet worden geladen.';

  @override
  String get upload_screen_log_not_exists =>
      'Uploadlog is niet meer beschikbaar.';

  @override
  String get upload_screen_next => 'Volgende upload om ...';

  @override
  String get upload_screen_next_upload_prefix => 'Volgende upload om ';

  @override
  String get upload_screen_no_data_server => 'Stel eerst de gegevensserver in.';

  @override
  String get upload_screen_no_logs => 'Nog geen uploadlogboeken.';

  @override
  String get upload_screen_payload_count => 'Aantal payloads';

  @override
  String get upload_screen_payload_count_label => 'Aantal payloads:';

  @override
  String get upload_screen_payload_size => 'Payloadgrootte:';

  @override
  String get upload_screen_result => 'Resultaat:';

  @override
  String get upload_screen_retry => 'Aantal nieuwe pogingen:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'V geslaagd';

  @override
  String get upload_screen_today => 'Vandaag';

  @override
  String get upload_screen_upload_now => 'Nu uploaden';

  @override
  String get upload_screen_upload_success => 'Upload geslaagd.';

  @override
  String get upload_screen_uploading => 'Uploaden...';

  @override
  String get upload_screen_yesterday => 'Gisteren';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP-URL\'s moeten een hostnaam bevatten.';

  @override
  String get url_screen_invalid_url_error =>
      'Voer een geldige URL met een ondersteund schema in.';

  @override
  String get url_screen_subtitle => 'Voer de livestream URL in';

  @override
  String get url_screen_title => 'Livestream URL';

  @override
  String get url_screen_unsupported_scheme_error =>
      'فقط نشانی‌های HTTP، HTTPS، RTSP و RTSPS پشتیبانی می‌شوند.';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Voer een live-stream-URL in.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://voorbeeld.com/stream of rtsp://voorbeeld.com/stream';

  @override
  String get video_sources_back_camera => 'Camera aan de achterkant';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_file => 'Bestand';

  @override
  String get video_sources_front_camera => 'Camera aan de voorkant';

  @override
  String get video_sources_live_stream => 'Livestream URL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Cameratoestemming is nodig om de camera te gebruiken';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Camera niet gevonden';

  @override
  String get video_sources_screen_import_error =>
      'Videobestand kon niet worden geïmporteerd.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Ga naar instellingen en geef toestemming voor fototoegang voor deze app.';

  @override
  String get video_sources_screen_select_camera =>
      'Tik om deze camera te selecteren';

  @override
  String get video_sources_screen_select_file => 'Tik om een bestand te kiezen';

  @override
  String get video_sources_screen_select_live =>
      'Tik om de live-stream-URL in te stellen';

  @override
  String get video_sources_webcam => 'Webcam';
}
