// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class LocalizationDe extends Localization {
  LocalizationDe([String locale = 'de']) : super(locale);

  @override
  String get product_name => 'Zähler';

  @override
  String get product_desc => 'Nutzung von Computer Vision und KI zum Zählen von Personen, Fahrzeugen, Haustieren und mehr.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Live-Stream URL';

  @override
  String get video_sources_file => 'Datei';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nicht gefunden';

  @override
  String get video_sources_camera_not_found_message => 'Kamerazugriff muss gewährt werden, um die Kamera zu nutzen';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam nicht gefunden';

  @override
  String get video_sources_webcam_not_found_message => 'Bitte überprüfen Sie, ob eine Webcam angeschlossen ist';

  @override
  String get wizard_screen_desc => 'Erstellen Sie unten ein neues Projekt, um mit dem Zählen zu beginnen.';

  @override
  String get wizard_screen_new_project_from => 'Neues Projekt aus';

  @override
  String get wizard_screen_language => 'Sprache';

  @override
  String get wizard_screen_about => 'Über';

  @override
  String get wizard_screen_open_projects_tip => 'Alle Projekte werden automatisch lokal gespeichert';

  @override
  String get wizard_screen_open_projects => 'Bestehendes Projekt öffnen';

  @override
  String get wizard_screen_email_us => 'E-Mail an uns';

  @override
  String get language_screen_language => 'Sprache';

  @override
  String get project_view_no_videos => 'Keine Videoquelle verfügbar.';

  @override
  String get about_screen_title => 'Über';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get about_screen_app_version => 'App-Version';

  @override
  String get about_screen_models => 'Objekterkennungsmodelle';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build-Informationen';

  @override
  String get benchmark_screen_title => 'Modell-Benchmarks';

  @override
  String get benchmark_screen_recommended => 'Empfohlenes Modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Benchmark starten';

  @override
  String get benchmark_screen_start_failed => 'Benchmark konnte nicht gestartet werden, der Fehlercode ist';

  @override
  String get benchmark_screen_models => 'Objekterkennungsmodelle';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Projekt verlassen bestätigen';

  @override
  String get project_screen_exit_confirm_content => 'Beim Verlassen des Projekts wird die Zählung gestoppt. Möchten Sie wirklich fortfahren?';

  @override
  String get project_screen_exit_button => 'Beenden';

  @override
  String get project_screen_add_video_button => 'Videoquelle hinzufügen';

  @override
  String get project_screen_from_desc => 'Wir speichern einen 24-Stunden-Verlauf, sodass Sie jeden gewünschten Zeitabschnitt einsehen können.';

  @override
  String get project_screen_report_settings => 'Einstellungen';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Wählen Sie einen Filterbereich aus der Liste unten';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Endzeit muss größer als Startzeit sein';

  @override
  String get filter_screen_error_custom => 'Benutzerdefiniert';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Ende';

  @override
  String get settings_screen_title => 'Einstellungen';

  @override
  String get settings_screen_desc => 'Projektnamen, Erkennungsparameter und Zählrückstellung festlegen.';

  @override
  String get settings_screen_project_id => 'Projekt-ID';

  @override
  String get settings_screen_project_name => 'Projektname';

  @override
  String get settings_screen_project_name_place_holder => 'Hauptstraße 123 oder Stadtpark';

  @override
  String get settings_screen_project_error => 'Der Projektname darf nicht leer sein';

  @override
  String get settings_screen_random_count_button => 'Zufällige Zählungen hinzufügen';

  @override
  String get settings_screen_reset_count_header => 'Alle Zählungen in diesem Projekt zurücksetzen';

  @override
  String get settings_screen_reset_count_button => 'Zählungen zurücksetzen';

  @override
  String get settings_screen_reset_count_content => 'Sind Sie sicher, dass Sie alle Zählungen zurücksetzen möchten?';

  @override
  String get settings_screen_delete_header => 'Dieses Projekt löschen';

  @override
  String get settings_screen_delete_content => 'Sind Sie sicher, dass Sie dieses Projekt löschen möchten?';

  @override
  String get settings_screen_delete_button => 'Löschen';

  @override
  String get settings_screen_center_point_title => 'Mittelpunkt auf Zielobjekt';

  @override
  String get settings_screen_center_point_desc => 'Der Mittelpunkt hilft zu bestimmen, ob sich das Zielobjekt innerhalb der Trefferzone befindet.';

  @override
  String get settings_screen_center_point_button => 'Mittelpunkt auf Zielobjekt anzeigen';

  @override
  String get settings_screen_lost_target_title => 'Verlorenes Zielobjekt';

  @override
  String get settings_screen_lost_target_desc => 'Wenn die Objektverfolgung ein Ziel verliert, macht diese Option es sichtbar. Standardmäßig werden verlorene Ziele nicht angezeigt.';

  @override
  String get settings_screen_lost_target_button => 'Verlorenes Zielobjekt anzeigen';

  @override
  String get detection_screen_title => 'Erkennungseinstellungen';

  @override
  String get detection_screen_models => 'Modelle';

  @override
  String get detection_screen_confidence => 'Konfidenz';

  @override
  String get detection_screen_confidence_desc => 'Konfidenz über #0 wird als gültige Erkennung betrachtet';

  @override
  String get detection_screen_low => 'Niedrig';

  @override
  String get detection_screen_high => 'Hoch';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Ein niedrigerer NMS-Schwellenwert (z.B. 30%) entfernt überlappende Begrenzungsrahmen aggressiver, während ein höherer NMS-Schwellenwert (z.B. 0,6) mehr Überlappung zulässt';

  @override
  String get detection_screen_match => 'Übereinstimmung';

  @override
  String get detection_screen_match_desc => 'Übereinstimmung über #0 wird als dasselbe Objekt betrachtet.';

  @override
  String get detection_screen_lost => 'Verloren';

  @override
  String get detection_screen_lost_desc => 'Verfolgtes Objekt wird entfernt, wenn es für #0 verloren geht';

  @override
  String get detection_screen_consider_valid => 'Als gültig betrachten nach';

  @override
  String get detection_screen_consider_valid_desc => 'Verfolgtes Objekt wird nach #0 als gültig betrachtet';

  @override
  String get detection_screen_reset => 'Zurücksetzen';

  @override
  String get detection_screen_reset_content => 'Sind Sie sicher, dass Sie die Erkennungseinstellungen zurücksetzen möchten?';

  @override
  String get url_screen_title => 'Live-Stream URL';

  @override
  String get url_screen_desc => 'Bitte geben Sie die Live-Stream URL ein';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://beispiel.de/stream oder rtsp://beispiel.de/stream';

  @override
  String get add_video_screen_title => 'Videoquelle hinzufügen';

  @override
  String get add_video_screen_from => 'Videoquelle hinzufügen von';

  @override
  String get webcam_screen_add_title => 'Webcam hinzufügen';

  @override
  String get webcam_screen_edit_title => 'Webcam auswählen';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Frontkamera';

  @override
  String get camera_screen_back_camera => 'Rückkamera';

  @override
  String get camera_screen_add_title => 'Kamera hinzufügen';

  @override
  String get camera_screen_edit_title => 'Kamera auswählen';

  @override
  String get camera_screen_zoom_level => 'Zoom-Stufe';

  @override
  String get video_screen_name_empty => 'Der Videoname darf nicht leer sein.';

  @override
  String get video_screen_desc => 'Videoquellen verwalten, Erkennungszonen hinzufügen oder ändern.';

  @override
  String get video_screen_video_name => 'Name der Videoquelle';

  @override
  String get video_screen_edit_placeholder => 'Haustür-Kamera oder Parkplatz-Kamera';

  @override
  String get video_screen_change_file => 'Datei ändern';

  @override
  String get video_screen_add_zone => 'Erkennungszone hinzufügen';

  @override
  String get video_screen_zones => 'Erkennungszonen';

  @override
  String get video_screen_zones_desc => 'Verwenden Sie Drag & Drop, um Zonen anzupassen';

  @override
  String get video_screen_tools => 'Werkzeuge';

  @override
  String get video_screen_move_bottom => 'Aktuelle Zone nach unten verschieben';

  @override
  String get video_screen_add_point => 'Punkt zur aktuellen Zone hinzufügen';

  @override
  String get video_screen_remove_point => 'Punkt aus der aktuellen Zone entfernen';

  @override
  String get video_screen_playback_speed => 'Wiedergabegeschwindigkeit';

  @override
  String get video_screen_playback_current => 'aktuell: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Diese Videoquelle löschen';

  @override
  String get video_screen_delete_content => 'Sind Sie sicher, dass Sie diese Videoquelle löschen möchten?';

  @override
  String get video_screen_delete_button => 'Löschen';

  @override
  String get video_screen_sources => 'Bildquelle, Erkennungsziele und Modellparameter konfigurieren.';

  @override
  String get video_screen_targets => 'Erkennungsziele';

  @override
  String get video_screen_detection => 'Modellparameter';

  @override
  String get color_screen_title => 'Farbe auswählen';

  @override
  String get zone_screen_desc => 'In der Erkennungszone können Sie festlegen, welche Objekttypen erkannt werden sollen und welche Zähler angezeigt werden, wie z.B. Erkannt, Erstellt und Eingetreten.';

  @override
  String get zone_screen_name_placeholder => 'Name der Zone, z.B. Gehweg oder Parkplatz';

  @override
  String get zone_screen_zone_color => 'Zonenfarbe';

  @override
  String get zone_screen_color => 'Farbe';

  @override
  String get zone_screen_delete_header => 'Diese Zone löschen';

  @override
  String get zone_screen_delete_content => 'Sind Sie sicher, dass Sie diese Zone löschen möchten?';

  @override
  String get zone_screen_delete_button => 'Löschen';

  @override
  String get zone_screen_can_not_delete => 'Zone kann nicht gelöscht werden';

  @override
  String get zone_screen_one_zone_required => 'Mindestens eine Zone ist erforderlich.';

  @override
  String get zone_screen_zone_name_required => 'Der Zonenname darf nicht leer sein';

  @override
  String get counter_screen_show_on => 'Auf dem Bildschirm anzeigen';

  @override
  String get counter_screen_enabled => 'Aktiviert';

  @override
  String get counter_screen_reentry_threshold => 'Wiedereintritts-Schwellenwert';

  @override
  String get counter_screen_reentry_desc => 'Objekte müssen #0 Mal eintreten, mit einer Abklingzeit von #1 Sekunden zwischen jedem Austritt und Wiedereintritt, um einen Wiedereintritt auszulösen';

  @override
  String get counter_screen_reentry_title => 'Wiedereintritts-Zählung';

  @override
  String get counter_screen_cooldown_threshold => 'Abklingzeit-Schwellenwert';

  @override
  String get counter_screen_cooldown_desc => 'Wiedereintritt erfordert eine Abklingzeit von #0 Sekunden nach Verlassen der Erkennungszone';

  @override
  String get counter_screen_cooldown_time => 'Abklingzeit';

  @override
  String get counter_screen_cooldown_in_seconds => 'in Sekunden';

  @override
  String get counter_screen_stagnant_threshold => 'Stillstands-Schwellenwert';

  @override
  String get counter_screen_stagnant_desc => 'Objekte, die mehr als #0 Sekunden stillstehen, werden als stagnierend betrachtet';

  @override
  String get counter_screen_stagnant_consider => 'Als stagnierend betrachten';

  @override
  String get counter_screen_stagnant_in_seconds => 'in Sekunden';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beschreibungs-Präfix';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beschreibungs-Suffix';

  @override
  String get counter_screen_name_error => 'Der Zählername darf nicht leer sein';

  @override
  String get counter_screen_enabled_error => 'Fehler';

  @override
  String get counter_screen_enabled_error_content => 'Sie müssen zuerst einen anderen Zähler aktivieren, bevor Sie diesen Zähler deaktivieren können';

  @override
  String get objects_screen_title => 'Objekte';

  @override
  String get objects_screen_desc => 'Wählen Sie Erkennungsziele wie Person, Auto, Bus usw.';

  @override
  String get open_project_screen_title => 'Projekt öffnen';

  @override
  String get open_project_screen_desc => 'Öffnen Sie zuvor erstellte Projekte, wobei nur die 20 neuesten behalten werden.';

  @override
  String get open_project_screen_no_project => 'Kein Projekt gefunden.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videoquelle';

  @override
  String get default_zone_name => 'Erkennungszone';

  @override
  String get error_oops => 'Ups, etwas ist schief gelaufen';

  @override
  String get error_content => 'Ein unerwarteter Fehler ist aufgetreten. Möchten Sie einen E-Mail-Bericht senden?';

  @override
  String get error_report => 'E-Mail an uns';

  @override
  String get submit => 'Absenden';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get close => 'Schließen';

  @override
  String get back => 'Zurück';

  @override
  String get settings_screen_detection_button => 'MISSING';
}

