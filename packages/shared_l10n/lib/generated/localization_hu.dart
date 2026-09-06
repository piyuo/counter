// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class LocalizationHu extends Localization {
  LocalizationHu([String locale = 'hu']) : super(locale);

  @override
  String get about_screen_app_version => 'Alkalmazás verziója';

  @override
  String get about_screen_email_us => 'Írjon nekünk';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get appeared => 'Megjelent';

  @override
  String get appeared_help =>
      'Megszámolja azokat az embereket vagy járműveket, amelyek első észlelt pozíciója ezen a területen belül volt.\\n\\nSegít megérteni, hol kezdődik a követés.\\n\\n(Elsősorban haladó felhasználóknak)';

  @override
  String get average_occupancy => 'Átlagos létszám';

  @override
  String get average_occupancy_help =>
      'Megmutatja az emberek vagy járművek átlagos számát ezen a területen az aktuális számlálási időszak alatt.\\n\\nSegít megmutatni, mennyire volt forgalmas a terület a teljes időszak során.';

  @override
  String get average_stay => 'Átlagos tartózkodási idő';

  @override
  String get average_stay_help =>
      'Megmutatja, hogy az emberek vagy járművek átlagosan mennyi ideig maradtak ezen a területen.\\n\\nA hosszabb átlagos tartózkodási idő arra utalhat, hogy az ügyfelek több időt töltenek ezen a területen.';

  @override
  String get camera_test_screen_help =>
      'A Piyuo Counter a kamerát és az eszközön futó AI-t használja emberek számolására. Először ellenőrizzük, hogy az eszköze kompatibilis-e.';

  @override
  String get camera_test_screen_instruction =>
      'Irányítsa a kamerát emberekre. Az alkalmazás kereteket rajzol a felismert személyek köré.';

  @override
  String get camera_test_screen_next =>
      'Koppintson a Tovább gombra a folytatáshoz.';

  @override
  String get camera_test_screen_start =>
      'Koppintson a Start gombra. Ha kéri, engedélyezze a kamera használatát.';

  @override
  String get camera_test_screen_test_failed => 'A teszt sikertelen!';

  @override
  String get camera_test_screen_test_passed => 'A teszt sikeres!';

  @override
  String get camera_test_screen_title => 'AI kamerateszt';

  @override
  String get camera_test_screen_wait =>
      'Várakozás, hogy az AI embereket észleljen…';

  @override
  String get cta_screen_custom => 'Saját szerver használata';

  @override
  String get cta_screen_custom_help =>
      'Küldje a forgalmi adatokat közvetlenül saját backendjébe vagy adatbázisába.';

  @override
  String get cta_screen_footer =>
      'A folytatással elfogadja a Szolgáltatási feltételeket, az Adatvédelmi irányelveket és az Adatfeldolgozási megállapodást.';

  @override
  String get cta_screen_invitation => 'Meghívókód használata';

  @override
  String get cta_screen_invitation_help =>
      'Csatlakozzon egy meglévő szervezethez a rendszergazdától kapott meghívóval.';

  @override
  String get cta_screen_local => 'Csak ezen az eszközön';

  @override
  String get cta_screen_local_help =>
      'A forgalmi adatokat csak ezen az eszközön tárolja. Semmi sem kerül feltöltésre.';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud használata';

  @override
  String get cta_screen_piyuo_help =>
      'Tárolja a forgalmi adatokat a Piyuo Cloudban irányítópultokkal és üzleti elemzésekkel.';

  @override
  String get cta_screen_premium => 'Prémium';

  @override
  String get cta_screen_title =>
      'A Piyuo Counter 5 percenként névtelen forgalmi statisztikákat készít.\\nVálassza ki, hogyan szeretné tárolni és elérni adatait.';

  @override
  String get current_occupancy => 'Jelenlegi darabszám';

  @override
  String get current_occupancy_help =>
      'Megmutatja az ezen a területen lévő emberek vagy járművek jelenlegi darabszámát.\\n\\nAz érték valós időben frissül, és segít ellenőrizni, hogy az AI felismerése megegyezik-e azzal, amit a képernyőn lát. Nem kerül feltöltésre a telemetriai adatok közé.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Mentés...';

  @override
  String get custom_server_screen_server_url_label => 'Szerver URL';

  @override
  String get detection_screen_confidence => 'Konfidenciaküszöb';

  @override
  String get detection_screen_confidence_dialog =>
      'Meghatározza, mennyire kell biztosnak lennie az AI-nak egy személy vagy jármű megszámlálása előtt.\\nAlacsonyabb értékek\\n• Több objektumot érzékelnek\\n• Jobbak távoli vagy részben rejtett objektumokhoz\\n• Növelhetik a hibás észleléseket\\nMagasabb értékek\\n• Csak nagy biztonságú észleléseket számolnak\\n• Csökkentik a hibás észleléseket\\n• Kihagyhatnak kicsi vagy nehéz objektumokat\\nHasználjon alacsonyabb értéket, ha az alkalmazás kihagy embereket vagy járműveket.\\nHasználjon magasabb értéket, ha az alkalmazás árnyékokat, tükröződéseket vagy más hibás objektumokat számol.';

  @override
  String get detection_screen_confidence_help =>
      'Az objektum felismeréséhez szükséges minimális megbízhatóság.';

  @override
  String get detection_screen_confidence_max_label => 'Szigorú';

  @override
  String get detection_screen_confidence_min_label => 'Laza';

  @override
  String get detection_screen_disappear => 'Eltűnési időkorlát';

  @override
  String get detection_screen_disappear_dialog =>
      'Meghatározza, mennyi ideig vár az AI, mielőtt egy objektumot eltűntként jelöl meg, miután már nem érzékeli.\\nRövidebb értékek\\n• Az objektumokat hamarabb jelölik eltűntként\\n• Jobb gyors forgalomhoz\\n• Az átmenetileg elrejtett objektumokat tévesen eltűntként jelölhetik\\nHosszabb értékek\\n• Tovább várnak, mielőtt eltűntként jelölik az objektumokat\\n• Jobb, ha objektumok röviden blokkolva vannak vagy kimaradnak\\n• Késleltetik az eltűnési eseményeket';

  @override
  String get detection_screen_disappear_help =>
      'Mennyi ideig vár az AI, mielőtt eltűntnek jelöl egy objektumot, miután már nem érzékeli.';

  @override
  String get detection_screen_disappear_max_label => 'Lassú';

  @override
  String get detection_screen_disappear_min_label => 'Gyors';

  @override
  String get detection_screen_memory_dialog =>
      'Meghatározza, mennyi ideig emlékszik az AI egy objektumra az eltűnése után.\\nNövelje ezt az értéket, ha emberek vagy járművek gyakran más objektumok mögé rejtőznek.\\nCsökkentse ezt az értéket, ha az objektumok helytelenül kapcsolódnak össze a jelenet elhagyása után.';

  @override
  String get detection_screen_min_presence => 'Minimális jelenléti idő';

  @override
  String get detection_screen_min_presence_help =>
      'Az objektumnak láthatónak kell maradnia, mielőtt számításba kerül. A hosszabb értékek segítenek csökkenteni a rövid téves észleléseket.';

  @override
  String get detection_screen_min_presence_max_label => 'Biztonságosabb';

  @override
  String get detection_screen_min_presence_min_label => 'Gyorsabb';

  @override
  String get detection_screen_minimum_visible =>
      'Az objektumoknak ennyi ideig láthatónak kell maradniuk, mielőtt megszámolják őket.\\nNövelje ezt az értéket, hogy figyelmen kívül hagyja a rövid hibás észleléseket.\\nCsökkentse ezt az értéket, ha a gyorsan mozgó embereket vagy járműveket kihagyja.';

  @override
  String get detection_screen_new_track => 'Új követési küszöb';

  @override
  String get detection_screen_new_track_help =>
      'Az új objektum követésének elindításához szükséges minimális megbízhatóság. Alacsony értékek duplikált követéseket okozhatnak.';

  @override
  String get detection_screen_new_track_max_label => 'Konzervatív';

  @override
  String get detection_screen_new_track_min_label => 'Agresszív';

  @override
  String get detection_screen_reset => 'Visszaállítás';

  @override
  String get detection_screen_reset_content =>
      'Biztosan visszaállítja a felismerési beállításokat?';

  @override
  String get detection_screen_show_track_id =>
      'Nyomon követési azonosító megjelenítése';

  @override
  String get detection_screen_show_track_id_help =>
      'Engedélyezze ezt az opciót az egyes követett objektumok egyedi nyomon követési azonosítóinak megjelenítéséhez.';

  @override
  String get detection_screen_stay => 'Tartózkodási idő';

  @override
  String get detection_screen_stay_help =>
      'Mennyi ideig kell egy objektumnak a területen maradnia, hogy tartózkodásnak számítson.';

  @override
  String get detection_screen_stay_max_label => 'Késleltetett';

  @override
  String get detection_screen_stay_min_label => 'Azonnali';

  @override
  String get detection_screen_stay_threshold =>
      'Meghatározza, mikor járul hozzá egy objektum a Tartózkodás számlálásához.\\nRövidebb értékek\\n• Azonnal számolják a tartózkodást\\n• Jobb gyors elemzéshez\\nHosszabb értékek\\n• Figyelmen kívül hagyják a rövid átmenő forgalmat\\n• Jobb a foglaltság méréséhez';

  @override
  String get detection_screen_subtitle =>
      'Állítsa be, hogyan érzékeli és követi az AI az objektumokat';

  @override
  String get detection_screen_title => 'Követés és számlálás';

  @override
  String get detection_screen_track_dialog =>
      'Meghatározza, mikor válik egy újonnan észlelt objektum új nyomvonallá.\\nAlacsonyabb értékek\\n• A követés hamarabb elkezdődik\\n• Jobb gyorsan mozgó objektumokhoz\\n• Duplikált nyomvonalakat hozhat létre\\nMagasabb értékek\\n• Erősebb bizonyíték szükséges új nyomvonal létrehozása előtt\\n• Csökkenti a duplikált nyomvonalakat\\n• Késleltetheti az új objektumok követését';

  @override
  String get detection_screen_track_memory => 'Követési memória';

  @override
  String get detection_screen_track_memory_help =>
      'Meghatározza, mennyi ideig marad aktív a követés egy objektum ideiglenes eltűnése után. A hosszabb értékek segítenek rövid kitakarások után.';

  @override
  String get detection_screen_track_memory_max_label => 'Hosszú';

  @override
  String get detection_screen_track_memory_min_label => 'Rövid';

  @override
  String get device_not_supported_screen_body =>
      'A Piyuo Counter a kameráját használja a gyalogosok és járművek valós idejű észlelésére. Ezen az eszközön nincs elérhető kamera.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Próbálja meg megnyitni ezt az alkalmazást a telefonján';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Egy kamerás okostelefon vagy táblagép';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'iOS vagy Android készülék ajánlott';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Amire szüksége van';

  @override
  String get device_not_supported_screen_title => 'Kamera nem található';

  @override
  String get disappeared => 'Eltűnt';

  @override
  String get disappeared_help =>
      'Megszámolja azokat az embereket vagy járműveket, amelyek utolsó észlelt pozíciója ezen a területen belül volt.\\n\\nA követés a beállított eltűnési idő után ér véget, ha a személy vagy jármű már nem észlelhető.\\n\\n(Elsősorban haladó felhasználóknak)';

  @override
  String get dpa => 'Adatfeldolgozási megállapodás';

  @override
  String get durationDaysShort => '%sn';

  @override
  String get durationHoursShort => '%só';

  @override
  String get durationMinutesShort => '%sp';

  @override
  String get durationSecondsShort => '%smp';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Belépett';

  @override
  String get entered_help =>
      'Megszámolja azokat az embereket vagy járműveket, amelyek az aktuális számlálási időszak alatt beléptek erre a területre.\\n\\nBelépés akkor kerül számításra, amikor egy személy vagy jármű a területen kívülről belülre mozog.';

  @override
  String get exited => 'Kilépett';

  @override
  String get exited_help =>
      'Megszámolja azokat az embereket vagy járműveket, amelyek az aktuális számlálási időszak alatt elhagyták ezt a területet.\\n\\nKilépés akkor kerül számításra, amikor egy személy vagy jármű a területen belülről kifelé mozog.';

  @override
  String get language_screen_language => 'Nyelv';

  @override
  String get language_screen_subtitle => 'Válassza ki az alkalmazás nyelvét.';

  @override
  String get local_only_screen_body =>
      'A \'Csak helyi eszköz\' mód lehetővé teszi, hogy adatfeltöltés nélkül kipróbáld az AI kamerás észlelést és követést. Minden forgalmi statisztikát csak ezen az eszközön dolgozunk fel, tökéletes teszteléshez, mielőtt szerverhez csatlakozol.';

  @override
  String get local_only_screen_use_action => 'Csak helyi eszköz használata';

  @override
  String get local_screen_text =>
      'A Piyuo Counter teljes egészében ezen az eszközön fut.\\nA forgalmi statisztikák csak ezen az eszközön lesznek tárolva, és nem kerülnek feltöltésre.\\nKésőbb a Beállításokban csatlakozhat a Piyuo Cloudhoz vagy saját szerveréhez.';

  @override
  String get maximum_occupancy => 'Maximális létszám';

  @override
  String get maximum_occupancy_help =>
      'Megmutatja az emberek vagy járművek legnagyobb egyidejű számát ezen a területen az aktuális számlálási időszak alatt.\\n\\nSegít azonosítani a csúcsforgalmi időszakokat.';

  @override
  String get maximum_stay => 'Maximális tartózkodási idő';

  @override
  String get maximum_stay_help =>
      'Megmutatja, hogy egy személy vagy jármű mennyi ideig tartózkodott a leghosszabb ideig ezen a területen az aktuális számlálási időszak alatt.\\n\\nSegít azonosítani a szokatlanul hosszú tartózkodásokat vagy megállásokat.';

  @override
  String get metric_events => 'Események';

  @override
  String get metric_live => 'Élő';

  @override
  String get metric_show_less => 'Kevesebb megjelenítése';

  @override
  String get metric_show_more => 'Több megjelenítése';

  @override
  String get metric_statistics => 'Statisztikák';

  @override
  String get metrics_counting_all => 'Összes';

  @override
  String get metrics_counting_done => 'Befejezve';

  @override
  String get metrics_counting_in_progress => 'Folyamatban';

  @override
  String get metrics_counting_missing => 'Hiányzik';

  @override
  String get metrics_counting_window =>
      'Statisztikák minden 5 perces időszakhoz';

  @override
  String get onboarding_back_action => 'Vissza';

  @override
  String get onboarding_cta_no_server => 'Nem szeretne adatokat feltölteni?';

  @override
  String get onboarding_cta_title => 'Hová kerüljenek az adatai?';

  @override
  String get onboarding_intro_text1 =>
      'A Piyuo Counter a készüléked kameráját és beépített AI-ját használja, hogy valós időben felismerje az embereket és járműveket.\\nFelismerési és követési technológiával automatikusan megszámolja a gyalogos- és járműforgalmat — mindez közvetlenül a készülékeden történik.';

  @override
  String get onboarding_intro_text2 =>
      'Minden AI-feldolgozás helyben, a készülékeden történik. Nem töltünk fel videót, képet, arcot vagy személyazonosságot.\\nCsak névtelen, 5 percenkénti összesítéseket osztunk meg, amelyek tartalmazzák a számlálást, foglaltságot, be- és kilépéseket, valamint a tartózkodási idő statisztikáit.';

  @override
  String get onboarding_intro_text3 =>
      'Csak indítsd el az alkalmazást, és hagyd futni. A Piyuo Counter folyamatosan és automatikusan gyűjti és tárolja a forgalmi adatokat.\\nAz adatösszesítők 5 percenként mentődnek, és óránként feltöltődnek a Piyuo Cloud-ra vagy a saját szerveredre.';

  @override
  String get onboarding_intro_title1 => 'AI forgalomszámlálás';

  @override
  String get onboarding_intro_title2 => 'Adatvédelem mindenekelőtt';

  @override
  String get onboarding_intro_title3 => 'Automatikusan működik éjjel-nappal';

  @override
  String get onboarding_next_action => 'Következő';

  @override
  String get onboarding_skip_action => 'Bevezető kihagyása';

  @override
  String get onboarding_start_action => 'Indítás';

  @override
  String get passed_by => 'Áthaladt';

  @override
  String get passed_by_help =>
      'Megszámolja azokat az embereket vagy járműveket, amelyek az aktuális számlálási időszak alatt áthaladtak ezen a területen.\\n\\nMinden személy vagy jármű áthaladásonként csak egyszer kerül megszámolásra.';

  @override
  String get payloads_screen_area => 'Terület';

  @override
  String get payloads_screen_confidence => 'Biztonság';

  @override
  String get payloads_screen_coverage => 'Lefedettség';

  @override
  String get payloads_screen_delivered => 'Kézbesítve';

  @override
  String get payloads_screen_failed_load =>
      'Nem sikerült betölteni a legutóbbi payloadokat';

  @override
  String get payloads_screen_frame_processed => 'Feldolgozott képkockák';

  @override
  String get payloads_screen_hour_not_exists => 'Ez az óra már nem létezik.';

  @override
  String get payloads_screen_missing_time => 'Hiányzó idő';

  @override
  String get payloads_screen_no_payloads => 'Még nincsenek payloadok.';

  @override
  String get payloads_screen_partial =>
      'Az időablak korán véget ért (részleges)';

  @override
  String get payloads_screen_partially => 'Részben kézbesítve';

  @override
  String get payloads_screen_payload_not_exists =>
      'Ez a payload már nem létezik.';

  @override
  String get payloads_screen_pending => 'Függőben lévő kézbesítés';

  @override
  String get payloads_screen_process_fps => 'Feldolgozási FPS';

  @override
  String get payloads_screen_resend => 'Újraküldés';

  @override
  String get payloads_screen_select_first =>
      'Először válasszon ki legalább egy dátumot vagy órát.';

  @override
  String get payloads_screen_subtitle =>
      'Válasszon dátum vagy óra szerint az újraküldéshez';

  @override
  String get payloads_screen_title => 'Legutóbbi payloadok';

  @override
  String get personal_custom_screen_build_server =>
      'Segítségre van szüksége saját szerverének beállításához?\\nTekintse meg API-dokumentációnkat és szerverpéldáinkat.';

  @override
  String get personal_custom_screen_help_action =>
      'API-dokumentáció megnyitása';

  @override
  String get personal_custom_screen_reset_action => 'Újrakezdés';

  @override
  String get personal_custom_success_screen_help =>
      'Koppintson lent a Start gombra a számlálás megkezdéséhez.';

  @override
  String get personal_custom_success_screen_help1 =>
      'A forgalmi statisztikák óránként automatikusan feltöltésre kerülnek.\\nAz Upload Logs képernyőről kézzel is feltöltheti őket。';

  @override
  String get personal_custom_success_screen_help2 =>
      'A szerverének még nem kell online lennie.\\nKezdje el a számlálást most. A szervert később is befejezheti és tesztelheti. A forgalmi statisztikák ezen az eszközön maradnak, amíg sikeresen fel nem töltődnek.';

  @override
  String get personal_custom_success_screen_send_to =>
      'A forgalmi statisztikák ide lesznek elküldve';

  @override
  String get personal_custom_success_screen_title => 'A szervere készen áll';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Saját Piyuo Cloud URL';

  @override
  String get piyuo_server_screen_copy_action => 'URL másolása';

  @override
  String get piyuo_server_screen_copy_success => 'URL másolva';

  @override
  String get piyuo_server_screen_saving_action => 'Mentés...';

  @override
  String get piyuo_server_screen_start =>
      'Nyomja meg lent a \"Start\" gombot a számlálás megkezdéséhez.';

  @override
  String get piyuo_server_screen_url_help =>
      'Személyes Piyuo Cloud irányítópultja ezen az URL-en érhető el.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Mentse el ezt az URL-t, hogy másik eszközről is elérhesse a forgalmi irányítópultot.';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloud használata';

  @override
  String get privacy => 'Adatvédelmi irányelvek';

  @override
  String get product_copyright => 'Szerzői jog © 2026';

  @override
  String get product_desc => 'MI-alapú személy- és járműszámlálás.';

  @override
  String get settings_screen_custom_subtitle =>
      'Forgalmi adatok küldése közvetlenül saját háttérrendszerébe vagy adatbázisába.';

  @override
  String get settings_screen_custom_title => 'Egyéni szerver használata';

  @override
  String get settings_screen_data_server_label => 'Adatszerver';

  @override
  String get settings_screen_detection_target => 'Észlelési cél';

  @override
  String get settings_screen_language_title => 'Nyelv';

  @override
  String get settings_screen_local_subtitle =>
      'A forgalmi adatokat csak ezen az eszközön tárolja. Semmi sem kerül feltöltésre.';

  @override
  String get settings_screen_local_title => 'Csak helyi eszköz';

  @override
  String get settings_screen_misc_label => 'Egyéb';

  @override
  String get settings_screen_object_detection => 'Objektumészlelés';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Tárolja a forgalmi adatokat a Piyuo Cloudban irányítópultokkal és üzleti elemzésekkel.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Ez törli az összes adatot, és újrakezdi. Ez a művelet nem vonható vissza.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Minden adat visszaállítása?';

  @override
  String get settings_screen_subscription_body =>
      'Kezelje előfizetését és számlázási adatait';

  @override
  String get settings_screen_subscription_title => 'Előfizetés';

  @override
  String get start_screen_about => 'Névjegy';

  @override
  String get start_screen_server_none =>
      'Az adatok csak ezen az eszközön maradnak';

  @override
  String get start_screen_server_personal =>
      'Az adatok óránként kerülnek feltöltésre ide';

  @override
  String get start_screen_settings => 'Beállítások';

  @override
  String get start_screen_upload_logs => 'Naplók feltöltése';

  @override
  String get start_screen_video_sources => 'Videóforrások';

  @override
  String get stayed => 'Tartózkodott';

  @override
  String get stayed_help =>
      'Megszámolja azokat az embereket vagy járműveket, amelyek legalább a beállított tartózkodási ideig ezen a területen maradtak.\\n\\nAz alapértelmezett tartózkodási idő 15 másodperc, amely a Beállításokban módosítható.';

  @override
  String get target_pedestrian => 'Gyalogos';

  @override
  String get target_pedestrian_help =>
      'Emberek számlálása a gyalogosfelismerő modellel';

  @override
  String get target_screen_subtitle =>
      'Válassza ki a használni kívánt felismerési modellt';

  @override
  String get target_vehicle => 'Jármű';

  @override
  String get target_vehicle_help =>
      'Autók és más járművek számlálása a járműfelismerő modellel';

  @override
  String get telemetry_error_connection_refused =>
      'A szerver nem elérhető. Lehet, hogy jelenleg offline állapotban van.';

  @override
  String get telemetry_error_connection_reset =>
      'A kapcsolat megszakadt. Ellenőrizd az internetkapcsolatot, majd próbáld újra.';

  @override
  String get telemetry_error_connection_timeout =>
      'A kapcsolat túl sokáig nem válaszolt. Ellenőrizd az internetkapcsolatot, majd próbáld újra.';

  @override
  String get telemetry_error_database_error =>
      'Az adatbázisba történő írás sikertelen volt.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'A szerver címe nem található. Ellenőrizd az internetkapcsolatot vagy a szerver URL-jét.';

  @override
  String get telemetry_error_http_error_status =>
      'A szerver elutasította a kérést. Próbáld újra később.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Váratlan hiba történt a szerverrel való kommunikáció során.';

  @override
  String get telemetry_error_invalid_url =>
      'A szerver címe érvénytelen. Ellenőrizd a beállításokat.';

  @override
  String get telemetry_error_network_error =>
      'Hálózati hiba történt. Ellenőrizd az internetkapcsolatot, majd próbáld újra.';

  @override
  String get telemetry_error_socket_error =>
      'Hálózati kapcsolódási hiba történt. Ellenőrizd az internetkapcsolatot.';

  @override
  String get telemetry_error_transport_exception =>
      'Hiba történt az adatok küldése közben. Próbáld újra.';

  @override
  String get telemetry_error_unknown_error => 'Váratlan hiba történt.';

  @override
  String get terms => 'Szolgáltatási feltételek';

  @override
  String get upload_screen_attempt_time => 'Próbálkozás ideje:';

  @override
  String get upload_screen_error => 'Hiba:';

  @override
  String get upload_screen_failed => 'Sikertelen';

  @override
  String get upload_screen_load_error =>
      'Nem sikerült betölteni a feltöltési naplókat.';

  @override
  String get upload_screen_log_not_exists =>
      'A feltöltési napló már nem érhető el.';

  @override
  String get upload_screen_next => 'Következő feltöltés ...';

  @override
  String get upload_screen_next_upload_prefix => 'Következő feltöltés ';

  @override
  String get upload_screen_no_data_server =>
      'Először állítsa be az adatszervert.';

  @override
  String get upload_screen_no_logs => 'Még nincsenek feltöltési naplók.';

  @override
  String get upload_screen_payload_count => 'Payloadok száma';

  @override
  String get upload_screen_payload_count_label => 'Payloadok száma:';

  @override
  String get upload_screen_payload_size => 'Payload mérete:';

  @override
  String get upload_screen_result => 'Eredmény:';

  @override
  String get upload_screen_retry => 'Újrapróbálkozások száma:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Sikeres';

  @override
  String get upload_screen_today => 'Ma';

  @override
  String get upload_screen_upload_now => 'Feltöltés most';

  @override
  String get upload_screen_upload_success => 'Sikeres feltöltés.';

  @override
  String get upload_screen_uploading => 'Feltöltés...';

  @override
  String get upload_screen_yesterday => 'Tegnap';

  @override
  String get url_screen_invalid_rtsp_error =>
      'Az RTSP URL-nek tartalmaznia kell gazdagépnevet.';

  @override
  String get url_screen_invalid_url_error =>
      'Adjon meg egy érvényes URL-t támogatott sémával.';

  @override
  String get url_screen_subtitle =>
      'Kérjük, adja meg az élő közvetítés URL-jét';

  @override
  String get url_screen_title => 'Élő közvetítés URL';

  @override
  String get url_screen_unsupported_scheme_error => 'Only HTTP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Adjon meg egy élő közvetítés URL-jét.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream vagy rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Hátsó kamera';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_file => 'Fájl';

  @override
  String get video_sources_front_camera => 'Elülső kamera';

  @override
  String get video_sources_live_stream => 'Élő közvetítés URL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'A kamera használatához engedélyezni kell a kamera hozzáférést';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Kamera nem található';

  @override
  String get video_sources_screen_import_error =>
      'Nem sikerült importálni a videófájlt.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Menjen a beállításokhoz és engedélyezze a fényképekhez való hozzáférést ennek az alkalmazásnak.';

  @override
  String get video_sources_screen_select_camera =>
      'Koppintson a kamera kiválasztásához';

  @override
  String get video_sources_screen_select_file =>
      'Koppintson egy fájl kiválasztásához';

  @override
  String get video_sources_screen_select_live =>
      'Koppintson az élő közvetítés URL-jének beállításához';

  @override
  String get video_sources_webcam => 'Webkamera';
}
