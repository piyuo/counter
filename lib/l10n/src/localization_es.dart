// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LocalizationEs extends Localization {
  LocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get about_screen_app_version => 'Versión de la aplicación';

  @override
  String get about_screen_benchmark => 'Evaluación comparativa';

  @override
  String get about_screen_models => 'Modelos de detección de objetos';

  @override
  String get about_screen_opencv_build_info =>
      'Información de compilación de OpenCV';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_title => 'Acerca de';

  @override
  String get add_video_screen_from => 'Añadir fuente de vídeo desde';

  @override
  String get add_video_screen_title => 'Añadir fuente de vídeo';

  @override
  String get back => 'Volver';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Modelos de detección de objetos';

  @override
  String get benchmark_screen_recommended => 'Modelo recomendado';

  @override
  String get benchmark_screen_start_button => 'Iniciar evaluación';

  @override
  String get benchmark_screen_start_failed =>
      'Error al iniciar la evaluación, el código de error es';

  @override
  String get benchmark_screen_title => 'Evaluación de modelos';

  @override
  String get camera_screen_add_title => 'Añadir cámara';

  @override
  String get camera_screen_back_camera => 'Cámara trasera';

  @override
  String get camera_screen_edit_title => 'Elegir cámara';

  @override
  String get camera_screen_front_camera => 'Cámara frontal';

  @override
  String get camera_screen_zoom_level => 'Nivel de zoom';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get color_screen_title => 'Elige un color';

  @override
  String get counter_screen_cooldown_desc =>
      'La reentrada requiere un tiempo de espera de #0 segundos después de salir de la zona de detección';

  @override
  String get counter_screen_cooldown_in_seconds => 'en segundos';

  @override
  String get counter_screen_cooldown_threshold => 'Umbral de tiempo de espera';

  @override
  String get counter_screen_cooldown_time => 'Tiempo de espera';

  @override
  String get counter_screen_enabled => 'Habilitado';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content =>
      'Necesitas habilitar otro contador primero, luego podrás deshabilitar este contador';

  @override
  String get counter_screen_name_error =>
      'El nombre del contador no puede estar vacío';

  @override
  String get counter_screen_reentry_desc =>
      'Los objetos deben entrar #0 veces, con un tiempo de espera de #1 segundos entre cada salida y reentrada, para activar la reentrada';

  @override
  String get counter_screen_reentry_threshold => 'Umbral de reentrada';

  @override
  String get counter_screen_reentry_title => 'Conteo de reentrada';

  @override
  String get counter_screen_show_on => 'Mostrar en pantalla';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estancado';

  @override
  String get counter_screen_stagnant_desc =>
      'Los objetos que permanezcan estacionarios durante más de #0 segundos se considerarán estancados';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefijo de descripción';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufijo de descripción';

  @override
  String get counter_screen_stagnant_in_seconds => 'en segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Umbral de estancamiento';

  @override
  String get default_project_name => 'Proyecto';

  @override
  String get default_video_name => 'Fuente de vídeo';

  @override
  String get default_zone_name => 'Zona de detección';

  @override
  String get detection_screen_confidence => 'Confianza';

  @override
  String get detection_screen_confidence_desc =>
      'confianza superior a #0 se considera una detección válida';

  @override
  String get detection_screen_consider_valid => 'Considerar válido después de';

  @override
  String get detection_screen_consider_valid_desc =>
      'El objeto en seguimiento se considerará válido después de #0';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc =>
      'Determina dinámicamente el tiempo de eliminación de objetos perdidos entre #0 y #1 según la velocidad de movimiento';

  @override
  String get detection_screen_low => 'Baja';

  @override
  String get detection_screen_match => 'Coincidencia';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold es un parámetro clave en el seguimiento de objetos que mide el grado de coincidencia entre diferentes cuadros de detección. Un valor más bajo facilita la asociación de objetos pero aumenta el riesgo de asociaciones incorrectas. Un valor más alto es más estricto con las asociaciones pero puede perder algunas coincidencias reales.';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_nms => 'Supresión no máxima';

  @override
  String get detection_screen_nms_desc =>
      '#0 Un umbral NMS más bajo (ej. 0.3-0.4) elimina los recuadros superpuestos de manera más estricta y reduce los falsos positivos pero puede pasar por alto personas superpuestas. Un umbral más alto (0.7-0.9) conserva más recuadros lo que puede aumentar los falsos positivos pero detecta mejor a las personas superpuestas.';

  @override
  String get detection_screen_reset => 'Reiniciar';

  @override
  String get detection_screen_reset_content =>
      '¿Estás seguro de que quieres reiniciar los ajustes de detección?';

  @override
  String get detection_screen_title => 'Ajustes de detección';

  @override
  String get error_content =>
      'Ha ocurrido un error inesperado. ¿Te gustaría enviar un informe por email?';

  @override
  String get error_oops => 'Vaya, algo ha salido mal';

  @override
  String get error_report => 'Envíanos un email';

  @override
  String get filter_screen_desc =>
      'Selecciona un rango de filtro de la lista siguiente';

  @override
  String get filter_screen_error_content =>
      'La hora de finalización debe ser posterior a la hora de inicio';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get filter_screen_error_start => 'Inicio';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get no => 'No';

  @override
  String get objects_screen_desc =>
      'Elige objetivos de detección como persona, coche, autobús, etc.';

  @override
  String get objects_screen_title => 'Objetos';

  @override
  String get ok => 'Aceptar';

  @override
  String get open_project_screen_desc =>
      'Abre proyectos creados previamente, conservando solo los 20 más recientes.';

  @override
  String get open_project_screen_no_project =>
      'No se encontró ningún proyecto.';

  @override
  String get open_project_screen_title => 'Abrir proyecto';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get product_desc =>
      'Usando visión artificial e IA para contar personas, vehículos, mascotas y más.';

  @override
  String get product_name => 'Contador';

  @override
  String get project_screen_add_video_button => 'Añadir fuente de vídeo';

  @override
  String get project_screen_exit_button => 'Salir';

  @override
  String get project_screen_exit_confirm_content =>
      'Al abandonar el proyecto se detendrá el conteo. ¿Estás seguro de que quieres continuar?';

  @override
  String get project_screen_exit_confirm_title =>
      'Confirmar salida del proyecto';

  @override
  String get project_screen_from_desc =>
      'Mantenemos un registro continuo de 24 horas, para que puedas consultar cualquier intervalo de tiempo que necesites.';

  @override
  String get project_screen_report_settings => 'Ajustes';

  @override
  String get project_screen_title => 'Proyecto';

  @override
  String get project_view_no_videos => 'No hay fuentes de vídeo disponibles.';

  @override
  String get settings_screen_center_point_button =>
      'Mostrar punto central en el objetivo';

  @override
  String get settings_screen_center_point_desc =>
      'El punto central ayuda a determinar si el objetivo está dentro de la zona de detección.';

  @override
  String get settings_screen_center_point_title =>
      'Punto central en el objetivo';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_delete_content =>
      '¿Estás seguro de que quieres eliminar este proyecto?';

  @override
  String get settings_screen_delete_header => 'Eliminar este proyecto';

  @override
  String get settings_screen_desc =>
      'Configura el nombre del proyecto, parámetros de detección y reinicio de conteos.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar objetivo perdido';

  @override
  String get settings_screen_lost_target_desc =>
      'Cuando el seguimiento de objetos pierde un objetivo, esta opción lo hace visible. Por defecto, los objetivos perdidos no se muestran.';

  @override
  String get settings_screen_lost_target_title => 'Objetivo perdido';

  @override
  String get settings_screen_project_error =>
      'El nombre del proyecto no puede estar vacío';

  @override
  String get settings_screen_project_id => 'ID del proyecto';

  @override
  String get settings_screen_project_name => 'Nombre del proyecto';

  @override
  String get settings_screen_project_name_place_holder =>
      'Calle Gran Vía 123 o Parque del Retiro';

  @override
  String get settings_screen_random_count_button => 'Añadir conteos aleatorios';

  @override
  String get settings_screen_reset_count_button => 'Reiniciar conteos';

  @override
  String get settings_screen_reset_count_content =>
      '¿Estás seguro de que quieres reiniciar todos los conteos?';

  @override
  String get settings_screen_reset_count_header =>
      'Reiniciar todos los conteos en este proyecto';

  @override
  String get settings_screen_title => 'Ajustes';

  @override
  String get submit => 'Enviar';

  @override
  String get url_screen_desc =>
      'Por favor, introduce la URL de transmisión en directo';

  @override
  String get url_screen_title => 'URL de transmisión en directo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://ejemplo.com/transmision o rtsp://ejemplo.com/transmision';

  @override
  String get video_screen_add_point => 'Añadir punto a la zona actual';

  @override
  String get video_screen_add_zone => 'Añadir zona de detección';

  @override
  String get video_screen_change_file => 'Cambiar archivo';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_delete_content =>
      '¿Estás seguro de que quieres eliminar esta fuente de vídeo?';

  @override
  String get video_screen_delete_header => 'Eliminar esta fuente de vídeo';

  @override
  String get video_screen_desc =>
      'Gestiona fuentes de vídeo, añade o modifica zonas de detección.';

  @override
  String get video_screen_detection => 'Parámetros del modelo';

  @override
  String get video_screen_edit_placeholder =>
      'Cámara de la entrada o Cámara del aparcamiento';

  @override
  String get video_screen_move_bottom => 'Mover zona actual al fondo';

  @override
  String get video_screen_name_empty =>
      'El nombre del vídeo no puede estar vacío.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'actual: ';

  @override
  String get video_screen_playback_speed => 'Velocidad de reproducción';

  @override
  String get video_screen_remove_point => 'Eliminar punto de la zona actual';

  @override
  String get video_screen_sources =>
      'Configura la fuente de imagen, objetivos de detección y parámetros del modelo.';

  @override
  String get video_screen_targets => 'Objetivos de detección';

  @override
  String get video_screen_tools => 'Herramientas';

  @override
  String get video_screen_video_name => 'Nombre de la fuente de vídeo';

  @override
  String get video_screen_zones => 'Zonas de detección';

  @override
  String get video_screen_zones_desc =>
      'Usa arrastrar y soltar para ajustar zonas';

  @override
  String get video_sources_camera => 'Cámara';

  @override
  String get video_sources_camera_denied => 'Acceso a cámara denegado';

  @override
  String get video_sources_camera_denied_msg =>
      'Ve a ajustes y permite el acceso a la cámara para esta aplicación.';

  @override
  String get video_sources_camera_not_found_message =>
      'Necesitas conceder permisos de cámara para utilizarla';

  @override
  String get video_sources_camera_not_found_title => 'Cámara no encontrada';

  @override
  String get video_sources_file => 'Archivo';

  @override
  String get video_sources_live_stream => 'URL de transmisión en directo';

  @override
  String get video_sources_photos_denied => 'Acceso a fotos denegado';

  @override
  String get video_sources_photos_denied_msg =>
      'Ve a ajustes y permite el acceso a fotos para esta aplicación.';

  @override
  String get video_sources_photos_goto_settings => 'Ir a ajustes';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_webcam_not_found_message =>
      'Por favor compruebe el permiso de la aplicación y la conexión de la cámara';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam no encontrada';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get webcam_screen_add_title => 'Añadir webcam';

  @override
  String get webcam_screen_edit_title => 'Elegir webcam';

  @override
  String get wizard_screen_about => 'Acerca de';

  @override
  String get wizard_screen_desc =>
      'Crea un nuevo proyecto a continuación para empezar a contar.';

  @override
  String get wizard_screen_email_us => 'Envíanos un email';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_new_project_from => 'Nuevo proyecto desde';

  @override
  String get wizard_screen_open_projects => 'Abrir proyecto existente';

  @override
  String get wizard_screen_open_projects_tip =>
      'Todos los proyectos se guardarán automáticamente en local';

  @override
  String get yes => 'Sí';

  @override
  String get zone_screen_can_not_delete => 'No se puede eliminar la zona';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_delete_content =>
      '¿Estás seguro de que quieres eliminar esta zona?';

  @override
  String get zone_screen_delete_header => 'Eliminar esta zona';

  @override
  String get zone_screen_desc =>
      'La zona de detección puede configurar los tipos de objetos a detectar y elegir qué contadores mostrar, como Detectados, Aparecidos y Entrados.';

  @override
  String get zone_screen_name_placeholder =>
      'El nombre de la zona, como Acera o Aparcamiento';

  @override
  String get zone_screen_one_zone_required => 'Se requiere al menos una zona.';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_color => 'Color de la zona';

  @override
  String get zone_screen_zone_name_required =>
      'El nombre de la zona no puede estar vacío';

  @override
  String get zone_screen_zone_show_summary => 'Mostrar resumen en pantalla';
}

