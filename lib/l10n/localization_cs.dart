// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class LocalizationCs extends Localization {
  LocalizationCs([String locale = 'cs']) : super(locale);

  @override
  String get product_name => 'Počítadlo';

  @override
  String get product_desc => 'Využívá počítačové vidění a umělou inteligenci k počítání osob, vozidel, domácích mazlíčků a dalších objektů.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'URL živého přenosu';

  @override
  String get video_sources_file => 'Soubor';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nenalezena';

  @override
  String get video_sources_camera_not_found_message => 'Pro použití kamery je nutné udělit povolení';

  @override
  String get video_sources_webcam_not_found_title => 'Webkamera nenalezena';

  @override
  String get video_sources_webcam_not_found_message => 'Zkontrolujte povolení aplikace a připojení kamery';

  @override
  String get wizard_screen_desc => 'Vytvořte nový projekt a začněte počítat.';

  @override
  String get wizard_screen_new_project_from => 'Nový projekt z';

  @override
  String get wizard_screen_language => 'Jazyk';

  @override
  String get wizard_screen_about => 'O aplikaci';

  @override
  String get wizard_screen_open_projects_tip => 'Všechny projekty se automaticky ukládají lokálně';

  @override
  String get wizard_screen_open_projects => 'Otevřít existující projekt';

  @override
  String get wizard_screen_email_us => 'Napište nám';

  @override
  String get language_screen_language => 'Jazyk';

  @override
  String get project_view_no_videos => 'Žádný zdroj videa není k dispozici.';

  @override
  String get about_screen_title => 'O aplikaci';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Verze aplikace';

  @override
  String get about_screen_models => 'Modely detekce objektů';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informace o sestavení OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmarky modelů';

  @override
  String get benchmark_screen_recommended => 'Doporučený model';

  @override
  String get benchmark_screen_fps => 'Snímky za sekundu';

  @override
  String get benchmark_screen_start_button => 'Spustit benchmark';

  @override
  String get benchmark_screen_start_failed => 'Spuštění benchmarku selhalo, kód chyby je';

  @override
  String get benchmark_screen_models => 'Modely detekce objektů';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Potvrďte ukončení projektu';

  @override
  String get project_screen_exit_confirm_content => 'Opuštění projektu zastaví počítání. Opravdu chcete pokračovat?';

  @override
  String get project_screen_exit_button => 'Ukončit';

  @override
  String get project_screen_add_video_button => 'Přidat zdroj videa';

  @override
  String get project_screen_from_desc => 'Udržujeme klouzavý 24hodinový záznam, takže můžete zobrazit jakýkoliv časový úsek.';

  @override
  String get project_screen_report_settings => 'Nastavení';

  @override
  String get filter_screen_title => 'Filtr';

  @override
  String get filter_screen_desc => 'Vyberte rozsah filtru ze seznamu níže';

  @override
  String get filter_screen_error_title => 'Filtr';

  @override
  String get filter_screen_error_content => 'Koncový čas musí být větší než počáteční';

  @override
  String get filter_screen_error_custom => 'Vlastní';

  @override
  String get filter_screen_error_start => 'Začátek';

  @override
  String get filter_screen_error_end => 'Konec';

  @override
  String get settings_screen_title => 'Nastavení';

  @override
  String get settings_screen_desc => 'Nastavení názvu projektu, parametrů detekce, vynulování počítadel.';

  @override
  String get settings_screen_project_id => 'ID projektu';

  @override
  String get settings_screen_project_name => 'Název projektu';

  @override
  String get settings_screen_project_name_place_holder => 'Hlavní 123 nebo Náměstí Republiky';

  @override
  String get settings_screen_project_error => 'Název projektu nemůže být prázdný';

  @override
  String get settings_screen_random_count_button => 'Přidat náhodná počítadla';

  @override
  String get settings_screen_reset_count_header => 'Vynulovat všechna počítadla v tomto projektu';

  @override
  String get settings_screen_reset_count_button => 'Vynulovat počítadla';

  @override
  String get settings_screen_reset_count_content => 'Opravdu chcete vynulovat všechna počítadla?';

  @override
  String get settings_screen_delete_header => 'Smazat tento projekt';

  @override
  String get settings_screen_delete_content => 'Opravdu chcete smazat tento projekt?';

  @override
  String get settings_screen_delete_button => 'Smazat';

  @override
  String get settings_screen_center_point_title => 'Středový bod na cíli';

  @override
  String get settings_screen_center_point_desc => 'Středový bod pomáhá určit, zda se cíl nachází v zóně zásahu.';

  @override
  String get settings_screen_center_point_button => 'Zobrazit středový bod na cíli';

  @override
  String get settings_screen_lost_target_title => 'Ztracený cíl';

  @override
  String get settings_screen_lost_target_desc => 'Když sledování objektů ztratí cíl, tato možnost ho zviditelní. Ve výchozím nastavení nejsou ztracené cíle zobrazeny.';

  @override
  String get settings_screen_lost_target_button => 'Zobrazit ztracený cíl';

  @override
  String get detection_screen_title => 'Nastavení detekce';

  @override
  String get detection_screen_models => 'Modely';

  @override
  String get detection_screen_confidence => 'Jistota';

  @override
  String get detection_screen_confidence_desc => 'jistota nad #0 je považována za platnou detekci';

  @override
  String get detection_screen_low => 'Nízká';

  @override
  String get detection_screen_high => 'Vysoká';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Nižší práh NMS (např. 0.3-0.4) přísněji odstraňuje překrývající se rámečky a snižuje falešně pozitivní výsledky ale může přehlédnout překrývající se osoby. Vyšší práh (0.7-0.9) zachovává více rámečků což může zvýšit falešně pozitivní výsledky ale lépe detekuje překrývající se osoby.';

  @override
  String get detection_screen_match => 'Shoda';

  @override
  String get detection_screen_match_desc => '#0 matchThreshold je klíčový parametr ve sledování objektů který měří míru shody mezi různými detekčními rámečky. Nižší hodnota usnadňuje propojení objektů ale zvyšuje riziko chybných propojení. Vyšší hodnota je při propojování objektů přísnější ale může přehlédnout některé skutečné shody.';

  @override
  String get detection_screen_lost => 'Ztráta';

  @override
  String get detection_screen_lost_desc => 'Dynamicky určuje čas pro odstranění ztracených objektů mezi #0 a #1 podle rychlosti pohybu';

  @override
  String get detection_screen_consider_valid => 'Považovat za platný po';

  @override
  String get detection_screen_consider_valid_desc => 'Sledovaný objekt bude považován za platný po #0';

  @override
  String get detection_screen_reset => 'Resetovat';

  @override
  String get detection_screen_reset_content => 'Opravdu chcete resetovat nastavení detekce?';

  @override
  String get url_screen_title => 'URL živého přenosu';

  @override
  String get url_screen_desc => 'Zadejte prosím URL živého přenosu';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream nebo rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Přidat zdroj videa';

  @override
  String get add_video_screen_from => 'Přidat zdroj videa z';

  @override
  String get webcam_screen_add_title => 'Přidat webkameru';

  @override
  String get webcam_screen_edit_title => 'Vybrat webkameru';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Přední kamera';

  @override
  String get camera_screen_back_camera => 'Zadní kamera';

  @override
  String get camera_screen_add_title => 'Přidat kameru';

  @override
  String get camera_screen_edit_title => 'Vybrat kameru';

  @override
  String get camera_screen_zoom_level => 'Úroveň přiblížení';

  @override
  String get video_screen_name_empty => 'Název zdroje videa nemůže být prázdný.';

  @override
  String get video_screen_desc => 'Správa zdrojů videa, přidávání nebo úprava detekčních zón.';

  @override
  String get video_screen_video_name => 'Název zdroje videa';

  @override
  String get video_screen_edit_placeholder => 'Kamera u vchodu nebo Kamera na parkovišti';

  @override
  String get video_screen_change_file => 'Změnit soubor';

  @override
  String get video_screen_add_zone => 'Přidat detekční zónu';

  @override
  String get video_screen_zones => 'Detekční zóny';

  @override
  String get video_screen_zones_desc => 'Použijte přetažení pro úpravu zón';

  @override
  String get video_screen_tools => 'Nástroje';

  @override
  String get video_screen_move_bottom => 'Přesunout aktuální zónu dolů';

  @override
  String get video_screen_add_point => 'Přidat bod do aktuální zóny';

  @override
  String get video_screen_remove_point => 'Odebrat bod z aktuální zóny';

  @override
  String get video_screen_playback_speed => 'Rychlost přehrávání';

  @override
  String get video_screen_playback_current => 'aktuální: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Smazat tento zdroj videa';

  @override
  String get video_screen_delete_content => 'Opravdu chcete smazat tento zdroj videa?';

  @override
  String get video_screen_delete_button => 'Smazat';

  @override
  String get video_screen_sources => 'Konfigurace zdroje obrazu, detekčních cílů a parametrů modelu.';

  @override
  String get video_screen_targets => 'Detekční cíle';

  @override
  String get video_screen_detection => 'Parametry modelu';

  @override
  String get color_screen_title => 'Vybrat barvu';

  @override
  String get zone_screen_desc => 'Detekční zóna může nastavit typy objektů k detekci a zvolit, která počítadla zobrazit, jako např. Detekováno, Vytvořeno a Vstoupilo.';

  @override
  String get zone_screen_name_placeholder => 'Název zóny, např. Chodník nebo Parkoviště';

  @override
  String get zone_screen_zone_color => 'Barva zóny';

  @override
  String get zone_screen_color => 'Barva';

  @override
  String get zone_screen_delete_header => 'Smazat tuto zónu';

  @override
  String get zone_screen_delete_content => 'Opravdu chcete smazat tuto zónu?';

  @override
  String get zone_screen_delete_button => 'Smazat';

  @override
  String get zone_screen_can_not_delete => 'Nelze smazat zónu';

  @override
  String get zone_screen_one_zone_required => 'Je vyžadována alespoň jedna zóna.';

  @override
  String get zone_screen_zone_name_required => 'Název zóny nemůže být prázdný';

  @override
  String get counter_screen_show_on => 'Zobrazit na obrazovce';

  @override
  String get counter_screen_enabled => 'Povoleno';

  @override
  String get counter_screen_reentry_threshold => 'Práh opětovného vstupu';

  @override
  String get counter_screen_reentry_desc => 'Objekty musí vstoupit #0 krát, s #1 sekundovou prodlevou mezi každým výstupem a opětovným vstupem, aby se spustil opětovný vstup';

  @override
  String get counter_screen_reentry_title => 'Počet opětovných vstupů';

  @override
  String get counter_screen_cooldown_threshold => 'Práh prodlevy';

  @override
  String get counter_screen_cooldown_desc => 'Opětovný vstup vyžaduje #0 sekundovou prodlevu po opuštění detekční zóny';

  @override
  String get counter_screen_cooldown_time => 'Doba prodlevy';

  @override
  String get counter_screen_cooldown_in_seconds => 'v sekundách';

  @override
  String get counter_screen_stagnant_threshold => 'Práh stagnace';

  @override
  String get counter_screen_stagnant_desc => 'Objekty, které zůstávají nehybné více než #0 sekund, budou považovány za stagnující';

  @override
  String get counter_screen_stagnant_consider => 'Považovat za stagnující';

  @override
  String get counter_screen_stagnant_in_seconds => 'v sekundách';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefix popisu';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufix popisu';

  @override
  String get counter_screen_name_error => 'Název počítadla nemůže být prázdný';

  @override
  String get counter_screen_enabled_error => 'Chyba';

  @override
  String get counter_screen_enabled_error_content => 'Nejprve musíte povolit jiné počítadlo, pak můžete zakázat toto počítadlo';

  @override
  String get objects_screen_title => 'Objekty';

  @override
  String get objects_screen_desc => 'Zvolte detekční cíle jako osoba, auto, autobus atd.';

  @override
  String get open_project_screen_title => 'Otevřít projekt';

  @override
  String get open_project_screen_desc => 'Otevřete dříve vytvořené projekty, uchováváme pouze posledních 20.';

  @override
  String get open_project_screen_no_project => 'Žádný projekt nenalezen.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Zdroj videa';

  @override
  String get default_zone_name => 'Detekční zóna';

  @override
  String get error_oops => 'Jejda, něco se pokazilo';

  @override
  String get error_content => 'Došlo k neočekávané chybě. Chcete odeslat hlášení e-mailem?';

  @override
  String get error_report => 'Napište nám';

  @override
  String get submit => 'Odeslat';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Zrušit';

  @override
  String get yes => 'Ano';

  @override
  String get no => 'Ne';

  @override
  String get close => 'Zavřít';

  @override
  String get back => 'Zpět';

  @override
  String get zone_screen_zone => 'Zóna';

  @override
  String get zone_screen_zone_show_summary => 'Zobrazit shrnutí na obrazovce';

  @override
  String get video_sources_photos_denied => 'Přístup k fotografiím odepřen';

  @override
  String get video_sources_photos_goto_settings => 'Přejít do nastavení';

  @override
  String get video_sources_camera_denied => 'Přístup ke kameře odepřen';

  @override
  String get video_sources_photos_denied_msg => 'Přejděte do nastavení a povolte přístup k fotografiím pro tuto aplikaci.';

  @override
  String get video_sources_camera_denied_msg => 'Přejděte do nastavení a povolte přístup ke kameře pro tuto aplikaci.';
}
