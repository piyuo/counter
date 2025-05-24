// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class LocalizationLt extends Localization {
  LocalizationLt([String locale = 'lt']) : super(locale);

  @override
  String get product_name => 'Skaitiklis';

  @override
  String get product_desc =>
      'Naudojant kompiuterinę viziją ir dirbtinį intelektą skaičiuoti žmones, transporto priemones, gyvūnus ir daugiau.';

  @override
  String get product_copyright => 'Autorių teisės © 2025';

  @override
  String get video_sources_webcam => 'Internetinė kamera';

  @override
  String get video_sources_live_stream => 'Tiesioginės transliacijos URL';

  @override
  String get video_sources_file => 'Failas';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nerasta';

  @override
  String get video_sources_camera_not_found_message =>
      'Reikia suteikti kameros leidimą, kad galėtumėte naudoti kamerą';

  @override
  String get video_sources_webcam_not_found_title =>
      'Internetinė kamera nerasta';

  @override
  String get video_sources_webcam_not_found_message =>
      'Patikrinkite programėlės leidimą ir kameros prisijungimą';

  @override
  String get wizard_screen_desc =>
      'Sukurkite naują projektą žemiau, kad pradėtumėte skaičiuoti.';

  @override
  String get wizard_screen_new_project_from => 'Naujas projektas iš';

  @override
  String get wizard_screen_language => 'Kalba';

  @override
  String get wizard_screen_about => 'Apie';

  @override
  String get wizard_screen_open_projects_tip =>
      'Visi projektai bus automatiškai išsaugoti vietiniame įrenginyje';

  @override
  String get wizard_screen_open_projects => 'Atidaryti esamą projektą';

  @override
  String get wizard_screen_email_us => 'Susisiekite el. paštu';

  @override
  String get language_screen_language => 'Kalba';

  @override
  String get project_view_no_videos => 'Nėra vaizdo šaltinio.';

  @override
  String get about_screen_title => 'Apie';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Programos versija';

  @override
  String get about_screen_models => 'Objektų aptikimo modeliai';

  @override
  String get about_screen_benchmark => 'Našumo testas';

  @override
  String get about_screen_opencv_build_info => 'OpenCV kūrimo informacija';

  @override
  String get benchmark_screen_title => 'Modelių našumo testai';

  @override
  String get benchmark_screen_recommended => 'Rekomenduojamas modelis';

  @override
  String get benchmark_screen_fps => 'Kadrai per sekundę';

  @override
  String get benchmark_screen_start_button => 'Pradėti našumo testą';

  @override
  String get benchmark_screen_start_failed =>
      'Nepavyko pradėti našumo testo, klaidos kodas yra';

  @override
  String get benchmark_screen_models => 'Objektų aptikimo modeliai';

  @override
  String get project_screen_title => 'Projektas';

  @override
  String get project_screen_exit_confirm_title =>
      'Patvirtinkite išėjimą iš projekto';

  @override
  String get project_screen_exit_confirm_content =>
      'Išėjus iš projekto skaičiavimas bus sustabdytas. Ar tikrai norite tęsti?';

  @override
  String get project_screen_exit_button => 'Išeiti';

  @override
  String get project_screen_add_video_button => 'Pridėti vaizdo šaltinį';

  @override
  String get project_screen_from_desc =>
      'Mes saugome besisukančią 24 valandų įrašą, todėl galite peržiūrėti bet kurį laiko tarpą.';

  @override
  String get project_screen_report_settings => 'Nustatymai';

  @override
  String get filter_screen_title => 'Filtras';

  @override
  String get filter_screen_desc =>
      'Pasirinkite filtro diapazoną iš žemiau pateikto sąrašo';

  @override
  String get filter_screen_error_title => 'Filtras';

  @override
  String get filter_screen_error_content =>
      'Pabaigos laikas turi būti didesnis nei pradžios laikas';

  @override
  String get filter_screen_error_custom => 'Pasirinktinis';

  @override
  String get filter_screen_error_start => 'Pradžia';

  @override
  String get filter_screen_error_end => 'Pabaiga';

  @override
  String get settings_screen_title => 'Nustatymai';

  @override
  String get settings_screen_desc =>
      'Nustatykite projekto pavadinimą, aptikimo parametrus, skaičiavimo išvalymą.';

  @override
  String get settings_screen_project_id => 'Projekto ID';

  @override
  String get settings_screen_project_name => 'Projekto pavadinimas';

  @override
  String get settings_screen_project_name_place_holder =>
      'Gedimino pr. 123 arba Vingio parkas';

  @override
  String get settings_screen_project_error =>
      'Projekto pavadinimas negali būti tuščias';

  @override
  String get settings_screen_random_count_button =>
      'Pridėti atsitiktinius skaičiavimus';

  @override
  String get settings_screen_reset_count_header =>
      'Atstatyti visus skaičiavimus šiame projekte';

  @override
  String get settings_screen_reset_count_button => 'Atstatyti skaičiavimus';

  @override
  String get settings_screen_reset_count_content =>
      'Ar tikrai norite atstatyti visus skaičiavimus?';

  @override
  String get settings_screen_delete_header => 'Ištrinti šį projektą';

  @override
  String get settings_screen_delete_content =>
      'Ar tikrai norite ištrinti šį projektą?';

  @override
  String get settings_screen_delete_button => 'Ištrinti';

  @override
  String get settings_screen_center_point_title => 'Centro taškas ant taikinio';

  @override
  String get settings_screen_center_point_desc =>
      'Centro taškas padeda nustatyti, ar taikinys yra smūgio zonoje.';

  @override
  String get settings_screen_center_point_button =>
      'Rodyti centro tašką ant taikinio';

  @override
  String get settings_screen_lost_target_title => 'Prarastas taikinys';

  @override
  String get settings_screen_lost_target_desc =>
      'Kai objektų sekimas praranda taikinį, ši parinktis padaro jį matomą. Pagal nutylėjimą prarasti taikiniai nerodomi.';

  @override
  String get settings_screen_lost_target_button => 'Rodyti prarastą taikinį';

  @override
  String get detection_screen_title => 'Aptikimo nustatymai';

  @override
  String get detection_screen_models => 'Modeliai';

  @override
  String get detection_screen_confidence => 'Pasitikėjimas';

  @override
  String get detection_screen_confidence_desc =>
      'pasitikėjimas virš #0 laikomas galiojančiu aptikimu';

  @override
  String get detection_screen_low => 'Žemas';

  @override
  String get detection_screen_high => 'Aukštas';

  @override
  String get detection_screen_nms => 'Ne maksimalus slopinimas';

  @override
  String get detection_screen_nms_desc =>
      '#0 Žemesnis NMS slenkstis (pvz. 0.3-0.4) griežčiau pašalina persidengiančius langelius ir sumažina klaidingai teigiamus rezultatus bet gali praleisti persidengiančius žmones. Aukštesnis slenkstis (0.7-0.9) išsaugo daugiau langelių kas gali padidinti klaidingai teigiamus rezultatus bet geriau aptinka persidengiančius žmones.';

  @override
  String get detection_screen_match => 'Atitikimas';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold yra pagrindinis parametras objektų sekime kuris matuoja atitikimo laipsnį tarp skirtingų aptikimo laukelių. Mažesnė vertė palengvina objektų susiejimą bet padidina neteisingų susiejimų riziką. Didesnė vertė yra griežtesnė objektų susiejimams bet gali praleisti kai kuriuos tikrus atitikimus.';

  @override
  String get detection_screen_lost => 'Prarastas';

  @override
  String get detection_screen_lost_desc =>
      'Dinamiškai nustato prarastų objektų pašalinimo laiką nuo #0 iki #1 pagal judėjimo greitį';

  @override
  String get detection_screen_consider_valid => 'Laikyti galiojančiu po';

  @override
  String get detection_screen_consider_valid_desc =>
      'Sekamas objektas bus laikomas galiojančiu po #0';

  @override
  String get detection_screen_reset => 'Atstatyti';

  @override
  String get detection_screen_reset_content =>
      'Ar tikrai norite atstatyti aptikimo nustatymus?';

  @override
  String get url_screen_title => 'Tiesioginės transliacijos URL';

  @override
  String get url_screen_desc => 'Įveskite tiesioginės transliacijos URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream arba rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Pridėti vaizdo šaltinį';

  @override
  String get add_video_screen_from => 'Pridėti vaizdo šaltinį iš';

  @override
  String get webcam_screen_add_title => 'Pridėti internetinę kamerą';

  @override
  String get webcam_screen_edit_title => 'Pasirinkti internetinę kamerą';

  @override
  String get webcam_manager_webcam => 'Internetinė kamera';

  @override
  String get camera_screen_front_camera => 'Priekinė kamera';

  @override
  String get camera_screen_back_camera => 'Galinė kamera';

  @override
  String get camera_screen_add_title => 'Pridėti kamerą';

  @override
  String get camera_screen_edit_title => 'Pasirinkti kamerą';

  @override
  String get camera_screen_zoom_level => 'Priartinimo lygis';

  @override
  String get video_screen_name_empty =>
      'Vaizdo šaltinio pavadinimas negali būti tuščias.';

  @override
  String get video_screen_desc =>
      'Valdyti vaizdo šaltinius, pridėti ar modifikuoti aptikimo zonas.';

  @override
  String get video_screen_video_name => 'Vaizdo šaltinio pavadinimas';

  @override
  String get video_screen_edit_placeholder =>
      'Priekinių durų kamera arba Automobilio stovėjimo aikštelės kamera';

  @override
  String get video_screen_change_file => 'Keisti failą';

  @override
  String get video_screen_add_zone => 'Pridėti aptikimo zoną';

  @override
  String get video_screen_zones => 'Aptikimo zonos';

  @override
  String get video_screen_zones_desc =>
      'Naudokite vilkimą ir padėjimą zonoms koreguoti';

  @override
  String get video_screen_tools => 'Įrankiai';

  @override
  String get video_screen_move_bottom => 'Perkelti dabartinę zoną į apačią';

  @override
  String get video_screen_add_point => 'Pridėti tašką į dabartinę zoną';

  @override
  String get video_screen_remove_point => 'Pašalinti tašką iš dabartinės zonos';

  @override
  String get video_screen_playback_speed => 'Atkūrimo greitis';

  @override
  String get video_screen_playback_current => 'dabartinis: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Ištrinti šį vaizdo šaltinį';

  @override
  String get video_screen_delete_content =>
      'Ar tikrai norite ištrinti šį vaizdo šaltinį?';

  @override
  String get video_screen_delete_button => 'Ištrinti';

  @override
  String get video_screen_sources =>
      'Konfigūruoti vaizdo šaltinį, aptikimo taikinius ir modelio parametrus.';

  @override
  String get video_screen_targets => 'Aptikimo taikiniai';

  @override
  String get video_screen_detection => 'Modelio parametrai';

  @override
  String get color_screen_title => 'Pasirinkti spalvą';

  @override
  String get zone_screen_desc =>
      'Aptikimo zonoje galima nustatyti aptikimo objektų tipus ir pasirinkti, kuriuos skaitiklius rodyti, pvz., aptiktus, atsiradusius ir įėjusius.';

  @override
  String get zone_screen_name_placeholder =>
      'Zonos pavadinimas, pvz., šaligatvis ar automobilių stovėjimo aikštelė';

  @override
  String get zone_screen_zone_color => 'Zonos spalva';

  @override
  String get zone_screen_color => 'Spalva';

  @override
  String get zone_screen_delete_header => 'Ištrinti šią zoną';

  @override
  String get zone_screen_delete_content =>
      'Ar tikrai norite ištrinti šią zoną?';

  @override
  String get zone_screen_delete_button => 'Ištrinti';

  @override
  String get zone_screen_can_not_delete => 'Negalima ištrinti zonos';

  @override
  String get zone_screen_one_zone_required => 'Būtina bent viena zona.';

  @override
  String get zone_screen_zone_name_required =>
      'Zonos pavadinimas negali būti tuščias';

  @override
  String get counter_screen_show_on => 'Rodyti ekrane';

  @override
  String get counter_screen_enabled => 'Įjungta';

  @override
  String get counter_screen_reentry_threshold =>
      'Pakartotinio įėjimo slenkstis';

  @override
  String get counter_screen_reentry_desc =>
      'Objektai turi įeiti #0 kartų, su #1 sekundžių atvėsimo laiku tarp kiekvieno išėjimo ir pakartotinio įėjimo, kad būtų užfiksuotas pakartotinis įėjimas';

  @override
  String get counter_screen_reentry_title => 'Pakartotinio įėjimo skaičiavimas';

  @override
  String get counter_screen_cooldown_threshold => 'Atvėsimo slenkstis';

  @override
  String get counter_screen_cooldown_desc =>
      'Pakartotiniam įėjimui reikalingas #0 sekundžių atvėsimo laikas po išėjimo iš aptikimo zonos';

  @override
  String get counter_screen_cooldown_time => 'Atvėsimo laikas';

  @override
  String get counter_screen_cooldown_in_seconds => 'sekundėmis';

  @override
  String get counter_screen_stagnant_threshold => 'Stagnacijos slenkstis';

  @override
  String get counter_screen_stagnant_desc =>
      'Objektai, išliekantys nejudančioje padėtyje ilgiau nei #0 sekundžių, bus laikomi stagnuojančiais';

  @override
  String get counter_screen_stagnant_consider => 'Laikyti stagnuojančiu';

  @override
  String get counter_screen_stagnant_in_seconds => 'sekundėmis';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Aprašymo priešdėlis';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Aprašymo priesaga';

  @override
  String get counter_screen_name_error =>
      'Skaitiklio pavadinimas negali būti tuščias';

  @override
  String get counter_screen_enabled_error => 'Klaida';

  @override
  String get counter_screen_enabled_error_content =>
      'Pirmiausia turite įjungti kitą skaitiklį, tada galėsite išjungti šį skaitiklį';

  @override
  String get objects_screen_title => 'Objektai';

  @override
  String get objects_screen_desc =>
      'Pasirinkite aptikimo taikinius, pvz., asmuo, automobilis, autobusas ir kt.';

  @override
  String get open_project_screen_title => 'Atidaryti projektą';

  @override
  String get open_project_screen_desc =>
      'Atidarykite anksčiau sukurtus projektus, išsaugant tik 20 naujausių.';

  @override
  String get open_project_screen_no_project => 'Projektų nerasta.';

  @override
  String get default_project_name => 'Projektas';

  @override
  String get default_video_name => 'Vaizdo šaltinis';

  @override
  String get default_zone_name => 'Aptikimo zona';

  @override
  String get error_oops => 'Oi, kažkas įvyko ne taip';

  @override
  String get error_content =>
      'Įvyko netikėta klaida. Ar norėtumėte pateikti pranešimą el. paštu?';

  @override
  String get error_report => 'Rašyti el. laišką';

  @override
  String get submit => 'Pateikti';

  @override
  String get ok => 'Gerai';

  @override
  String get cancel => 'Atšaukti';

  @override
  String get yes => 'Taip';

  @override
  String get no => 'Ne';

  @override
  String get close => 'Uždaryti';

  @override
  String get back => 'Atgal';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_show_summary => 'Rodyti santrauką ekrane';

  @override
  String get video_sources_photos_denied => 'Prieiga prie nuotraukų atmesta';

  @override
  String get video_sources_photos_goto_settings => 'Eiti į nustatymus';

  @override
  String get video_sources_camera_denied => 'Prieiga prie kameros atmesta';

  @override
  String get video_sources_photos_denied_msg =>
      'Eikite į nustatymus ir leiskite šiai programėlei pasiekti nuotraukas.';

  @override
  String get video_sources_camera_denied_msg =>
      'Eikite į nustatymus ir leiskite šiai programėlei pasiekti kamerą.';
}