/// The translations for German, as used in Austria (`de_AT`).
class LocalizationDeAt extends LocalizationDe {
  LocalizationDeAt(): super('de_AT');

  @override
  String get product_name => 'Zähler';

  @override
  String get product_desc => 'Nutzt Computervision und KI, um Personen, Fahrzeuge, Haustiere und mehr zu zählen.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Live-Stream URL';

  @override
  String get video_sources_file => 'Datei';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nicht gefunden';

  @override
  String get video_sources_camera_not_found_message => 'Sie müssen die Kameraberechtigung erteilen, um die Kamera zu verwenden';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam nicht gefunden';

  @override
  String get video_sources_webcam_not_found_message => 'Bitte überprüfen Sie, ob eine Webcam angeschlossen ist';

  @override
  String get wizard_screen_desc => 'Erstellen Sie unten ein neues Projekt, um mit dem Zählen zu beginnen.';

  @override
  String get wizard_screen_new_project_from => 'Neues Projekt aus';

  @override
  String get wizard_screen_language => 'Sprache';

  @override
  String get wizard_screen_about => 'Über';

  @override
  String get wizard_screen_open_projects_tip => 'Alle Projekte werden automatisch lokal gespeichert';

  @override
  String get wizard_screen_open_projects => 'Bestehendes Projekt öffnen';

