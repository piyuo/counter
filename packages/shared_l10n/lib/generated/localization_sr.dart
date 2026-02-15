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
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_models => 'Modeli za detekciju objekata';

  @override
  String get about_screen_opencv_build_info => 'OpenCV informacije o izgradnji';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_title => 'O programu';

  @override
  String get add_video_screen_from => 'Dodaj video izvor iz';

  @override
  String get add_video_screen_title => 'Dodaj video izvor';

  @override
  String get back => 'Nazad';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Modeli za detekciju objekata';

  @override
  String get benchmark_screen_recommended => 'Preporučeni model';

  @override
  String get benchmark_screen_start_button => 'Pokreni benchmark';

  @override
  String get benchmark_screen_start_failed =>
      'Neuspešno pokretanje benchmarka, kod greške je';

  @override
  String get benchmark_screen_title => 'Benchmark modela';

  @override
  String get camera_screen_add_title => 'Dodaj kameru';

  @override
  String get camera_screen_back_camera => 'Zadnja kamera';

  @override
  String get camera_screen_edit_title => 'Izaberi kameru';

  @override
  String get camera_screen_front_camera => 'Prednja kamera';

  @override
  String get camera_screen_zoom_level => 'Nivo zuma';

  @override
  String get cancel => 'Otkaži';

  @override
  String get close => 'Zatvori';

  @override
  String get color_screen_title => 'Izaberi boju';

  @override
  String get counter_screen_cooldown_desc =>
      'Ponovni ulazak zahteva #0 sekundi hlađenja nakon izlaska iz zone detekcije';

  @override
  String get counter_screen_cooldown_in_seconds => 'u sekundama';

  @override
  String get counter_screen_cooldown_threshold => 'Prag hlađenja';

  @override
  String get counter_screen_cooldown_time => 'Vreme hlađenja';

  @override
  String get counter_screen_enabled => 'Omogućeno';

  @override
  String get counter_screen_enabled_error => 'Greška';

  @override
  String get counter_screen_enabled_error_content =>
      'Potrebno je prvo omogućiti drugi brojač, a zatim možete onemogućiti ovaj brojač';

  @override
  String get counter_screen_name_error => 'Ime brojača ne može biti prazno';

  @override
  String get counter_screen_reentry_desc =>
      'Objekti moraju ući #0 puta, sa #1 sekundi hlađenja između svakog izlaska i ponovnog ulaska, da bi pokrenuli ponovno ulaženje';

  @override
  String get counter_screen_reentry_threshold => 'Prag ponovnog ulaska';

  @override
  String get counter_screen_reentry_title => 'Brojanje ponovnih ulazaka';

  @override
  String get counter_screen_show_on => 'Prikaži na ekranu';

  @override
  String get counter_screen_stagnant_consider => 'Smatraj stagniranim';

  @override
  String get counter_screen_stagnant_desc =>
      'Objekti koji ostanu nepomični duže od #0 sekundi smatraće se stagniranim';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefiks opisa';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufiks opisa';

  @override
  String get counter_screen_stagnant_in_seconds => 'u sekundama';

  @override
  String get counter_screen_stagnant_threshold => 'Prag stagnacije';

  @override
  String get default_project_name => 'Projekat';

  @override
  String get default_video_name => 'Video izvor';

  @override
  String get default_zone_name => 'Zona detekcije';

  @override
  String get detection_screen_confidence => 'Pouzdanost';

  @override
  String get detection_screen_confidence_desc =>
      'pouzdanost iznad #0 se smatra validnom detekcijom';

  @override
  String get detection_screen_consider_valid => 'Smatraj validnim nakon';

  @override
  String get detection_screen_consider_valid_desc =>
      'Praćeni objekat će se smatrati validnim nakon #0';

  @override
  String get detection_screen_high => 'Visoka';

  @override
  String get detection_screen_lost => 'Izgubljeno';

  @override
  String get detection_screen_lost_desc =>
      'Динамички одређује време уклањања изгубљених објеката између #0 и #1 на основу брзине кретања';

  @override
  String get detection_screen_low => 'Niska';

  @override
  String get detection_screen_match => 'Podudaranje';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold je ključni parametar u praćenju objekata koji meri stepen podudaranja između različitih okvira detekcije. Niža vrednost olakšava povezivanje objekata ali povećava rizik od pogrešnih povezivanja. Viša vrednost je stroža kod povezivanja objekata ali može propustiti neka stvarna podudaranja.';

  @override
  String get detection_screen_models => 'Modeli';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc =>
      '#0 Niži NMS prag (npr. 0.3-0.4) strože uklanja preklapajuće okvire i smanjuje lažno pozitivne rezultate ali može propustiti preklapajuće osobe. Viši prag (0.7-0.9) zadržava više okvira što može povećati lažno pozitivne rezultate ali bolje otkriva preklapajuće osobe.';

  @override
  String get detection_screen_reset => 'Resetuj';

  @override
  String get detection_screen_reset_content =>
      'Da li ste sigurni da želite da resetujete podešavanja detekcije?';

  @override
  String get detection_screen_title => 'Podešavanja detekcije';

  @override
  String get error_content =>
      'Došlo je do neočekivane greške. Da li želite da pošaljete izveštaj putem e-pošte?';

  @override
  String get error_oops => 'Ups, nešto je pošlo po zlu';

  @override
  String get error_report => 'Pošaljite nam e-mail';

  @override
  String get filter_screen_desc => 'Izaberite opseg filtera sa liste ispod';

  @override
  String get filter_screen_error_content =>
      'Vreme završetka mora biti veće od vremena početka';

  @override
  String get filter_screen_error_custom => 'Prilagođeno';

  @override
  String get filter_screen_error_end => 'Kraj';

  @override
  String get filter_screen_error_start => 'Početak';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get language_screen_language => 'Jezik';

  @override
  String get no => 'Ne';

  @override
  String get objects_screen_desc =>
      'Izaberite ciljeve detekcije poput osobe, automobila, autobusa, itd.';

  @override
  String get objects_screen_title => 'Objekti';

  @override
  String get ok => 'U redu';

  @override
  String get open_project_screen_desc =>
      'Otvorite prethodno kreirane projekte, čuvajući samo najnovijih 20.';

  @override
  String get open_project_screen_no_project =>
      'Nije pronađen nijedan projekat.';

  @override
  String get open_project_screen_title => 'Otvori projekat';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get product_desc =>
      'Korišćenje računarskog vida i veštačke inteligencije za brojanje ljudi, vozila, kućnih ljubimaca i više.';

  @override
  String get product_name => 'Бројач';

  @override
  String get project_screen_add_video_button => 'Dodaj video izvor';

  @override
  String get project_screen_exit_button => 'Izlaz';

  @override
  String get project_screen_exit_confirm_content =>
      'Napuštanje projekta će zaustaviti brojanje. Da li ste sigurni da želite da nastavite?';

  @override
  String get project_screen_exit_confirm_title =>
      'Potvrdite izlazak iz projekta';

  @override
  String get project_screen_from_desc =>
      'Čuvamo evidenciju za protekla 24 sata, tako da možete pregledati bilo koji vremenski period koji vam je potreban.';

  @override
  String get project_screen_report_settings => 'Podešavanja';

  @override
  String get project_screen_title => 'Projekat';

  @override
  String get project_view_no_videos => 'Nema dostupnih video izvora.';

  @override
  String get settings_screen_center_point_button =>
      'Prikaži centralnu tačku na meti';

  @override
  String get settings_screen_center_point_desc =>
      'Centralna tačka pomaže da se odredi da li je meta unutar zone detekcije.';

  @override
  String get settings_screen_center_point_title => 'Centralna tačka na meti';

  @override
  String get settings_screen_delete_button => 'Izbriši';

  @override
  String get settings_screen_delete_content =>
      'Da li ste sigurni da želite da izbrišete ovaj projekat?';

  @override
  String get settings_screen_delete_header => 'Izbriši ovaj projekat';

  @override
  String get settings_screen_desc =>
      'Postavite ime projekta, parametre detekcije, brisanje brojanja.';

  @override
  String get settings_screen_lost_target_button => 'Prikaži izgubljenu metu';

  @override
  String get settings_screen_lost_target_desc =>
      'Kada praćenje objekta izgubi metu, ova opcija je čini vidljivom. Podrazumevano, izgubljene mete se ne prikazuju.';

  @override
  String get settings_screen_lost_target_title => 'Izgubljena meta';

  @override
  String get settings_screen_project_error =>
      'Ime projekta ne može biti prazno';

  @override
  String get settings_screen_project_id => 'ID projekta';

  @override
  String get settings_screen_project_name => 'Ime projekta';

  @override
  String get settings_screen_project_name_place_holder =>
      'Knez Mihailova 15 ili Park Tašmajdan';

  @override
  String get settings_screen_random_count_button => 'Dodaj nasumična brojanja';

  @override
  String get settings_screen_reset_count_button => 'Resetuj brojanja';

  @override
  String get settings_screen_reset_count_content =>
      'Da li ste sigurni da želite da resetujete sva brojanja?';

  @override
  String get settings_screen_reset_count_header =>
      'Resetuj sva brojanja u ovom projektu';

  @override
  String get settings_screen_title => 'Podešavanja';

  @override
  String get submit => 'Pošalji';

  @override
  String get url_screen_desc => 'Unesite URL live streama';

  @override
  String get url_screen_title => 'URL live streama';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream ili rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'Dodaj tačku trenutnoj zoni';

  @override
  String get video_screen_add_zone => 'Dodaj zonu detekcije';

  @override
  String get video_screen_change_file => 'Promeni fajl';

  @override
  String get video_screen_delete_button => 'Izbriši';

  @override
  String get video_screen_delete_content =>
      'Da li ste sigurni da želite da izbrišete ovaj video izvor?';

  @override
  String get video_screen_delete_header => 'Izbriši ovaj video izvor';

  @override
  String get video_screen_desc =>
      'Upravljajte video izvorima, dodajte ili izmenite zone detekcije.';

  @override
  String get video_screen_detection => 'Parametri modela';

  @override
  String get video_screen_edit_placeholder =>
      'Kamera na ulaznim vratima ili Kamera na parkingu';

  @override
  String get video_screen_move_bottom => 'Pomeri trenutnu zonu na dno';

  @override
  String get video_screen_name_empty => 'Ime video izvora ne može biti prazno.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'trenutna: ';

  @override
  String get video_screen_playback_speed => 'Brzina reprodukcije';

  @override
  String get video_screen_remove_point => 'Ukloni tačku iz trenutne zone';

  @override
  String get video_screen_sources =>
      'Konfigurišite izvor slike, ciljeve detekcije i parametre modela.';

  @override
  String get video_screen_targets => 'Ciljevi detekcije';

  @override
  String get video_screen_tools => 'Alati';

  @override
  String get video_screen_video_name => 'Ime video izvora';

  @override
  String get video_screen_zones => 'Zone detekcije';

  @override
  String get video_screen_zones_desc =>
      'Koristite prevuci i pusti za podešavanje zona';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_denied => 'Pristup kameri odbijen';

  @override
  String get video_sources_camera_denied_msg =>
      'Идите у подешавања и дозволите приступ камери за ову апликацију.';

  @override
  String get video_sources_camera_not_found_message =>
      'Potrebno je odobriti dozvolu za kameru da biste je koristili';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nije pronađena';

  @override
  String get video_sources_file => 'Fajl';

  @override
  String get video_sources_live_stream => 'URL live streama';

  @override
  String get video_sources_photos_denied => 'Pristup fotografijama odbijen';

  @override
  String get video_sources_photos_denied_msg =>
      'Идите у подешавања и дозволите приступ фотографијама за ову апликацију.';

  @override
  String get video_sources_photos_goto_settings => 'Иди у подешавања';

  @override
  String get video_sources_webcam => 'Veb kamera';

  @override
  String get video_sources_webcam_not_found_message =>
      'Proverite dozvolu aplikacije i konekciju veb kamere';

  @override
  String get video_sources_webcam_not_found_title =>
      'Veb kamera nije pronađena';

  @override
  String get webcam_manager_webcam => 'Veb kamera';

  @override
  String get webcam_screen_add_title => 'Dodaj veb kameru';

  @override
  String get webcam_screen_edit_title => 'Izaberi veb kameru';

  @override
  String get wizard_screen_about => 'O programu';

  @override
  String get wizard_screen_desc =>
      'Kreirajte novi projekat da biste počeli brojanje.';

  @override
  String get wizard_screen_email_us => 'Pošaljite nam e-mail';

  @override
  String get wizard_screen_language => 'Jezik';

  @override
  String get wizard_screen_new_project_from => 'Novi projekat iz';

  @override
  String get wizard_screen_open_projects => 'Otvori postojeći projekat';

  @override
  String get wizard_screen_open_projects_tip =>
      'Svi projekti će biti automatski sačuvani lokalno';

  @override
  String get yes => 'Da';

  @override
  String get zone_screen_can_not_delete => 'Nije moguće izbrisati zonu';

  @override
  String get zone_screen_color => 'Boja';

  @override
  String get zone_screen_delete_button => 'Izbriši';

  @override
  String get zone_screen_delete_content =>
      'Da li ste sigurni da želite da izbrišete ovu zonu?';

  @override
  String get zone_screen_delete_header => 'Izbriši ovu zonu';

  @override
  String get zone_screen_desc =>
      'Zona detekcije može postaviti tipove objekata za detekciju i izabrati koje brojače prikazati, poput Detektovano, Kreirano i Ušlo.';

  @override
  String get zone_screen_name_placeholder =>
      'Ime zone, poput Trotoar ili Parking';

  @override
  String get zone_screen_one_zone_required =>
      'Potrebna je najmanje jedna zona.';

  @override
  String get zone_screen_zone => 'Зона';

  @override
  String get zone_screen_zone_color => 'Boja zone';

  @override
  String get zone_screen_zone_name_required => 'Ime zone ne može biti prazno';

  @override
  String get zone_screen_zone_show_summary => 'Прикажи резиме на екрану';
}