/// The translations for Spanish Castilian, as used in Argentina (`es_AR`).
class LocalizationEsAr extends LocalizationEs {
  LocalizationEsAr() : super('es_AR');

  @override
  String get about_screen_app_version => 'Versión de la app';

  @override
  String get about_screen_benchmark => 'Rendimiento';

  @override
  String get about_screen_models => 'Modelos de detección de objetos';

  @override
  String get about_screen_opencv_build_info =>
      'Información de compilación de OpenCV';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_title => 'Acerca de';

  @override
  String get add_video_screen_from => 'Agregar fuente de video desde';

  @override
  String get add_video_screen_title => 'Agregar fuente de video';

  @override
  String get back => 'Volver';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Modelos de detección de objetos';

  @override
  String get benchmark_screen_recommended => 'Modelo recomendado';

  @override
  String get benchmark_screen_start_button => 'Iniciar prueba';

  @override
  String get benchmark_screen_start_failed =>
      'No se pudo iniciar la prueba, el código de error es';

  @override
  String get benchmark_screen_title => 'Rendimiento de modelos';

  @override
  String get camera_screen_add_title => 'Agregar cámara';

  @override
  String get camera_screen_back_camera => 'Cámara trasera';

  @override
  String get camera_screen_edit_title => 'Elegir cámara';

