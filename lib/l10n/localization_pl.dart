// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class LocalizationPl extends Localization {
  LocalizationPl([String locale = 'pl']) : super(locale);

  @override
  String get product_name => 'Licznik';

  @override
  String get product_desc => 'Wykorzystuje widzenie komputerowe i sztuczną inteligencję do liczenia osób, pojazdów, zwierząt i nie tylko.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Kamera internetowa';

  @override
  String get video_sources_live_stream => 'Adres URL transmisji na żywo';

  @override
  String get video_sources_file => 'Plik';

  @override
  String get video_sources_camera => 'Aparat';

  @override
  String get video_sources_camera_not_found_title => 'Nie znaleziono aparatu';

  @override
  String get video_sources_camera_not_found_message => 'Wymagane jest udzielenie uprawnień do korzystania z aparatu';

  @override
  String get video_sources_webcam_not_found_title => 'Nie znaleziono kamery internetowej';

  @override
  String get video_sources_webcam_not_found_message => 'Sprawdź, czy kamera internetowa jest podłączona';

  @override
  String get wizard_screen_desc => 'Utwórz nowy projekt, aby rozpocząć liczenie.';

  @override
  String get wizard_screen_new_project_from => 'Nowy projekt z';

  @override
  String get wizard_screen_language => 'Język';

  @override
  String get wizard_screen_about => 'O aplikacji';

  @override
  String get wizard_screen_open_projects_tip => 'Wszystkie projekty będą automatycznie zapisywane lokalnie';

  @override
  String get wizard_screen_open_projects => 'Otwórz istniejący projekt';

  @override
  String get wizard_screen_email_us => 'Napisz do nas';

  @override
  String get language_screen_language => 'Język';

  @override
  String get project_view_no_videos => 'Brak dostępnego źródła wideo.';

  @override
  String get about_screen_title => 'O aplikacji';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Wersja aplikacji';

  @override
  String get about_screen_models => 'Modele wykrywania obiektów';

  @override
  String get about_screen_benchmark => 'Test wydajności';

  @override
  String get about_screen_opencv_build_info => 'Informacje o kompilacji OpenCV';

  @override
  String get benchmark_screen_title => 'Testy wydajności modeli';

  @override
  String get benchmark_screen_recommended => 'Zalecany model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Rozpocznij test wydajności';

  @override
  String get benchmark_screen_start_failed => 'Nie udało się rozpocząć testu wydajności, kod błędu to';

  @override
  String get benchmark_screen_models => 'Modele wykrywania obiektów';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Potwierdź wyjście z projektu';

  @override
  String get project_screen_exit_confirm_content => 'Opuszczenie projektu zatrzyma liczenie. Czy na pewno chcesz kontynuować?';

  @override
  String get project_screen_exit_button => 'Wyjdź';

  @override
  String get project_screen_add_video_button => 'Dodaj źródło wideo';

  @override
  String get project_screen_from_desc => 'Przechowujemy historię z ostatnich 24 godzin, dzięki czemu możesz przeglądać dowolny przedział czasowy.';

  @override
  String get project_screen_report_settings => 'Ustawienia';

  @override
  String get filter_screen_title => 'Filtr';

  @override
  String get filter_screen_desc => 'Wybierz zakres filtrowania z poniższej listy';

  @override
  String get filter_screen_error_title => 'Filtr';

  @override
  String get filter_screen_error_content => 'Czas zakończenia musi być późniejszy niż czas rozpoczęcia';

  @override
  String get filter_screen_error_custom => 'Niestandardowy';

  @override
  String get filter_screen_error_start => 'Początek';

  @override
  String get filter_screen_error_end => 'Koniec';

  @override
  String get settings_screen_title => 'Ustawienia';

  @override
  String get settings_screen_desc => 'Ustaw nazwę projektu, parametry wykrywania, zerowanie liczników.';

  @override
  String get settings_screen_project_id => 'ID projektu';

  @override
  String get settings_screen_project_name => 'Nazwa projektu';

  @override
  String get settings_screen_project_name_place_holder => 'ul. Marszałkowska 123 lub Park Łazienkowski';

  @override
  String get settings_screen_project_error => 'Nazwa projektu nie może być pusta';

  @override
  String get settings_screen_random_count_button => 'Dodaj losowe liczniki';

  @override
  String get settings_screen_reset_count_header => 'Resetuj wszystkie liczniki w tym projekcie';

  @override
  String get settings_screen_reset_count_button => 'Resetuj liczniki';

  @override
  String get settings_screen_reset_count_content => 'Czy na pewno chcesz zresetować wszystkie liczniki?';

  @override
  String get settings_screen_delete_header => 'Usuń ten projekt';

  @override
  String get settings_screen_delete_content => 'Czy na pewno chcesz usunąć ten projekt?';

  @override
  String get settings_screen_delete_button => 'Usuń';

  @override
  String get settings_screen_center_point_title => 'Punkt centralny na celu';

  @override
  String get settings_screen_center_point_desc => 'Punkt centralny pomaga określić, czy cel znajduje się w strefie detekcji.';

  @override
  String get settings_screen_center_point_button => 'Pokaż punkt centralny na celu';

  @override
  String get settings_screen_lost_target_title => 'Zgubiony cel';

  @override
  String get settings_screen_lost_target_desc => 'Gdy śledzenie obiektu zgubi cel, ta opcja umożliwia jego wyświetlenie. Domyślnie zgubione cele nie są pokazywane.';

  @override
  String get settings_screen_lost_target_button => 'Pokaż zgubiony cel';

  @override
  String get detection_screen_title => 'Ustawienia wykrywania';

  @override
  String get detection_screen_models => 'Modele';

  @override
  String get detection_screen_confidence => 'Pewność';

  @override
  String get detection_screen_confidence_desc => 'pewność powyżej #0 jest uznawana za prawidłowe wykrycie';

  @override
  String get detection_screen_low => 'Niska';

  @override
  String get detection_screen_high => 'Wysoka';

  @override
  String get detection_screen_nms => 'Tłumienie nie-maksymalnych';

  @override
  String get detection_screen_nms_desc => '#0 Niższy próg NMS (np. 30%) będzie bardziej agresywnie usuwał nakładające się ramki, podczas gdy wyższy próg NMS (np. 0,6) pozwoli na większe nakładanie się';

  @override
  String get detection_screen_match => 'Dopasowanie';

  @override
  String get detection_screen_match_desc => 'Dopasowanie powyżej #0 jest uznawane za ten sam obiekt.';

  @override
  String get detection_screen_lost => 'Zgubiony';

  @override
  String get detection_screen_lost_desc => 'Śledzony obiekt zostanie usunięty, jeśli będzie zgubiony przez #0';

  @override
  String get detection_screen_consider_valid => 'Uznaj za prawidłowy po';

  @override
  String get detection_screen_consider_valid_desc => 'Śledzony obiekt będzie uznany za prawidłowy po #0';

  @override
  String get detection_screen_reset => 'Reset';

  @override
  String get detection_screen_reset_content => 'Czy na pewno chcesz zresetować ustawienia wykrywania?';

  @override
  String get url_screen_title => 'Adres URL transmisji na żywo';

  @override
  String get url_screen_desc => 'Wprowadź adres URL transmisji na żywo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream lub rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Dodaj źródło wideo';

  @override
  String get add_video_screen_from => 'Dodaj źródło wideo z';

  @override
  String get webcam_screen_add_title => 'Dodaj kamerę internetową';

  @override
  String get webcam_screen_edit_title => 'Wybierz kamerę internetową';

  @override
  String get webcam_manager_webcam => 'Kamera internetowa';

  @override
  String get camera_screen_front_camera => 'Przedni aparat';

  @override
  String get camera_screen_back_camera => 'Tylny aparat';

  @override
  String get camera_screen_add_title => 'Dodaj aparat';

  @override
  String get camera_screen_edit_title => 'Wybierz aparat';

  @override
  String get camera_screen_zoom_level => 'Poziom przybliżenia';

  @override
  String get video_screen_name_empty => 'Nazwa źródła wideo nie może być pusta.';

  @override
  String get video_screen_desc => 'Zarządzaj źródłami wideo, dodawaj lub modyfikuj strefy wykrywania.';

  @override
  String get video_screen_video_name => 'Nazwa źródła wideo';

  @override
  String get video_screen_edit_placeholder => 'Kamera przy drzwiach frontowych lub Kamera na parkingu';

  @override
  String get video_screen_change_file => 'Zmień plik';

  @override
  String get video_screen_add_zone => 'Dodaj strefę wykrywania';

  @override
  String get video_screen_zones => 'Strefy wykrywania';

  @override
  String get video_screen_zones_desc => 'Użyj przeciągnij i upuść, aby dostosować strefy';

  @override
  String get video_screen_tools => 'Narzędzia';

  @override
  String get video_screen_move_bottom => 'Przenieś bieżącą strefę na dół';

  @override
  String get video_screen_add_point => 'Dodaj punkt do bieżącej strefy';

  @override
  String get video_screen_remove_point => 'Usuń punkt z bieżącej strefy';

  @override
  String get video_screen_playback_speed => 'Szybkość odtwarzania';

  @override
  String get video_screen_playback_current => 'obecnie: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Usuń to źródło wideo';

  @override
  String get video_screen_delete_content => 'Czy na pewno chcesz usunąć to źródło wideo?';

  @override
  String get video_screen_delete_button => 'Usuń';

  @override
  String get video_screen_sources => 'Skonfiguruj źródło obrazu, cele wykrywania i parametry modelu.';

  @override
  String get video_screen_targets => 'Cele wykrywania';

  @override
  String get video_screen_detection => 'Parametry modelu';

  @override
  String get color_screen_title => 'Wybierz kolor';

  @override
  String get zone_screen_desc => 'W strefie wykrywania można ustawić typy obiektów do wykrycia i wybrać, które liczniki wyświetlać, takie jak Wykryte, Utworzone i Weszły.';

  @override
  String get zone_screen_name_placeholder => 'Nazwa strefy, np. Chodnik lub Parking';

  @override
  String get zone_screen_zone_color => 'Kolor strefy';

  @override
  String get zone_screen_color => 'Kolor';

  @override
  String get zone_screen_delete_header => 'Usuń tę strefę';

  @override
  String get zone_screen_delete_content => 'Czy na pewno chcesz usunąć tę strefę?';

  @override
  String get zone_screen_delete_button => 'Usuń';

  @override
  String get zone_screen_can_not_delete => 'Nie można usunąć strefy';

  @override
  String get zone_screen_one_zone_required => 'Wymagana jest co najmniej jedna strefa.';

  @override
  String get zone_screen_zone_name_required => 'Nazwa strefy nie może być pusta';

  @override
  String get counter_screen_show_on => 'Pokaż na ekranie';

  @override
  String get counter_screen_enabled => 'Włączone';

  @override
  String get counter_screen_reentry_threshold => 'Próg ponownego wejścia';

  @override
  String get counter_screen_reentry_desc => 'Obiekty muszą wejść #0 razy, z #1 sekundowym czasem odnowienia między każdym wyjściem i ponownym wejściem, aby wywołać ponowne wejście';

  @override
  String get counter_screen_reentry_title => 'Licznik ponownych wejść';

  @override
  String get counter_screen_cooldown_threshold => 'Próg czasu odnowienia';

  @override
  String get counter_screen_cooldown_desc => 'Ponowne wejście wymaga #0 sekundowego czasu odnowienia po opuszczeniu strefy wykrywania';

  @override
  String get counter_screen_cooldown_time => 'Czas odnowienia';

  @override
  String get counter_screen_cooldown_in_seconds => 'w sekundach';

  @override
  String get counter_screen_stagnant_threshold => 'Próg bezruchu';

  @override
  String get counter_screen_stagnant_desc => 'Obiekty pozostające w bezruchu przez ponad #0 sekund będą uznawane za nieruchome';

  @override
  String get counter_screen_stagnant_consider => 'Uznaj za nieruchomy';

  @override
  String get counter_screen_stagnant_in_seconds => 'w sekundach';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Przedrostek opisu';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Przyrostek opisu';

  @override
  String get counter_screen_name_error => 'Nazwa licznika nie może być pusta';

  @override
  String get counter_screen_enabled_error => 'Błąd';

  @override
  String get counter_screen_enabled_error_content => 'Musisz najpierw włączyć inny licznik, a następnie możesz wyłączyć ten licznik';

  @override
  String get objects_screen_title => 'Obiekty';

  @override
  String get objects_screen_desc => 'Wybierz cele do wykrycia, takie jak osoba, samochód, autobus itp.';

  @override
  String get open_project_screen_title => 'Otwórz projekt';

  @override
  String get open_project_screen_desc => 'Otwórz wcześniej utworzone projekty, zachowując tylko 20 najnowszych.';

  @override
  String get open_project_screen_no_project => 'Nie znaleziono projektu.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Źródło wideo';

  @override
  String get default_zone_name => 'Strefa wykrywania';

  @override
  String get error_oops => 'Ups, coś poszło nie tak';

  @override
  String get error_content => 'Wystąpił nieoczekiwany błąd. Czy chcesz wysłać raport e-mail?';

  @override
  String get error_report => 'Napisz do nas';

  @override
  String get submit => 'Wyślij';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anuluj';

  @override
  String get yes => 'Tak';

  @override
  String get no => 'Nie';

  @override
  String get close => 'Zamknij';

  @override
  String get back => 'Wstecz';

  @override
  String get zone_screen_zone => 'Strefa';

  @override
  String get zone_screen_zone_show_summary => 'Pokaż podsumowanie na ekranie';

  @override
  String get video_sources_photos_denied => 'Odmowa dostępu do zdjęć';

  @override
  String get video_sources_photos_goto_settings => 'Przejdź do ustawień';

  @override
  String get video_sources_camera_denied => 'Odmowa dostępu do kamery';

  @override
  String get video_sources_photos_denied_msg => 'Przejdź do ustawień i zezwól na dostęp do zdjęć dla tej aplikacji.';

  @override
  String get video_sources_camera_denied_msg => 'Przejdź do ustawień i zezwól na dostęp do kamery dla tej aplikacji.';
}
