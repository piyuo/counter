// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class LocalizationSl extends Localization {
  LocalizationSl([String locale = 'sl']) : super(locale);

  @override
  String get about_screen_app_version => 'Verzija aplikacije';

  @override
  String get about_screen_benchmark => 'Primerjalni test';

  @override
  String get about_screen_models => 'Modeli za zaznavanje objektov';

  @override
  String get about_screen_opencv_build_info => 'OpenCV informacije o gradnji';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_title => 'O aplikaciji';

  @override
  String get add_video_screen_from => 'Dodaj vir videoposnetka iz';

  @override
  String get add_video_screen_title => 'Dodaj vir videoposnetka';

  @override
  String get back => 'Nazaj';

  @override
  String get benchmark_screen_fps => 'Sličice na sekundo';

  @override
  String get benchmark_screen_models => 'Modeli za zaznavanje objektov';

  @override
  String get benchmark_screen_recommended => 'Priporočeni model';

  @override
  String get benchmark_screen_start_button => 'Začni primerjalni test';

  @override
  String get benchmark_screen_start_failed =>
      'Ni mogoče zagnati primerjalnega testa, koda napake je';

  @override
  String get benchmark_screen_title => 'Primerjalni testi modelov';

  @override
  String get camera_screen_add_title => 'Dodaj kamero';

  @override
  String get camera_screen_back_camera => 'Zadnja kamera';

  @override
  String get camera_screen_edit_title => 'Izberi kamero';

  @override
  String get camera_screen_front_camera => 'Sprednja kamera';

  @override
  String get camera_screen_zoom_level => 'Raven povečave';

  @override
  String get cancel => 'Prekliči';

  @override
  String get close => 'Zapri';

  @override
  String get color_screen_title => 'Izberi barvo';

  @override
  String get counter_screen_cooldown_desc =>
      'Ponovni vstop zahteva #0 sekundno ohlajanje po izhodu iz območja zaznavanja';

  @override
  String get counter_screen_cooldown_in_seconds => 'v sekundah';

  @override
  String get counter_screen_cooldown_threshold => 'Prag ohlajanja';

  @override
  String get counter_screen_cooldown_time => 'Čas ohlajanja';

  @override
  String get counter_screen_enabled => 'Omogočeno';

  @override
  String get counter_screen_enabled_error => 'Napaka';

  @override
  String get counter_screen_enabled_error_content =>
      'Najprej morate omogočiti drug števec, nato lahko onemogočite ta števec';

  @override
  String get counter_screen_name_error => 'Ime števca ne sme biti prazno';

  @override
  String get counter_screen_reentry_desc =>
      'Objekti morajo vstopiti #0 krat, z #1 sekundnim časom ohlajanja med vsakim izhodom in ponovnim vstopom, da sprožijo ponovni vstop';

  @override
  String get counter_screen_reentry_threshold => 'Prag ponovnega vstopa';

  @override
  String get counter_screen_reentry_title => 'Štetje ponovnih vstopov';

  @override
  String get counter_screen_show_on => 'Prikaži na zaslonu';

  @override
  String get counter_screen_stagnant_consider => 'Upoštevaj kot mirujoče';

  @override
  String get counter_screen_stagnant_desc =>
      'Objekti, ki ostanejo na mestu več kot #0 sekund, bodo obravnavani kot mirujoči';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Predpona opisa';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Pripona opisa';

  @override
  String get counter_screen_stagnant_in_seconds => 'v sekundah';

  @override
  String get counter_screen_stagnant_threshold => 'Prag mirovanja';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Vir videoposnetka';

  @override
  String get default_zone_name => 'Območje zaznavanja';

  @override
  String get detection_screen_confidence => 'Zaupanje';

  @override
  String get detection_screen_confidence_desc =>
      'zaupanje nad #0 se šteje kot veljavno zaznavanje';

  @override
  String get detection_screen_consider_valid => 'Upoštevaj kot veljavno po';

  @override
  String get detection_screen_consider_valid_desc =>
      'Objekt sledenja bo veljal za veljavnega po #0';

  @override
  String get detection_screen_high => 'Visoko';

  @override
  String get detection_screen_lost => 'Izgubljeno';

  @override
  String get detection_screen_lost_desc =>
      'Dinamično določa čas odstranitve izgubljenih predmetov med #0 in #1 glede na hitrost gibanja';

  @override
  String get detection_screen_low => 'Nizko';

  @override
  String get detection_screen_match => 'Ujemanje';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold je ključni parameter pri sledenju objektov ki meri stopnjo ujemanja med različnimi zaznavnimi okvirji. Nižja vrednost olajša povezovanje objektov vendar poveča tveganje napačnih povezav. Višja vrednost je pri povezovanju objektov strožja vendar lahko spregleda nekatere resnične ujemanja.';

  @override
  String get detection_screen_models => 'Modeli';

  @override
  String get detection_screen_nms => 'Neprekosljivo zatiranje maksimumov';

  @override
  String get detection_screen_nms_desc =>
      '#0 Nižji prag NMS (npr. 0.3-0.4) strožje odstrani prekrivajoče se okvirje in zmanjša lažno pozitivne rezultate vendar lahko spregleda prekrivajoče se osebe. Višji prag (0.7-0.9) ohrani več okvirjev kar lahko poveča lažno pozitivne rezultate vendar bolje zazna prekrivajoče se osebe.';

  @override
  String get detection_screen_reset => 'Ponastavi';

  @override
  String get detection_screen_reset_content =>
      'Ali ste prepričani, da želite ponastaviti nastavitve zaznavanja?';

  @override
  String get detection_screen_title => 'Nastavitve zaznavanja';

  @override
  String get error_content =>
      'Prišlo je do nepričakovane napake. Želite poslati poročilo po e-pošti?';

  @override
  String get error_oops => 'Ups, nekaj je šlo narobe';

  @override
  String get error_report => 'Pišite nam';

  @override
  String get filter_screen_desc => 'Izberite razpon filtra s spodnjega seznama';

  @override
  String get filter_screen_error_content =>
      'Končni čas mora biti večji od začetnega časa';

  @override
  String get filter_screen_error_custom => 'Po meri';

  @override
  String get filter_screen_error_end => 'Konec';

  @override
  String get filter_screen_error_start => 'Začetek';

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
      'Izberite cilje zaznavanja, kot so oseba, avtomobil, avtobus itd.';

  @override
  String get objects_screen_title => 'Objekti';

  @override
  String get ok => 'V redu';

  @override
  String get open_project_screen_desc =>
      'Odprite prej ustvarjene projekte, obdržite le zadnjih 20.';

  @override
  String get open_project_screen_no_project => 'Ni najdenih projektov.';

  @override
  String get open_project_screen_title => 'Odpri projekt';

  @override
  String get product_copyright => 'Avtorske pravice © 2025';

  @override
  String get product_desc =>
      'Uporaba računalniškega vida in umetne inteligence za štetje ljudi, vozil, hišnih ljubljenčkov in več.';

  @override
  String get product_name => 'Števec';

  @override
  String get project_screen_add_video_button => 'Dodaj vir videoposnetka';

  @override
  String get project_screen_exit_button => 'Izhod';

  @override
  String get project_screen_exit_confirm_content =>
      'Če zapustite projekt, se bo štetje ustavilo. Ali ste prepričani, da želite nadaljevati?';

  @override
  String get project_screen_exit_confirm_title => 'Potrdi izhod iz projekta';

  @override
  String get project_screen_from_desc =>
      'Hranimo 24-urni zapis, zato si lahko ogledate katerikoli časovni odsek.';

  @override
  String get project_screen_report_settings => 'Nastavitve';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_view_no_videos => 'Ni virov videoposnetkov.';

  @override
  String get settings_screen_center_point_button =>
      'Prikaži središčno točko na tarči';

  @override
  String get settings_screen_center_point_desc =>
      'Središčna točka pomaga določiti, ali je tarča znotraj območja zadetka.';

  @override
  String get settings_screen_center_point_title => 'Središčna točka na tarči';

  @override
  String get settings_screen_delete_button => 'Izbriši';

  @override
  String get settings_screen_delete_content =>
      'Ali ste prepričani, da želite izbrisati ta projekt?';

  @override
  String get settings_screen_delete_header => 'Izbriši ta projekt';

  @override
  String get settings_screen_desc =>
      'Nastavite ime projekta, parametre zaznavanja, brisanje štetja.';

  @override
  String get settings_screen_lost_target_button => 'Prikaži izgubljeno tarčo';

  @override
  String get settings_screen_lost_target_desc =>
      'Ko sledenje objektov izgubi tarčo, ta možnost omogoči, da je vidna. Privzeto izgubljene tarče niso prikazane.';

  @override
  String get settings_screen_lost_target_title => 'Izgubljena tarča';

  @override
  String get settings_screen_project_error => 'Ime projekta ne sme biti prazno';

  @override
  String get settings_screen_project_id => 'ID projekta';

  @override
  String get settings_screen_project_name => 'Ime projekta';

  @override
  String get settings_screen_project_name_place_holder =>
      'Slovenska 123 ali Park Tivoli';

  @override
  String get settings_screen_random_count_button => 'Dodaj naključna štetja';

  @override
  String get settings_screen_reset_count_button => 'Ponastavi štetja';

  @override
  String get settings_screen_reset_count_content =>
      'Ali ste prepričani, da želite ponastaviti vsa štetja?';

  @override
  String get settings_screen_reset_count_header =>
      'Ponastavi vsa štetja v tem projektu';

  @override
  String get settings_screen_title => 'Nastavitve';

  @override
  String get submit => 'Pošlji';

  @override
  String get url_screen_desc => 'Vnesite URL naslov v živo';

  @override
  String get url_screen_title => 'URL naslov v živo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream ali rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'Dodaj točko v trenutno območje';

  @override
  String get video_screen_add_zone => 'Dodaj območje zaznavanja';

  @override
  String get video_screen_change_file => 'Spremeni datoteko';

  @override
  String get video_screen_delete_button => 'Izbriši';

  @override
  String get video_screen_delete_content =>
      'Ali ste prepričani, da želite izbrisati ta vir videoposnetka?';

  @override
  String get video_screen_delete_header => 'Izbriši ta vir videoposnetka';

  @override
  String get video_screen_desc =>
      'Upravljanje virov videoposnetkov, dodajanje ali spreminjanje območij zaznavanja.';

  @override
  String get video_screen_detection => 'Parametri modela';

  @override
  String get video_screen_edit_placeholder =>
      'Kamera pri vhodnih vratih ali Kamera na parkirišču';

  @override
  String get video_screen_move_bottom => 'Premakni trenutno območje na dno';

  @override
  String get video_screen_name_empty => 'Ime videoposnetka ne sme biti prazno.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'trenutno: ';

  @override
  String get video_screen_playback_speed => 'Hitrost predvajanja';

  @override
  String get video_screen_remove_point =>
      'Odstrani točko iz trenutnega območja';

  @override
  String get video_screen_sources =>
      'Konfigurirajte vir slike, tarče zaznavanja in parametre modela.';

  @override
  String get video_screen_targets => 'Tarče zaznavanja';

  @override
  String get video_screen_tools => 'Orodja';

  @override
  String get video_screen_video_name => 'Ime vira videoposnetka';

  @override
  String get video_screen_zones => 'Območja zaznavanja';

  @override
  String get video_screen_zones_desc =>
      'Uporabite povleci in spusti za prilagoditev območij';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_denied => 'Dostop do kamere zavrnjen';

  @override
  String get video_sources_camera_denied_msg =>
      'Pojdite v nastavitve in dovolite dostop do kamere za to aplikacijo.';

  @override
  String get video_sources_camera_not_found_message =>
      'Za uporabo kamere potrebujete dovoljenje';

  @override
  String get video_sources_camera_not_found_title => 'Kamera ni najdena';

  @override
  String get video_sources_file => 'Datoteka';

  @override
  String get video_sources_live_stream => 'URL naslov v živo';

  @override
  String get video_sources_photos_denied => 'Dostop do fotografij zavrnjen';

  @override
  String get video_sources_photos_denied_msg =>
      'Pojdite v nastavitve in dovolite dostop do fotografij za to aplikacijo.';

  @override
  String get video_sources_photos_goto_settings => 'Pojdi v nastavitve';

  @override
  String get video_sources_webcam => 'Spletna kamera';

  @override
  String get video_sources_webcam_not_found_message =>
      'Preverite dovoljenje aplikacije in povezavo spletne kamere';

  @override
  String get video_sources_webcam_not_found_title =>
      'Spletna kamera ni najdena';

  @override
  String get webcam_manager_webcam => 'Spletna kamera';

  @override
  String get webcam_screen_add_title => 'Dodaj spletno kamero';

  @override
  String get webcam_screen_edit_title => 'Izberi spletno kamero';

  @override
  String get wizard_screen_about => 'O aplikaciji';

  @override
  String get wizard_screen_desc => 'Ustvarite nov projekt za začetek štetja.';

  @override
  String get wizard_screen_email_us => 'Pišite nam';

  @override
  String get wizard_screen_language => 'Jezik';

  @override
  String get wizard_screen_new_project_from => 'Nov projekt iz';

  @override
  String get wizard_screen_open_projects => 'Odpri obstoječi projekt';

  @override
  String get wizard_screen_open_projects_tip =>
      'Vsi projekti se bodo samodejno shranili lokalno';

  @override
  String get yes => 'Da';

  @override
  String get zone_screen_can_not_delete => 'Območja ni mogoče izbrisati';

  @override
  String get zone_screen_color => 'Barva';

  @override
  String get zone_screen_delete_button => 'Izbriši';

  @override
  String get zone_screen_delete_content =>
      'Ali ste prepričani, da želite izbrisati to območje?';

  @override
  String get zone_screen_delete_header => 'Izbriši to območje';

  @override
  String get zone_screen_desc =>
      'Območje zaznavanja lahko nastavi vrste objektov za zaznavanje in izbere, kateri števci se prikažejo, kot so Zaznani, Nastali in Vstopili.';

  @override
  String get zone_screen_name_placeholder =>
      'Ime območja, kot je Pločnik ali Parkirišče';

  @override
  String get zone_screen_one_zone_required => 'Potrebno je vsaj eno območje.';

  @override
  String get zone_screen_zone => 'Območje';

  @override
  String get zone_screen_zone_color => 'Barva območja';

  @override
  String get zone_screen_zone_name_required => 'Ime območja ne sme biti prazno';

  @override
  String get zone_screen_zone_show_summary => 'Prikaži povzetek na zaslonu';
}
