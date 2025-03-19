// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class LocalizationHr extends Localization {
  LocalizationHr([String locale = 'hr']) : super(locale);

  @override
  String get product_name => 'Vision Counter';

  @override
  String get product_desc => 'Korištenje računalnog vida i umjetne inteligencije za brojanje ljudi, vozila, kućnih ljubimaca i više.';

  @override
  String get product_copyright => 'Autorska prava © 2025';

  @override
  String get video_sources_webcam => 'Web kamera';

  @override
  String get video_sources_live_stream => 'URL živog prijenosa';

  @override
  String get video_sources_file => 'Datoteka';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nije pronađena';

  @override
  String get video_sources_camera_not_found_message => 'Potrebno je odobriti dozvolu za pristup kameri';

  @override
  String get video_sources_webcam_not_found_title => 'Web kamera nije pronađena';

  @override
  String get video_sources_webcam_not_found_message => 'Provjerite je li web kamera priključena';

  @override
  String get wizard_screen_desc => 'Izradite novi projekt u nastavku za početak brojanja.';

  @override
  String get wizard_screen_new_project_from => 'Novi projekt iz';

  @override
  String get wizard_screen_language => 'Jezik';

  @override
  String get wizard_screen_about => 'O aplikaciji';

  @override
  String get wizard_screen_open_projects_tip => 'Svi projekti automatski će se spremiti lokalno';

  @override
  String get wizard_screen_open_projects => 'Otvori postojeći projekt';

  @override
  String get wizard_screen_email_us => 'Pošaljite nam e-mail';

  @override
  String get language_screen_language => 'Jezik';

  @override
  String get project_view_no_videos => 'Nema dostupnih video izvora.';

  @override
  String get about_screen_title => 'O aplikaciji';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Verzija aplikacije';

  @override
  String get about_screen_models => 'Modeli za prepoznavanje objekata';

  @override
  String get about_screen_benchmark => 'Testiranje performansi';

  @override
  String get about_screen_opencv_build_info => 'OpenCV informacije o izgradnji';

  @override
  String get benchmark_screen_title => 'Testiranje modela';

  @override
  String get benchmark_screen_recommended => 'Preporučeni model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Pokreni testiranje';

  @override
  String get benchmark_screen_start_failed => 'Neuspješno pokretanje testiranja, kôd pogreške je';

  @override
  String get benchmark_screen_models => 'Modeli za prepoznavanje objekata';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Potvrdi izlazak iz projekta';

  @override
  String get project_screen_exit_confirm_content => 'Napuštanje projekta zaustavit će brojanje. Jeste li sigurni da želite nastaviti?';

  @override
  String get project_screen_exit_button => 'Izlaz';

  @override
  String get project_screen_add_video_button => 'Dodaj video izvor';

  @override
  String get project_screen_from_desc => 'Čuvamo 24-satnu evidenciju, tako da možete pregledati bilo koji vremenski odsječak koji trebate.';

  @override
  String get project_screen_report_settings => 'Postavke';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Odaberite raspon filtera s popisa u nastavku';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Vrijeme završetka mora biti veće od vremena početka';

  @override
  String get filter_screen_error_custom => 'Prilagođeno';

  @override
  String get filter_screen_error_start => 'Početak';

  @override
  String get filter_screen_error_end => 'Kraj';

  @override
  String get settings_screen_title => 'Postavke';

  @override
  String get settings_screen_desc => 'Postavite naziv projekta, parametre detekcije, brisanje brojanja.';

  @override
  String get settings_screen_project_id => 'ID projekta';

  @override
  String get settings_screen_project_name => 'Naziv projekta';

  @override
  String get settings_screen_project_name_place_holder => 'Ilica 123 ili Park Maksimir';

  @override
  String get settings_screen_project_error => 'Naziv projekta ne može biti prazan';

  @override
  String get settings_screen_random_count_button => 'Dodaj nasumična brojanja';

  @override
  String get settings_screen_reset_count_header => 'Resetiraj sva brojanja u ovom projektu';

  @override
  String get settings_screen_reset_count_button => 'Resetiraj brojanja';

  @override
  String get settings_screen_reset_count_content => 'Jeste li sigurni da želite resetirati sva brojanja?';

  @override
  String get settings_screen_delete_header => 'Izbriši ovaj projekt';

  @override
  String get settings_screen_delete_content => 'Jeste li sigurni da želite izbrisati ovaj projekt?';

  @override
  String get settings_screen_delete_button => 'Izbriši';

  @override
  String get settings_screen_center_point_title => 'Središnja točka na meti';

  @override
  String get settings_screen_center_point_desc => 'Središnja točka pomaže odrediti je li meta unutar zone detekcije.';

  @override
  String get settings_screen_center_point_button => 'Prikaži središnju točku na meti';

  @override
  String get settings_screen_lost_target_title => 'Izgubljena meta';

  @override
  String get settings_screen_lost_target_desc => 'Kada praćenje objekta izgubi metu, ova opcija je čini vidljivom. Prema zadanim postavkama, izgubljene mete nisu prikazane.';

  @override
  String get settings_screen_lost_target_button => 'Prikaži izgubljenu metu';

  @override
  String get detection_screen_title => 'Postavke detekcije';

  @override
  String get detection_screen_models => 'Modeli';

  @override
  String get detection_screen_confidence => 'Pouzdanost';

  @override
  String get detection_screen_confidence_desc => 'pouzdanost iznad #0 smatra se valjanom detekcijom';

  @override
  String get detection_screen_low => 'Nisko';

  @override
  String get detection_screen_high => 'Visoko';

  @override
  String get detection_screen_nms => 'Ne-maksimalna supresija';

  @override
  String get detection_screen_nms_desc => '#0 Niži NMS prag (npr. 30%) agresivnije će uklanjati preklapajuće granične okvire, dok će viši NMS prag (npr. 0.6) dopustiti više preklapanja';

  @override
  String get detection_screen_match => 'Podudaranje';

  @override
  String get detection_screen_match_desc => 'Podudaranje iznad #0 smatra se istim objektom.';

  @override
  String get detection_screen_lost => 'Izgubljeno';

  @override
  String get detection_screen_lost_desc => 'Praćeni objekt bit će uklonjen ako je izgubljen za #0';

  @override
  String get detection_screen_consider_valid => 'Smatraj valjanim nakon';

  @override
  String get detection_screen_consider_valid_desc => 'Praćeni objekt smatrat će se valjanim nakon #0';

  @override
  String get detection_screen_reset => 'Resetiraj';

  @override
  String get detection_screen_reset_content => 'Jeste li sigurni da želite resetirati postavke detekcije?';

  @override
  String get url_screen_title => 'URL živog prijenosa';

  @override
  String get url_screen_desc => 'Unesite URL živog prijenosa';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://primjer.com/stream ili rtsp://primjer.com/stream';

  @override
  String get add_video_screen_title => 'Dodaj video izvor';

  @override
  String get add_video_screen_from => 'Dodaj video izvor iz';

  @override
  String get webcam_screen_add_title => 'Dodaj web kameru';

  @override
  String get webcam_screen_edit_title => 'Odaberi web kameru';

  @override
  String get webcam_manager_webcam => 'Web kamera';

  @override
  String get camera_screen_front_camera => 'Prednja kamera';

  @override
  String get camera_screen_back_camera => 'Stražnja kamera';

  @override
  String get camera_screen_add_title => 'Dodaj kameru';

  @override
  String get camera_screen_edit_title => 'Odaberi kameru';

  @override
  String get camera_screen_zoom_level => 'Razina zumiranja';

  @override
  String get video_screen_name_empty => 'Naziv video izvora ne može biti prazan.';

  @override
  String get video_screen_desc => 'Upravljajte video izvorima, dodajte ili modificirajte zone detekcije.';

  @override
  String get video_screen_video_name => 'Naziv video izvora';

  @override
  String get video_screen_edit_placeholder => 'Kamera na ulaznim vratima ili Kamera na parkiralištu';

  @override
  String get video_screen_change_file => 'Promijeni datoteku';

  @override
  String get video_screen_add_zone => 'Dodaj zonu detekcije';

  @override
  String get video_screen_zones => 'Zone detekcije';

  @override
  String get video_screen_zones_desc => 'Koristite povuci i ispusti za prilagodbu zona';

  @override
  String get video_screen_tools => 'Alati';

  @override
  String get video_screen_move_bottom => 'Premjesti trenutnu zonu na dno';

  @override
  String get video_screen_add_point => 'Dodaj točku u trenutnu zonu';

  @override
  String get video_screen_remove_point => 'Ukloni točku iz trenutne zone';

  @override
  String get video_screen_playback_speed => 'Brzina reprodukcije';

  @override
  String get video_screen_playback_current => 'trenutno: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Izbriši ovaj video izvor';

  @override
  String get video_screen_delete_content => 'Jeste li sigurni da želite izbrisati ovaj video izvor?';

  @override
  String get video_screen_delete_button => 'Izbriši';

  @override
  String get video_screen_sources => 'Konfiguriraj izvor slike, ciljeve detekcije i parametre modela.';

  @override
  String get video_screen_targets => 'Ciljevi detekcije';

  @override
  String get video_screen_detection => 'Parametri modela';

  @override
  String get color_screen_title => 'Odaberi boju';

  @override
  String get zone_screen_desc => 'Zona detekcije može postaviti vrste objekata za detekciju i odabrati koje brojače prikazati, poput Otkriveno, Stvoreno i Ušlo.';

  @override
  String get zone_screen_name_placeholder => 'Naziv zone, poput Pločnik ili Parkiralište';

  @override
  String get zone_screen_zone_color => 'Boja zone';

  @override
  String get zone_screen_color => 'Boja';

  @override
  String get zone_screen_delete_header => 'Izbriši ovu zonu';

  @override
  String get zone_screen_delete_content => 'Jeste li sigurni da želite izbrisati ovu zonu?';

  @override
  String get zone_screen_delete_button => 'Izbriši';

  @override
  String get zone_screen_can_not_delete => 'Nije moguće izbrisati zonu';

  @override
  String get zone_screen_one_zone_required => 'Potrebna je barem jedna zona.';

  @override
  String get zone_screen_zone_name_required => 'Naziv zone ne može biti prazan';

  @override
  String get counter_screen_show_on => 'Prikaži na zaslonu';

  @override
  String get counter_screen_enabled => 'Omogućeno';

  @override
  String get counter_screen_reentry_threshold => 'Prag ponovnog ulaska';

  @override
  String get counter_screen_reentry_desc => 'Objekti moraju ući #0 puta, s #1 sekundi hlađenja između svakog izlaska i ponovnog ulaska, kako bi pokrenuli ponovno brojanje';

  @override
  String get counter_screen_reentry_title => 'Brojanje ponovnog ulaska';

  @override
  String get counter_screen_cooldown_threshold => 'Prag hlađenja';

  @override
  String get counter_screen_cooldown_desc => 'Ponovni ulazak zahtijeva #0 sekundi hlađenja nakon izlaska iz zone detekcije';

  @override
  String get counter_screen_cooldown_time => 'Vrijeme hlađenja';

  @override
  String get counter_screen_cooldown_in_seconds => 'u sekundama';

  @override
  String get counter_screen_stagnant_threshold => 'Prag stagnacije';

  @override
  String get counter_screen_stagnant_desc => 'Objekti koji ostanu nepomični više od #0 sekundi smatrat će se stagniranima';

  @override
  String get counter_screen_stagnant_consider => 'Smatraj stagniranim';

  @override
  String get counter_screen_stagnant_in_seconds => 'u sekundama';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefiks opisa';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufiks opisa';

  @override
  String get counter_screen_name_error => 'Naziv brojača ne može biti prazan';

  @override
  String get counter_screen_enabled_error => 'Pogreška';

  @override
  String get counter_screen_enabled_error_content => 'Prvo morate omogućiti drugi brojač, zatim možete onemogućiti ovaj brojač';

  @override
  String get objects_screen_title => 'Objekti';

  @override
  String get objects_screen_desc => 'Odaberite ciljeve detekcije poput osobe, automobila, autobusa, itd.';

  @override
  String get open_project_screen_title => 'Otvori projekt';

  @override
  String get open_project_screen_desc => 'Otvorite prethodno kreirane projekte, zadržavajući samo najnovijih 20.';

  @override
  String get open_project_screen_no_project => 'Nije pronađen nijedan projekt.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Video izvor';

  @override
  String get default_zone_name => 'Zona detekcije';

  @override
  String get error_oops => 'Ups, nešto je pošlo po krivu';

  @override
  String get error_content => 'Došlo je do neočekivane pogreške. Želite li poslati izvješće putem e-maila?';

  @override
  String get error_report => 'Pošalji nam e-mail';

  @override
  String get submit => 'Pošalji';

  @override
  String get ok => 'U redu';

  @override
  String get cancel => 'Odustani';

  @override
  String get yes => 'Da';

  @override
  String get no => 'Ne';

  @override
  String get close => 'Zatvori';

  @override
  String get back => 'Natrag';
}