  @override
  String get camera_screen_front_camera => 'Cámara frontal';

  @override
  String get camera_screen_zoom_level => 'Nivel de zoom';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get color_screen_title => 'Elegí un color';

  @override
  String get counter_screen_cooldown_desc =>
      'El reingreso requiere un tiempo de enfriamiento de #0 segundos después de salir de la zona de detección';

  @override
  String get counter_screen_cooldown_in_seconds => 'en segundos';

  @override
  String get counter_screen_cooldown_threshold => 'Umbral de enfriamiento';

  @override
  String get counter_screen_cooldown_time => 'Tiempo de enfriamiento';

  @override
  String get counter_screen_enabled => 'Habilitado';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content =>
      'Necesitás habilitar otro contador primero, luego podés deshabilitar este contador';

  @override
  String get counter_screen_name_error =>
      'El nombre del contador no puede estar vacío';

  @override
  String get counter_screen_reentry_desc =>
      'Los objetos deben ingresar #0 veces, con un tiempo de espera de #1 segundos entre cada salida y reingreso, para activar el reingreso';

  @override
  String get counter_screen_reentry_threshold => 'Umbral de reingreso';

  @override
  String get counter_screen_reentry_title => 'Conteo de reingreso';

  @override
  String get counter_screen_show_on => 'Mostrar en pantalla';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estancado';

  @override
  String get counter_screen_stagnant_desc =>
      'Los objetos que permanezcan inmóviles durante más de #0 segundos se considerarán estancados';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefijo de descripción';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufijo de descripción';

  @override
  String get counter_screen_stagnant_in_seconds => 'en segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Umbral de estancamiento';

  @override
  String get default_project_name => 'Proyecto';

  @override
  String get default_video_name => 'Fuente de video';

  @override
  String get default_zone_name => 'Zona de detección';

  @override
  String get detection_screen_confidence => 'Confianza';

  @override
  String get detection_screen_confidence_desc =>
      'confianza superior a #0 se considera una detección válida';

  @override
  String get detection_screen_consider_valid => 'Considerar válido después de';

  @override
  String get detection_screen_consider_valid_desc =>
      'El objeto en seguimiento se considerará válido después de #0';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc =>
      'Determina dinámicamente el tiempo de eliminación de objetos perdidos entre #0 y #1 según la velocidad de movimiento';

  @override
  String get detection_screen_low => 'Baja';

  @override
  String get detection_screen_match => 'Coincidencia';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold es un parámetro clave en el seguimiento de objetos que mide el grado de coincidencia entre diferentes cuadros de detección. Un valor más bajo facilita la asociación de objetos pero aumenta el riesgo de asociaciones incorrectas. Un valor más alto es más estricto con las asociaciones pero puede perder algunas coincidencias reales.';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_nms => 'Supresión no máxima';

  @override
  String get detection_screen_nms_desc =>
      '#0 Un umbral NMS más bajo (ej. 0.3-0.4) elimina los recuadros superpuestos de manera más estricta y reduce los falsos positivos pero puede pasar por alto personas superpuestas. Un umbral más alto (0.7-0.9) conserva más recuadros lo que puede aumentar los falsos positivos pero detecta mejor a las personas superpuestas.';

  @override
  String get detection_screen_reset => 'Reiniciar';

  @override
  String get detection_screen_reset_content =>
      '¿Estás seguro de que querés reiniciar la configuración de detección?';

  @override
  String get detection_screen_title => 'Configuración de detección';

  @override
  String get error_content =>
      'Ocurrió un error inesperado. ¿Querés enviar un informe por correo?';

  @override
  String get error_oops => 'Ups, algo salió mal';

  @override
  String get error_report => 'Envianos un correo';

  @override
  String get filter_screen_desc => 'Seleccioná un rango de filtro de la lista';

  @override
  String get filter_screen_error_content =>
      'La hora de finalización debe ser posterior a la hora de inicio';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get filter_screen_error_start => 'Inicio';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_title => 'Filtrar';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get no => 'No';

  @override
  String get objects_screen_desc =>
      'Elegí objetivos de detección como personas, autos, colectivos, etc.';

  @override
  String get objects_screen_title => 'Objetos';

  @override
  String get ok => 'Aceptar';

  @override
  String get open_project_screen_desc =>
      'Abrí proyectos creados anteriormente, manteniendo solo los 20 más recientes.';

  @override
  String get open_project_screen_no_project =>
      'No se encontró ningún proyecto.';

  @override
  String get open_project_screen_title => 'Abrir proyecto';

  @override
  String get product_copyright => 'Derechos de autor © 2025';

  @override
  String get product_desc =>
      'Usa visión por computadora e inteligencia artificial para contar personas, vehículos, mascotas y más.';

  @override
  String get product_name => 'Contador';

  @override
  String get project_screen_add_video_button => 'Agregar fuente de video';

  @override
  String get project_screen_exit_button => 'Salir';

  @override
  String get project_screen_exit_confirm_content =>
      'Salir del proyecto detendrá el conteo. ¿Estás seguro de que querés continuar?';

  @override
  String get project_screen_exit_confirm_title =>
      'Confirmar salida del proyecto';

  @override
  String get project_screen_from_desc =>
      'Mantenemos un registro continuo de 24 horas, para que puedas ver cualquier momento que necesites.';

  @override
  String get project_screen_report_settings => 'Configuración';

  @override
  String get project_screen_title => 'Proyecto';

  @override
  String get project_view_no_videos => 'No hay fuentes de video disponibles.';

