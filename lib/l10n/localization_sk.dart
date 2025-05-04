// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class LocalizationSk extends Localization {
  LocalizationSk([String locale = 'sk']) : super(locale);

  @override
  String get product_name => 'Počítadlo';

  @override
  String get product_desc => 'Využíva počítačové videnie a umelú inteligenciu na počítanie ľudí, vozidiel, domácich zvierat a ďalších objektov.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'URL živého prenosu';

  @override
  String get video_sources_file => 'Súbor';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nenájdená';

  @override
  String get video_sources_camera_not_found_message => 'Na použitie kamery je potrebné udeliť povolenie';

  @override
  String get video_sources_webcam_not_found_title => 'Webkamera nenájdená';

  @override
  String get video_sources_webcam_not_found_message => 'Skontrolujte povolenie aplikácie a pripojenie webkamery';

  @override
  String get wizard_screen_desc => 'Vytvorte nový projekt nižšie pre začatie počítania.';

  @override
  String get wizard_screen_new_project_from => 'Nový projekt z';

  @override
  String get wizard_screen_language => 'Jazyk';

  @override
  String get wizard_screen_about => 'O aplikácii';

  @override
  String get wizard_screen_open_projects_tip => 'Všetky projekty sa automaticky uložia lokálne';

  @override
  String get wizard_screen_open_projects => 'Otvoriť existujúci projekt';

  @override
  String get wizard_screen_email_us => 'Napíšte nám';

  @override
  String get language_screen_language => 'Jazyk';

  @override
  String get project_view_no_videos => 'Nie je dostupný žiadny zdroj videa.';

  @override
  String get about_screen_title => 'O aplikácii';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Verzia aplikácie';

  @override
  String get about_screen_models => 'Modely detekcie objektov';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informácie o zostavení OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmarky modelov';

  @override
  String get benchmark_screen_recommended => 'Odporúčaný model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Spustiť benchmark';

  @override
  String get benchmark_screen_start_failed => 'Spustenie benchmarku zlyhalo, kód chyby je';

  @override
  String get benchmark_screen_models => 'Modely detekcie objektov';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Potvrďte ukončenie projektu';

  @override
  String get project_screen_exit_confirm_content => 'Opustenie projektu zastaví počítanie. Naozaj chcete pokračovať?';

  @override
  String get project_screen_exit_button => 'Ukončiť';

  @override
  String get project_screen_add_video_button => 'Pridať zdroj videa';

  @override
  String get project_screen_from_desc => 'Uchovávame priebežný 24-hodinový záznam, aby ste mohli zobraziť akýkoľvek časový úsek.';

  @override
  String get project_screen_report_settings => 'Nastavenia';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Vyberte rozsah filtra zo zoznamu nižšie';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'Čas ukončenia musí byť väčší ako čas začiatku';

  @override
  String get filter_screen_error_custom => 'Vlastný';

  @override
  String get filter_screen_error_start => 'Začiatok';

  @override
  String get filter_screen_error_end => 'Koniec';

  @override
  String get settings_screen_title => 'Nastavenia';

  @override
  String get settings_screen_desc => 'Nastavte názov projektu, parametre detekcie, vynulovanie počítadiel.';

  @override
  String get settings_screen_project_id => 'ID projektu';

  @override
  String get settings_screen_project_name => 'Názov projektu';

  @override
  String get settings_screen_project_name_place_holder => 'Hlavná 123 alebo Námestie SNP';

  @override
  String get settings_screen_project_error => 'Názov projektu nemôže byť prázdny';

  @override
  String get settings_screen_random_count_button => 'Pridať náhodné počty';

  @override
  String get settings_screen_reset_count_header => 'Vynulovať všetky počítadlá v tomto projekte';

  @override
  String get settings_screen_reset_count_button => 'Vynulovať počítadlá';

  @override
  String get settings_screen_reset_count_content => 'Naozaj chcete vynulovať všetky počítadlá?';

  @override
  String get settings_screen_delete_header => 'Odstrániť tento projekt';

  @override
  String get settings_screen_delete_content => 'Naozaj chcete odstrániť tento projekt?';

  @override
  String get settings_screen_delete_button => 'Odstrániť';

  @override
  String get settings_screen_center_point_title => 'Stredový bod na cieli';

  @override
  String get settings_screen_center_point_desc => 'Stredový bod pomáha určiť, či je cieľ v zóne zásahu.';

  @override
  String get settings_screen_center_point_button => 'Zobraziť stredový bod na cieli';

  @override
  String get settings_screen_lost_target_title => 'Stratený cieľ';

  @override
  String get settings_screen_lost_target_desc => 'Keď sledovanie objektu stratí cieľ, táto možnosť ho zviditeľní. Predvolene sa stratené ciele nezobrazujú.';

  @override
  String get settings_screen_lost_target_button => 'Zobraziť stratený cieľ';

  @override
  String get detection_screen_title => 'Nastavenia detekcie';

  @override
  String get detection_screen_models => 'Modely';

  @override
  String get detection_screen_confidence => 'Spoľahlivosť';

  @override
  String get detection_screen_confidence_desc => 'spoľahlivosť nad #0 sa považuje za platnú detekciu';

  @override
  String get detection_screen_low => 'Nízka';

  @override
  String get detection_screen_high => 'Vysoká';

  @override
  String get detection_screen_nms => 'Potlačenie nemaximálnych hodnôt';

  @override
  String get detection_screen_nms_desc => '#0 Nižšia hranica NMS (napr. 0.3-0.4) prísnejšie odstraňuje prekrývajúce sa rámčeky a znižuje falošne pozitívne výsledky ale môže prehliadnuť prekrývajúce sa osoby. Vyššia hranica (0.7-0.9) zachováva viac rámčekov čo môže zvýšiť falošne pozitívne výsledky ale lepšie detekuje prekrývajúce sa osoby.';

  @override
  String get detection_screen_match => 'Zhoda';

  @override
  String get detection_screen_match_desc => '#0 matchThreshold je kľúčový parameter pri sledovaní objektov ktorý meria stupeň zhody medzi rôznymi detekčnými rámčekmi. Nižšia hodnota uľahčuje prepojenie objektov ale zvyšuje riziko nesprávnych prepojení. Vyššia hodnota je pri prepojeniach objektov prísnejšia ale môže prehliadnuť niektoré skutočné zhody.';

  @override
  String get detection_screen_lost => 'Stratený';

  @override
  String get detection_screen_lost_desc => 'Dynamicky určuje čas na odstránenie stratených objektov medzi #0 a #1 na základe rýchlosti pohybu';

  @override
  String get detection_screen_consider_valid => 'Považovať za platný po';

  @override
  String get detection_screen_consider_valid_desc => 'Sledovaný objekt bude považovaný za platný po #0';

  @override
  String get detection_screen_reset => 'Resetovať';

  @override
  String get detection_screen_reset_content => 'Naozaj chcete resetovať nastavenia detekcie?';

  @override
  String get url_screen_title => 'URL živého prenosu';

  @override
  String get url_screen_desc => 'Zadajte URL živého prenosu';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream alebo rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Pridať zdroj videa';

  @override
  String get add_video_screen_from => 'Pridať zdroj videa z';

  @override
  String get webcam_screen_add_title => 'Pridať webkameru';

  @override
  String get webcam_screen_edit_title => 'Vybrať webkameru';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Predná kamera';

  @override
  String get camera_screen_back_camera => 'Zadná kamera';

  @override
  String get camera_screen_add_title => 'Pridať kameru';

  @override
  String get camera_screen_edit_title => 'Vybrať kameru';

  @override
  String get camera_screen_zoom_level => 'Úroveň priblíženia';

  @override
  String get video_screen_name_empty => 'Názov videa nemôže byť prázdny.';

  @override
  String get video_screen_desc => 'Spravujte zdroje videa, pridávajte alebo upravujte detekčné zóny.';

  @override
  String get video_screen_video_name => 'Názov zdroja videa';

  @override
  String get video_screen_edit_placeholder => 'Kamera pri vchode alebo Kamera na parkovisku';

  @override
  String get video_screen_change_file => 'Zmeniť súbor';

  @override
  String get video_screen_add_zone => 'Pridať detekčnú zónu';

  @override
  String get video_screen_zones => 'Detekčné zóny';

  @override
  String get video_screen_zones_desc => 'Použite presúvanie na úpravu zón';

  @override
  String get video_screen_tools => 'Nástroje';

  @override
  String get video_screen_move_bottom => 'Presunúť aktuálnu zónu nadol';

  @override
  String get video_screen_add_point => 'Pridať bod do aktuálnej zóny';

  @override
  String get video_screen_remove_point => 'Odstrániť bod z aktuálnej zóny';

  @override
  String get video_screen_playback_speed => 'Rýchlosť prehrávania';

  @override
  String get video_screen_playback_current => 'aktuálna: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Odstrániť tento zdroj videa';

  @override
  String get video_screen_delete_content => 'Naozaj chcete odstrániť tento zdroj videa?';

  @override
  String get video_screen_delete_button => 'Odstrániť';

  @override
  String get video_screen_sources => 'Nakonfigurujte zdroj obrazu, ciele detekcie a parametre modelu.';

  @override
  String get video_screen_targets => 'Ciele detekcie';

  @override
  String get video_screen_detection => 'Parametre modelu';

  @override
  String get color_screen_title => 'Vyberte farbu';

  @override
  String get zone_screen_desc => 'Detekčná zóna môže nastaviť typy objektov na detekciu a vybrať, ktoré počítadlá zobraziť, ako napríklad Detegované, Vytvorené a Vstúpené.';

  @override
  String get zone_screen_name_placeholder => 'Názov zóny, ako Chodník alebo Parkovisko';

  @override
  String get zone_screen_zone_color => 'Farba zóny';

  @override
  String get zone_screen_color => 'Farba';

  @override
  String get zone_screen_delete_header => 'Odstrániť túto zónu';

  @override
  String get zone_screen_delete_content => 'Naozaj chcete odstrániť túto zónu?';

  @override
  String get zone_screen_delete_button => 'Odstrániť';

  @override
  String get zone_screen_can_not_delete => 'Nemožno odstrániť zónu';

  @override
  String get zone_screen_one_zone_required => 'Vyžaduje sa aspoň jedna zóna.';

  @override
  String get zone_screen_zone_name_required => 'Názov zóny nemôže byť prázdny';

  @override
  String get counter_screen_show_on => 'Zobraziť na obrazovke';

  @override
  String get counter_screen_enabled => 'Povolené';

  @override
  String get counter_screen_reentry_threshold => 'Hranica opätovného vstupu';

  @override
  String get counter_screen_reentry_desc => 'Objekty musia vstúpiť #0 krát, s #1 sekundovou dobou ochladenia medzi každým výstupom a opätovným vstupom, aby spustili opätovný vstup';

  @override
  String get counter_screen_reentry_title => 'Počet opätovných vstupov';

  @override
  String get counter_screen_cooldown_threshold => 'Hranica ochladzovacej doby';

  @override
  String get counter_screen_cooldown_desc => 'Opätovný vstup vyžaduje #0 sekundovú dobu ochladenia po opustení detekčnej zóny';

  @override
  String get counter_screen_cooldown_time => 'Doba ochladenia';

  @override
  String get counter_screen_cooldown_in_seconds => 'v sekundách';

  @override
  String get counter_screen_stagnant_threshold => 'Hranica stagnácie';

  @override
  String get counter_screen_stagnant_desc => 'Objekty, ktoré zostanú nehybné viac ako #0 sekúnd, budú považované za stagnujúce';

  @override
  String get counter_screen_stagnant_consider => 'Považovať za stagnujúce';

  @override
  String get counter_screen_stagnant_in_seconds => 'v sekundách';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Predpona popisu';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Prípona popisu';

  @override
  String get counter_screen_name_error => 'Názov počítadla nemôže byť prázdny';

  @override
  String get counter_screen_enabled_error => 'Chyba';

  @override
  String get counter_screen_enabled_error_content => 'Najprv musíte povoliť iné počítadlo, až potom môžete zakázať toto počítadlo';

  @override
  String get objects_screen_title => 'Objekty';

  @override
  String get objects_screen_desc => 'Vyberte ciele detekcie ako osoba, auto, autobus atď.';

  @override
  String get open_project_screen_title => 'Otvoriť projekt';

  @override
  String get open_project_screen_desc => 'Otvorte predtým vytvorené projekty, pričom sa zachováva iba posledných 20.';

  @override
  String get open_project_screen_no_project => 'Nenašiel sa žiadny projekt.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Zdroj videa';

  @override
  String get default_zone_name => 'Detekčná zóna';

  @override
  String get error_oops => 'Ups, niečo sa pokazilo';

  @override
  String get error_content => 'Došlo k neočakávanej chybe. Chcete odoslať emailovú správu?';

  @override
  String get error_report => 'Napísať email';

  @override
  String get submit => 'Odoslať';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get yes => 'Áno';

  @override
  String get no => 'Nie';

  @override
  String get close => 'Zavrieť';

  @override
  String get back => 'Späť';

  @override
  String get zone_screen_zone => 'Zóna';

  @override
  String get zone_screen_zone_show_summary => 'Zobraziť súhrn na obrazovke';

  @override
  String get video_sources_photos_denied => 'Prístup k fotografiám zamietnutý';

  @override
  String get video_sources_photos_goto_settings => 'Prejsť do nastavení';

  @override
  String get video_sources_camera_denied => 'Prístup ku kamere zamietnutý';

  @override
  String get video_sources_photos_denied_msg => 'Prejdite do nastavení a povoľte prístup k fotografiám pre túto aplikáciu.';

  @override
  String get video_sources_camera_denied_msg => 'Prejdite do nastavení a povoľte prístup ku kamere pre túto aplikáciu.';
}
