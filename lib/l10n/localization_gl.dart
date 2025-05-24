// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class LocalizationGl extends Localization {
  LocalizationGl([String locale = 'gl']) : super(locale);

  @override
  String get product_name => 'Contador';

  @override
  String get product_desc =>
      'Usa visión por computador e intelixencia artificial para contar persoas, vehículos, mascotas e moito máis.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Cámara web';

  @override
  String get video_sources_live_stream => 'URL de transmisión en directo';

  @override
  String get video_sources_file => 'Ficheiro';

  @override
  String get video_sources_camera => 'Cámara';

  @override
  String get video_sources_camera_not_found_title => 'Cámara non atopada';

  @override
  String get video_sources_camera_not_found_message =>
      'Necesita conceder permiso de cámara para utilizala';

  @override
  String get video_sources_webcam_not_found_title => 'Cámara web non atopada';

  @override
  String get video_sources_webcam_not_found_message =>
      'Comprobe o permiso e conexión da aplicación';

  @override
  String get wizard_screen_desc =>
      'Cree un novo proxecto para comezar a contar.';

  @override
  String get wizard_screen_new_project_from => 'Novo proxecto desde';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_about => 'Acerca de';

  @override
  String get wizard_screen_open_projects_tip =>
      'Todos os proxectos gardaranse automaticamente no dispositivo';

  @override
  String get wizard_screen_open_projects => 'Abrir proxecto existente';

  @override
  String get wizard_screen_email_us => 'Envíanos un correo';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get project_view_no_videos => 'Non hai fonte de vídeo dispoñible.';

  @override
  String get about_screen_title => 'Acerca de';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_app_version => 'Versión da aplicación';

  @override
  String get about_screen_models => 'Modelos de detección de obxectos';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info =>
      'Información de compilación de OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmarks dos modelos';

  @override
  String get benchmark_screen_recommended => 'Modelo recomendado';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Iniciar benchmark';

  @override
  String get benchmark_screen_start_failed =>
      'Erro ao iniciar o benchmark, o código de erro é';

  @override
  String get benchmark_screen_models => 'Modelos de detección de obxectos';

  @override
  String get project_screen_title => 'Proxecto';

  @override
  String get project_screen_exit_confirm_title => 'Confirmar saída do proxecto';

  @override
  String get project_screen_exit_confirm_content =>
      'Abandonar o proxecto deterá a contaxe. Está seguro de que quere continuar?';

  @override
  String get project_screen_exit_button => 'Saír';

  @override
  String get project_screen_add_video_button => 'Engadir fonte de vídeo';

  @override
  String get project_screen_from_desc =>
      'Mantemos un rexistro continuo de 24 horas, para que poida ver calquera segmento de tempo que necesite.';

  @override
  String get project_screen_report_settings => 'Configuración';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get filter_screen_desc =>
      'Seleccione un rango de filtro da lista seguinte';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_error_content =>
      'A hora de fin debe ser posterior á hora de inicio';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_start => 'Inicio';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get settings_screen_title => 'Configuración';

  @override
  String get settings_screen_desc =>
      'Configure o nome do proxecto, os parámetros de detección e o borrado de contadores.';

  @override
  String get settings_screen_project_id => 'ID do proxecto';

  @override
  String get settings_screen_project_name => 'Nome do proxecto';

  @override
  String get settings_screen_project_name_place_holder =>
      'Rúa do Franco 123 ou Parque de Santa Margarita';

  @override
  String get settings_screen_project_error =>
      'O nome do proxecto non pode estar baleiro';

  @override
  String get settings_screen_random_count_button =>
      'Engadir contaxes aleatorias';

  @override
  String get settings_screen_reset_count_header =>
      'Reiniciar todas as contaxes neste proxecto';

  @override
  String get settings_screen_reset_count_button => 'Reiniciar contaxes';

  @override
  String get settings_screen_reset_count_content =>
      'Está seguro de que quere reiniciar todas as contaxes?';

  @override
  String get settings_screen_delete_header => 'Eliminar este proxecto';

  @override
  String get settings_screen_delete_content =>
      'Está seguro de que quere eliminar este proxecto?';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_center_point_title => 'Punto central no obxectivo';

  @override
  String get settings_screen_center_point_desc =>
      'O punto central axuda a determinar se o obxectivo está dentro da zona de detección.';

  @override
  String get settings_screen_center_point_button =>
      'Mostrar punto central no obxectivo';

  @override
  String get settings_screen_lost_target_title => 'Obxectivo perdido';

  @override
  String get settings_screen_lost_target_desc =>
      'Cando o seguimento de obxectos perde un obxectivo, esta opción faino visible. Por defecto, os obxectivos perdidos non se mostran.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar obxectivo perdido';

  @override
  String get detection_screen_title => 'Configuración de detección';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_confidence => 'Confianza';

  @override
  String get detection_screen_confidence_desc =>
      'confianza por riba de #0 considérase unha detección válida';

  @override
  String get detection_screen_low => 'Baixa';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_nms => 'Supresión non máxima';

  @override
  String get detection_screen_nms_desc =>
      '#0 Un limiar NMS máis baixo (p.ex. 0.3-0.4) elimina as caixas superpostas máis estritamente e reduce os falsos positivos pero pode perder persoas superpostas. Un limiar máis alto (0.7-0.9) mantén máis caixas o que pode aumentar os falsos positivos pero detecta mellor as persoas superpostas.';

  @override
  String get detection_screen_match => 'Coincidencia';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold é un parámetro clave no seguimento de obxectos que mide o grao de coincidencia entre diferentes caixas de detección. Un valor máis baixo facilita a asociación de obxectos pero aumenta o risco de asociacións incorrectas. Un valor máis alto é máis estrito coas asociacións pero pode perder algunhas coincidencias reais.';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc =>
      'Determina dinamicamente o tempo de eliminación de obxectos perdidos entre #0 e #1 segundo a velocidade de movemento';

  @override
  String get detection_screen_consider_valid => 'Considerar válido despois de';

  @override
  String get detection_screen_consider_valid_desc =>
      'O obxecto seguido considerarase válido despois de #0';

  @override
  String get detection_screen_reset => 'Restablecer';

  @override
  String get detection_screen_reset_content =>
      'Está seguro de que quere restablecer a configuración de detección?';

  @override
  String get url_screen_title => 'URL de transmisión en directo';

  @override
  String get url_screen_desc => 'Introduza o URL da transmisión en directo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream ou rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Engadir fonte de vídeo';

  @override
  String get add_video_screen_from => 'Engadir fonte de vídeo desde';

  @override
  String get webcam_screen_add_title => 'Engadir cámara web';

  @override
  String get webcam_screen_edit_title => 'Escoller cámara web';

  @override
  String get webcam_manager_webcam => 'Cámara web';

  @override
  String get camera_screen_front_camera => 'Cámara frontal';

  @override
  String get camera_screen_back_camera => 'Cámara traseira';

  @override
  String get camera_screen_add_title => 'Engadir cámara';

  @override
  String get camera_screen_edit_title => 'Escoller cámara';

  @override
  String get camera_screen_zoom_level => 'Nivel de zoom';

  @override
  String get video_screen_name_empty =>
      'O nome do vídeo non pode estar baleiro.';

  @override
  String get video_screen_desc =>
      'Xestionar fontes de vídeo, engadir ou modificar zonas de detección.';

  @override
  String get video_screen_video_name => 'Nome da fonte de vídeo';

  @override
  String get video_screen_edit_placeholder =>
      'Cámara da porta principal ou Cámara do aparcadoiro';

  @override
  String get video_screen_change_file => 'Cambiar ficheiro';

  @override
  String get video_screen_add_zone => 'Engadir zona de detección';

  @override
  String get video_screen_zones => 'Zonas de detección';

  @override
  String get video_screen_zones_desc =>
      'Use arrastrar e soltar para axustar as zonas';

  @override
  String get video_screen_tools => 'Ferramentas';

  @override
  String get video_screen_move_bottom => 'Mover a zona actual ao fondo';

  @override
  String get video_screen_add_point => 'Engadir punto á zona actual';

  @override
  String get video_screen_remove_point => 'Eliminar punto da zona actual';

  @override
  String get video_screen_playback_speed => 'Velocidade de reprodución';

  @override
  String get video_screen_playback_current => 'actual: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Eliminar esta fonte de vídeo';

  @override
  String get video_screen_delete_content =>
      'Está seguro de que quere eliminar esta fonte de vídeo?';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_sources =>
      'Configurar fonte de imaxe, obxectivos de detección e parámetros do modelo.';

  @override
  String get video_screen_targets => 'Obxectivos de detección';

  @override
  String get video_screen_detection => 'Parámetros do modelo';

  @override
  String get color_screen_title => 'Escoller unha cor';

  @override
  String get zone_screen_desc =>
      'A zona de detección pode establecer os tipos de obxectos a detectar e escoller que contadores mostrar, como Detectados, Aparecidos e Entrados.';

  @override
  String get zone_screen_name_placeholder =>
      'O nome da zona, como Beirarrúa ou Aparcadoiro';

  @override
  String get zone_screen_zone_color => 'Cor da zona';

  @override
  String get zone_screen_color => 'Cor';

  @override
  String get zone_screen_delete_header => 'Eliminar esta zona';

  @override
  String get zone_screen_delete_content =>
      'Está seguro de que quere eliminar esta zona?';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_can_not_delete => 'Non se pode eliminar a zona';

  @override
  String get zone_screen_one_zone_required => 'Requírese polo menos unha zona.';

  @override
  String get zone_screen_zone_name_required =>
      'O nome da zona non pode estar baleiro';

  @override
  String get counter_screen_show_on => 'Mostrar na pantalla';

  @override
  String get counter_screen_enabled => 'Activado';

  @override
  String get counter_screen_reentry_threshold => 'Limiar de reentrada';

  @override
  String get counter_screen_reentry_desc =>
      'Os obxectos deben entrar #0 veces, cun tempo de espera de #1 segundos entre cada saída e reentrada, para activar a reentrada';

  @override
  String get counter_screen_reentry_title => 'Contaxe de reentrada';

  @override
  String get counter_screen_cooldown_threshold => 'Limiar de tempo de espera';

  @override
  String get counter_screen_cooldown_desc =>
      'A reentrada require un tempo de espera de #0 segundos despois de saír da zona de detección';

  @override
  String get counter_screen_cooldown_time => 'Tempo de espera';

  @override
  String get counter_screen_cooldown_in_seconds => 'en segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Limiar de estancamento';

  @override
  String get counter_screen_stagnant_desc =>
      'Os obxectos que permanezan estacionarios durante máis de #0 segundos consideraranse estancados';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estancado';

  @override
  String get counter_screen_stagnant_in_seconds => 'en segundos';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefixo de descrición';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufixo de descrición';

  @override
  String get counter_screen_name_error =>
      'O nome do contador non pode estar baleiro';

  @override
  String get counter_screen_enabled_error => 'Erro';

  @override
  String get counter_screen_enabled_error_content =>
      'Debe activar primeiro outro contador para poder desactivar este';

  @override
  String get objects_screen_title => 'Obxectos';

  @override
  String get objects_screen_desc =>
      'Escoller obxectivos de detección como persoa, coche, autobús, etc.';

  @override
  String get open_project_screen_title => 'Abrir proxecto';

  @override
  String get open_project_screen_desc =>
      'Abrir proxectos creados anteriormente, mantendo só os 20 máis recentes.';

  @override
  String get open_project_screen_no_project => 'Non se atopou ningún proxecto.';

  @override
  String get default_project_name => 'Proxecto';

  @override
  String get default_video_name => 'Fonte de vídeo';

  @override
  String get default_zone_name => 'Zona de detección';

  @override
  String get error_oops => 'Ups, algo saíu mal';

  @override
  String get error_content =>
      'Produciuse un erro inesperado. Quere enviar un informe por correo electrónico?';

  @override
  String get error_report => 'Envíanos un correo';

  @override
  String get submit => 'Enviar';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yes => 'Si';

  @override
  String get no => 'Non';

  @override
  String get close => 'Pechar';

  @override
  String get back => 'Volver';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_show_summary => 'Amosar resumo na pantalla';

  @override
  String get video_sources_photos_denied => 'Acceso a fotos denegado';

  @override
  String get video_sources_photos_goto_settings => 'Ir a axustes';

  @override
  String get video_sources_camera_denied => 'Acceso á cámara denegado';

  @override
  String get video_sources_photos_denied_msg =>
      'Vaia a axustes e permita o acceso a fotos para esta aplicación.';

  @override
  String get video_sources_camera_denied_msg =>
      'Vaia a axustes e permita o acceso á cámara para esta aplicación.';
}