  @override
  String get settings_screen_center_point_button =>
      'Mostrar punto central en el objetivo';

  @override
  String get settings_screen_center_point_desc =>
      'El punto central ayuda a determinar si el objetivo está dentro de la zona de detección.';

  @override
  String get settings_screen_center_point_title =>
      'Punto central en el objetivo';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_delete_content =>
      '¿Estás seguro de que querés eliminar este proyecto?';

  @override
  String get settings_screen_delete_header => 'Eliminar este proyecto';

  @override
  String get settings_screen_desc =>
      'Configurá el nombre del proyecto, parámetros de detección y limpieza de conteos.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar objetivo perdido';

  @override
  String get settings_screen_lost_target_desc =>
      'Cuando el seguimiento pierde un objetivo, esta opción lo hace visible. Por defecto, los objetivos perdidos no se muestran.';

  @override
  String get settings_screen_lost_target_title => 'Objetivo perdido';

  @override
  String get settings_screen_project_error =>
      'El nombre del proyecto no puede estar vacío';

  @override
  String get settings_screen_project_id => 'ID del proyecto';

  @override
  String get settings_screen_project_name => 'Nombre del proyecto';

  @override
  String get settings_screen_project_name_place_holder =>
      'Av. Corrientes 123 o Parque Centenario';

  @override
  String get settings_screen_random_count_button =>
      'Agregar conteos aleatorios';

  @override
  String get settings_screen_reset_count_button => 'Reiniciar conteos';

  @override
  String get settings_screen_reset_count_content =>
      '¿Estás seguro de que querés reiniciar todos los conteos?';

  @override
  String get settings_screen_reset_count_header =>
      'Reiniciar todos los conteos de este proyecto';

  @override
  String get settings_screen_title => 'Configuración';

  @override
  String get submit => 'Enviar';

  @override
  String get url_screen_desc =>
      'Por favor, ingresá la URL de transmisión en vivo';

  @override
  String get url_screen_title => 'URL de transmisión en vivo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://ejemplo.com/stream o rtsp://ejemplo.com/stream';

  @override
  String get video_screen_add_point => 'Agregar punto a la zona actual';

  @override
  String get video_screen_add_zone => 'Agregar zona de detección';

  @override
  String get video_screen_change_file => 'Cambiar archivo';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_delete_content =>
      '¿Estás seguro de que querés eliminar esta fuente de video?';

  @override
  String get video_screen_delete_header => 'Eliminar esta fuente de video';

  @override
  String get video_screen_desc =>
      'Administrá fuentes de video, agregá o modificá zonas de detección.';

  @override
  String get video_screen_detection => 'Parámetros del modelo';

  @override
  String get video_screen_edit_placeholder =>
      'Cámara de entrada o Cámara de estacionamiento';

  @override
  String get video_screen_move_bottom => 'Mover zona actual al fondo';

  @override
  String get video_screen_name_empty =>
      'El nombre del video no puede estar vacío.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'actual: ';

  @override
  String get video_screen_playback_speed => 'Velocidad de reproducción';

  @override
  String get video_screen_remove_point => 'Quitar punto de la zona actual';

  @override
  String get video_screen_sources =>
      'Configurá la fuente de imagen, objetivos de detección y parámetros del modelo.';

  @override
  String get video_screen_targets => 'Objetivos de detección';

  @override
  String get video_screen_tools => 'Herramientas';

  @override
  String get video_screen_video_name => 'Nombre de fuente de video';

  @override
  String get video_screen_zones => 'Zonas de detección';

  @override
  String get video_screen_zones_desc =>
      'Usá arrastrar y soltar para ajustar zonas';

  @override
  String get video_sources_camera => 'Cámara';

  @override
  String get video_sources_camera_denied => 'Acceso a cámara denegado';

  @override
  String get video_sources_camera_denied_msg =>
      'Andá a configuración y permitile a la app acceder a tu cámara.';

  @override
  String get video_sources_camera_not_found_message =>
      'Necesita otorgar permiso para usar la cámara';

  @override
  String get video_sources_camera_not_found_title => 'Cámara no encontrada';

  @override
  String get video_sources_file => 'Archivo';

  @override
  String get video_sources_live_stream => 'URL de transmisión en vivo';

  @override
  String get video_sources_photos_denied => 'Acceso a fotos denegado';

  @override
  String get video_sources_photos_denied_msg =>
      'Andá a configuración y permitile a la app acceder a tus fotos.';

  @override
  String get video_sources_photos_goto_settings => 'Ir a ajustes';

  @override
  String get video_sources_webcam => 'Cámara web';

  @override
  String get video_sources_webcam_not_found_message =>
      'Por favor compruebe el permiso de la aplicación y la conexión de la cámara';

  @override
  String get video_sources_webcam_not_found_title => 'Cámara web no encontrada';

  @override
  String get webcam_manager_webcam => 'Cámara web';

  @override
  String get webcam_screen_add_title => 'Agregar cámara web';

  @override
  String get webcam_screen_edit_title => 'Elegir cámara web';

  @override
  String get wizard_screen_about => 'Acerca de';

  @override
  String get wizard_screen_desc =>
      'Creá un nuevo proyecto para comenzar a contar.';

  @override
  String get wizard_screen_email_us => 'Envianos un correo';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_new_project_from => 'Nuevo proyecto desde';

  @override
  String get wizard_screen_open_projects => 'Abrir proyecto existente';

  @override
  String get wizard_screen_open_projects_tip =>
      'Todos los proyectos se guardarán automáticamente en forma local';

  @override
  String get yes => 'Sí';

  @override
  String get zone_screen_can_not_delete => 'No se puede eliminar la zona';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_delete_content =>
      '¿Estás seguro de que querés eliminar esta zona?';

  @override
  String get zone_screen_delete_header => 'Eliminar esta zona';

  @override
  String get zone_screen_desc =>
      'La zona de detección puede configurar los tipos de objetos a detectar y elegir qué contadores mostrar, como Detectados, Generados y Entrantes.';

  @override
  String get zone_screen_name_placeholder =>
      'Nombre de la zona, como Vereda o Estacionamiento';

  @override
  String get zone_screen_one_zone_required => 'Se requiere al menos una zona.';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_color => 'Color de zona';

  @override
  String get zone_screen_zone_name_required =>
      'El nombre de la zona no puede estar vacío';

  @override
  String get zone_screen_zone_show_summary => 'Mostrar resumen en pantalla';
}

/// The translations for Spanish Castilian, as used in Colombia (`es_CO`).
class LocalizationEsCo extends LocalizationEs {
  LocalizationEsCo() : super('es_CO');