  @override
  String get wizard_screen_email_us => 'E-Mail an uns';

  @override
  String get language_screen_language => 'Sprache';

  @override
  String get project_view_no_videos => 'Keine Videoquelle verfügbar.';

  @override
  String get about_screen_title => 'Über';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get about_screen_app_version => 'App-Version';

  @override
  String get about_screen_models => 'Objekterkennungsmodelle';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build-Informationen';

  @override
  String get benchmark_screen_title => 'Modell-Benchmarks';

  @override
  String get benchmark_screen_recommended => 'Empfohlenes Modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Benchmark starten';

  @override
  String get benchmark_screen_start_failed => 'Benchmark konnte nicht gestartet werden, der Fehlercode ist';

  @override
  String get benchmark_screen_models => 'Objekterkennungsmodelle';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Projekt verlassen bestätigen';

  @override
  String get project_screen_exit_confirm_content => 'Wenn Sie das Projekt verlassen, wird das Zählen gestoppt. Möchten Sie wirklich fortfahren?';

  @override
  String get project_screen_exit_button => 'Beenden';

  @override
  String get project_screen_add_video_button => 'Videoquelle hinzufügen';

  @override
  String get project_screen_from_desc => 'Wir führen einen kontinuierlichen 24-Stunden-Aufzeichnung, damit Sie jeden beliebigen Zeitabschnitt einsehen können.';

