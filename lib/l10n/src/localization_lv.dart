// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class LocalizationLv extends Localization {
  LocalizationLv([String locale = 'lv']) : super(locale);

  @override
  String get product_name => 'Skaitītājs';

  @override
  String get product_desc =>
      'Izmanto datora redzi un mākslīgo intelektu, lai skaitītu cilvēkus, transportlīdzekļus, mājdzīvniekus un citus objektus.';

  @override
  String get product_copyright => 'Autortiesības © 2025';

  @override
  String get video_sources_webcam => 'Tīmekļa kamera';

  @override
  String get video_sources_live_stream => 'Tiešraides URL';

  @override
  String get video_sources_file => 'Fails';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera nav atrasta';

  @override
  String get video_sources_camera_not_found_message =>
      'Lai izmantotu kameru, nepieciešama atļauja piekļūt kamerai';

  @override
  String get video_sources_webcam_not_found_title =>
      'Tīmekļa kamera nav atrasta';

  @override
  String get video_sources_webcam_not_found_message =>
      'Lūdzu pārbaudiet lietotnes atļauju un kameras savienojumu';

  @override
  String get wizard_screen_desc =>
      'Izveidojiet jaunu projektu, lai sāktu skaitīšanu.';

  @override
  String get wizard_screen_new_project_from => 'Jauns projekts no';

  @override
  String get wizard_screen_language => 'Valoda';

  @override
  String get wizard_screen_about => 'Par programmu';

  @override
  String get wizard_screen_open_projects_tip =>
      'Visi projekti tiks automātiski saglabāti lokāli';

  @override
  String get wizard_screen_open_projects => 'Atvērt esošu projektu';

  @override
  String get wizard_screen_email_us => 'Rakstīt mums';

  @override
  String get language_screen_language => 'Valoda';

  @override
  String get project_view_no_videos => 'Nav pieejams video avots.';

  @override
  String get about_screen_title => 'Par programmu';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Lietotnes versija';

  @override
  String get about_screen_models => 'Objektu noteikšanas modeļi';

  @override
  String get about_screen_benchmark => 'Veiktspējas tests';

  @override
  String get about_screen_opencv_build_info => 'OpenCV būvēšanas informācija';

  @override
  String get benchmark_screen_title => 'Modeļu veiktspējas testi';

  @override
  String get benchmark_screen_recommended => 'Ieteicamais modelis';

  @override
  String get benchmark_screen_fps => 'Kadri sekundē';

  @override
  String get benchmark_screen_start_button => 'Sākt veiktspējas testu';

  @override
  String get benchmark_screen_start_failed =>
      'Neizdevās sākt veiktspējas testu, kļūdas kods ir';

  @override
  String get benchmark_screen_models => 'Objektu noteikšanas modeļi';

  @override
  String get project_screen_title => 'Projekts';

  @override
  String get project_screen_exit_confirm_title =>
      'Apstiprināt iziešanu no projekta';

  @override
  String get project_screen_exit_confirm_content =>
      'Atstājot projektu, skaitīšana tiks apturēta. Vai tiešām vēlaties turpināt?';

  @override
  String get project_screen_exit_button => 'Iziet';

  @override
  String get project_screen_add_video_button => 'Pievienot video avotu';

  @override
  String get project_screen_from_desc =>
      'Mēs uzturam nepārtrauktu 24 stundu ierakstu, lai jūs varētu apskatīt jebkuru laika periodu.';

  @override
  String get project_screen_report_settings => 'Iestatījumi';

  @override
  String get filter_screen_title => 'Filtrs';

  @override
  String get filter_screen_desc =>
      'Izvēlieties filtra diapazonu no saraksta zemāk';

  @override
  String get filter_screen_error_title => 'Filtrs';

  @override
  String get filter_screen_error_content =>
      'Beigu laikam jābūt lielākam par sākuma laiku';

  @override
  String get filter_screen_error_custom => 'Pielāgots';

  @override
  String get filter_screen_error_start => 'Sākums';

  @override
  String get filter_screen_error_end => 'Beigas';

  @override
  String get settings_screen_title => 'Iestatījumi';

  @override
  String get settings_screen_desc =>
      'Iestatiet projekta nosaukumu, noteikšanas parametrus, skaitītāju atiestatīšanu.';

  @override
  String get settings_screen_project_id => 'Projekta ID';

  @override
  String get settings_screen_project_name => 'Projekta nosaukums';

  @override
  String get settings_screen_project_name_place_holder =>
      'Rīgas iela 123 vai Vērmanes dārzs';

  @override
  String get settings_screen_project_error =>
      'Projekta nosaukums nevar būt tukšs';

  @override
  String get settings_screen_random_count_button =>
      'Pievienot nejaušus skaitījumus';

  @override
  String get settings_screen_reset_count_header =>
      'Atiestatīt visus skaitījumus šajā projektā';

  @override
  String get settings_screen_reset_count_button => 'Atiestatīt skaitījumus';

  @override
  String get settings_screen_reset_count_content =>
      'Vai tiešām vēlaties atiestatīt visus skaitījumus?';

  @override
  String get settings_screen_delete_header => 'Dzēst šo projektu';

  @override
  String get settings_screen_delete_content =>
      'Vai tiešām vēlaties dzēst šo projektu?';

  @override
  String get settings_screen_delete_button => 'Dzēst';

  @override
  String get settings_screen_center_point_title => 'Centrālais punkts uz mērķa';

  @override
  String get settings_screen_center_point_desc =>
      'Centrālais punkts palīdz noteikt, vai mērķis atrodas trāpījuma zonā.';

  @override
  String get settings_screen_center_point_button =>
      'Rādīt centrālo punktu uz mērķa';

  @override
  String get settings_screen_lost_target_title => 'Pazaudētais mērķis';

  @override
  String get settings_screen_lost_target_desc =>
      'Kad objektu izsekošana pazaudē mērķi, šī opcija to padara redzamu. Pēc noklusējuma pazaudētie mērķi netiek rādīti.';

  @override
  String get settings_screen_lost_target_button => 'Rādīt pazaudēto mērķi';

  @override
  String get detection_screen_title => 'Noteikšanas iestatījumi';

  @override
  String get detection_screen_models => 'Modeļi';

  @override
  String get detection_screen_confidence => 'Ticamība';

  @override
  String get detection_screen_confidence_desc =>
      'ticamība virs #0 tiek uzskatīta par derīgu noteikšanu';

  @override
  String get detection_screen_low => 'Zema';

  @override
  String get detection_screen_high => 'Augsta';

  @override
  String get detection_screen_nms => 'Ne-maksimuma apspiešana';

  @override
  String get detection_screen_nms_desc =>
      '#0 Zemāks NMS slieksnis (piem. 0.3-0.4) stingrāk noņem pārklājošos kadrus un samazina viltus pozitīvos rezultātus bet var neatpazīt pārklājošos cilvēkus. Augstāks slieksnis (0.7-0.9) saglabā vairāk kadru kas var palielināt viltus pozitīvos rezultātus bet labāk atpazīst pārklājošos cilvēkus.';

  @override
  String get detection_screen_match => 'Atbilstība';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold ir galvenais parametrs objektu izsekošanā kas mēra atbilstības pakāpi starp dažādiem noteikšanas rāmjiem. Zemāka vērtība atvieglo objektu sasaisti bet palielina nepareizu sasaišu risku. Augstāka vērtība ir stingrāka attiecībā uz objektu sasaistēm bet var nokavēt dažas patiesas atbilstības.';

  @override
  String get detection_screen_lost => 'Pazaudēts';

  @override
  String get detection_screen_lost_desc =>
      'Dinamiski nosaka zaudēto objektu noņemšanas laiku starp #0 un #1 atkarībā no kustības ātruma';

  @override
  String get detection_screen_consider_valid => 'Uzskatīt par derīgu pēc';

  @override
  String get detection_screen_consider_valid_desc =>
      'Izsekojamais objekts tiks uzskatīts par derīgu pēc #0';

  @override
  String get detection_screen_reset => 'Atiestatīt';

  @override
  String get detection_screen_reset_content =>
      'Vai tiešām vēlaties atiestatīt noteikšanas iestatījumus?';

  @override
  String get url_screen_title => 'Tiešraides URL';

  @override
  String get url_screen_desc => 'Lūdzu, ievadiet tiešraides URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream vai rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Pievienot video avotu';

  @override
  String get add_video_screen_from => 'Pievienot video avotu no';

  @override
  String get webcam_screen_add_title => 'Pievienot tīmekļa kameru';

  @override
  String get webcam_screen_edit_title => 'Izvēlēties tīmekļa kameru';

  @override
  String get webcam_manager_webcam => 'Tīmekļa kamera';

  @override
  String get camera_screen_front_camera => 'Priekšējā kamera';

  @override
  String get camera_screen_back_camera => 'Aizmugurējā kamera';

  @override
  String get camera_screen_add_title => 'Pievienot kameru';

  @override
  String get camera_screen_edit_title => 'Izvēlēties kameru';

  @override
  String get camera_screen_zoom_level => 'Tālummaiņas līmenis';

  @override
  String get video_screen_name_empty => 'Video nosaukums nevar būt tukšs.';

  @override
  String get video_screen_desc =>
      'Pārvaldīt video avotus, pievienot vai modificēt noteikšanas zonas.';

  @override
  String get video_screen_video_name => 'Video avota nosaukums';

  @override
  String get video_screen_edit_placeholder =>
      'Priekšdurvju kamera vai Autostāvvietas kamera';

  @override
  String get video_screen_change_file => 'Mainīt failu';

  @override
  String get video_screen_add_zone => 'Pievienot noteikšanas zonu';

  @override
  String get video_screen_zones => 'Noteikšanas zonas';

  @override
  String get video_screen_zones_desc =>
      'Izmantojiet velciet un nometiet, lai pielāgotu zonas';

  @override
  String get video_screen_tools => 'Rīki';

  @override
  String get video_screen_move_bottom => 'Pārvietot pašreizējo zonu uz apakšu';

  @override
  String get video_screen_add_point => 'Pievienot punktu pašreizējai zonai';

  @override
  String get video_screen_remove_point => 'Noņemt punktu no pašreizējās zonas';

  @override
  String get video_screen_playback_speed => 'Atskaņošanas ātrums';

  @override
  String get video_screen_playback_current => 'pašreizējais: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Dzēst šo video avotu';

  @override
  String get video_screen_delete_content =>
      'Vai tiešām vēlaties dzēst šo video avotu?';

  @override
  String get video_screen_delete_button => 'Dzēst';

  @override
  String get video_screen_sources =>
      'Konfigurēt attēla avotu, noteikšanas mērķus un modeļa parametrus.';

  @override
  String get video_screen_targets => 'Noteikšanas mērķi';

  @override
  String get video_screen_detection => 'Modeļa parametri';

  @override
  String get color_screen_title => 'Izvēlēties krāsu';

  @override
  String get zone_screen_desc =>
      'Noteikšanas zonā var iestatīt nosakāmo objektu veidus un izvēlēties, kurus skaitītājus rādīt, piemēram, Noteikts, Radies un Ienācis.';

  @override
  String get zone_screen_name_placeholder =>
      'Zonas nosaukums, piemēram, Ietve vai Autostāvvieta';

  @override
  String get zone_screen_zone_color => 'Zonas krāsa';

  @override
  String get zone_screen_color => 'Krāsa';

  @override
  String get zone_screen_delete_header => 'Dzēst šo zonu';

  @override
  String get zone_screen_delete_content => 'Vai tiešām vēlaties dzēst šo zonu?';

  @override
  String get zone_screen_delete_button => 'Dzēst';

  @override
  String get zone_screen_can_not_delete => 'Nevar dzēst zonu';

  @override
  String get zone_screen_one_zone_required => 'Nepieciešama vismaz viena zona.';

  @override
  String get zone_screen_zone_name_required =>
      'Zonas nosaukums nevar būt tukšs';

  @override
  String get counter_screen_show_on => 'Rādīt uz ekrāna';

  @override
  String get counter_screen_enabled => 'Ieslēgts';

  @override
  String get counter_screen_reentry_threshold =>
      'Atkārtotas ienākšanas slieksnis';

  @override
  String get counter_screen_reentry_desc =>
      'Objektiem jāienāk #0 reizes ar #1 sekunžu atdzišanas laiku starp katru iziešanu un atkārtotu ienākšanu, lai izraisītu atkārtotu ienākšanu';

  @override
  String get counter_screen_reentry_title => 'Atkārtotas ienākšanas skaitījums';

  @override
  String get counter_screen_cooldown_threshold => 'Atdzišanas slieksnis';

  @override
  String get counter_screen_cooldown_desc =>
      'Atkārtotai ienākšanai nepieciešams #0 sekunžu atdzišanas laiks pēc iziešanas no noteikšanas zonas';

  @override
  String get counter_screen_cooldown_time => 'Atdzišanas laiks';

  @override
  String get counter_screen_cooldown_in_seconds => 'sekundēs';

  @override
  String get counter_screen_stagnant_threshold => 'Stagnācijas slieksnis';

  @override
  String get counter_screen_stagnant_desc =>
      'Objekti, kas paliek nekustīgi ilgāk par #0 sekundēm, tiks uzskatīti par stagnējošiem';

  @override
  String get counter_screen_stagnant_consider => 'Uzskatīt par stagnējošu';

  @override
  String get counter_screen_stagnant_in_seconds => 'sekundēs';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Apraksta prefikss';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Apraksta sufikss';

  @override
  String get counter_screen_name_error =>
      'Skaitītāja nosaukums nevar būt tukšs';

  @override
  String get counter_screen_enabled_error => 'Kļūda';

  @override
  String get counter_screen_enabled_error_content =>
      'Jums vispirms jāiespējo cits skaitītājs, tad varēsiet atspējot šo skaitītāju';

  @override
  String get objects_screen_title => 'Objekti';

  @override
  String get objects_screen_desc =>
      'Izvēlieties noteikšanas mērķus, piemēram, persona, automašīna, autobuss utt.';

  @override
  String get open_project_screen_title => 'Atvērt projektu';

  @override
  String get open_project_screen_desc =>
      'Atvērt iepriekš izveidotus projektus, saglabājot tikai 20 jaunākos.';

  @override
  String get open_project_screen_no_project => 'Projekts nav atrasts.';

  @override
  String get default_project_name => 'Projekts';

  @override
  String get default_video_name => 'Video avots';

  @override
  String get default_zone_name => 'Noteikšanas zona';

  @override
  String get error_oops => 'Ak vai, kaut kas nogāja greizi';

  @override
  String get error_content =>
      'Notika neparedzēta kļūda. Vai vēlaties iesniegt e-pasta ziņojumu?';

  @override
  String get error_report => 'Rakstīt mums';

  @override
  String get submit => 'Iesniegt';

  @override
  String get ok => 'Labi';

  @override
  String get cancel => 'Atcelt';

  @override
  String get yes => 'Jā';

  @override
  String get no => 'Nē';

  @override
  String get close => 'Aizvērt';

  @override
  String get back => 'Atpakaļ';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_show_summary => 'Rādīt kopsavilkumu ekrānā';

  @override
  String get video_sources_photos_denied => 'Piekļuve fotoattēliem liegta';

  @override
  String get video_sources_photos_goto_settings => 'Doties uz iestatījumiem';

  @override
  String get video_sources_camera_denied => 'Piekļuve kamerai liegta';

  @override
  String get video_sources_photos_denied_msg =>
      'Lūdzu dodieties uz iestatījumiem un atļaujiet šai lietotnei piekļūt fotoattēliem.';

  @override
  String get video_sources_camera_denied_msg =>
      'Lūdzu dodieties uz iestatījumiem un atļaujiet šai lietotnei piekļūt kamerai.';
}
