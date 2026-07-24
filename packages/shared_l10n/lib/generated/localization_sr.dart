// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class LocalizationSr extends Localization {
  LocalizationSr([String locale = 'sr']) : super(locale);

  @override
  String get about_screen_app_version => 'Verzija aplikacije';

  @override
  String get about_screen_email_us => 'Pošaljite nam e-mail';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get appeared => 'Pojavili se';

  @override
  String get appeared_help =>
      'Broji ljude ili vozila čija je prva otkrivena pozicija bila unutar ove oblasti.\\n\\nPomaže da se razume gde praćenje počinje.\\n\\n(Uglavnom namenjeno naprednim korisnicima)';

  @override
  String get average_occupancy => 'Prosečna popunjenost';

  @override
  String get average_occupancy_help =>
      'Prikazuje prosečan broj ljudi ili vozila u ovoj oblasti tokom trenutnog perioda brojanja.\\n\\nPomaže da se proceni koliko je oblast bila prometna tokom celog perioda brojanja.';

  @override
  String get average_stay => 'Prosečno vreme zadržavanja';

  @override
  String get average_stay_help =>
      'Prikazuje prosečno vreme koje su ljudi ili vozila proveli u ovoj oblasti.\\n\\nDuže prosečno zadržavanje može značiti da posetioci provode više vremena u ovoj oblasti.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter koristi kameru i AI na uređaju za brojanje ljudi. Hajde prvo da proverimo da li je vaš uređaj kompatibilan.';

  @override
  String get camera_test_screen_instruction =>
      'Usmerite kameru ka ljudima. Aplikacija će prikazati okvire oko otkrivenih osoba.';

  @override
  String get camera_test_screen_next => 'Dodirnite Sledeće za nastavak.';

  @override
  String get camera_test_screen_start =>
      'Dodirnite Pokreni. Ako se zatraži, dozvolite pristup kameri.';

  @override
  String get camera_test_screen_test_failed => 'Test nije uspeo!';

  @override
  String get camera_test_screen_test_passed => 'Test uspešan!';

  @override
  String get camera_test_screen_title => 'AI test kamere';

  @override
  String get camera_test_screen_wait => 'Čeka se da AI otkrije ljude…';

  @override
  String get cta_screen_custom => 'Koristi svoj server';

  @override
  String get cta_screen_custom_help =>
      'Šaljite podatke o saobraćaju direktno na svoj backend ili bazu podataka.';

  @override
  String get cta_screen_footer =>
      'Nastavljanjem prihvatate Uslove korišćenja, Politiku privatnosti i Sporazum o obradi podataka.';

  @override
  String get cta_screen_invitation => 'Koristi kod pozivnice';

  @override
  String get cta_screen_invitation_help =>
      'Pridružite se postojećoj organizaciji pomoću pozivnice administratora.';

  @override
  String get cta_screen_local => 'Samo na ovom uređaju';

  @override
  String get cta_screen_local_help =>
      'Čuvajte podatke o saobraćaju samo na ovom uređaju. Ništa se ne otprema.';

  @override
  String get cta_screen_piyuo => 'Koristi Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Čuvajte podatke o saobraćaju u Piyuo Cloud uz kontrolne table i poslovne uvide.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter pravi anonimnu statistiku saobraćaja svakih 5 minuta.\\nIzaberite kako želite da čuvate i pristupate svojim podacima.';

  @override
  String get current_occupancy => 'Тренутни број';

  @override
  String get current_occupancy_help =>
      'Prikazuje trenutni broj ljudi ili vozila u ovoj oblasti.\\n\\nOvaj broj se ažurira u realnom vremenu i pomaže da proverite da li AI prepoznavanje odgovara onome što vidite na ekranu. Ne uključuje se u otpremljene telemetrijske podatke.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Čuvanje...';

  @override
  String get custom_server_screen_server_url_label => 'URL servera';

  @override
  String get detection_screen_confidence => 'Prag pouzdanosti';

  @override
  String get detection_screen_confidence_dialog =>
      'Одређује колико AI мора бити сигуран пре бројања особе или возила.\\nНиже вредности\\n• Откривају више објеката\\n• Боље за удаљене или делимично скривене објекте\\n• Могу повећати лажна откривања\\nВише вредности\\n• Броје само откривања са високом поузданошћу\\n• Смањују лажна откривања\\n• Могу пропустити мале или тешке објекте\\nКористите нижу вредност ако апликација пропушта људе или возила.\\nКористите вишу вредност ако апликација броји сенке, одблеске или друге лажне објекте.';

  @override
  String get detection_screen_confidence_help =>
      'Minimalna pouzdanost potrebna za detekciju objekta.';

  @override
  String get detection_screen_confidence_max_label => 'Strogo';

  @override
  String get detection_screen_confidence_min_label => 'Labavo';

  @override
  String get detection_screen_disappear => 'Vreme isteka za nestanak';

  @override
  String get detection_screen_disappear_dialog =>
      'Одређује колико дуго AI чека пре него што означи објекат као нестао након што више није откривен.\\nКраће вредности\\n• Брже означавају објекте као нестале\\n• Боље за брз саобраћај\\n• Могу погрешно означити привремено скривене објекте као нестале\\nДуже вредности\\n• Дуже чекају пре означавања објеката као несталих\\n• Боље када су објекти накратко блокирани или пропуштени\\n• Одлажу догађаје нестанка';

  @override
  String get detection_screen_disappear_help =>
      'Koliko AI čeka pre nego što označi objekat kao nestao nakon što prestane da ga detektuje.';

  @override
  String get detection_screen_disappear_max_label => 'Sporo';

  @override
  String get detection_screen_disappear_min_label => 'Brzo';

  @override
  String get detection_screen_memory_dialog =>
      'Одређује колико дуго AI памти објекат након што нестане.\\nПовећајте ову вредност ако су људи или возила често скривени иза других објеката.\\nСмањите ову вредност ако се објекти погрешно повезују након напуштања сцене.';

  @override
  String get detection_screen_min_presence => 'Minimalno vreme prisustva';

  @override
  String get detection_screen_min_presence_help =>
      'Objekat mora ostati vidljiv pre nego što bude izbrojan. Veće vrednosti pomažu da se smanje kratkotrajne lažne detekcije.';

  @override
  String get detection_screen_min_presence_max_label => 'Bezbednije';

  @override
  String get detection_screen_min_presence_min_label => 'Brže';

  @override
  String get detection_screen_minimum_visible =>
      'Објекти морају остати видљиви овoлико дуго пре него што буду избројани.\\nПовећајте ову вредност да бисте занемарили кратка лажна откривања.\\nСмањите ову вредност ако се брзо покретни људи или возила пропуштају.';

  @override
  String get detection_screen_new_track => 'Prag za novo praćenje';

  @override
  String get detection_screen_new_track_help =>
      'Minimalna pouzdanost potrebna za početak praćenja novog objekta. Niže vrednosti mogu napraviti duple tragove.';

  @override
  String get detection_screen_new_track_max_label => 'Konzervativno';

  @override
  String get detection_screen_new_track_min_label => 'Agresivno';

  @override
  String get detection_screen_reset => 'Resetuj';

  @override
  String get detection_screen_reset_content =>
      'Da li ste sigurni da želite da resetujete podešavanja detekcije?';

  @override
  String get detection_screen_show_track_id => 'Prikaži ID praćenja';

  @override
  String get detection_screen_show_track_id_help =>
      'Omogućite ovu opciju da prikazuje jedinstvene ID-je praćenja za svaki praćeni objekat.';

  @override
  String get detection_screen_stay => 'Vreme zadržavanja';

  @override
  String get detection_screen_stay_help =>
      'Koliko dugo objekat mora ostati u području pre nego što se računa kao zadržavanje.';

  @override
  String get detection_screen_stay_max_label => 'Odloženo';

  @override
  String get detection_screen_stay_min_label => 'Odmah';

  @override
  String get detection_screen_stay_threshold =>
      'Одређује када објекат доприноси броју „Задржавања“.\\nКраће вредности\\n• Одмах броје задржавање\\n• Боље за брзу анализу\\nДуже вредности\\n• Занемарују кратак пролазни саобраћај\\n• Боље за мерење попуњености';

  @override
  String get detection_screen_subtitle =>
      'Podesite kako AI detektuje i prati objekte.';

  @override
  String get detection_screen_title => 'Praćenje i brojanje';

  @override
  String get detection_screen_track_dialog =>
      'Одређује када новооткривени објекат постаје нова путања.\\nНиже вредности\\n• Праћење почиње раније\\n• Боље за брзо покретне објекте\\n• Могу створити дуплиране путање\\nВише вредности\\n• Захтевају јаче доказе пре креирања нове путање\\n• Смањују дуплиране путање\\n• Могу одложити праћење нових објеката';

  @override
  String get detection_screen_track_memory => 'Memorija praćenja';

  @override
  String get detection_screen_track_memory_help =>
      'Koliko dugo nastaviti praćenje objekta nakon privremenog gubitka. Veće vrednosti pomažu da se praćenje vrati posle kratkog zaklanjanja.';

  @override
  String get detection_screen_track_memory_max_label => 'Dugo';

  @override
  String get detection_screen_track_memory_min_label => 'Kratko';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter koristi kameru za otkrivanje pešaka i vozila u realnom vremenu. Ovaj uređaj nema dostupnu kameru.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Pokušajte otvoriti ovu aplikaciju na telefonu';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Pametni telefon ili tablet sa kamerom';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Preporučuje se iOS ili Android uređaj';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Šta vam je potrebno';

  @override
  String get device_not_supported_screen_title => 'Kamera nije pronađena';

  @override
  String get disappeared => 'Nestali';

  @override
  String get disappeared_help =>
      'Broji ljude ili vozila čija je poslednja otkrivena pozicija bila unutar ove oblasti.\\n\\nPraćenje se završava nakon podešenog vremena nestanka ako osoba ili vozilo više nisu otkriveni.\\n\\n(Uglavnom namenjeno naprednim korisnicima)';

  @override
  String get dpa => 'Sporazum o obradi podataka';

  @override
  String get durationDaysShort => '%sd';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ssek';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Ušli';

  @override
  String get entered_help =>
      'Broji ljude ili vozila koja su ušla u ovu oblast tokom trenutnog perioda brojanja.\\n\\nUlazak se računa kada se osoba ili vozilo kreće izvan oblasti ka unutra.';

  @override
  String get exited => 'Izašli';

  @override
  String get exited_help =>
      'Broji ljude ili vozila koja su izašla iz ove oblasti tokom trenutnog perioda brojanja.\\n\\nIzlazak se računa kada se osoba ili vozilo kreće iz unutrašnjosti oblasti ka spolja.';

  @override
  String get language_screen_language => 'Jezik';

  @override
  String get language_screen_subtitle =>
      'Izaberite jezik koji će se koristiti u aplikaciji.';

  @override
  String get local_only_screen_body =>
      'Režim Samo lokalni uređaj vam omogućava da isprobate AI detekciju i praćenje kamerom bez otpremanja podataka. Sva statistika o pešačkom saobraćaju obrađuje se samo na ovom uređaju, idealno za testiranje pre povezivanja sa serverom.';

  @override
  String get local_only_screen_use_action => 'Koristi samo lokalni uređaj';

  @override
  String get local_screen_text =>
      'Piyuo Counter će raditi u potpunosti na ovom uređaju.\\nStatistika saobraćaja biće sačuvana samo na ovom uređaju i neće se otpremati.\\nKasnije se možete povezati sa Piyuo Cloud ili svojim serverom u Podešavanjima.';

  @override
  String get maximum_occupancy => 'Maksimalna popunjenost';

  @override
  String get maximum_occupancy_help =>
      'Prikazuje najveći broj ljudi ili vozila koji su se istovremeno nalazili u ovoj oblasti tokom trenutnog perioda brojanja.\\n\\nKorisno za utvrđivanje perioda najveće gužve ili saobraćaja.';

  @override
  String get maximum_stay => 'Maksimalno vreme zadržavanja';

  @override
  String get maximum_stay_help =>
      'Prikazuje najduže vreme koje su osoba ili vozilo proveli u ovoj oblasti tokom trenutnog perioda brojanja.\\n\\nKorisno za prepoznavanje neuobičajeno dugih poseta ili zaustavljanja.';

  @override
  String get metric_events => 'Događaji';

  @override
  String get metric_live => 'Uživo';

  @override
  String get metric_show_less => 'Prikaži manje';

  @override
  String get metric_show_more => 'Prikaži više';

  @override
  String get metric_statistics => 'Statistika';

  @override
  String get metrics_counting_all => 'Sve';

  @override
  String get metrics_counting_done => 'Završeno';

  @override
  String get metrics_counting_in_progress => 'U toku';

  @override
  String get metrics_counting_missing => 'Nedostaje';

  @override
  String get metrics_counting_window =>
      'Statistika za svaki period od 5 minuta';

  @override
  String get onboarding_back_action => 'Nazad';

  @override
  String get onboarding_cta_no_server => 'Ne želite da otpremate podatke?';

  @override
  String get onboarding_cta_title => 'Gde treba slati vaše podatke?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter користи камеру твог уређаја и уграђену AI да одмах препозна људе и возила.\\nЗахваљујући технологији детекције и праћења, аутоматски броји проток пешака и возила — све се обрађује директно на твом уређају.';

  @override
  String get onboarding_intro_text2 =>
      'Сва AI обрада се одвија локално на твом уређају. Ниједан видео, слика, лице или идентитет се не шаље.\\nДеле се само анонимни сажеци на сваких 5 минута, укључујући статистику бројања, попуњености, улазака, излазака и времена задржавања.';

  @override
  String get onboarding_intro_text3 =>
      'Само покрени апликацију и остави је да ради. Piyuo Counter аутоматски и непрекидно прикупља и чува податке о саобраћају.\\nСажеци података се чувају на сваких 5 минута и шаљу сваког сата на Piyuo Cloud или твој сопствени сервер.';

  @override
  String get onboarding_intro_title1 => 'AI brojanje saobraćaja';

  @override
  String get onboarding_intro_title2 => 'Privatnost na prvom mestu';

  @override
  String get onboarding_intro_title3 => 'Radi automatski 24/7';

  @override
  String get onboarding_next_action => 'Sledeće';

  @override
  String get onboarding_skip_action => 'Preskoči uvod';

  @override
  String get onboarding_start_action => 'Pokreni';

  @override
  String get passed_by => 'Prošli';

  @override
  String get passed_by_help =>
      'Broji ljude ili vozila koja su prošla kroz ovu oblast tokom trenutnog perioda brojanja.\\n\\nSvaka osoba ili vozilo broji se samo jednom za svaki prolazak kroz oblast.';

  @override
  String get payloads_screen_area => 'Područje';

  @override
  String get payloads_screen_confidence => 'Pouzdanost';

  @override
  String get payloads_screen_coverage => 'Pokrivenost';

  @override
  String get payloads_screen_delivered => 'Dostavljeno';

  @override
  String get payloads_screen_failed_load =>
      'Neuspešno učitavanje nedavnih payload-a';

  @override
  String get payloads_screen_frame_processed => 'Obrađeni frejmovi';

  @override
  String get payloads_screen_hour_not_exists => 'Ovaj sat više ne postoji.';

  @override
  String get payloads_screen_missing_time => 'Nedostajuće vreme';

  @override
  String get payloads_screen_no_payloads => 'Još nema payload-a.';

  @override
  String get payloads_screen_partial => 'Prozor je završen ranije (delimično)';

  @override
  String get payloads_screen_partially => 'Delimično dostavljeno';

  @override
  String get payloads_screen_payload_not_exists =>
      'Ovaj payload više ne postoji.';

  @override
  String get payloads_screen_pending => 'Čeka isporuku';

  @override
  String get payloads_screen_process_fps => 'FPS obrade';

  @override
  String get payloads_screen_resend => 'Ponovo pošalji';

  @override
  String get payloads_screen_select_first =>
      'Prvo izaberite barem jedan datum ili sat.';

  @override
  String get payloads_screen_subtitle =>
      'Izaberite datum ili sat za ponovno slanje';

  @override
  String get payloads_screen_title => 'Nedavni payloadi';

  @override
  String get personal_custom_screen_build_server =>
      'Treba vam pomoć pri podešavanju sopstvenog servera?\\nPogledajte našu API dokumentaciju i primere servera.';

  @override
  String get personal_custom_screen_help_action => 'Otvori API dokumentaciju';

  @override
  String get personal_custom_screen_reset_action => 'Počni ispočetka';

  @override
  String get personal_custom_success_screen_help =>
      'Dodirnite Start ispod da biste započeli brojanje.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Statistika saobraćaja se automatski otprema svakog sata.\\nMožete je poslati i ručno sa ekrana dnevnika otpremanja.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Vaš server još ne mora biti na mreži.\\nPočnite sa brojanjem odmah. Kasnije možete završiti podešavanje i testiranje svog servera. Statistika saobraćaja će ostati na ovom uređaju dok se uspešno ne otpremi.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Statistika saobraćaja biće poslata na';

  @override
  String get personal_custom_success_screen_title => 'Vaš server je spreman';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Vaš Piyuo Cloud URL';

  @override
  String get piyuo_server_screen_copy_action => 'Kopiraj URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL je kopiran';

  @override
  String get piyuo_server_screen_saving_action => 'Čuvanje...';

  @override
  String get piyuo_server_screen_start =>
      'Pritisnite \"Start\" ispod da biste započeli brojanje.';

  @override
  String get piyuo_server_screen_url_help =>
      'Vaša lična Piyuo Cloud kontrolna tabla dostupna je na ovom URL-u.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Sačuvajte ovaj URL da biste pristupili kontrolnoj tabli saobraćaja sa drugog uređaja.';

  @override
  String get piyuo_server_screen_use_action => 'Koristi Piyuo Cloud';

  @override
  String get privacy => 'Politika privatnosti';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc =>
      'Brojanje ljudi i vozila pomoću veštačke inteligencije.';

  @override
  String get settings_screen_custom_subtitle =>
      'Šaljite podatke o saobraćaju direktno na svoj backend ili bazu podataka.';

  @override
  String get settings_screen_custom_title => 'Koristi prilagođeni server';

  @override
  String get settings_screen_data_server_label => 'Server podataka';

  @override
  String get settings_screen_detection_target => 'Cilj detekcije';

  @override
  String get settings_screen_language_title => 'Jezik';

  @override
  String get settings_screen_local_subtitle =>
      'Čuvajte podatke o saobraćaju samo na ovom uređaju. Ništa se ne otprema.';

  @override
  String get settings_screen_local_title => 'Samo lokalni uređaj';

  @override
  String get settings_screen_misc_label => 'Razno';

  @override
  String get settings_screen_object_detection => 'Detekcija objekata';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Čuvajte podatke o prometu u Piyuo Cloud-u uz kontrolne table i poslovne uvide.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Ovo će obrisati sve podatke i početi ispočetka. Ovu radnju nije moguće opozvati.';

  @override
  String get settings_screen_reset_all_data_title => 'Resetovati sve podatke?';

  @override
  String get settings_screen_subscription_body =>
      'Upravljajte pretplatom i podacima za naplatu';

  @override
  String get settings_screen_subscription_title => 'Pretplata';

  @override
  String get start_screen_about => 'O programu';

  @override
  String get start_screen_server_none =>
      'Podaci se čuvaju samo na ovom uređaju';

  @override
  String get start_screen_server_personal =>
      'Podaci se otpremaju svakog sata na';

  @override
  String get start_screen_settings => 'Podešavanja';

  @override
  String get start_screen_upload_logs => 'Otpremi zapisnike';

  @override
  String get start_screen_video_sources => 'Izvori videa';

  @override
  String get stayed => 'Ostali';

  @override
  String get stayed_help =>
      'Broji ljude ili vozila koja su ostala u ovoj oblasti najmanje tokom podešenog vremena zadržavanja.\\n\\nPodrazumevano vreme zadržavanja je 15 sekundi i može se promeniti u Podešavanjima.';

  @override
  String get target_pedestrian => 'Pešak';

  @override
  String get target_pedestrian_help =>
      'Brojite ljude pomoću modela za detekciju pešaka';

  @override
  String get target_screen_subtitle =>
      'Izaberite model detekcije koji želite da koristite';

  @override
  String get target_vehicle => 'Vozilo';

  @override
  String get target_vehicle_help =>
      'Brojite automobile i druga vozila pomoću modela za detekciju vozila';

  @override
  String get telemetry_error_connection_refused =>
      'Сервер није доступан. Можда је тренутно ван мреже.';

  @override
  String get telemetry_error_connection_reset =>
      'Веза је ресетована. Проверите интернет везу и покушајте поново.';

  @override
  String get telemetry_error_connection_timeout =>
      'Веза је предуго чекала на одговор. Проверите интернет везу и покушајте поново.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Адреса сервера није пронађена. Проверите интернет везу или URL сервера.';

  @override
  String get telemetry_error_http_error_status =>
      'Сервер је одбио захтев. Покушајте поново касније.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Дошло је до неочекиване грешке приликом комуникације са сервером.';

  @override
  String get telemetry_error_invalid_url =>
      'Адреса сервера није важећа. Проверите подешавања.';

  @override
  String get telemetry_error_network_error =>
      'Дошло је до мрежне грешке. Проверите интернет везу и покушајте поново.';

  @override
  String get telemetry_error_socket_error =>
      'Дошло је до проблема са мрежном везом. Проверите интернет везу.';

  @override
  String get telemetry_error_transport_exception =>
      'Нешто је пошло по злу приликом слања података. Покушајте поново.';

  @override
  String get terms => 'Uslovi korišćenja';

  @override
  String get upload_screen_attempt_time => 'Vreme pokušaja:';

  @override
  String get upload_screen_error => 'Greška:';

  @override
  String get upload_screen_failed => 'Neuspešno';

  @override
  String get upload_screen_load_error =>
      'Neuspešno učitavanje dnevnika otpremanja.';

  @override
  String get upload_screen_log_not_exists =>
      'Dnevnik otpremanja više nije dostupan.';

  @override
  String get upload_screen_next => 'Sledeće otpremanje u ...';

  @override
  String get upload_screen_next_upload_prefix => 'Sledeće otpremanje u ';

  @override
  String get upload_screen_no_data_server => 'Prvo podesite server za podatke.';

  @override
  String get upload_screen_no_logs => 'Još nema zapisa o otpremanju.';

  @override
  String get upload_screen_payload_count => 'Broj payload-a';

  @override
  String get upload_screen_payload_count_label => 'Broj payload-a:';

  @override
  String get upload_screen_payload_size => 'Veličina payload-a:';

  @override
  String get upload_screen_result => 'Rezultat:';

  @override
  String get upload_screen_retry => 'Broj ponovnih pokušaja:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Uspešno';

  @override
  String get upload_screen_today => 'Danas';

  @override
  String get upload_screen_upload_now => 'Otpremi sada';

  @override
  String get upload_screen_upload_success => 'Otpremanje uspešno.';

  @override
  String get upload_screen_uploading => 'Otpremanje...';

  @override
  String get upload_screen_yesterday => 'Juče';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP URL mora sadržati ime hosta.';

  @override
  String get url_screen_invalid_url_error =>
      'Unesite važeći URL sa podržanom šemom.';

  @override
  String get url_screen_subtitle => 'Unesite URL live streama';

  @override
  String get url_screen_title => 'URL live streama';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Unesite URL prenosa uživo.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream ili rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Zadnja kamera';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_file => 'Fajl';

  @override
  String get video_sources_front_camera => 'Prednja kamera';

  @override
  String get video_sources_live_stream => 'URL live streama';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Potrebno je odobriti dozvolu za kameru da biste je koristili';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Kamera nije pronađena';

  @override
  String get video_sources_screen_import_error =>
      'Nije moguće uvesti video fajl.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Идите у подешавања и дозволите приступ фотографијама за ову апликацију.';

  @override
  String get video_sources_screen_select_camera =>
      'Dodirnite da izaberete ovu kameru';

  @override
  String get video_sources_screen_select_file =>
      'Dodirnite da izaberete datoteku';

  @override
  String get video_sources_screen_select_live =>
      'Dodirnite da podesite URL prenosa uživo';

  @override
  String get video_sources_webcam => 'Veb kamera';
}