  @override
  String get project_screen_report_settings => 'Einstellungen';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Wählen Sie einen Filterbereich aus der Liste unten aus';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Die Endzeit muss größer als die Startzeit sein';

  @override
  String get filter_screen_error_custom => 'Benutzerdefiniert';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Ende';

  @override
  String get settings_screen_title => 'Einstellungen';

  @override
  String get settings_screen_desc => 'Legen Sie Projektname, Erkennungsparameter und Zählungslöschung fest.';

  @override
  String get settings_screen_project_id => 'Projekt-ID';

  @override
  String get settings_screen_project_name => 'Projektname';

  @override
  String get settings_screen_project_name_place_holder => 'Mariahilfer Straße oder Stadtpark';

  @override
  String get settings_screen_project_error => 'Der Projektname darf nicht leer sein';

  @override
  String get settings_screen_random_count_button => 'Zufällige Zählungen hinzufügen';

  @override
  String get settings_screen_reset_count_header => 'Alle Zählungen in diesem Projekt zurücksetzen';

  @override
  String get settings_screen_reset_count_button => 'Zählungen zurücksetzen';

  @override
  String get settings_screen_reset_count_content => 'Sind Sie sicher, dass Sie alle Zählungen zurücksetzen möchten?';

  @override
  String get settings_screen_delete_header => 'Dieses Projekt löschen';

  @override
  String get settings_screen_delete_content => 'Sind Sie sicher, dass Sie dieses Projekt löschen möchten?';

  @override
  String get settings_screen_delete_button => 'Löschen';

  @override
  String get settings_screen_center_point_title => 'Mittelpunkt auf Zielobjekt';

  @override
  String get settings_screen_center_point_desc => 'Der Mittelpunkt hilft bei der Bestimmung, ob sich das Zielobjekt innerhalb der Trefferzone befindet.';

  @override
  String get settings_screen_center_point_button => 'Mittelpunkt auf Zielobjekt anzeigen';

  @override
  String get settings_screen_lost_target_title => 'Verlorenes Zielobjekt';

  @override
  String get settings_screen_lost_target_desc => 'Wenn die Objektverfolgung ein Zielobjekt verliert, macht diese Option es sichtbar. Standardmäßig werden verlorene Zielobjekte nicht angezeigt.';

  @override
  String get settings_screen_lost_target_button => 'Verlorenes Zielobjekt anzeigen';

  @override
  String get detection_screen_title => 'Erkennungseinstellungen';

  @override
  String get detection_screen_models => 'Modelle';

  @override
  String get detection_screen_confidence => 'Konfidenz';

  @override
  String get detection_screen_confidence_desc => 'Konfidenz über #0 wird als gültige Erkennung betrachtet';

  @override
  String get detection_screen_low => 'Niedrig';

  @override
  String get detection_screen_high => 'Hoch';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Ein niedrigerer NMS-Schwellenwert (z.B. 30%) entfernt überlappende Begrenzungsrahmen aggressiver, während ein höherer NMS-Schwellenwert (z.B. 0,6) mehr Überlappung zulässt';

  @override
  String get detection_screen_match => 'Übereinstimmung';

  @override
  String get detection_screen_match_desc => 'Übereinstimmung über #0 wird als dasselbe Objekt betrachtet.';

  @override
  String get detection_screen_lost => 'Verloren';

  @override
  String get detection_screen_lost_desc => 'Verfolgtes Objekt wird entfernt, wenn es für #0 verloren geht';

  @override
  String get detection_screen_consider_valid => 'Als gültig betrachten nach';

  @override
  String get detection_screen_consider_valid_desc => 'Verfolgtes Objekt wird nach #0 als gültig betrachtet';

  @override
  String get detection_screen_reset => 'Zurücksetzen';

  @override
  String get detection_screen_reset_content => 'Sind Sie sicher, dass Sie die Erkennungseinstellungen zurücksetzen möchten?';

  @override
  String get url_screen_title => 'Live-Stream URL';