  @override
  String get about_screen_app_version => 'Versión de la aplicación';

  @override
  String get about_screen_benchmark => 'Prueba de rendimiento';

  @override
  String get about_screen_models => 'Modelos de detección de objetos';

  @override
  String get about_screen_opencv_build_info =>
      'Información de compilación de OpenCV';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_title => 'Acerca de';

  @override
  String get add_video_screen_from => 'Agregar fuente de video desde';

  @override
  String get add_video_screen_title => 'Agregar fuente de video';

  @override
  String get back => 'Atrás';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Modelos de detección de objetos';

  @override
  String get benchmark_screen_recommended => 'Modelo recomendado';

  @override
  String get benchmark_screen_start_button => 'Iniciar prueba';

  @override
  String get benchmark_screen_start_failed =>
      'Error al iniciar la prueba, el código de error es';

  @override
  String get benchmark_screen_title => 'Pruebas de rendimiento de modelos';

  @override
  String get camera_screen_add_title => 'Agregar cámara';

  @override
  String get camera_screen_back_camera => 'Cámara trasera';

  @override
  String get camera_screen_edit_title => 'Elegir cámara';

  @override
  String get camera_screen_front_camera => 'Cámara frontal';

  @override
  String get camera_screen_zoom_level => 'Nivel de zoom';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get color_screen_title => 'Elegir un color';

  @override
  String get counter_screen_cooldown_desc =>
      'El reingreso requiere un tiempo de espera de #0 segundos después de salir de la zona de detección';

  @override
  String get counter_screen_cooldown_in_seconds => 'en segundos';

  @override
  String get counter_screen_cooldown_threshold => 'Umbral de enfriamiento';

  @override
  String get counter_screen_cooldown_time => 'Tiempo de espera';

  @override
  String get counter_screen_enabled => 'Habilitado';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content =>
      'Necesitas habilitar otro contador primero, luego podrás deshabilitar este contador';

  @override
  String get counter_screen_name_error =>
      'El nombre del contador no puede estar vacío';

  @override
  String get counter_screen_reentry_desc =>
      'Los objetos deben entrar #0 veces, con un tiempo de espera de #1 segundos entre cada salida y reingreso, para activar el reingreso';

  @override
  String get counter_screen_reentry_threshold => 'Umbral de reingreso';

  @override
  String get counter_screen_reentry_title => 'Conteo de reingreso';

  @override
  String get counter_screen_show_on => 'Mostrar en pantalla';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estancado';

  @override
  String get counter_screen_stagnant_desc =>
      'Los objetos que permanezcan inmóviles durante más de #0 segundos se considerarán estancados';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefijo de descripción';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufijo de descripción';

  @override
  String get counter_screen_stagnant_in_seconds => 'en segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Umbral de estancamiento';

  @override
  String get default_project_name => 'Proyecto';

  @override
  String get default_video_name => 'Fuente de video';

  @override
  String get default_zone_name => 'Zona de detección';

  @override
  String get detection_screen_confidence => 'Confianza';

  @override
  String get detection_screen_confidence_desc =>
      'confianza superior a #0 se considera como una detección válida';

  @override
  String get detection_screen_consider_valid => 'Considerar válido después de';

  @override
  String get detection_screen_consider_valid_desc =>
      'El objeto seguido se considerará válido después de #0';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc =>
      'Determina dinámicamente el tiempo de eliminación de objetos perdidos entre #0 y #1 según la velocidad de movimiento';

  @override
  String get detection_screen_low => 'Baja';

  @override
  String get detection_screen_match => 'Coincidencia';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold es un parámetro clave en el seguimiento de objetos que mide el grado de coincidencia entre diferentes marcos de detección. Un valor más bajo facilita la asociación de objetos pero aumenta el riesgo de asociaciones incorrectas. Un valor más alto es más estricto con las asociaciones pero puede perder algunas coincidencias reales.';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_nms => 'Supresión no máxima';

  @override
  String get detection_screen_nms_desc =>
      '#0 Un umbral NMS más bajo (ej. 0.3-0.4) elimina los recuadros superpuestos de manera más estricta y reduce los falsos positivos pero puede pasar por alto personas superpuestas. Un umbral más alto (0.7-0.9) conserva más recuadros lo que puede aumentar los falsos positivos pero detecta mejor a las personas superpuestas.';

  @override
  String get detection_screen_reset => 'Reiniciar';

  @override
  String get detection_screen_reset_content =>
      '¿Estás seguro de que deseas reiniciar la configuración de detección?';

  @override
  String get detection_screen_title => 'Configuración de detección';

  @override
  String get error_content =>
      'Ocurrió un error inesperado. ¿Te gustaría enviar un reporte por correo electrónico?';

  @override
  String get error_oops => 'Ups, algo salió mal';

  @override
  String get error_report => 'Escríbenos';

  @override
  String get filter_screen_desc =>
      'Selecciona un rango de filtro de la lista a continuación';

  @override
  String get filter_screen_error_content =>
      'La hora de fin debe ser mayor que la hora de inicio';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get filter_screen_error_start => 'Inicio';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get no => 'No';

  @override
  String get objects_screen_desc =>
      'Elige objetivos de detección como persona, carro, bus, etc.';

  @override
  String get objects_screen_title => 'Objetos';

  @override
  String get ok => 'Aceptar';

  @override
  String get open_project_screen_desc =>
      'Abre proyectos creados anteriormente, conservando solo los 20 más recientes.';

  @override
  String get open_project_screen_no_project => 'No se encontraron proyectos.';

  @override
  String get open_project_screen_title => 'Abrir Proyecto';

  @override
  String get product_copyright => 'Derechos de autor © 2025';

  @override
  String get product_desc =>
      'Utiliza visión por computadora e inteligencia artificial para contar personas, vehículos, mascotas y más.';

  @override
  String get product_name => 'Contador';

  @override
  String get project_screen_add_video_button => 'Agregar fuente de video';

  @override
  String get project_screen_exit_button => 'Salir';

  @override
  String get project_screen_exit_confirm_content =>
      'Salir del proyecto detendrá el conteo. ¿Estás seguro de que deseas continuar?';

  @override
  String get project_screen_exit_confirm_title =>
      'Confirmar salida del proyecto';

  @override
  String get project_screen_from_desc =>
      'Mantenemos un registro continuo de 24 horas, para que puedas ver cualquier momento que necesites.';

  @override
  String get project_screen_report_settings => 'Configuración';

  @override
  String get project_screen_title => 'Proyecto';

