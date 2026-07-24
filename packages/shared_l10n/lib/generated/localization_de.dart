// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class LocalizationDe extends Localization {
  LocalizationDe([String locale = 'de']) : super(locale);

  @override
  String get about_screen_app_version => 'App-Version';

  @override
  String get about_screen_email_us => 'E-Mail an uns';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get appeared => 'Erschienen';

  @override
  String get appeared_help =>
      'Zählt Personen oder Fahrzeuge, deren erste erkannte Position innerhalb dieses Bereichs lag.\\n\\nHilft dabei zu verstehen, wo die Verfolgung beginnt.\\n\\n(Hauptsächlich für fortgeschrittene Benutzer gedacht)';

  @override
  String get average_occupancy => 'Durchschnittliche Belegung';

  @override
  String get average_occupancy_help =>
      'Zeigt die durchschnittliche Anzahl von Personen oder Fahrzeugen in diesem Bereich während des aktuellen Zählfensters an.\\n\\nSo lässt sich erkennen, wie stark der Bereich während des gesamten Zählfensters genutzt wurde.';

  @override
  String get average_stay => 'Durchschnittliche Verweildauer';

  @override
  String get average_stay_help =>
      'Zeigt die durchschnittliche Verweildauer von Personen oder Fahrzeugen in diesem Bereich an.\\n\\nEine längere durchschnittliche Verweildauer kann darauf hindeuten, dass Kunden mehr Zeit in diesem Bereich verbringen.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter verwendet Ihre Kamera und KI auf dem Gerät, um Personen zu zählen. Prüfen wir zuerst, ob Ihr Gerät kompatibel ist.';

  @override
  String get camera_test_screen_instruction =>
      'Richten Sie die Kamera auf Personen. Die App zeichnet Kästchen um erkannte Personen.';

  @override
  String get camera_test_screen_next =>
      'Tippen Sie auf „Weiter“, um fortzufahren.';

  @override
  String get camera_test_screen_start =>
      'Tippen Sie auf „Start“. Erteilen Sie bei Aufforderung die Kameraberechtigung.';

  @override
  String get camera_test_screen_test_failed => 'Test fehlgeschlagen!';

  @override
  String get camera_test_screen_test_passed => 'Test bestanden!';

  @override
  String get camera_test_screen_title => 'KI-Kameratest';

  @override
  String get camera_test_screen_wait => 'Warten, bis die KI Personen erkennt…';

  @override
  String get cta_screen_custom => 'Eigenen Server verwenden';

  @override
  String get cta_screen_custom_help =>
      'Senden Sie Verkehrsdaten direkt an Ihr eigenes Backend oder Ihre Datenbank.';

  @override
  String get cta_screen_footer =>
      'Durch die Fortsetzung stimmen Sie den Nutzungsbedingungen, der Datenschutzerklärung und der Vereinbarung zur Datenverarbeitung zu.';

  @override
  String get cta_screen_invitation => 'Einladungscode verwenden';

  @override
  String get cta_screen_invitation_help =>
      'Treten Sie einer bestehenden Organisation mit einer Einladung Ihres Administrators bei.';

  @override
  String get cta_screen_local => 'Nur auf diesem Gerät';

  @override
  String get cta_screen_local_help =>
      'Speichern Sie Verkehrsdaten nur auf diesem Gerät. Es wird nichts hochgeladen.';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud verwenden';

  @override
  String get cta_screen_piyuo_help =>
      'Speichern Sie Verkehrsdaten in Piyuo Cloud mit Dashboards und Geschäftseinblicken.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter erstellt alle 5 Minuten anonyme Verkehrsstatistiken.\\nWählen Sie, wie Sie Ihre Daten speichern und darauf zugreifen möchten.';

  @override
  String get current_occupancy => 'Aktuelle Anzahl';

  @override
  String get current_occupancy_help =>
      'Zeigt die aktuelle Anzahl der Personen oder Fahrzeuge in diesem Bereich.\\n\\nDieser Wert wird in Echtzeit aktualisiert und hilft dabei zu überprüfen, ob die KI-Erkennung mit dem übereinstimmt, was auf dem Bildschirm zu sehen ist. Er wird nicht in die hochgeladenen Telemetriedaten aufgenommen.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Speichern...';

  @override
  String get custom_server_screen_server_url_label => 'Server-URL';

  @override
  String get detection_screen_confidence => 'Vertrauensschwelle';

  @override
  String get detection_screen_confidence_dialog =>
      'Legt fest, wie sicher die KI sein muss, bevor sie eine Person oder ein Fahrzeug zählt.\\nNiedrigere Werte\\n• Erkennen mehr Objekte\\n• Besser für entfernte oder teilweise verdeckte Objekte\\n• Können mehr Fehlerkennungen verursachen\\nHöhere Werte\\n• Zählen nur sehr sichere Erkennungen\\n• Reduzieren Fehlerkennungen\\n• Können kleine oder schwierige Objekte übersehen\\nVerwenden Sie einen niedrigeren Wert, wenn die App Personen oder Fahrzeuge übersieht.\\nVerwenden Sie einen höheren Wert, wenn die App Schatten, Spiegelungen oder andere falsche Objekte zählt.';

  @override
  String get detection_screen_confidence_help =>
      'Mindestvertrauen, das zum Erkennen eines Objekts erforderlich ist.';

  @override
  String get detection_screen_confidence_max_label => 'Streng';

  @override
  String get detection_screen_confidence_min_label => 'Locker';

  @override
  String get detection_screen_disappear =>
      'Zeitüberschreitung bis zum Verschwinden';

  @override
  String get detection_screen_disappear_dialog =>
      'Legt fest, wie lange die KI wartet, bevor sie ein Objekt als verschwunden markiert, nachdem es nicht mehr erkannt wird.\\nKürzere Werte\\n• Markieren Objekte schneller als verschwunden\\n• Besser für schnellen Verkehr\\n• Können vorübergehend verdeckte Objekte fälschlich als verschwunden markieren\\nLängere Werte\\n• Warten länger, bevor Objekte als verschwunden markiert werden\\n• Besser, wenn Objekte kurz blockiert oder übersehen werden\\n• Verzögern Verschwinden-Ereignisse';

  @override
  String get detection_screen_disappear_help =>
      'Wie lange die KI wartet, bevor ein Objekt nach dem letzten Erkennen als verschwunden gilt.';

  @override
  String get detection_screen_disappear_max_label => 'Langsam';

  @override
  String get detection_screen_disappear_min_label => 'Schnell';

  @override
  String get detection_screen_memory_dialog =>
      'Legt fest, wie lange die KI sich an ein Objekt erinnert, nachdem es verschwunden ist.\\nErhöhen Sie diesen Wert, wenn Personen oder Fahrzeuge häufig hinter anderen Objekten verdeckt werden.\\nVerringern Sie diesen Wert, wenn Objekte nach dem Verlassen der Szene falsch verknüpft werden.';

  @override
  String get detection_screen_min_presence => 'Minimale Anwesenheitszeit';

  @override
  String get detection_screen_min_presence_help =>
      'Ein Objekt muss sichtbar bleiben, bevor es gezählt wird. Höhere Werte helfen, kurzzeitige Fehldetektionen zu reduzieren.';

  @override
  String get detection_screen_min_presence_max_label => 'Sicherer';

  @override
  String get detection_screen_min_presence_min_label => 'Schneller';

  @override
  String get detection_screen_minimum_visible =>
      'Objekte müssen so lange sichtbar bleiben, bevor sie gezählt werden.\\nErhöhen Sie diesen Wert, um kurze Fehlerkennungen zu ignorieren.\\nVerringern Sie diesen Wert, wenn sich schnell bewegende Personen oder Fahrzeuge übersehen werden.';

  @override
  String get detection_screen_new_track => 'Schwelle für neue Verfolgung';

  @override
  String get detection_screen_new_track_help =>
      'Mindestvertrauen zum Starten der Verfolgung eines neuen Objekts. Niedrige Werte können doppelte Verfolgungen erzeugen.';

  @override
  String get detection_screen_new_track_max_label => 'Konservativ';

  @override
  String get detection_screen_new_track_min_label => 'Aggressiv';

  @override
  String get detection_screen_reset => 'Zurücksetzen';

  @override
  String get detection_screen_reset_content =>
      'Sind Sie sicher, dass Sie die Erkennungseinstellungen zurücksetzen möchten?';

  @override
  String get detection_screen_show_track_id => 'Track-ID anzeigen';

  @override
  String get detection_screen_show_track_id_help =>
      'Aktivieren Sie diese Option, um eindeutige Verfolgungs-IDs für jedes verfolgtes Objekt anzuzeigen.';

  @override
  String get detection_screen_stay => 'Verweildauer';

  @override
  String get detection_screen_stay_help =>
      'Wie lange ein Objekt im Bereich bleiben muss, bevor es als Aufenthalt gezählt wird.';

  @override
  String get detection_screen_stay_max_label => 'Verzögert';

  @override
  String get detection_screen_stay_min_label => 'Sofort';

  @override
  String get detection_screen_stay_threshold =>
      'Legt fest, wann ein Objekt zur Verweildauer-Zählung beiträgt.\\nKürzere Werte\\n• Zählen Verweildauer sofort\\n• Besser für schnelle Analysen\\nLängere Werte\\n• Ignorieren kurzen Durchgangsverkehr\\n• Besser für Belegungsmessung';

  @override
  String get detection_screen_subtitle =>
      'Passen Sie an, wie die KI Objekte erkennt und verfolgt';

  @override
  String get detection_screen_title => 'Verfolgung & Zählung';

  @override
  String get detection_screen_track_dialog =>
      'Legt fest, wann ein neu erkanntes Objekt zu einer neuen Spur wird.\\nNiedrigere Werte\\n• Verfolgung beginnt schneller\\n• Besser für sich schnell bewegende Objekte\\n• Können doppelte Spuren erzeugen\\nHöhere Werte\\n• Erfordern stärkere Beweise vor Erstellung einer neuen Spur\\n• Reduzieren doppelte Spuren\\n• Können die Verfolgung neuer Objekte verzögern';

  @override
  String get detection_screen_track_memory => 'Tracking-Speicher';

  @override
  String get detection_screen_track_memory_help =>
      'Legt fest, wie lange ein Objekt nach einem kurzzeitigen Verlust weiter verfolgt wird. Längere Werte helfen nach kurzen Verdeckungen.';

  @override
  String get detection_screen_track_memory_max_label => 'Lang';

  @override
  String get detection_screen_track_memory_min_label => 'Kurz';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter verwendet Ihre Kamera, um Fußgänger und Fahrzeuge in Echtzeit zu erkennen. Auf diesem Gerät ist keine Kamera verfügbar.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Versuchen Sie, diese App auf Ihrem Smartphone zu öffnen';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Ein Smartphone oder Tablet mit Kamera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Ein iOS- oder Android-Gerät wird empfohlen';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Was Sie benötigen';

  @override
  String get device_not_supported_screen_title => 'Kamera nicht gefunden';

  @override
  String get disappeared => 'Verschwunden';

  @override
  String get disappeared_help =>
      'Zählt Personen oder Fahrzeuge, deren letzte erkannte Position innerhalb dieses Bereichs lag.\\n\\nDie Verfolgung endet nach der eingestellten Ausblendzeit, wenn die Person oder das Fahrzeug nicht mehr erkannt wird.\\n\\n(Hauptsächlich für fortgeschrittene Benutzer gedacht)';

  @override
  String get dpa => 'Vereinbarung zur Datenverarbeitung';

  @override
  String get durationDaysShort => '%sT';

  @override
  String get durationHoursShort => '%sStd';

  @override
  String get durationMinutesShort => '%sMin';

  @override
  String get durationSecondsShort => '%sSek';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Eingetreten';

  @override
  String get entered_help =>
      'Zählt Personen oder Fahrzeuge, die diesen Bereich während des aktuellen Zählfensters betreten haben.\\n\\nEin Eintritt wird gezählt, wenn sich eine Person oder ein Fahrzeug von außerhalb in den Bereich bewegt.';

  @override
  String get exited => 'Verlassen';

  @override
  String get exited_help =>
      'Zählt Personen oder Fahrzeuge, die diesen Bereich während des aktuellen Zählfensters verlassen haben.\\n\\nEin Austritt wird gezählt, wenn sich eine Person oder ein Fahrzeug von innerhalb des Bereichs nach außerhalb bewegt.';

  @override
  String get language_screen_language => 'Sprache';

  @override
  String get language_screen_subtitle =>
      'Wählen Sie die im App verwendete Sprache aus.';

  @override
  String get local_only_screen_body =>
      'Der Modus \'Nur lokales Gerät\' lässt Sie die KI-Kameraerkennung und -verfolgung testen, ohne Daten hochzuladen. Alle Besucherstatistiken werden nur auf diesem Gerät verarbeitet, ideal, um die Kamera zu testen, bevor Sie sich mit einem Server verbinden.';

  @override
  String get local_only_screen_use_action => 'Nur lokales Gerät verwenden';

  @override
  String get local_screen_text =>
      'Piyuo Counter läuft vollständig auf diesem Gerät.\\nDie Verkehrsstatistiken werden nur auf diesem Gerät gespeichert und nicht hochgeladen.\\nSie können später in den Einstellungen eine Verbindung zu Piyuo Cloud oder Ihrem eigenen Server herstellen.';

  @override
  String get maximum_occupancy => 'Maximale Belegung';

  @override
  String get maximum_occupancy_help =>
      'Zeigt die höchste Anzahl von Personen oder Fahrzeugen, die sich gleichzeitig während des aktuellen Zählfensters in diesem Bereich befanden.\\n\\nHilft dabei, Spitzenzeiten bei Personen- oder Fahrzeugaufkommen zu erkennen.';

  @override
  String get maximum_stay => 'Maximale Verweildauer';

  @override
  String get maximum_stay_help =>
      'Zeigt die längste Zeit an, die eine Person oder ein Fahrzeug während des aktuellen Zählfensters in diesem Bereich geblieben ist.\\n\\nHilft dabei, ungewöhnlich lange Besuche oder Stopps zu erkennen.';

  @override
  String get metric_events => 'Ereignisse';

  @override
  String get metric_live => 'Live';

  @override
  String get metric_show_less => 'Weniger anzeigen';

  @override
  String get metric_show_more => 'Mehr anzeigen';

  @override
  String get metric_statistics => 'Statistiken';

  @override
  String get metrics_counting_all => 'Alle';

  @override
  String get metrics_counting_done => 'Abgeschlossen';

  @override
  String get metrics_counting_in_progress => 'In Bearbeitung';

  @override
  String get metrics_counting_missing => 'Fehlend';

  @override
  String get metrics_counting_window =>
      'Statistiken für jeden 5-Minuten-Zeitraum';

  @override
  String get onboarding_back_action => 'Zurück';

  @override
  String get onboarding_cta_no_server => 'Möchten Sie keine Daten hochladen?';

  @override
  String get onboarding_cta_title => 'Wohin sollen Ihre Daten gesendet werden?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter erkennt mit der Kamera und KI direkt auf deinem Gerät Personen und Fahrzeuge in Echtzeit.\\nDurch Erkennungs- und Tracking-Technologie zählt die App automatisch Fußgänger- und Fahrzeugverkehr — alles läuft direkt auf deinem Gerät.';

  @override
  String get onboarding_intro_text2 =>
      'Die gesamte KI-Verarbeitung erfolgt lokal auf deinem Gerät. Es werden keine Videos, Bilder, Gesichter oder Identitäten hochgeladen.\\nEs werden nur anonyme 5-Minuten-Zusammenfassungen geteilt, mit Zählungen, Auslastung, Ein- und Ausgängen sowie Verweildauer-Statistiken.';

  @override
  String get onboarding_intro_text3 =>
      'Starte einfach die App und lass sie laufen. Piyuo Counter sammelt und speichert automatisch fortlaufend Verkehrsdaten.\\nDatenzusammenfassungen werden alle 5 Minuten gespeichert und stündlich zu Piyuo Cloud oder deinem eigenen Server hochgeladen.';

  @override
  String get onboarding_intro_title1 => 'KI-Verkehrszählung';

  @override
  String get onboarding_intro_title2 => 'Datenschutz an erster Stelle';

  @override
  String get onboarding_intro_title3 => 'Läuft automatisch rund um die Uhr';

  @override
  String get onboarding_next_action => 'Weiter';

  @override
  String get onboarding_skip_action => 'Einführung überspringen';

  @override
  String get onboarding_start_action => 'Starten';

  @override
  String get passed_by => 'Vorbeigegangen';

  @override
  String get passed_by_help =>
      'Zählt Personen oder Fahrzeuge, die diesen Bereich während des aktuellen Zählfensters durchquert haben.\\n\\nJede Person oder jedes Fahrzeug wird pro Durchgang durch den Bereich nur einmal gezählt.';

  @override
  String get payloads_screen_area => 'Bereich';

  @override
  String get payloads_screen_confidence => 'Konfidenz';

  @override
  String get payloads_screen_coverage => 'Abdeckung';

  @override
  String get payloads_screen_delivered => 'Zugestellt';

  @override
  String get payloads_screen_failed_load =>
      'Letzte Payloads konnten nicht geladen werden';

  @override
  String get payloads_screen_frame_processed => 'Verarbeitete Frames';

  @override
  String get payloads_screen_hour_not_exists =>
      'Diese Stunde existiert nicht mehr.';

  @override
  String get payloads_screen_missing_time => 'Fehlende Zeit';

  @override
  String get payloads_screen_no_payloads => 'Noch keine Payloads vorhanden.';

  @override
  String get payloads_screen_partial => 'Fenster vorzeitig beendet (teilweise)';

  @override
  String get payloads_screen_partially => 'Teilweise zugestellt';

  @override
  String get payloads_screen_payload_not_exists =>
      'Diese Payload existiert nicht mehr.';

  @override
  String get payloads_screen_pending => 'Ausstehend';

  @override
  String get payloads_screen_process_fps => 'Verarbeitungs-FPS';

  @override
  String get payloads_screen_resend => 'Erneut senden';

  @override
  String get payloads_screen_select_first =>
      'Wählen Sie zuerst mindestens ein Datum oder eine Stunde aus.';

  @override
  String get payloads_screen_subtitle =>
      'Nach Datum oder Stunde zum erneuten Senden auswählen';

  @override
  String get payloads_screen_title => 'Neueste Payloads';

  @override
  String get personal_custom_screen_build_server =>
      'Benötigen Sie Hilfe beim Einrichten Ihres eigenen Servers?\\nSehen Sie sich unsere API-Dokumentation und Serverbeispiele an.';

  @override
  String get personal_custom_screen_help_action => 'API-Dokumentation öffnen';

  @override
  String get personal_custom_screen_reset_action => 'Von vorn beginnen';

  @override
  String get personal_custom_success_screen_help =>
      'Tippen Sie unten auf Start, um mit dem Zählen zu beginnen.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Verkehrsstatistiken werden stündlich automatisch hochgeladen.\\nSie können sie auch im Bildschirm „Upload-Protokolle“ manuell hochladen.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Ihr Server muss noch nicht online sein.\\nBeginnen Sie jetzt mit dem Zählen. Sie können Ihren Server später fertigstellen und testen. Die Verkehrsstatistiken bleiben auf diesem Gerät, bis sie erfolgreich hochgeladen wurden.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Verkehrsstatistiken werden gesendet an';

  @override
  String get personal_custom_success_screen_title => 'Server bereit';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Ihre Piyuo Cloud-URL';

  @override
  String get piyuo_server_screen_copy_action => 'URL kopieren';

  @override
  String get piyuo_server_screen_copy_success => 'URL kopiert';

  @override
  String get piyuo_server_screen_saving_action => 'Speichern...';

  @override
  String get piyuo_server_screen_start =>
      'Drücken Sie unten auf „Start“, um mit dem Zählen zu beginnen.';

  @override
  String get piyuo_server_screen_url_help =>
      'Ihr persönliches Piyuo Cloud-Dashboard ist unter dieser URL verfügbar.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Speichern Sie diese URL, um von einem anderen Gerät auf Ihr Verkehrs-Dashboard zuzugreifen.';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloud verwenden';

  @override
  String get privacy => 'Datenschutzerklärung';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'KI-gestützte Personen- und Fahrzeugzählung.';

  @override
  String get settings_screen_custom_subtitle =>
      'Senden Sie Verkehrsdaten direkt an Ihr Backend oder Ihre Datenbank.';

  @override
  String get settings_screen_custom_title =>
      'Benutzerdefinierten Server verwenden';

  @override
  String get settings_screen_data_server_label => 'Datenserver';

  @override
  String get settings_screen_detection_target => 'Erkennungsziel';

  @override
  String get settings_screen_language_title => 'Sprache';

  @override
  String get settings_screen_local_subtitle =>
      'Speichern Sie Verkehrsdaten nur auf diesem Gerät. Es wird nichts hochgeladen.';

  @override
  String get settings_screen_local_title => 'Nur auf diesem Gerät';

  @override
  String get settings_screen_misc_label => 'Verschiedenes';

  @override
  String get settings_screen_object_detection => 'Objekterkennung';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Speichern Sie Ihre Besucherdaten in der Piyuo Cloud mit Dashboards und Business-Einblicken.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Dadurch werden alle Daten gelöscht und Sie beginnen von vorne. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get settings_screen_reset_all_data_title => 'Alle Daten zurücksetzen?';

  @override
  String get settings_screen_subscription_body =>
      'Verwalten Sie Ihr Abonnement und Ihre Rechnungsdaten';

  @override
  String get settings_screen_subscription_title => 'Abonnement';

  @override
  String get start_screen_about => 'Über';

  @override
  String get start_screen_server_none =>
      'Daten werden nur auf diesem Gerät gespeichert';

  @override
  String get start_screen_server_personal => 'Stündlicher Daten-Upload zu';

  @override
  String get start_screen_settings => 'Einstellungen';

  @override
  String get start_screen_upload_logs => 'Protokolle hochladen';

  @override
  String get start_screen_video_sources => 'Videoquellen';

  @override
  String get stayed => 'Verweilt';

  @override
  String get stayed_help =>
      'Zählt Personen oder Fahrzeuge, die mindestens die eingestellte Verweildauer in diesem Bereich geblieben sind.\\n\\nDie Standard-Verweildauer beträgt 15 Sekunden und kann in den Einstellungen geändert werden.';

  @override
  String get target_pedestrian => 'Fußgänger';

  @override
  String get target_pedestrian_help =>
      'Personen mit dem Fußgänger-Erkennungsmodell zählen';

  @override
  String get target_screen_subtitle =>
      'Wählen Sie das gewünschte Erkennungsmodell aus';

  @override
  String get target_vehicle => 'Fahrzeuge';

  @override
  String get target_vehicle_help =>
      'Autos und andere Fahrzeuge mit dem Fahrzeug-Erkennungsmodell zählen';

  @override
  String get telemetry_error_connection_refused =>
      'Server konnte nicht erreicht werden. Er ist möglicherweise gerade offline.';

  @override
  String get telemetry_error_connection_reset =>
      'Die Verbindung wurde zurückgesetzt. Bitte überprüfe deine Internetverbindung und versuche es erneut.';

  @override
  String get telemetry_error_connection_timeout =>
      'Die Verbindung hat zu lange für eine Antwort gebraucht. Bitte überprüfe deine Internetverbindung und versuche es erneut.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Serveradresse konnte nicht gefunden werden. Bitte überprüfe deine Internetverbindung oder die Server-URL.';

  @override
  String get telemetry_error_http_error_status =>
      'Der Server hat die Anfrage abgelehnt. Bitte versuche es später erneut.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Bei der Kommunikation mit dem Server ist ein unerwarteter Fehler aufgetreten.';

  @override
  String get telemetry_error_invalid_url =>
      'Die Serveradresse ist ungültig. Bitte überprüfe deine Einstellungen.';

  @override
  String get telemetry_error_network_error =>
      'Ein Netzwerkfehler ist aufgetreten. Bitte überprüfe deine Internetverbindung und versuche es erneut.';

  @override
  String get telemetry_error_socket_error =>
      'Es ist ein Netzwerkverbindungsproblem aufgetreten. Bitte überprüfe deine Internetverbindung.';

  @override
  String get telemetry_error_transport_exception =>
      'Beim Senden der Daten ist ein Fehler aufgetreten. Bitte versuche es erneut.';

  @override
  String get terms => 'Nutzungsbedingungen';

  @override
  String get upload_screen_attempt_time => 'Zeit des Versuchs:';

  @override
  String get upload_screen_error => 'Fehler:';

  @override
  String get upload_screen_failed => 'Fehlgeschlagen';

  @override
  String get upload_screen_load_error =>
      'Upload-Protokolle konnten nicht geladen werden.';

  @override
  String get upload_screen_log_not_exists =>
      'Upload-Protokoll ist nicht mehr verfügbar.';

  @override
  String get upload_screen_next => 'Nächster Upload um ...';

  @override
  String get upload_screen_next_upload_prefix => 'Nächster Upload um ';

  @override
  String get upload_screen_no_data_server =>
      'Bitte richten Sie zuerst den Datenserver ein.';

  @override
  String get upload_screen_no_logs => 'Noch keine Upload-Protokolle.';

  @override
  String get upload_screen_payload_count => 'Anzahl der Payloads';

  @override
  String get upload_screen_payload_count_label => 'Anzahl der Payloads:';

  @override
  String get upload_screen_payload_size => 'Payload-Größe:';

  @override
  String get upload_screen_result => 'Ergebnis:';

  @override
  String get upload_screen_retry => 'Anzahl der Wiederholungen:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Erfolgreich';

  @override
  String get upload_screen_today => 'Heute';

  @override
  String get upload_screen_upload_now => 'Jetzt hochladen';

  @override
  String get upload_screen_upload_success => 'Upload erfolgreich.';

  @override
  String get upload_screen_uploading => 'Wird hochgeladen...';

  @override
  String get upload_screen_yesterday => 'Gestern';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP-URLs müssen einen Hostnamen enthalten.';

  @override
  String get url_screen_invalid_url_error =>
      'Geben Sie eine gültige URL mit unterstütztm Schema ein.';

  @override
  String get url_screen_subtitle => 'Bitte geben Sie die Live-Stream URL ein';

  @override
  String get url_screen_title => 'Live-Stream URL';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Bitte geben Sie eine Live-Stream-URL ein.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://beispiel.de/stream oder rtsp://beispiel.de/stream';

  @override
  String get video_sources_back_camera => 'Rückkamera';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_file => 'Datei';

  @override
  String get video_sources_front_camera => 'Frontkamera';

  @override
  String get video_sources_live_stream => 'Live-Stream URL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Kamerazugriff muss gewährt werden, um die Kamera zu nutzen';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Kamera nicht gefunden';

  @override
  String get video_sources_screen_import_error =>
      'Videodatei konnte nicht importiert werden.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Bitte gehe zu den Einstellungen und erlaube den Fotozugriff für diese App.';

  @override
  String get video_sources_screen_select_camera =>
      'Tippen, um diese Kamera auszuwählen';

  @override
  String get video_sources_screen_select_file =>
      'Tippen, um eine Datei auszuwählen';

  @override
  String get video_sources_screen_select_live =>
      'Tippen, um die Live-Stream-URL festzulegen';

  @override
  String get video_sources_webcam => 'Webcam';
}