  @override
  String get url_screen_desc => 'Bitte geben Sie die Live-Stream URL ein';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://beispiel.at/stream oder rtsp://beispiel.at/stream';

  @override
  String get add_video_screen_title => 'Videoquelle hinzufügen';

  @override
  String get add_video_screen_from => 'Videoquelle hinzufügen von';

  @override
  String get webcam_screen_add_title => 'Webcam hinzufügen';

  @override
  String get webcam_screen_edit_title => 'Webcam auswählen';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Frontkamera';

  @override
  String get camera_screen_back_camera => 'Rückkamera';

  @override
  String get camera_screen_add_title => 'Kamera hinzufügen';

  @override
  String get camera_screen_edit_title => 'Kamera auswählen';

  @override
  String get camera_screen_zoom_level => 'Zoomstufe';

  @override
  String get video_screen_name_empty => 'Der Videoname darf nicht leer sein.';

  @override
  String get video_screen_desc => 'Videoquellen verwalten, Erkennungszonen hinzufügen oder bearbeiten.';

  @override
  String get video_screen_video_name => 'Videoquellenname';

  @override
  String get video_screen_edit_placeholder => 'Eingangstür-Kamera oder Parkplatz-Kamera';

  @override
  String get video_screen_change_file => 'Datei ändern';

  @override
  String get video_screen_add_zone => 'Erkennungszone hinzufügen';

  @override
  String get video_screen_zones => 'Erkennungszonen';

  @override
  String get video_screen_zones_desc => 'Verwenden Sie Drag & Drop, um Zonen anzupassen';

  @override
  String get video_screen_tools => 'Werkzeuge';

  @override
  String get video_screen_move_bottom => 'Aktuelle Zone nach unten verschieben';

  @override
  String get video_screen_add_point => 'Punkt zur aktuellen Zone hinzufügen';

  @override
  String get video_screen_remove_point => 'Punkt aus aktueller Zone entfernen';

  @override
  String get video_screen_playback_speed => 'Wiedergabegeschwindigkeit';

  @override
  String get video_screen_playback_current => 'aktuell: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Diese Videoquelle löschen';

  @override
  String get video_screen_delete_content => 'Sind Sie sicher, dass Sie diese Videoquelle löschen möchten?';

  @override
  String get video_screen_delete_button => 'Löschen';

  @override
  String get video_screen_sources => 'Bildquelle, Erkennungsziele und Modellparameter konfigurieren.';

  @override
  String get video_screen_targets => 'Erkennungsziele';

  @override
  String get video_screen_detection => 'Modellparameter';

  @override
  String get color_screen_title => 'Farbe auswählen';

  @override
  String get zone_screen_desc => 'Die Erkennungszone kann Objekttypen für die Erkennung festlegen und auswählen, welche Zähler angezeigt werden sollen, wie z.B. Erkannt, Erschienen und Eingetreten.';

  @override
  String get zone_screen_name_placeholder => 'Der Name der Zone, wie Gehsteig oder Parkplatz';

  @override
  String get zone_screen_zone_color => 'Zonenfarbe';

  @override
  String get zone_screen_color => 'Farbe';

  @override
  String get zone_screen_delete_header => 'Diese Zone löschen';

  @override
  String get zone_screen_delete_content => 'Sind Sie sicher, dass Sie diese Zone löschen möchten?';

  @override
  String get zone_screen_delete_button => 'Löschen';

  @override
  String get zone_screen_can_not_delete => 'Zone kann nicht gelöscht werden';

  @override
  String get zone_screen_one_zone_required => 'Mindestens eine Zone ist erforderlich.';

  @override
  String get zone_screen_zone_name_required => 'Der Zonenname darf nicht leer sein';

  @override
  String get counter_screen_show_on => 'Am Bildschirm anzeigen';

  @override
  String get counter_screen_enabled => 'Aktiviert';

  @override
  String get counter_screen_reentry_threshold => 'Wiedereintritts-Schwellenwert';

  @override
  String get counter_screen_reentry_desc => 'Objekte müssen #0 Mal eintreten, mit einer Abkühlung von #1 Sekunden zwischen jedem Austritt und Wiedereintritt, um einen Wiedereintritt auszulösen';

  @override
  String get counter_screen_reentry_title => 'Wiedereintritts-Zählung';

  @override
  String get counter_screen_cooldown_threshold => 'Abkühlungs-Schwellenwert';

  @override
  String get counter_screen_cooldown_desc => 'Wiedereintritt erfordert eine Abkühlung von #0 Sekunden nach Verlassen der Erkennungszone';

  @override
  String get counter_screen_cooldown_time => 'Abkühlungszeit';

  @override
  String get counter_screen_cooldown_in_seconds => 'in Sekunden';

  @override
  String get counter_screen_stagnant_threshold => 'Stillstands-Schwellenwert';

  @override
  String get counter_screen_stagnant_desc => 'Objekte, die länger als #0 Sekunden stillstehen, werden als stillstehend betrachtet';