  @override
  String get project_view_no_videos => 'No hay fuentes de video disponibles.';

  @override
  String get settings_screen_center_point_button =>
      'Mostrar punto central en el objetivo';

  @override
  String get settings_screen_center_point_desc =>
      'El punto central ayuda a determinar si el objetivo está dentro de la zona de detección.';

  @override
  String get settings_screen_center_point_title =>
      'Punto central en el objetivo';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_delete_content =>
      '¿Estás seguro de que deseas eliminar este proyecto?';

  @override
  String get settings_screen_delete_header => 'Eliminar este proyecto';

  @override
  String get settings_screen_desc =>
      'Configura el nombre del proyecto, parámetros de detección y reinicio de contadores.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar objetivo perdido';

  @override
  String get settings_screen_lost_target_desc =>
      'Cuando el seguimiento de objetos pierde un objetivo, esta opción lo hace visible. Por defecto, los objetivos perdidos no se muestran.';

  @override
  String get settings_screen_lost_target_title => 'Objetivo perdido';

  @override
  String get settings_screen_project_error =>
      'El nombre del proyecto no puede estar vacío';

  @override
  String get settings_screen_project_id => 'ID del Proyecto';

  @override
  String get settings_screen_project_name => 'Nombre del Proyecto';

  @override
  String get settings_screen_project_name_place_holder =>
      'Calle 123 o Parque Simón Bolívar';

  @override
  String get settings_screen_random_count_button =>
      'Agregar conteos aleatorios';

  @override
  String get settings_screen_reset_count_button => 'Reiniciar conteos';

  @override
  String get settings_screen_reset_count_content =>
      '¿Estás seguro de que deseas reiniciar todos los conteos?';

  @override
  String get settings_screen_reset_count_header =>
      'Reiniciar todos los conteos en este proyecto';

  @override
  String get settings_screen_title => 'Configuración';

  @override
  String get submit => 'Enviar';

  @override
  String get url_screen_desc =>
      'Por favor ingresa la URL de transmisión en vivo';

  @override
  String get url_screen_title => 'URL de transmisión en vivo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://ejemplo.com/transmision o rtsp://ejemplo.com/transmision';

  @override
  String get video_screen_add_point => 'Agregar punto a la zona actual';

  @override
  String get video_screen_add_zone => 'Agregar zona de detección';

  @override
  String get video_screen_change_file => 'Cambiar archivo';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_delete_content =>
      '¿Estás seguro de que deseas eliminar esta fuente de video?';

  @override
  String get video_screen_delete_header => 'Eliminar esta fuente de video';

  @override
  String get video_screen_desc =>
      'Administra fuentes de video, agrega o modifica zonas de detección.';

  @override
  String get video_screen_detection => 'Parámetros del modelo';

  @override
  String get video_screen_edit_placeholder =>
      'Cámara de la entrada o Cámara del parqueadero';

  @override
  String get video_screen_move_bottom => 'Mover zona actual al fondo';

  @override
  String get video_screen_name_empty =>
      'El nombre del video no puede estar vacío.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'actual: ';

  @override
  String get video_screen_playback_speed => 'Velocidad de reproducción';

  @override
  String get video_screen_remove_point => 'Quitar punto de la zona actual';

  @override
  String get video_screen_sources =>
      'Configura la fuente de imagen, objetivos de detección y parámetros del modelo.';

  @override
  String get video_screen_targets => 'Objetivos de detección';

  @override
  String get video_screen_tools => 'Herramientas';

  @override
  String get video_screen_video_name => 'Nombre de la fuente de video';

  @override
  String get video_screen_zones => 'Zonas de detección';

  @override
  String get video_screen_zones_desc =>
      'Usa arrastrar y soltar para ajustar las zonas';

  @override
  String get video_sources_camera => 'Cámara';

  @override
  String get video_sources_camera_denied => 'Acceso a cámara denegado';

  @override
  String get video_sources_camera_denied_msg =>
      'Ve a configuración y permite el acceso a la cámara para esta aplicación.';

  @override
  String get video_sources_camera_not_found_message =>
      'Necesitas otorgar permiso para usar la cámara';

  @override
  String get video_sources_camera_not_found_title => 'Cámara no encontrada';

  @override
  String get video_sources_file => 'Archivo';

  @override
  String get video_sources_live_stream => 'URL de transmisión en vivo';

  @override
  String get video_sources_photos_denied => 'Acceso a fotos denegado';

  @override
  String get video_sources_photos_denied_msg =>
      'Ve a configuración y permite el acceso a fotos para esta aplicación.';

  @override
  String get video_sources_photos_goto_settings => 'Ir a configuración';

  @override
  String get video_sources_webcam => 'Cámara web';

  @override
  String get video_sources_webcam_not_found_message =>
      'Verificar permiso de la app y conexión de cámara';

  @override
  String get video_sources_webcam_not_found_title => 'Cámara web no encontrada';

  @override
  String get webcam_manager_webcam => 'Cámara web';

  @override
  String get webcam_screen_add_title => 'Agregar cámara web';

  @override
  String get webcam_screen_edit_title => 'Elegir cámara web';

  @override
  String get wizard_screen_about => 'Acerca de';

  @override
  String get wizard_screen_desc =>
      'Crea un nuevo proyecto para comenzar a contar.';

  @override
  String get wizard_screen_email_us => 'Escríbenos';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_new_project_from => 'Nuevo proyecto desde';

  @override
  String get wizard_screen_open_projects => 'Abrir proyecto existente';

  @override
  String get wizard_screen_open_projects_tip =>
      'Todos los proyectos se guardarán automáticamente de forma local';

  @override
  String get yes => 'Sí';

  @override
  String get zone_screen_can_not_delete => 'No se puede eliminar la zona';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_delete_content =>
      '¿Estás seguro de que deseas eliminar esta zona?';

  @override
  String get zone_screen_delete_header => 'Eliminar esta zona';

  @override
  String get zone_screen_desc =>
      'La zona de detección puede configurar los tipos de objetos a detectar y elegir qué contadores mostrar, como Detectados, Generados y Entrantes.';

  @override
  String get zone_screen_name_placeholder =>
      'Nombre de la zona, como Andén o Parqueadero';

  @override
  String get zone_screen_one_zone_required => 'Se requiere al menos una zona.';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_color => 'Color de la zona';

  @override
  String get zone_screen_zone_name_required =>
      'El nombre de la zona no puede estar vacío';

