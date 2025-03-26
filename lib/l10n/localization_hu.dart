// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class LocalizationHu extends Localization {
  LocalizationHu([String locale = 'hu']) : super(locale);

  @override
  String get product_name => 'Számláló';

  @override
  String get product_desc => 'Számoljon embereket, járműveket, háziállatokat és egyebeket számítógépes látás és mesterséges intelligencia segítségével.';

  @override
  String get product_copyright => 'Szerzői jog © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'Élő közvetítés URL';

  @override
  String get video_sources_file => 'Fájl';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nem található';

  @override
  String get video_sources_camera_not_found_message => 'A kamera használatához engedélyezni kell a kamera hozzáférést';

  @override
  String get video_sources_webcam_not_found_title => 'Webkamera nem található';

  @override
  String get video_sources_webcam_not_found_message => 'Ellenőrizze, hogy csatlakoztatva van-e webkamera';

  @override
  String get wizard_screen_desc => 'Hozzon létre új projektet a számlálás megkezdéséhez.';

  @override
  String get wizard_screen_new_project_from => 'Új projekt létrehozása innen';

  @override
  String get wizard_screen_language => 'Nyelv';

  @override
  String get wizard_screen_about => 'Névjegy';

  @override
  String get wizard_screen_open_projects_tip => 'Minden projekt automatikusan mentésre kerül helyileg';

  @override
  String get wizard_screen_open_projects => 'Meglévő projekt megnyitása';

  @override
  String get wizard_screen_email_us => 'Írjon nekünk';

  @override
  String get language_screen_language => 'Nyelv';

  @override
  String get project_view_no_videos => 'Nincs elérhető videóforrás.';

  @override
  String get about_screen_title => 'Névjegy';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'Alkalmazás verziója';

  @override
  String get about_screen_models => 'Objektumfelismerő modellek';

  @override
  String get about_screen_benchmark => 'Teljesítményteszt';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Fordítási Információk';

  @override
  String get benchmark_screen_title => 'Modellek teljesítménytesztje';

  @override
  String get benchmark_screen_recommended => 'Ajánlott modell';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Teljesítményteszt indítása';

  @override
  String get benchmark_screen_start_failed => 'Nem sikerült elindítani a teljesítménytesztet, a hibakód';

  @override
  String get benchmark_screen_models => 'Objektumfelismerő modellek';

  @override
  String get project_screen_title => 'Projekt';

  @override
  String get project_screen_exit_confirm_title => 'Projekt kilépés megerősítése';

  @override
  String get project_screen_exit_confirm_content => 'A projekt elhagyása leállítja a számlálást. Biztosan folytatja?';

  @override
  String get project_screen_exit_button => 'Kilépés';

  @override
  String get project_screen_add_video_button => 'Videóforrás hozzáadása';

  @override
  String get project_screen_from_desc => '24 órás adatot tárolunk, így bármely időszakot megtekintheti.';

  @override
  String get project_screen_report_settings => 'Beállítások';

  @override
  String get filter_screen_title => 'Szűrő';

  @override
  String get filter_screen_desc => 'Válasszon szűrési tartományt az alábbi listából';

  @override
  String get filter_screen_error_title => 'Szűrő';

  @override
  String get filter_screen_error_content => 'A befejezési időnek nagyobbnak kell lennie a kezdési időnél';

  @override
  String get filter_screen_error_custom => 'Egyéni';

  @override
  String get filter_screen_error_start => 'Kezdet';

  @override
  String get filter_screen_error_end => 'Vége';

  @override
  String get settings_screen_title => 'Beállítások';

  @override
  String get settings_screen_desc => 'Állítsa be a projekt nevét, a felismerési paramétereket, a számlálás törlését.';

  @override
  String get settings_screen_project_id => 'Projekt azonosító';

  @override
  String get settings_screen_project_name => 'Projekt neve';

  @override
  String get settings_screen_project_name_place_holder => 'Kossuth utca 123. vagy Városliget';

  @override
  String get settings_screen_project_error => 'A projekt neve nem lehet üres';

  @override
  String get settings_screen_random_count_button => 'Véletlenszerű számlálások hozzáadása';

  @override
  String get settings_screen_reset_count_header => 'Minden számlálás visszaállítása ebben a projektben';

  @override
  String get settings_screen_reset_count_button => 'Számlálások visszaállítása';

  @override
  String get settings_screen_reset_count_content => 'Biztosan visszaállítja az összes számlálást?';

  @override
  String get settings_screen_delete_header => 'Projekt törlése';

  @override
  String get settings_screen_delete_content => 'Biztosan törölni szeretné ezt a projektet?';

  @override
  String get settings_screen_delete_button => 'Törlés';

  @override
  String get settings_screen_center_point_title => 'Célpont középpontja';

  @override
  String get settings_screen_center_point_desc => 'A középpont segít meghatározni, hogy a célpont a találati zónán belül van-e.';

  @override
  String get settings_screen_center_point_button => 'Célpont középpontjának megjelenítése';

  @override
  String get settings_screen_lost_target_title => 'Elveszett célpont';

  @override
  String get settings_screen_lost_target_desc => 'Amikor az objektumkövetés elveszít egy célpontot, ez az opció láthatóvá teszi. Alapértelmezés szerint az elveszett célpontok nem láthatók.';

  @override
  String get settings_screen_lost_target_button => 'Elveszett célpont megjelenítése';

  @override
  String get detection_screen_title => 'Felismerési beállítások';

  @override
  String get detection_screen_models => 'Modellek';

  @override
  String get detection_screen_confidence => 'Megbízhatóság';

  @override
  String get detection_screen_confidence_desc => '#0 feletti megbízhatóság érvényes felismerésnek számít';

  @override
  String get detection_screen_low => 'Alacsony';

  @override
  String get detection_screen_high => 'Magas';

  @override
  String get detection_screen_nms => 'Nem-maximum elnyomás';

  @override
  String get detection_screen_nms_desc => '#0 Alacsonyabb NMS küszöbérték (pl. 30%) agresszívebben távolítja el az átfedő határolókereteket, míg a magasabb NMS küszöbérték (pl. 0,6) több átfedést engedélyez';

  @override
  String get detection_screen_match => 'Egyezés';

  @override
  String get detection_screen_match_desc => '#0 feletti egyezés ugyanannak az objektumnak tekintendő.';

  @override
  String get detection_screen_lost => 'Elveszett';

  @override
  String get detection_screen_lost_desc => 'A követett objektum eltávolításra kerül, ha #0 ideig elveszett';

  @override
  String get detection_screen_consider_valid => 'Érvényesnek tekintve ennyi után';

  @override
  String get detection_screen_consider_valid_desc => 'A követett objektum #0 után érvényesnek tekintendő';

  @override
  String get detection_screen_reset => 'Visszaállítás';

  @override
  String get detection_screen_reset_content => 'Biztosan visszaállítja a felismerési beállításokat?';

  @override
  String get url_screen_title => 'Élő közvetítés URL';

  @override
  String get url_screen_desc => 'Kérjük, adja meg az élő közvetítés URL-jét';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream vagy rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Videóforrás hozzáadása';

  @override
  String get add_video_screen_from => 'Videóforrás hozzáadása innen';

  @override
  String get webcam_screen_add_title => 'Webkamera hozzáadása';

  @override
  String get webcam_screen_edit_title => 'Webkamera kiválasztása';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Előlapi kamera';

  @override
  String get camera_screen_back_camera => 'Hátlapi kamera';

  @override
  String get camera_screen_add_title => 'Kamera hozzáadása';

  @override
  String get camera_screen_edit_title => 'Kamera kiválasztása';

  @override
  String get camera_screen_zoom_level => 'Nagyítási szint';

  @override
  String get video_screen_name_empty => 'A videó neve nem lehet üres.';

  @override
  String get video_screen_desc => 'Videóforrások kezelése, felismerési zónák hozzáadása vagy módosítása.';

  @override
  String get video_screen_video_name => 'Videóforrás neve';

  @override
  String get video_screen_edit_placeholder => 'Bejárati ajtó kamera vagy Parkoló kamera';

  @override
  String get video_screen_change_file => 'Fájl módosítása';

  @override
  String get video_screen_add_zone => 'Felismerési zóna hozzáadása';

  @override
  String get video_screen_zones => 'Felismerési zónák';

  @override
  String get video_screen_zones_desc => 'Használja a fogd és vidd módszert a zónák beállításához';

  @override
  String get video_screen_tools => 'Eszközök';

  @override
  String get video_screen_move_bottom => 'Jelenlegi zóna áthelyezése alulra';

  @override
  String get video_screen_add_point => 'Pont hozzáadása a jelenlegi zónához';

  @override
  String get video_screen_remove_point => 'Pont eltávolítása a jelenlegi zónából';

  @override
  String get video_screen_playback_speed => 'Lejátszási sebesség';

  @override
  String get video_screen_playback_current => 'jelenlegi: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Videóforrás törlése';

  @override
  String get video_screen_delete_content => 'Biztosan törölni szeretné ezt a videóforrást?';

  @override
  String get video_screen_delete_button => 'Törlés';

  @override
  String get video_screen_sources => 'Képforrás, felismerési célpontok és modellparaméterek beállítása.';

  @override
  String get video_screen_targets => 'Felismerési célpontok';

  @override
  String get video_screen_detection => 'Modellparaméterek';

  @override
  String get color_screen_title => 'Szín kiválasztása';

  @override
  String get zone_screen_desc => 'A felismerési zóna beállíthatja a felismerendő objektumtípusokat és kiválaszthatja, mely számlálók jelenjenek meg, például Felismert, Létrejött és Belépett.';

  @override
  String get zone_screen_name_placeholder => 'A zóna neve, például Járda vagy Parkoló';

  @override
  String get zone_screen_zone_color => 'Zóna színe';

  @override
  String get zone_screen_color => 'Szín';

  @override
  String get zone_screen_delete_header => 'Zóna törlése';

  @override
  String get zone_screen_delete_content => 'Biztosan törölni szeretné ezt a zónát?';

  @override
  String get zone_screen_delete_button => 'Törlés';

  @override
  String get zone_screen_can_not_delete => 'Nem lehet törölni a zónát';

  @override
  String get zone_screen_one_zone_required => 'Legalább egy zóna szükséges.';

  @override
  String get zone_screen_zone_name_required => 'A zóna neve nem lehet üres';

  @override
  String get counter_screen_show_on => 'Megjelenítés a képernyőn';

  @override
  String get counter_screen_enabled => 'Engedélyezve';

  @override
  String get counter_screen_reentry_threshold => 'Újrabelépési küszöb';

  @override
  String get counter_screen_reentry_desc => 'Az objektumnak #0 alkalommal kell belépnie, minden kilépés és újrabelépés között #1 másodperces várakozási idővel, hogy kiváltsa az újrabelépést';

  @override
  String get counter_screen_reentry_title => 'Újrabelépés számlálás';

  @override
  String get counter_screen_cooldown_threshold => 'Várakozási küszöb';

  @override
  String get counter_screen_cooldown_desc => 'Az újrabelépéshez #0 másodperces várakozási idő szükséges a felismerési zónából való kilépés után';

  @override
  String get counter_screen_cooldown_time => 'Várakozási idő';

  @override
  String get counter_screen_cooldown_in_seconds => 'másodpercben';

  @override
  String get counter_screen_stagnant_threshold => 'Mozdulatlan küszöb';

  @override
  String get counter_screen_stagnant_desc => 'A #0 másodpercnél hosszabb ideig egy helyben maradó objektumok mozdulatlannak tekintendők';

  @override
  String get counter_screen_stagnant_consider => 'Mozdulatlannak tekintve';

  @override
  String get counter_screen_stagnant_in_seconds => 'másodpercben';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Leírás előtag';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Leírás utótag';

  @override
  String get counter_screen_name_error => 'A számláló neve nem lehet üres';

  @override
  String get counter_screen_enabled_error => 'Hiba';

  @override
  String get counter_screen_enabled_error_content => 'Először engedélyeznie kell egy másik számlálót, csak ezután tilthatja le ezt a számlálót';

  @override
  String get objects_screen_title => 'Objektumok';

  @override
  String get objects_screen_desc => 'Válasszon felismerési célpontokat, például személy, autó, busz stb.';

  @override
  String get open_project_screen_title => 'Projekt megnyitása';

  @override
  String get open_project_screen_desc => 'Nyissa meg a korábban létrehozott projekteket, csak a legutóbbi 20 kerül megőrzésre.';

  @override
  String get open_project_screen_no_project => 'Nem található projekt.';

  @override
  String get default_project_name => 'Projekt';

  @override
  String get default_video_name => 'Videóforrás';

  @override
  String get default_zone_name => 'Felismerési zóna';

  @override
  String get error_oops => 'Hoppá, valami hiba történt';

  @override
  String get error_content => 'Váratlan hiba történt. Szeretne e-mailes hibajelentést küldeni?';

  @override
  String get error_report => 'Írjon nekünk';

  @override
  String get submit => 'Küldés';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Mégse';

  @override
  String get yes => 'Igen';

  @override
  String get no => 'Nem';

  @override
  String get close => 'Bezárás';

  @override
  String get back => 'Vissza';

  @override
  String get zone_screen_zone => 'Zóna';

  @override
  String get zone_screen_zone_show_summary => 'Összegzés mutatása';

  @override
  String get video_sources_photos_denied => 'Fényképekhez való hozzáférés megtagadva';

  @override
  String get video_sources_phtots_goto_settings => 'Beállítások';

  @override
  String get video_sources_camera_denied => 'Kamerához való hozzáférés megtagadva';

  @override
  String get video_sources_phtots_denied_msg => 'Menjen a beállításokhoz és engedélyezze a fényképekhez való hozzáférést ennek az alkalmazásnak.';

  @override
  String get video_sources_camera_denied_msg => 'Menjen a beállításokhoz és engedélyezze a kamerához való hozzáférést ennek az alkalmazásnak.';
}