  @override
  String get counter_screen_stagnant_consider => 'Als stillstehend betrachten';

  @override
  String get counter_screen_stagnant_in_seconds => 'in Sekunden';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beschreibungs-Präfix';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beschreibungs-Suffix';

  @override
  String get counter_screen_name_error => 'Der Zählername darf nicht leer sein';

  @override
  String get counter_screen_enabled_error => 'Fehler';

  @override
  String get counter_screen_enabled_error_content => 'Sie müssen zuerst einen anderen Zähler aktivieren, dann können Sie diesen Zähler deaktivieren';

  @override
  String get objects_screen_title => 'Objekte';

  @override
  String get objects_screen_desc => 'Wählen Sie Erkennungsziele wie Person, Auto, Bus, usw.';

  @override
  String get open_project_screen_title => 'Projekt öffnen';

  @override
  String get open_project_screen_desc => 'Öffnen Sie zuvor erstellte Projekte, wobei nur die letzten 20 behalten werden.';

  @override
  String get open_project_screen_no_project => 'Kein Projekt gefunden.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videoquelle';

  @override
  String get default_zone_name => 'Erkennungszone';

  @override
  String get error_oops => 'Hoppla, etwas ist schiefgelaufen';

  @override
  String get error_content => 'Ein unerwarteter Fehler ist aufgetreten. Möchten Sie einen E-Mail-Bericht senden?';

  @override
  String get error_report => 'E-Mail an uns';

  @override
  String get submit => 'Absenden';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get close => 'Schließen';

  @override
  String get back => 'Zurück';

  @override
  String get settings_screen_detection_button => 'MISSING';
}

/// The translations for German, as used in Switzerland (`de_CH`).
class LocalizationDeCh extends LocalizationDe {
  LocalizationDeCh(): super('de_CH');

  @override
  String get product_name => 'Zähler';

  @override
  String get product_desc => 'Verwendet Computervision und KI, um Personen, Fahrzeuge, Haustiere und mehr zu zählen.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'Live-Stream URL';

  @override
  String get video_sources_file => 'Datei';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nicht gefunden';

  @override
  String get video_sources_camera_not_found_message => 'Kamerazugriff muss gewährt werden, um die Kamera zu nutzen';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam nicht gefunden';

  @override
  String get video_sources_webcam_not_found_message => 'Bitte prüfen Sie, ob eine Webcam angeschlossen ist';

  @override
  String get wizard_screen_desc => 'Erstellen Sie ein neues Projekt, um mit dem Zählen zu beginnen.';

  @override
  String get wizard_screen_new_project_from => 'Neues Projekt aus';

  @override
  String get wizard_screen_language => 'Sprache';

  @override
  String get wizard_screen_about => 'Über';

  @override
  String get wizard_screen_open_projects_tip => 'Alle Projekte werden automatisch lokal gespeichert';

  @override
  String get wizard_screen_open_projects => 'Bestehendes Projekt öffnen';

  @override
  String get wizard_screen_email_us => 'E-Mail an uns';

  @override
  String get language_screen_language => 'Sprache';

  @override
  String get project_view_no_videos => 'Keine Videoquelle verfügbar.';

  @override
  String get about_screen_title => 'Über';

  @override
  String get about_screen_platform => 'Plattform';

  @override
  String get about_screen_app_version => 'App-Version';

  @override
  String get about_screen_models => 'Objekterkennungsmodelle';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build-Info';

  @override
  String get benchmark_screen_title => 'Modell-Benchmarks';

  @override
  String get benchmark_screen_recommended => 'Empfohlenes Modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Benchmark starten';

  @override
  String get benchmark_screen_start_failed => 'Benchmark konnte nicht gestartet werden, der Fehlercode ist';

  @override
  String get benchmark_screen_models => 'Objekterkennungsmodelle';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Projekt verlassen bestätigen';

  @override
  String get project_screen_exit_confirm_content => 'Beim Verlassen des Projekts wird die Zählung gestoppt. Möchten Sie fortfahren?';

  @override
  String get project_screen_exit_button => 'Verlassen';

  @override
  String get project_screen_add_video_button => 'Videoquelle hinzufügen';

  @override
  String get project_screen_from_desc => 'Wir führen einen fortlaufenden 24-Stunden-Verlauf, damit Sie jeden Zeitausschnitt ansehen können.';

  @override
  String get project_screen_report_settings => 'Einstellungen';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Wählen Sie einen Filterbereich aus der Liste unten';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Endzeit muss grösser als Startzeit sein';

  @override
  String get filter_screen_error_custom => 'Benutzerdefiniert';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'Ende';

  @override
  String get settings_screen_title => 'Einstellungen';

  @override
  String get settings_screen_desc => 'Projektnamen, Erkennungsparameter und Zählungsrücksetzung festlegen.';

  @override
  String get settings_screen_project_id => 'Projekt-ID';

  @override
  String get settings_screen_project_name => 'Projektname';