  @override
  String get zone_screen_zone_show_summary => 'Mostrar resumen en pantalla';
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class LocalizationEsMx extends LocalizationEs {
  LocalizationEsMx() : super('es_MX');

  @override
  String get about_screen_app_version => 'Versión de la aplicación';

  @override
  String get about_screen_benchmark => 'Evaluación de rendimiento';

  @override
  String get about_screen_models => 'Modelos de detección de objetos';

  @override
  String get about_screen_opencv_build_info =>
      'Información de compilación de OpenCV';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_title => 'Acerca de';

  @override
  String get add_video_screen_from => 'Agregar fuente de video desde';

  @override
  String get add_video_screen_title => 'Agregar fuente de video';

  @override
  String get back => 'Regresar';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Modelos de detección de objetos';

  @override
  String get benchmark_screen_recommended => 'Modelo recomendado';

  @override
  String get benchmark_screen_start_button => 'Iniciar evaluación';

  @override
  String get benchmark_screen_start_failed =>
      'No se pudo iniciar la evaluación, el código de error es';

  @override
  String get benchmark_screen_title => 'Evaluaciones de modelos';

  @override
  String get camera_screen_add_title => 'Agregar cámara';

  @override
  String get camera_screen_back_camera => 'Cámara trasera';

  @override
  String get camera_screen_edit_title => 'Elegir cámara';

  @override
  String get camera_screen_front_camera => 'Cámara frontal';

  @override
  String get camera_screen_zoom_level => 'Nivel de zoom';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get color_screen_title => 'Elige un color';

  @override
  String get counter_screen_cooldown_desc =>
      'El reingreso requiere un tiempo de espera de #0 segundos después de salir de la zona de detección';

  @override
  String get counter_screen_cooldown_in_seconds => 'en segundos';

  @override
  String get counter_screen_cooldown_threshold => 'Umbral de tiempo de espera';

  @override
  String get counter_screen_cooldown_time => 'Tiempo de espera';

  @override
  String get counter_screen_enabled => 'Habilitado';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content =>
      'Necesitas habilitar otro contador primero, luego podrás deshabilitar este contador';

  @override
  String get counter_screen_name_error =>
      'El nombre del contador no puede estar vacío';

  @override
  String get counter_screen_reentry_desc =>
      'Los objetos deben entrar #0 veces, con un tiempo de espera de #1 segundos entre cada salida y reingreso, para activar el reingreso';

  @override
  String get counter_screen_reentry_threshold => 'Umbral de reingreso';

  @override
  String get counter_screen_reentry_title => 'Conteo de reingreso';

  @override
  String get counter_screen_show_on => 'Mostrar en pantalla';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estancado';

  @override
  String get counter_screen_stagnant_desc =>
      'Los objetos que permanezcan inmóviles por más de #0 segundos serán considerados estancados';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefijo de descripción';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufijo de descripción';

  @override
  String get counter_screen_stagnant_in_seconds => 'en segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Umbral de estancamiento';

  @override
  String get default_project_name => 'Proyecto';

  @override
  String get default_video_name => 'Fuente de video';

  @override
  String get default_zone_name => 'Zona de detección';

  @override
  String get detection_screen_confidence => 'Confianza';

  @override
  String get detection_screen_confidence_desc =>
      'confianza superior a #0 se considera como una detección válida';

  @override
  String get detection_screen_consider_valid => 'Considerar válido después de';

  @override
  String get detection_screen_consider_valid_desc =>
      'El objeto rastreado será considerado válido después de #0';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc =>
      'Determina dinámicamente el tiempo de eliminación de objetos perdidos entre #0 y #1 según la velocidad de movimiento';

  @override
  String get detection_screen_low => 'Baja';

  @override
  String get detection_screen_match => 'Coincidencia';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold es un parámetro clave en el seguimiento de objetos que mide el grado de coincidencia entre diferentes marcos de detección. Un valor más bajo facilita la asociación de objetos pero aumenta el riesgo de asociaciones incorrectas. Un valor más alto es más estricto pero puede perder algunas coincidencias reales.';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_nms => 'Supresión no máxima';

  @override
  String get detection_screen_nms_desc =>
      '#0 Un umbral NMS más bajo (ej. 0.3-0.4) elimina los recuadros superpuestos de manera más estricta y reduce los falsos positivos pero puede pasar por alto personas superpuestas. Un umbral más alto (0.7-0.9) conserva más recuadros lo que puede aumentar los falsos positivos pero detecta mejor a las personas superpuestas.';

  @override
  String get detection_screen_reset => 'Reiniciar';

  @override
  String get detection_screen_reset_content =>
      '¿Estás seguro de que quieres reiniciar los ajustes de detección?';

  @override
  String get detection_screen_title => 'Ajustes de detección';

  @override
  String get error_content =>
      'Ocurrió un error inesperado. ¿Te gustaría enviar un reporte por correo electrónico?';

  @override
  String get error_oops => 'Ups, algo salió mal';

  @override
  String get error_report => 'Envíanos un correo';

  @override
  String get filter_screen_desc =>
      'Selecciona un rango de filtro de la lista siguiente';

  @override
  String get filter_screen_error_content =>
      'La hora de finalización debe ser mayor que la hora de inicio';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get filter_screen_error_start => 'Inicio';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get no => 'No';

  @override
  String get objects_screen_desc =>
      'Elige objetivos de detección como persona, auto, autobús, etc.';

  @override
  String get objects_screen_title => 'Objetos';

  @override
  String get ok => 'Aceptar';

  @override
  String get open_project_screen_desc =>
      'Abre proyectos creados previamente, conservando solo los 20 más recientes.';

  @override
  String get open_project_screen_no_project =>
      'No se encontró ningún proyecto.';

  @override
  String get open_project_screen_title => 'Abrir proyecto';

  @override
  String get product_copyright => 'Derechos de autor © 2025';

  @override
  String get product_desc =>
      'Usa visión computacional e inteligencia artificial para contar personas, vehículos, mascotas y más.';

  @override
  String get product_name => 'Contador';

  @override
  String get project_screen_add_video_button => 'Agregar fuente de video';

  @override
  String get project_screen_exit_button => 'Salir';

  @override
  String get project_screen_exit_confirm_content =>
      'Salir del proyecto detendrá el conteo. ¿Estás seguro de que quieres continuar?';

  @override
  String get project_screen_exit_confirm_title =>
      'Confirmar salida del proyecto';

  @override
  String get project_screen_from_desc =>
      'Mantenemos un registro de las últimas 24 horas, para que puedas ver cualquier segmento de tiempo que necesites.';

  @override
  String get project_screen_report_settings => 'Configuración';

  @override
  String get project_screen_title => 'Proyecto';

  @override
  String get project_view_no_videos => 'No hay fuentes de video disponibles.';

  @override
  String get settings_screen_center_point_button =>
      'Mostrar punto central en el objetivo';

  @override
  String get settings_screen_center_point_desc =>
      'El punto central ayuda a determinar si el objetivo está dentro de la zona de detección.';

  @override
  String get settings_screen_center_point_title =>
      'Punto central en el objetivo';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_delete_content =>
      '¿Estás seguro de que quieres eliminar este proyecto?';

  @override
  String get settings_screen_delete_header => 'Eliminar este proyecto';

  @override
  String get settings_screen_desc =>
      'Establece el nombre del proyecto, parámetros de detección y borrado de conteos.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar objetivo perdido';

  @override
  String get settings_screen_lost_target_desc =>
      'Cuando el seguimiento de objetos pierde un objetivo, esta opción lo hace visible. Por defecto, los objetivos perdidos no se muestran.';

  @override
  String get settings_screen_lost_target_title => 'Objetivo perdido';

  @override
  String get settings_screen_project_error =>
      'El nombre del proyecto no puede estar vacío';

  @override
  String get settings_screen_project_id => 'ID del proyecto';

  @override
  String get settings_screen_project_name => 'Nombre del proyecto';

  @override
  String get settings_screen_project_name_place_holder =>
      'Av. Reforma 123 o Parque Chapultepec';

  @override
  String get settings_screen_random_count_button =>
      'Agregar conteos aleatorios';

  @override
  String get settings_screen_reset_count_button => 'Reiniciar conteos';

  @override
  String get settings_screen_reset_count_content =>
      '¿Estás seguro de que quieres reiniciar todos los conteos?';

  @override
  String get settings_screen_reset_count_header =>
      'Reiniciar todos los conteos en este proyecto';

  @override
  String get settings_screen_title => 'Configuración';

  @override
  String get submit => 'Enviar';

  @override
  String get url_screen_desc =>
      'Por favor ingresa la URL de transmisión en vivo';

  @override
  String get url_screen_title => 'URL de transmisión en vivo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://ejemplo.com/transmision o rtsp://ejemplo.com/transmision';

  @override
  String get video_screen_add_point => 'Agregar punto a la zona actual';

  @override
  String get video_screen_add_zone => 'Agregar zona de detección';

  @override
  String get video_screen_change_file => 'Cambiar archivo';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_delete_content =>
      '¿Estás seguro de que quieres eliminar esta fuente de video?';

  @override
  String get video_screen_delete_header => 'Eliminar esta fuente de video';

  @override
  String get video_screen_desc =>
      'Administra fuentes de video, agrega o modifica zonas de detección.';

  @override
  String get video_screen_detection => 'Parámetros del modelo';

  @override
  String get video_screen_edit_placeholder =>
      'Cámara de entrada o Cámara de estacionamiento';

  @override
  String get video_screen_move_bottom => 'Mover zona actual al fondo';

  @override
  String get video_screen_name_empty =>
      'El nombre del video no puede estar vacío.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'actual: ';

  @override
  String get video_screen_playback_speed => 'Velocidad de reproducción';

  @override
  String get video_screen_remove_point => 'Quitar punto de la zona actual';

  @override
  String get video_screen_sources =>
      'Configurar fuente de imagen, objetivos de detección y parámetros del modelo.';

  @override
  String get video_screen_targets => 'Objetivos de detección';

  @override
  String get video_screen_tools => 'Herramientas';

  @override
  String get video_screen_video_name => 'Nombre de la fuente de video';

  @override
  String get video_screen_zones => 'Zonas de detección';

  @override
  String get video_screen_zones_desc =>
      'Usa arrastrar y soltar para ajustar zonas';

  @override
  String get video_sources_camera => 'Cámara';

  @override
  String get video_sources_camera_denied => 'Acceso a cámara denegado';

  @override
  String get video_sources_camera_denied_msg =>
      'Ve a configuración y permite el acceso a la cámara para esta aplicación.';

  @override
  String get video_sources_camera_not_found_message =>
      'Se necesita otorgar permiso para usar la cámara';

  @override
  String get video_sources_camera_not_found_title => 'Cámara no encontrada';

  @override
  String get video_sources_file => 'Archivo';

  @override
  String get video_sources_live_stream => 'URL de transmisión en vivo';

  @override
  String get video_sources_photos_denied => 'Acceso a fotos denegado';

  @override
  String get video_sources_photos_denied_msg =>
      'Ve a configuración y permite el acceso a fotos para esta aplicación.';

  @override
  String get video_sources_photos_goto_settings => 'Ir a configuración';

  @override
  String get video_sources_webcam => 'Cámara web';

  @override
  String get video_sources_webcam_not_found_message =>
      'Verificar permiso de la app y conexión de cámara';

  @override
  String get video_sources_webcam_not_found_title => 'Cámara web no encontrada';

  @override
  String get webcam_manager_webcam => 'Cámara web';

  @override
  String get webcam_screen_add_title => 'Agregar cámara web';

  @override
  String get webcam_screen_edit_title => 'Elegir cámara web';

  @override
  String get wizard_screen_about => 'Acerca de';

  @override
  String get wizard_screen_desc =>
      'Crea un nuevo proyecto a continuación para comenzar a contar.';

  @override
  String get wizard_screen_email_us => 'Envíanos un correo';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_new_project_from => 'Nuevo proyecto desde';

  @override
  String get wizard_screen_open_projects => 'Abrir proyecto existente';

  @override
  String get wizard_screen_open_projects_tip =>
      'Todos los proyectos se guardarán automáticamente de forma local';

  @override
  String get yes => 'Sí';

  @override
  String get zone_screen_can_not_delete => 'No se puede eliminar la zona';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_delete_content =>
      '¿Estás seguro de que quieres eliminar esta zona?';

  @override
  String get zone_screen_delete_header => 'Eliminar esta zona';

  @override
  String get zone_screen_desc =>
      'La zona de detección puede establecer los tipos de objetos a detectar y elegir qué contadores mostrar, como Detectados, Generados y Entrados.';

  @override
  String get zone_screen_name_placeholder =>
      'El nombre de la zona, como Banqueta o Estacionamiento';

  @override
  String get zone_screen_one_zone_required => 'Se requiere al menos una zona.';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_color => 'Color de la zona';

  @override
  String get zone_screen_zone_name_required =>
      'El nombre de la zona no puede estar vacío';

  @override
  String get zone_screen_zone_show_summary => 'Mostrar resumen en pantalla';
}
