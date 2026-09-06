// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class LocalizationPl extends Localization {
  LocalizationPl([String locale = 'pl']) : super(locale);

  @override
  String get about_screen_app_version => 'Wersja aplikacji';

  @override
  String get about_screen_email_us => 'Napisz do nas';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get appeared => 'Pojawili się';

  @override
  String get appeared_help =>
      'Zlicza osoby lub pojazdy, których pierwsza wykryta pozycja znajdowała się w tym obszarze.\\n\\nPomaga zrozumieć, gdzie rozpoczyna się śledzenie.\\n\\n(Głównie dla zaawansowanych użytkowników)';

  @override
  String get average_occupancy => 'Średnia liczba osób';

  @override
  String get average_occupancy_help =>
      'Pokazuje średnią liczbę osób lub pojazdów w tym obszarze podczas bieżącego okna zliczania.\\n\\nPomaga ocenić, jak ruchliwy był ten obszar przez cały okres zliczania.';

  @override
  String get average_stay => 'Średni czas pobytu';

  @override
  String get average_stay_help =>
      'Pokazuje średni czas przebywania osób lub pojazdów w tym obszarze.\\n\\nDłuższy średni czas pobytu może oznaczać, że klienci spędzają więcej czasu w tym miejscu.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter używa kamery i AI działającej na urządzeniu do liczenia osób. Najpierw sprawdźmy, czy Twoje urządzenie jest zgodne.';

  @override
  String get camera_test_screen_instruction =>
      'Skieruj kamerę na ludzi. Aplikacja narysuje ramki wokół wykrytych osób.';

  @override
  String get camera_test_screen_next => 'Dotknij Dalej, aby kontynuować.';

  @override
  String get camera_test_screen_start =>
      'Dotknij Rozpocznij. Jeśli pojawi się monit, zezwól na dostęp do aparatu.';

  @override
  String get camera_test_screen_test_failed => 'Test nie powiódł się!';

  @override
  String get camera_test_screen_test_passed => 'Test zakończony pomyślnie!';

  @override
  String get camera_test_screen_title => 'Test kamery AI';

  @override
  String get camera_test_screen_wait =>
      'Oczekiwanie na wykrycie osób przez AI…';

  @override
  String get cta_screen_custom => 'Użyj własnego serwera';

  @override
  String get cta_screen_custom_help =>
      'Wysyłaj dane o ruchu bezpośrednio do własnego backendu lub bazy danych.';

  @override
  String get cta_screen_footer =>
      'Kontynuując, akceptujesz Warunki korzystania z usługi, Politykę prywatności oraz Umowę przetwarzania danych.';

  @override
  String get cta_screen_invitation => 'Użyj kodu zaproszenia';

  @override
  String get cta_screen_invitation_help =>
      'Dołącz do istniejącej organizacji za pomocą zaproszenia od administratora.';

  @override
  String get cta_screen_local => 'Tylko na tym urządzeniu';

  @override
  String get cta_screen_local_help =>
      'Przechowuj dane o ruchu tylko na tym urządzeniu. Żadne dane nie są przesyłane.';

  @override
  String get cta_screen_piyuo => 'Użyj Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Przechowuj dane o ruchu w Piyuo Cloud z pulpitami i analizami biznesowymi.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter tworzy anonimowe statystyki ruchu co 5 minut.\\nWybierz sposób przechowywania i dostępu do swoich danych.';

  @override
  String get current_occupancy => 'Aktualna liczba';

  @override
  String get current_occupancy_help =>
      'Pokazuje aktualną liczbę osób lub pojazdów w tym obszarze.\\n\\nTa liczba jest aktualizowana w czasie rzeczywistym i pomaga sprawdzić, czy wykrywanie AI odpowiada temu, co widać na ekranie. Nie jest uwzględniana w przesyłanych danych telemetrycznych.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Zapisywanie...';

  @override
  String get custom_server_screen_server_url_label => 'Adres URL serwera';

  @override
  String get detection_screen_confidence => 'Próg pewności';

  @override
  String get detection_screen_confidence_dialog =>
      'Określa, jak pewna musi być sztuczna inteligencja przed policzeniem osoby lub pojazdu.\\nNiższe wartości\\n• Wykrywają więcej obiektów\\n• Lepsze dla odległych lub częściowo zasłoniętych obiektów\\n• Mogą zwiększyć liczbę błędnych wykryć\\nWyższe wartości\\n• Liczą tylko wykrycia o wysokiej pewności\\n• Zmniejszają liczbę błędnych wykryć\\n• Mogą pomijać małe lub trudne obiekty\\nUżyj niższej wartości, jeśli aplikacja pomija osoby lub pojazdy.\\nUżyj wyższej wartości, jeśli aplikacja liczy cienie, odbicia lub inne błędne obiekty.';

  @override
  String get detection_screen_confidence_help =>
      'Minimalny poziom pewności wymagany do wykrycia obiektu.';

  @override
  String get detection_screen_confidence_max_label => 'Ścisły';

  @override
  String get detection_screen_confidence_min_label => 'Luźny';

  @override
  String get detection_screen_disappear => 'Limit czasu zniknięcia';

  @override
  String get detection_screen_disappear_dialog =>
      'Określa, jak długo AI czeka przed oznaczeniem obiektu jako zniknięty po tym, jak przestaje być wykrywany.\\nKrótsze wartości\\n• Szybciej oznaczają obiekty jako zniknięte\\n• Lepsze dla szybkiego ruchu\\n• Mogą błędnie oznaczyć tymczasowo zasłonięte obiekty jako zniknięte\\nDłuższe wartości\\n• Czekają dłużej przed oznaczeniem obiektów jako zniknięte\\n• Lepsze, gdy obiekty są krótko zablokowane lub pominięte\\n• Opóźniają zdarzenia zniknięcia';

  @override
  String get detection_screen_disappear_help =>
      'Jak długo AI czeka przed oznaczeniem obiektu jako znikniętego po utracie wykrywania.';

  @override
  String get detection_screen_disappear_max_label => 'Wolno';

  @override
  String get detection_screen_disappear_min_label => 'Szybko';

  @override
  String get detection_screen_memory_dialog =>
      'Określa, jak długo AI pamięta obiekt po jego zniknięciu.\\nZwiększ tę wartość, jeśli osoby lub pojazdy są często zasłonięte przez inne obiekty.\\nZmniejsz tę wartość, jeśli obiekty są błędnie łączone po opuszczeniu sceny.';

  @override
  String get detection_screen_min_presence => 'Minimalny czas obecności';

  @override
  String get detection_screen_min_presence_help =>
      'Obiekt musi pozostać widoczny, zanim zostanie zliczony. Wyższe wartości pomagają ograniczyć krótkotrwałe błędne wykrycia.';

  @override
  String get detection_screen_min_presence_max_label => 'Bezpieczniej';

  @override
  String get detection_screen_min_presence_min_label => 'Szybciej';

  @override
  String get detection_screen_minimum_visible =>
      'Obiekty muszą pozostać widoczne przez ten czas, zanim zostaną policzone.\\nZwiększ tę wartość, aby zignorować krótkie błędne wykrycia.\\nZmniejsz tę wartość, jeśli szybko poruszające się osoby lub pojazdy są pomijane.';

  @override
  String get detection_screen_new_track => 'Próg nowego śledzenia';

  @override
  String get detection_screen_new_track_help =>
      'Minimalny poziom pewności wymagany do rozpoczęcia śledzenia nowego obiektu. Niższe wartości mogą tworzyć zduplikowane śledzenia.';

  @override
  String get detection_screen_new_track_max_label => 'Zachowawczy';

  @override
  String get detection_screen_new_track_min_label => 'Agresywny';

  @override
  String get detection_screen_reset => 'Reset';

  @override
  String get detection_screen_reset_content =>
      'Czy na pewno chcesz zresetować ustawienia wykrywania?';

  @override
  String get detection_screen_show_track_id => 'Pokaż ID śledzenia';

  @override
  String get detection_screen_show_track_id_help =>
      'Włącz tę opcję, aby wyświetlić unikalne identyfikatory śledzenia dla każdego śledzonego obiektu.';

  @override
  String get detection_screen_stay => 'Czas pobytu';

  @override
  String get detection_screen_stay_help =>
      'Jak długo obiekt musi pozostać w obszarze, zanim zostanie uznany za pobyt.';

  @override
  String get detection_screen_stay_max_label => 'Opóźnione';

  @override
  String get detection_screen_stay_min_label => 'Natychmiast';

  @override
  String get detection_screen_stay_threshold =>
      'Określa, kiedy obiekt wpływa na liczbę Pobytu.\\nKrótsze wartości\\n• Liczą pobyt natychmiast\\n• Lepsze do szybkiej analizy\\nDłuższe wartości\\n• Ignorują krótki ruch przelotowy\\n• Lepsze do pomiaru obłożenia';

  @override
  String get detection_screen_subtitle =>
      'Dostosuj sposób wykrywania i śledzenia obiektów przez AI.';

  @override
  String get detection_screen_title => 'Śledzenie i zliczanie';

  @override
  String get detection_screen_track_dialog =>
      'Określa, kiedy nowo wykryty obiekt staje się nowym śladem.\\nNiższe wartości\\n• Śledzenie zaczyna się szybciej\\n• Lepsze dla szybko poruszających się obiektów\\n• Mogą tworzyć zduplikowane ślady\\nWyższe wartości\\n• Wymagają silniejszych dowodów przed utworzeniem nowego śladu\\n• Zmniejszają liczbę zduplikowanych śladów\\n• Mogą opóźniać śledzenie nowych obiektów';

  @override
  String get detection_screen_track_memory => 'Pamięć śledzenia';

  @override
  String get detection_screen_track_memory_help =>
      'Jak długo śledzić obiekt po jego chwilowym zniknięciu. Wyższe wartości pomagają odzyskać śledzenie po krótkim zasłonięciu.';

  @override
  String get detection_screen_track_memory_max_label => 'Długi';

  @override
  String get detection_screen_track_memory_min_label => 'Krótki';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter używa aparatu do wykrywania pieszych i pojazdów w czasie rzeczywistym. To urządzenie nie ma dostępnego aparatu.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Spróbuj otworzyć tę aplikację na swoim telefonie';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Smartfon lub tablet z aparatem';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Zalecane urządzenie z iOS lub Android';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Czego potrzebujesz';

  @override
  String get device_not_supported_screen_title => 'Nie znaleziono aparatu';

  @override
  String get disappeared => 'Zniknęli';

  @override
  String get disappeared_help =>
      'Zlicza osoby lub pojazdy, których ostatnia wykryta pozycja znajdowała się w tym obszarze.\\n\\nŚledzenie kończy się po ustawionym czasie zniknięcia, jeśli osoba lub pojazd nie jest już wykrywany.\\n\\n(Głównie dla zaawansowanych użytkowników)';

  @override
  String get dpa => 'Umowa przetwarzania danych';

  @override
  String get durationDaysShort => '%sd';

  @override
  String get durationHoursShort => '%sgodz.';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ssek';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Weszli';

  @override
  String get entered_help =>
      'Zlicza osoby lub pojazdy, które weszły do tego obszaru podczas bieżącego okna zliczania.\\n\\nWejście jest liczone, gdy osoba lub pojazd przemieszcza się z zewnątrz do wnętrza obszaru.';

  @override
  String get exited => 'Wyszli';

  @override
  String get exited_help =>
      'Zlicza osoby lub pojazdy, które opuściły ten obszar podczas bieżącego okna zliczania.\\n\\nWyjście jest liczone, gdy osoba lub pojazd przemieszcza się z wnętrza obszaru na zewnątrz.';

  @override
  String get language_screen_language => 'Język';

  @override
  String get language_screen_subtitle => 'Wybierz język używany w aplikacji.';

  @override
  String get local_only_screen_body =>
      'Tryb Tylko urządzenie lokalne pozwala wypróbować wykrywanie i śledzenie kamerą AI bez przesyłania jakichkolwiek danych. Wszystkie statystyki ruchu pieszych są przetwarzane wyłącznie na tym urządzeniu, świetne rozwiązanie do testów przed połączeniem z serwerem.';

  @override
  String get local_only_screen_use_action => 'Użyj tylko urządzenia lokalnego';

  @override
  String get local_screen_text =>
      'Piyuo Counter będzie działać całkowicie na tym urządzeniu.\\nStatystyki ruchu będą przechowywane tylko na tym urządzeniu i nie będą przesyłane.\\nPóźniej możesz połączyć się z Piyuo Cloud lub własnym serwerem w Ustawieniach.';

  @override
  String get maximum_occupancy => 'Maksymalna liczba osób';

  @override
  String get maximum_occupancy_help =>
      'Pokazuje największą liczbę osób lub pojazdów znajdujących się jednocześnie w tym obszarze podczas bieżącego okna zliczania.\\n\\nPomaga określić okresy największego ruchu.';

  @override
  String get maximum_stay => 'Maksymalny czas pobytu';

  @override
  String get maximum_stay_help =>
      'Pokazuje najdłuższy czas przebywania osoby lub pojazdu w tym obszarze podczas bieżącego okna zliczania.\\n\\nPomaga wykryć wyjątkowo długie wizyty lub postoje.';

  @override
  String get metric_events => 'Zdarzenia';

  @override
  String get metric_live => 'Na żywo';

  @override
  String get metric_show_less => 'Pokaż mniej';

  @override
  String get metric_show_more => 'Pokaż więcej';

  @override
  String get metric_statistics => 'Statystyki';

  @override
  String get metrics_counting_all => 'Wszystkie';

  @override
  String get metrics_counting_done => 'Ukończone';

  @override
  String get metrics_counting_in_progress => 'W toku';

  @override
  String get metrics_counting_missing => 'Brakujące';

  @override
  String get metrics_counting_window =>
      'Statystyki dla każdego 5-minutowego okresu';

  @override
  String get onboarding_back_action => 'Wstecz';

  @override
  String get onboarding_cta_no_server => 'Nie chcesz przesyłać danych?';

  @override
  String get onboarding_cta_title => 'Dokąd mają trafiać Twoje dane?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter korzysta z kamery Twojego urządzenia i wbudowanej AI, by na bieżąco rozpoznawać ludzi i pojazdy.\\nDzięki technologii detekcji i śledzenia automatycznie liczy ruch pieszych i pojazdów — wszystko dzieje się bezpośrednio na Twoim urządzeniu.';

  @override
  String get onboarding_intro_text2 =>
      'Całe przetwarzanie AI odbywa się lokalnie na Twoim urządzeniu. Żadne wideo, zdjęcia, twarze ani tożsamości nie są przesyłane.\\nUdostępniane są tylko anonimowe podsumowania co 5 minut, zawierające statystyki liczby osób, obłożenia, wejść, wyjść i czasu przebywania.';

  @override
  String get onboarding_intro_text3 =>
      'Wystarczy uruchomić aplikację i zostawić ją włączoną. Piyuo Counter automatycznie i nieprzerwanie zbiera oraz zapisuje dane o ruchu.\\nPodsumowania danych są zapisywane co 5 minut i przesyłane co godzinę do Piyuo Cloud lub Twojego własnego serwera.';

  @override
  String get onboarding_intro_title1 => 'Zliczanie ruchu przez AI';

  @override
  String get onboarding_intro_title2 => 'Prywatność przede wszystkim';

  @override
  String get onboarding_intro_title3 => 'Działa automatycznie 24/7';

  @override
  String get onboarding_next_action => 'Dalej';

  @override
  String get onboarding_skip_action => 'Pomiń wprowadzenie';

  @override
  String get onboarding_start_action => 'Rozpocznij';

  @override
  String get passed_by => 'Przeszli';

  @override
  String get passed_by_help =>
      'Zlicza osoby lub pojazdy, które przeszły przez ten obszar podczas bieżącego okna zliczania.\\n\\nKażda osoba lub pojazd jest liczona tylko raz przy każdym przejściu przez obszar.';

  @override
  String get payloads_screen_area => 'Obszar';

  @override
  String get payloads_screen_confidence => 'Zaufanie';

  @override
  String get payloads_screen_coverage => 'Pokrycie';

  @override
  String get payloads_screen_delivered => 'Dostarczono';

  @override
  String get payloads_screen_failed_load =>
      'Nie udało się załadować ostatnich payloadów';

  @override
  String get payloads_screen_frame_processed => 'Przetworzone klatki';

  @override
  String get payloads_screen_hour_not_exists => 'Ta godzina już nie istnieje.';

  @override
  String get payloads_screen_missing_time => 'Utracony czas';

  @override
  String get payloads_screen_no_payloads => 'Brak payloadów.';

  @override
  String get payloads_screen_partial =>
      'Okno zakończyło się wcześniej (częściowe)';

  @override
  String get payloads_screen_partially => 'Częściowo dostarczono';

  @override
  String get payloads_screen_payload_not_exists =>
      'Ten payload już nie istnieje.';

  @override
  String get payloads_screen_pending => 'Oczekuje na dostarczenie';

  @override
  String get payloads_screen_process_fps => 'Przetwarzanie FPS';

  @override
  String get payloads_screen_resend => 'Wyślij ponownie';

  @override
  String get payloads_screen_select_first =>
      'Najpierw wybierz co najmniej jedną datę lub godzinę.';

  @override
  String get payloads_screen_subtitle =>
      'Wybierz datę lub godzinę do ponownego wysłania';

  @override
  String get payloads_screen_title => 'Ostatnie payloady';

  @override
  String get personal_custom_screen_build_server =>
      'Potrzebujesz pomocy z konfiguracją własnego serwera?\\nZobacz naszą dokumentację API i przykłady serwerów.';

  @override
  String get personal_custom_screen_help_action => 'Otwórz dokumentację API';

  @override
  String get personal_custom_screen_reset_action => 'Zacznij od nowa';

  @override
  String get personal_custom_success_screen_help =>
      'Naciśnij Start poniżej, aby rozpocząć zliczanie.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Statystyki ruchu są automatycznie przesyłane co godzinę.\\nMożesz też przesłać je ręcznie z ekranu Dziennik przesyłania.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Twój serwer nie musi być jeszcze online.\\nRozpocznij zliczanie już teraz. Później możesz dokończyć budowę i testowanie swojego serwera. Statystyki ruchu pozostaną na tym urządzeniu do czasu ich pomyślnego przesłania.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Statystyki ruchu zostaną wysłane do';

  @override
  String get personal_custom_success_screen_title => 'Serwer jest gotowy';

  @override
  String get piyuo_server_screen_cloud_url_label =>
      'Twój adres URL Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Kopiuj URL';

  @override
  String get piyuo_server_screen_copy_success => 'Skopiowano URL';

  @override
  String get piyuo_server_screen_saving_action => 'Zapisywanie...';

  @override
  String get piyuo_server_screen_start =>
      'Naciśnij poniżej \"Start\", aby rozpocząć zliczanie.';

  @override
  String get piyuo_server_screen_url_help =>
      'Twój osobisty pulpit Piyuo Cloud jest dostępny pod tym adresem URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Zapisz ten adres URL, aby uzyskać dostęp do pulpitu ruchu z innego urządzenia.';

  @override
  String get piyuo_server_screen_use_action => 'Użyj Piyuo Cloud';

  @override
  String get privacy => 'Polityka prywatności';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'Zliczanie osób i pojazdów z wykorzystaniem AI.';

  @override
  String get settings_screen_custom_subtitle =>
      'Wysyłaj dane o ruchu bezpośrednio do własnego backendu lub bazy danych.';

  @override
  String get settings_screen_custom_title => 'Użyj własnego serwera';

  @override
  String get settings_screen_data_server_label => 'Serwer danych';

  @override
  String get settings_screen_detection_target => 'Cel wykrywania';

  @override
  String get settings_screen_language_title => 'Język';

  @override
  String get settings_screen_local_subtitle =>
      'Przechowuj dane o ruchu tylko na tym urządzeniu. Nic nie będzie przesyłane.';

  @override
  String get settings_screen_local_title => 'Tylko urządzenie lokalne';

  @override
  String get settings_screen_misc_label => 'Różne';

  @override
  String get settings_screen_object_detection => 'Wykrywanie obiektów';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Przechowuj dane o ruchu w Piyuo Cloud z pulpitami i analizami biznesowymi.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Spowoduje to usunięcie wszystkich danych i rozpoczęcie od nowa. Tej operacji nie można cofnąć.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Zresetować wszystkie dane?';

  @override
  String get settings_screen_subscription_body =>
      'Zarządzaj subskrypcją i danymi rozliczeniowymi';

  @override
  String get settings_screen_subscription_title => 'Subskrypcja';

  @override
  String get start_screen_about => 'O aplikacji';

  @override
  String get start_screen_server_none =>
      'Dane są przechowywane tylko na tym urządzeniu';

  @override
  String get start_screen_server_personal => 'Dane są przesyłane co godzinę do';

  @override
  String get start_screen_settings => 'Ustawienia';

  @override
  String get start_screen_upload_logs => 'Prześlij logi';

  @override
  String get start_screen_video_sources => 'Źródła wideo';

  @override
  String get stayed => 'Pozostali';

  @override
  String get stayed_help =>
      'Zlicza osoby lub pojazdy, które pozostały w tym obszarze przez co najmniej ustawiony czas przebywania.\\n\\nDomyślny czas przebywania wynosi 15 sekund i można go zmienić w Ustawieniach.';

  @override
  String get target_pedestrian => 'Pieszy';

  @override
  String get target_pedestrian_help =>
      'Licz osoby za pomocą modelu wykrywania pieszych';

  @override
  String get target_screen_subtitle =>
      'Wybierz model wykrywania, którego chcesz użyć';

  @override
  String get target_vehicle => 'Pojazd';

  @override
  String get target_vehicle_help =>
      'Licz samochody i inne pojazdy za pomocą modelu wykrywania pojazdów';

  @override
  String get telemetry_error_connection_refused =>
      'Nie udało się połączyć z serwerem. Może być obecnie niedostępny.';

  @override
  String get telemetry_error_connection_reset =>
      'Połączenie zostało zresetowane. Sprawdź połączenie internetowe i spróbuj ponownie.';

  @override
  String get telemetry_error_connection_timeout =>
      'Połączenie zbyt długo nie odpowiadało. Sprawdź połączenie internetowe i spróbuj ponownie.';

  @override
  String get telemetry_error_database_error =>
      'Zapis do bazy danych nie powiódł się.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Nie znaleziono adresu serwera. Sprawdź połączenie internetowe lub adres URL serwera.';

  @override
  String get telemetry_error_http_error_status =>
      'Serwer odrzucił żądanie. Spróbuj ponownie później.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Wystąpił nieoczekiwany błąd podczas komunikacji z serwerem.';

  @override
  String get telemetry_error_invalid_url =>
      'Adres serwera jest nieprawidłowy. Sprawdź ustawienia.';

  @override
  String get telemetry_error_network_error =>
      'Wystąpił błąd sieci. Sprawdź połączenie internetowe i spróbuj ponownie.';

  @override
  String get telemetry_error_socket_error =>
      'Wystąpił problem z połączeniem sieciowym. Sprawdź połączenie internetowe.';

  @override
  String get telemetry_error_transport_exception =>
      'Coś poszło nie tak podczas wysyłania danych. Spróbuj ponownie.';

  @override
  String get telemetry_error_unknown_error => 'Wystąpił nieoczekiwany błąd.';

  @override
  String get terms => 'Warunki korzystania z usługi';

  @override
  String get upload_screen_attempt_time => 'Czas próby:';

  @override
  String get upload_screen_error => 'Błąd:';

  @override
  String get upload_screen_failed => 'Niepowodzenie';

  @override
  String get upload_screen_load_error =>
      'Nie udało się załadować dzienników przesyłania.';

  @override
  String get upload_screen_log_not_exists =>
      'Dziennik przesyłania nie jest już dostępny.';

  @override
  String get upload_screen_next => 'Następne przesyłanie o ...';

  @override
  String get upload_screen_next_upload_prefix => 'Następne przesyłanie o ';

  @override
  String get upload_screen_no_data_server => 'Najpierw ustaw serwer danych.';

  @override
  String get upload_screen_no_logs => 'Brak historii przesyłania.';

  @override
  String get upload_screen_payload_count => 'Liczba payloadów';

  @override
  String get upload_screen_payload_count_label => 'Liczba payloadów:';

  @override
  String get upload_screen_payload_size => 'Rozmiar payloadu:';

  @override
  String get upload_screen_result => 'Wynik:';

  @override
  String get upload_screen_retry => 'Liczba ponowień:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Sukces';

  @override
  String get upload_screen_today => 'Dzisiaj';

  @override
  String get upload_screen_upload_now => 'Prześlij teraz';

  @override
  String get upload_screen_upload_success => 'Przesłano pomyślnie.';

  @override
  String get upload_screen_uploading => 'Przesyłanie...';

  @override
  String get upload_screen_yesterday => 'Wczoraj';

  @override
  String get url_screen_invalid_rtsp_error =>
      'Adresy RTSP muszą zawierać nazwę hosta.';

  @override
  String get url_screen_invalid_url_error =>
      'Wprowadź prawidłowy adres URL z obsługiwanym schematem.';

  @override
  String get url_screen_subtitle => 'Wprowadź adres URL transmisji na żywo';

  @override
  String get url_screen_title => 'Adres URL transmisji na żywo';

  @override
  String get url_screen_unsupported_scheme_error => 'Seules les URL HTTP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Wprowadź adres URL transmisji na żywo.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream lub rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Tylny aparat';

  @override
  String get video_sources_camera => 'Aparat';

  @override
  String get video_sources_file => 'Plik';

  @override
  String get video_sources_front_camera => 'Przedni aparat';

  @override
  String get video_sources_live_stream => 'Adres URL transmisji na żywo';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Wymagane jest udzielenie uprawnień do korzystania z aparatu';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Nie znaleziono aparatu';

  @override
  String get video_sources_screen_import_error =>
      'Nie udało się zaimportować pliku wideo.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Przejdź do ustawień i zezwól na dostęp do zdjęć dla tej aplikacji.';

  @override
  String get video_sources_screen_select_camera =>
      'Dotknij, aby wybrać tę kamerę';

  @override
  String get video_sources_screen_select_file => 'Dotknij, aby wybrać plik';

  @override
  String get video_sources_screen_select_live =>
      'Dotknij, aby ustawić adres URL transmisji na żywo';

  @override
  String get video_sources_webcam => 'Kamera internetowa';
}
