// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class LocalizationCa extends Localization {
  LocalizationCa([String locale = 'ca']) : super(locale);

  @override
  String get product_name => 'Comptador de Visió';

  @override
  String get product_desc => 'Utilitza visió per ordinador i intel·ligència artificial per comptar persones, vehicles, mascotes i més.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Càmera web';

  @override
  String get video_sources_live_stream => 'URL de transmissió en directe';

  @override
  String get video_sources_file => 'Fitxer';

  @override
  String get video_sources_camera => 'Càmera';

  @override
  String get video_sources_camera_not_found_title => 'Càmera no trobada';

  @override
  String get video_sources_camera_not_found_message => 'Cal concedir permís a la càmera per utilitzar-la';

  @override
  String get video_sources_webcam_not_found_title => 'Càmera web no trobada';

  @override
  String get video_sources_webcam_not_found_message => 'Si us plau, comproveu si hi ha alguna càmera web connectada';

  @override
  String get wizard_screen_desc => 'Creeu un nou projecte a continuació per començar a comptar.';

  @override
  String get wizard_screen_new_project_from => 'Nou projecte des de';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_about => 'Quant a';

  @override
  String get wizard_screen_open_projects_tip => 'Tots els projectes es desaran automàticament de manera local';

  @override
  String get wizard_screen_open_projects => 'Obrir projecte existent';

  @override
  String get wizard_screen_email_us => 'Envia\'ns un correu';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get project_view_no_videos => 'No hi ha cap font de vídeo disponible.';

  @override
  String get about_screen_title => 'Quant a';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_app_version => 'Versió de l\'aplicació';

  @override
  String get about_screen_models => 'Models de detecció d\'objectes';

  @override
  String get about_screen_benchmark => 'Comparativa';

  @override
  String get about_screen_opencv_build_info => 'Informació de compilació d\'OpenCV';

  @override
  String get benchmark_screen_title => 'Comparatives dels models';

  @override
  String get benchmark_screen_recommended => 'Model recomanat';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Iniciar comparativa';

  @override
  String get benchmark_screen_start_failed => 'No s\'ha pogut iniciar la comparativa, el codi d\'error és';

  @override
  String get benchmark_screen_models => 'Models de detecció d\'objectes';

  @override
  String get project_screen_title => 'Projecte';

  @override
  String get project_screen_exit_confirm_title => 'Confirmar sortida del projecte';

  @override
  String get project_screen_exit_confirm_content => 'Sortir del projecte aturarà el comptatge. Esteu segur que voleu continuar?';

  @override
  String get project_screen_exit_button => 'Sortir';

  @override
  String get project_screen_add_video_button => 'Afegir font de vídeo';

  @override
  String get project_screen_from_desc => 'Mantenim un registre continu de 24 hores, així podeu veure qualsevol segment de temps que necessiteu.';

  @override
  String get project_screen_report_settings => 'Configuració';

  @override
  String get filter_screen_title => 'Filtre';

  @override
  String get filter_screen_desc => 'Seleccioneu un interval de filtre de la llista següent';

  @override
  String get filter_screen_error_title => 'Filtre';

  @override
  String get filter_screen_error_content => 'L\'hora de finalització ha de ser posterior a l\'hora d\'inici';

  @override
  String get filter_screen_error_custom => 'Personalitzat';

  @override
  String get filter_screen_error_start => 'Inici';

  @override
  String get filter_screen_error_end => 'Fi';

  @override
  String get settings_screen_title => 'Configuració';

  @override
  String get settings_screen_desc => 'Establiu el nom del projecte, els paràmetres de detecció i l\'esborrat de comptatge.';

  @override
  String get settings_screen_project_id => 'ID del projecte';

  @override
  String get settings_screen_project_name => 'Nom del projecte';

  @override
  String get settings_screen_project_name_place_holder => 'Carrer Major 123 o Parc de la Ciutadella';

  @override
  String get settings_screen_project_error => 'El nom del projecte no pot estar buit';

  @override
  String get settings_screen_random_count_button => 'Afegir comptatges aleatoris';

  @override
  String get settings_screen_reset_count_header => 'Restablir tots els comptatges d\'aquest projecte';

  @override
  String get settings_screen_reset_count_button => 'Restablir comptatges';

  @override
  String get settings_screen_reset_count_content => 'Esteu segur que voleu restablir tots els comptatges?';

  @override
  String get settings_screen_delete_header => 'Eliminar aquest projecte';

  @override
  String get settings_screen_delete_content => 'Esteu segur que voleu eliminar aquest projecte?';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_center_point_title => 'Punt central a l\'objectiu';

  @override
  String get settings_screen_center_point_desc => 'El punt central ajuda a determinar si l\'objectiu es troba dins de la zona d\'impacte.';

  @override
  String get settings_screen_center_point_button => 'Mostrar punt central a l\'objectiu';

  @override
  String get settings_screen_lost_target_title => 'Objectiu perdut';

  @override
  String get settings_screen_lost_target_desc => 'Quan el seguiment d\'objectes perd un objectiu, aquesta opció el fa visible. Per defecte, els objectius perduts no es mostren.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar objectiu perdut';

  @override
  String get detection_screen_title => 'Configuració de detecció';

  @override
  String get detection_screen_models => 'Models';

  @override
  String get detection_screen_confidence => 'Confiança';

  @override
  String get detection_screen_confidence_desc => 'confiança superior a #0 considerada com una detecció vàlida';

  @override
  String get detection_screen_low => 'Baix';

  @override
  String get detection_screen_high => 'Alt';

  @override
  String get detection_screen_nms => 'Supressió no màxima';

  @override
  String get detection_screen_nms_desc => '#0 Un llindar NMS més baix (per exemple, 30%) eliminarà més agressivament les caixes delimitadores superposades, mentre que un llindar NMS més alt (per exemple, 0,6) permetrà més superposició';

  @override
  String get detection_screen_match => 'Coincidència';

  @override
  String get detection_screen_match_desc => 'Coincidència superior a #0 es considera el mateix objecte.';

  @override
  String get detection_screen_lost => 'Perdut';

  @override
  String get detection_screen_lost_desc => 'L\'objecte en seguiment s\'eliminarà si es perd durant #0';

  @override
  String get detection_screen_consider_valid => 'Considerar vàlid després de';

  @override
  String get detection_screen_consider_valid_desc => 'L\'objecte en seguiment es considerarà vàlid després de #0';

  @override
  String get detection_screen_reset => 'Restablir';

  @override
  String get detection_screen_reset_content => 'Esteu segur que voleu restablir la configuració de detecció?';

  @override
  String get url_screen_title => 'URL de transmissió en directe';

  @override
  String get url_screen_desc => 'Si us plau, introduïu l\'URL de transmissió en directe';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream o rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Afegir font de vídeo';

  @override
  String get add_video_screen_from => 'Afegir font de vídeo des de';

  @override
  String get webcam_screen_add_title => 'Afegir càmera web';

  @override
  String get webcam_screen_edit_title => 'Triar càmera web';

  @override
  String get webcam_manager_webcam => 'Càmera web';

  @override
  String get camera_screen_front_camera => 'Càmera frontal';

  @override
  String get camera_screen_back_camera => 'Càmera posterior';

  @override
  String get camera_screen_add_title => 'Afegir càmera';

  @override
  String get camera_screen_edit_title => 'Triar càmera';

  @override
  String get camera_screen_zoom_level => 'Nivell de zoom';

  @override
  String get video_screen_name_empty => 'El nom del vídeo no pot estar buit.';

  @override
  String get video_screen_desc => 'Gestiona fonts de vídeo, afegeix o modifica zones de detecció.';

  @override
  String get video_screen_video_name => 'Nom de la font de vídeo';

  @override
  String get video_screen_edit_placeholder => 'Càmera de la porta principal o Càmera de l\'aparcament';

  @override
  String get video_screen_change_file => 'Canviar fitxer';

  @override
  String get video_screen_add_zone => 'Afegir zona de detecció';

  @override
  String get video_screen_zones => 'Zones de detecció';

  @override
  String get video_screen_zones_desc => 'Utilitzeu arrossegar i deixar anar per ajustar les zones';

  @override
  String get video_screen_tools => 'Eines';

  @override
  String get video_screen_move_bottom => 'Moure la zona actual a baix';

  @override
  String get video_screen_add_point => 'Afegir punt a la zona actual';

  @override
  String get video_screen_remove_point => 'Eliminar punt de la zona actual';

  @override
  String get video_screen_playback_speed => 'Velocitat de reproducció';

  @override
  String get video_screen_playback_current => 'actual: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Eliminar aquesta font de vídeo';

  @override
  String get video_screen_delete_content => 'Esteu segur que voleu eliminar aquesta font de vídeo?';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_sources => 'Configurar font d\'imatge, objectius de detecció i paràmetres del model.';

  @override
  String get video_screen_targets => 'Objectius de detecció';

  @override
  String get video_screen_detection => 'Paràmetres del model';

  @override
  String get color_screen_title => 'Triar un color';

  @override
  String get zone_screen_desc => 'La zona de detecció pot establir els tipus d\'objectes a detectar i triar quins comptadors mostrar, com ara Detectats, Apareguts i Entrats.';

  @override
  String get zone_screen_name_placeholder => 'El nom de la zona, com Vorera o Aparcament';

  @override
  String get zone_screen_zone_color => 'Color de la zona';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_delete_header => 'Eliminar aquesta zona';

  @override
  String get zone_screen_delete_content => 'Esteu segur que voleu eliminar aquesta zona?';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_can_not_delete => 'No es pot eliminar la zona';

  @override
  String get zone_screen_one_zone_required => 'Es requereix almenys una zona.';

  @override
  String get zone_screen_zone_name_required => 'El nom de la zona no pot estar buit';

  @override
  String get counter_screen_show_on => 'Mostrar a la pantalla';

  @override
  String get counter_screen_enabled => 'Activat';

  @override
  String get counter_screen_reentry_threshold => 'Llindar de reentrada';

  @override
  String get counter_screen_reentry_desc => 'Els objectes han d\'entrar #0 vegades, amb un temps d\'espera de #1 segons entre cada sortida i reentrada, per activar la reentrada';

  @override
  String get counter_screen_reentry_title => 'Comptatge de reentrades';

  @override
  String get counter_screen_cooldown_threshold => 'Llindar de temps d\'espera';

  @override
  String get counter_screen_cooldown_desc => 'La reentrada requereix un temps d\'espera de #0 segons després de sortir de la zona de detecció';

  @override
  String get counter_screen_cooldown_time => 'Temps d\'espera';

  @override
  String get counter_screen_cooldown_in_seconds => 'en segons';

  @override
  String get counter_screen_stagnant_threshold => 'Llindar d\'estancament';

  @override
  String get counter_screen_stagnant_desc => 'Els objectes que romanen estacionaris durant més de #0 segons es consideraran estancats';

  @override
  String get counter_screen_stagnant_consider => 'Considerar com a estancat';

  @override
  String get counter_screen_stagnant_in_seconds => 'en segons';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefix de descripció';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufix de descripció';

  @override
  String get counter_screen_name_error => 'El nom del comptador no pot estar buit';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content => 'Cal activar primer un altre comptador, després podreu desactivar aquest comptador';

  @override
  String get objects_screen_title => 'Objectes';

  @override
  String get objects_screen_desc => 'Trieu objectius de detecció com persona, cotxe, autobús, etc.';

  @override
  String get open_project_screen_title => 'Obrir projecte';

  @override
  String get open_project_screen_desc => 'Obrir projectes creats anteriorment, mantenint només els 20 més recents.';

  @override
  String get open_project_screen_no_project => 'No s\'ha trobat cap projecte.';

  @override
  String get default_project_name => 'Projecte';

  @override
  String get default_video_name => 'Font de vídeo';

  @override
  String get default_zone_name => 'Zona de detecció';

  @override
  String get error_oops => 'Ui, alguna cosa ha anat malament';

  @override
  String get error_content => 'S\'ha produït un error inesperat. Voleu enviar un informe per correu electrònic?';

  @override
  String get error_report => 'Envia\'ns un correu';

  @override
  String get submit => 'Enviar';

  @override
  String get ok => 'D\'acord';

  @override
  String get cancel => 'Cancel·lar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get close => 'Tancar';

  @override
  String get back => 'Tornar';
}