  @override
  String get settings_screen_project_name_place_holder => 'Bahnhofstrasse 123 oder Stadtpark';

  @override
  String get settings_screen_project_error => 'Der Projektname darf nicht leer sein';

  @override
  String get settings_screen_random_count_button => 'Zufällige Zählungen hinzufügen';

  @override
  String get settings_screen_reset_count_header => 'Alle Zählungen in diesem Projekt zurücksetzen';

  @override
  String get settings_screen_reset_count_button => 'Zählungen zurücksetzen';

  @override
  String get settings_screen_reset_count_content => 'Sind Sie sicher, dass Sie alle Zählungen zurücksetzen möchten?';

  @override
  String get settings_screen_delete_header => 'Dieses Projekt löschen';

  @override
  String get settings_screen_delete_content => 'Sind Sie sicher, dass Sie dieses Projekt löschen möchten?';

  @override
  String get settings_screen_delete_button => 'Löschen';

  @override
  String get settings_screen_center_point_title => 'Mittelpunkt auf Zielobjekt';

  @override
  String get settings_screen_center_point_desc => 'Der Mittelpunkt hilft zu bestimmen, ob sich das Ziel innerhalb der Trefferzone befindet.';

  @override
  String get settings_screen_center_point_button => 'Mittelpunkt auf Zielobjekt anzeigen';

  @override
  String get settings_screen_lost_target_title => 'Verlorenes Zielobjekt';

  @override
  String get settings_screen_lost_target_desc => 'Wenn die Objektverfolgung ein Ziel verliert, macht diese Option es sichtbar. Standardmässig werden verlorene Ziele nicht angezeigt.';

  @override
  String get settings_screen_lost_target_button => 'Verlorenes Zielobjekt anzeigen';

  @override
  String get detection_screen_title => 'Erkennungseinstellungen';

  @override
  String get detection_screen_models => 'Modelle';

  @override
  String get detection_screen_confidence => 'Konfidenz';

  @override
  String get detection_screen_confidence_desc => 'Konfidenz über #0 wird als gültige Erkennung betrachtet';

  @override
  String get detection_screen_low => 'Niedrig';

  @override
  String get detection_screen_high => 'Hoch';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Ein niedrigerer NMS-Schwellenwert (z.B. 30%) entfernt überlappende Begrenzungsrahmen aggressiver, während ein höherer NMS-Schwellenwert (z.B. 0,6) mehr Überlappung zulässt';

  @override
  String get detection_screen_match => 'Übereinstimmung';

  @override
  String get detection_screen_match_desc => 'Übereinstimmung über #0 wird als dasselbe Objekt betrachtet.';

  @override
  String get detection_screen_lost => 'Verloren';

  @override
  String get detection_screen_lost_desc => 'Verfolgtes Objekt wird entfernt, wenn es für #0 verloren ist';

  @override
  String get detection_screen_consider_valid => 'Als gültig betrachten nach';

  @override
  String get detection_screen_consider_valid_desc => 'Verfolgtes Objekt wird nach #0 als gültig betrachtet';

  @override
  String get detection_screen_reset => 'Zurücksetzen';

  @override
  String get detection_screen_reset_content => 'Sind Sie sicher, dass Sie die Erkennungseinstellungen zurücksetzen möchten?';

  @override
  String get url_screen_title => 'Live-Stream URL';

  @override
  String get url_screen_desc => 'Bitte geben Sie die Live-Stream URL ein';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://beispiel.com/stream oder rtsp://beispiel.com/stream';

  @override
  String get add_video_screen_title => 'Videoquelle hinzufügen';

  @override
  String get add_video_screen_from => 'Videoquelle hinzufügen von';

  @override
  String get webcam_screen_add_title => 'Webcam hinzufügen';

  @override
  String get webcam_screen_edit_title => 'Webcam auswählen';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Frontkamera';

  @override
  String get camera_screen_back_camera => 'Rückkamera';

  @override
  String get camera_screen_add_title => 'Kamera hinzufügen';

  @override
  String get camera_screen_edit_title => 'Kamera auswählen';

  @override
  String get camera_screen_zoom_level => 'Zoomstufe';

  @override
  String get video_screen_name_empty => 'Der Videoname darf nicht leer sein.';

  @override
  String get video_screen_desc => 'Verwalten Sie Videoquellen, fügen Sie Erkennungszonen hinzu oder ändern Sie sie.';

  @override
  String get video_screen_video_name => 'Name der Videoquelle';

  @override
  String get video_screen_edit_placeholder => 'Eingangskamera oder Parkplatzkamera';

  @override
  String get video_screen_change_file => 'Datei ändern';

  @override
  String get video_screen_add_zone => 'Erkennungszone hinzufügen';

  @override
  String get video_screen_zones => 'Erkennungszonen';

  @override
  String get video_screen_zones_desc => 'Verwenden Sie Drag and Drop, um Zonen anzupassen';

  @override
  String get video_screen_tools => 'Werkzeuge';

  @override
  String get video_screen_move_bottom => 'Aktuelle Zone nach unten verschieben';

  @override
  String get video_screen_add_point => 'Punkt zur aktuellen Zone hinzufügen';

  @override
  String get video_screen_remove_point => 'Punkt aus aktueller Zone entfernen';

  @override
  String get video_screen_playback_speed => 'Wiedergabegeschwindigkeit';

  @override
  String get video_screen_playback_current => 'aktuell: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Diese Videoquelle löschen';

  @override
  String get video_screen_delete_content => 'Sind Sie sicher, dass Sie diese Videoquelle löschen möchten?';

  @override
  String get video_screen_delete_button => 'Löschen';

  @override
  String get video_screen_sources => 'Bildquelle, Erkennungsziele und Modellparameter konfigurieren.';

  @override
  String get video_screen_targets => 'Erkennungsziele';

  @override
  String get video_screen_detection => 'Modellparameter';

  @override
  String get color_screen_title => 'Farbe auswählen';

  @override
  String get zone_screen_desc => 'In der Erkennungszone können Sie die Arten der zu erkennenden Objekte festlegen und auswählen, welche Zähler angezeigt werden sollen, wie z.B. Erkannt, Entstanden und Eingetreten.';

  @override
  String get zone_screen_name_placeholder => 'Der Name der Zone, wie Gehweg oder Parkplatz';

  @override
  String get zone_screen_zone_color => 'Zonenfarbe';

  @override
  String get zone_screen_color => 'Farbe';

  @override
  String get zone_screen_delete_header => 'Diese Zone löschen';

  @override
  String get zone_screen_delete_content => 'Sind Sie sicher, dass Sie diese Zone löschen möchten?';

  @override
  String get zone_screen_delete_button => 'Löschen';

  @override
  String get zone_screen_can_not_delete => 'Zone kann nicht gelöscht werden';

  @override
  String get zone_screen_one_zone_required => 'Mindestens eine Zone ist erforderlich.';

  @override
  String get zone_screen_zone_name_required => 'Der Zonenname darf nicht leer sein';

  @override
  String get counter_screen_show_on => 'Auf Bildschirm anzeigen';

  @override
  String get counter_screen_enabled => 'Aktiviert';

  @override
  String get counter_screen_reentry_threshold => 'Wiedereintritts-Schwellenwert';

  @override
  String get counter_screen_reentry_desc => 'Objekte müssen #0 mal eintreten, mit einer Abklingzeit von #1 Sekunden zwischen jedem Austritt und Wiedereintritt, um einen Wiedereintritt auszulösen';

  @override
  String get counter_screen_reentry_title => 'Wiedereintritts-Zählung';

  @override
  String get counter_screen_cooldown_threshold => 'Abklingzeit-Schwellenwert';

  @override
  String get counter_screen_cooldown_desc => 'Wiedereintritt erfordert eine Abklingzeit von #0 Sekunden nach Verlassen der Erkennungszone';

  @override
  String get counter_screen_cooldown_time => 'Abklingzeit';

  @override
  String get counter_screen_cooldown_in_seconds => 'in Sekunden';

  @override
  String get counter_screen_stagnant_threshold => 'Stillstands-Schwellenwert';

  @override
  String get counter_screen_stagnant_desc => 'Objekte, die länger als #0 Sekunden stillstehen, werden als stillstehend betrachtet';

  @override
  String get counter_screen_stagnant_consider => 'Als stillstehend betrachten';

  @override
  String get counter_screen_stagnant_in_seconds => 'in Sekunden';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Beschreibungs-Präfix';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Beschreibungs-Suffix';

  @override
  String get counter_screen_name_error => 'Der Zählername darf nicht leer sein';

  @override
  String get counter_screen_enabled_error => 'Fehler';

  @override
  String get counter_screen_enabled_error_content => 'Sie müssen zuerst einen anderen Zähler aktivieren, dann können Sie diesen Zähler deaktivieren';

  @override
  String get objects_screen_title => 'Objekte';

  @override
  String get objects_screen_desc => 'Wählen Sie Erkennungsziele wie Person, Auto, Bus usw.';

  @override
  String get open_project_screen_title => 'Projekt öffnen';

  @override
  String get open_project_screen_desc => 'Öffnen Sie zuvor erstellte Projekte, wobei nur die 20 neuesten behalten werden.';

  @override
  String get open_project_screen_no_project => 'Kein Projekt gefunden.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videoquelle';

  @override
  String get default_zone_name => 'Erkennungszone';

  @override
  String get error_oops => 'Hoppla, etwas ist schiefgelaufen';

  @override
  String get error_content => 'Ein unerwarteter Fehler ist aufgetreten. Möchten Sie einen E-Mail-Bericht senden?';

  @override
  String get error_report => 'E-Mail an uns';

  @override
  String get submit => 'Absenden';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get close => 'Schliessen';

  @override
  String get back => 'Zurück';

  @override
  String get settings_screen_detection_button => 'MISSING';
}
