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
  String get about_screen_email_us => 'Envíanos un email';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get appeared => 'Aparecieron';

  @override
  String get appeared_help =>
      'Cuenta las personas o vehículos cuya primera posición detectada estaba dentro de esta área.\\n\\nÚtil para comprender dónde comienza el seguimiento.\\n\\n(Principalmente para usuarios avanzados)';

  @override
  String get average_occupancy => 'Ocupación promedio';

  @override
  String get average_occupancy_help =>
      'Muestra el número promedio de personas o vehículos en esta área durante la ventana de conteo actual.\\n\\nAyuda a medir qué tan concurrida estuvo el área durante toda la ventana de conteo.';

  @override
  String get average_stay => 'Tiempo promedio de permanencia';

  @override
  String get average_stay_help =>
      'Muestra el tiempo promedio que las personas o los vehículos permanecieron en esta área.\\n\\nUn mayor tiempo promedio puede indicar que los clientes pasan más tiempo en esta área.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter utiliza la cámara y la IA del dispositivo para contar personas. Primero, comprobemos que tu dispositivo sea compatible.';

  @override
  String get camera_test_screen_instruction =>
      'Apunta la cámara hacia personas. La aplicación dibujará cuadros alrededor de quienes detecte.';

  @override
  String get camera_test_screen_next => 'Pulsa Siguiente para continuar.';

  @override
  String get camera_test_screen_start =>
      'Pulsa Iniciar. Si se solicita, permite el acceso a la cámara.';

  @override
  String get camera_test_screen_test_failed => '¡La prueba falló!';

  @override
  String get camera_test_screen_test_passed => '¡Prueba superada!';

  @override
  String get camera_test_screen_title => 'Prueba de cámara con IA';

  @override
  String get camera_test_screen_wait =>
      'Esperando a que la IA detecte personas…';

  @override
  String get cta_screen_custom => 'Usar tu propio servidor';

  @override
  String get cta_screen_custom_help =>
      'Envía los datos de tráfico directamente a tu backend o base de datos.';

  @override
  String get cta_screen_footer =>
      'Al continuar, aceptas los Términos de servicio, la Política de privacidad y el Acuerdo de procesamiento de datos.';

  @override
  String get cta_screen_invitation => 'Usar un código de invitación';

  @override
  String get cta_screen_invitation_help =>
      'Únete a una organización existente mediante una invitación de tu administrador.';

  @override
  String get cta_screen_local => 'Solo en este dispositivo';

  @override
  String get cta_screen_local_help =>
      'Guarda los datos de tráfico solo en este dispositivo. No se sube nada.';

  @override
  String get cta_screen_piyuo => 'Usar Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Guarda los datos de tráfico en Piyuo Cloud con paneles e información empresarial.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter crea estadísticas anónimas de tráfico cada 5 minutos.\\nElige cómo quieres almacenar y acceder a tus datos.';

  @override
  String get current_occupancy => 'Número actual';

  @override
  String get current_occupancy_help =>
      'Muestra el número actual de personas o vehículos en esta área.\\n\\nEste número se actualiza en tiempo real y ayuda a comprobar que la detección por IA coincide con lo que ves en pantalla. No se incluye en los datos de telemetría enviados.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Guardando...';

  @override
  String get custom_server_screen_server_url_label => 'URL del servidor';

  @override
  String get detection_screen_confidence => 'Umbral de confianza';

  @override
  String get detection_screen_confidence_dialog =>
      'Controla qué tan segura debe estar la IA antes de contar a una persona o vehículo.\\nValores más bajos\\n• Detectan más objetos\\n• Mejor para objetos distantes o parcialmente ocultos\\n• Pueden aumentar las detecciones falsas\\nValores más altos\\n• Cuentan solo detecciones de alta confianza\\n• Reducen las detecciones falsas\\n• Pueden pasar por alto objetos pequeños o difíciles\\nUsa un valor más bajo si la app no detecta personas o vehículos.\\nUsa un valor más alto si la app cuenta sombras, reflejos u otros objetos falsos.';

  @override
  String get detection_screen_confidence_help =>
      'Confianza mínima necesaria para detectar un objeto.';

  @override
  String get detection_screen_confidence_max_label => 'Estricto';

  @override
  String get detection_screen_confidence_min_label => 'Flexible';

  @override
  String get detection_screen_disappear => 'Tiempo de espera para desaparición';

  @override
  String get detection_screen_disappear_dialog =>
      'Determina cuánto tiempo espera la IA antes de marcar un objeto como desaparecido después de dejar de detectarse.\\nValores más cortos\\n• Marcan objetos como desaparecidos antes\\n• Mejor para tráfico rápido\\n• Pueden marcar objetos temporalmente ocultos como desaparecidos\\nValores más largos\\n• Esperan más antes de marcar objetos como desaparecidos\\n• Mejor cuando los objetos quedan bloqueados u ocultos brevemente\\n• Retrasan los eventos de desaparición';

  @override
  String get detection_screen_disappear_help =>
      'Cuánto espera la IA antes de marcar un objeto como desaparecido cuando deja de detectarlo.';

  @override
  String get detection_screen_disappear_max_label => 'Lento';

  @override
  String get detection_screen_disappear_min_label => 'Rápido';

  @override
  String get detection_screen_memory_dialog =>
      'Controla cuánto tiempo la IA recuerda un objeto después de que desaparece.\\nAumenta este valor si las personas o vehículos quedan ocultos con frecuencia detrás de otros objetos.\\nDisminuye este valor si los objetos se vinculan incorrectamente después de salir de la escena.';

  @override
  String get detection_screen_min_presence => 'Tiempo mínimo de presencia';

  @override
  String get detection_screen_min_presence_help =>
      'Un objeto debe permanecer visible antes de contarse. Los valores más altos ayudan a reducir detecciones falsas breves.';

  @override
  String get detection_screen_min_presence_max_label => 'Más seguro';

  @override
  String get detection_screen_min_presence_min_label => 'Más rápido';

  @override
  String get detection_screen_minimum_visible =>
      'Los objetos deben permanecer visibles durante este tiempo antes de ser contados.\\nAumenta este valor para ignorar detecciones falsas breves.\\nDisminuye este valor si se pasan por alto personas o vehículos que se mueven rápido.';

  @override
  String get detection_screen_new_track => 'Umbral para nuevo seguimiento';

  @override
  String get detection_screen_new_track_help =>
      'Confianza mínima para empezar a seguir un objeto nuevo. Los valores bajos pueden crear seguimientos duplicados.';

  @override
  String get detection_screen_new_track_max_label => 'Conservador';

  @override
  String get detection_screen_new_track_min_label => 'Agresivo';

  @override
  String get detection_screen_reset => 'Reiniciar';

  @override
  String get detection_screen_reset_content =>
      '¿Estás seguro de que quieres reiniciar los ajustes de detección?';

  @override
  String get detection_screen_show_track_id => 'Mostrar ID de seguimiento';

  @override
  String get detection_screen_show_track_id_help =>
      'Habilita esta opción para mostrar IDs de seguimiento únicos para cada objeto rastreado.';

  @override
  String get detection_screen_stay => 'Tiempo de permanencia';

  @override
  String get detection_screen_stay_help =>
      'Cuánto tiempo debe permanecer un objeto en el área antes de contarse como permanencia.';

  @override
  String get detection_screen_stay_max_label => 'Con retraso';

  @override
  String get detection_screen_stay_min_label => 'Instantáneo';

  @override
  String get detection_screen_stay_threshold =>
      'Determina cuándo un objeto contribuye al conteo de Permanencia.\\nValores más cortos\\n• Cuentan la permanencia de inmediato\\n• Mejor para análisis rápido\\nValores más largos\\n• Ignoran el tráfico breve de paso\\n• Mejor para medir la ocupación';

  @override
  String get detection_screen_subtitle =>
      'Ajusta cómo la IA detecta y sigue los objetos.';

  @override
  String get detection_screen_title => 'Seguimiento y conteo';

  @override
  String get detection_screen_track_dialog =>
      'Controla cuándo un objeto recién detectado se convierte en una nueva pista.\\nValores más bajos\\n• Comienzan a rastrear antes\\n• Mejor para objetos que se mueven rápido\\n• Pueden crear pistas duplicadas\\nValores más altos\\n• Requieren evidencia más sólida antes de crear una nueva pista\\n• Reducen las pistas duplicadas\\n• Pueden retrasar el rastreo de objetos nuevos';

  @override
  String get detection_screen_track_memory => 'Memoria de seguimiento';

  @override
  String get detection_screen_track_memory_help =>
      'Cuánto tiempo seguir rastreando un objeto después de perderlo temporalmente. Los valores más altos ayudan a recuperarlo tras una breve obstrucción.';

  @override
  String get detection_screen_track_memory_max_label => 'Largo';

  @override
  String get detection_screen_track_memory_min_label => 'Corto';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter usa la cámara para detectar peatones y vehículos en tiempo real. Este dispositivo no tiene una cámara disponible.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Intenta abrir esta aplicación en tu teléfono';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Un teléfono o tableta con cámara';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Se recomienda un dispositivo iOS o Android';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Lo que necesitas';

  @override
  String get device_not_supported_screen_title => 'Cámara no encontrada';

  @override
  String get disappeared => 'Desaparecieron';

  @override
  String get disappeared_help =>
      'Cuenta las personas o vehículos cuya última posición detectada estaba dentro de esta área.\\n\\nEl seguimiento finaliza después del Tiempo de Desaparición configurado si la persona o el vehículo deja de detectarse.\\n\\n(Principalmente para usuarios avanzados)';

  @override
  String get dpa => 'Acuerdo de procesamiento de datos';

  @override
  String get durationDaysShort => '%sd';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Entraron';

  @override
  String get entered_help =>
      'Cuenta las personas o vehículos que entraron en esta área durante la ventana de conteo actual.\\n\\nSe cuenta una entrada cuando una persona o vehículo pasa del exterior al interior del área.';

  @override
  String get exited => 'Salieron';

  @override
  String get exited_help =>
      'Cuenta las personas o vehículos que salieron de esta área durante la ventana de conteo actual.\\n\\nSe cuenta una salida cuando una persona o vehículo pasa del interior al exterior del área.';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get language_screen_subtitle =>
      'Elige el idioma que se usará en la aplicación.';

  @override
  String get local_only_screen_body =>
      'El modo Solo dispositivo local te permite probar la detección y el seguimiento con cámara e IA sin subir ningún dato. Todas las estadísticas de tráfico peatonal se procesan solo en este dispositivo, ideal para probar antes de conectarte a un servidor.';

  @override
  String get local_only_screen_use_action => 'Usar solo este dispositivo';

  @override
  String get local_screen_text =>
      'Piyuo Counter funcionará completamente en este dispositivo.\\nLas estadísticas de tráfico se guardarán solo en este dispositivo y no se subirán.\\nMás adelante podrás conectarte a Piyuo Cloud o a tu propio servidor desde Configuración.';

  @override
  String get maximum_occupancy => 'Ocupación máxima';

  @override
  String get maximum_occupancy_help =>
      'Muestra el mayor número de personas o vehículos que estuvieron al mismo tiempo en esta área durante la ventana de conteo actual.\\n\\nÚtil para identificar los momentos de mayor afluencia o tráfico.';

  @override
  String get maximum_stay => 'Tiempo máximo de permanencia';

  @override
  String get maximum_stay_help =>
      'Muestra el mayor tiempo que una persona o un vehículo permaneció en esta área durante la ventana de conteo actual.\\n\\nÚtil para identificar visitas o paradas inusualmente largas.';

  @override
  String get metric_events => 'Eventos';

  @override
  String get metric_live => 'En vivo';

  @override
  String get metric_show_less => 'Mostrar menos';

  @override
  String get metric_show_more => 'Mostrar más';

  @override
  String get metric_statistics => 'Estadísticas';

  @override
  String get metrics_counting_all => 'Todos';

  @override
  String get metrics_counting_done => 'Completado';

  @override
  String get metrics_counting_in_progress => 'En progreso';

  @override
  String get metrics_counting_missing => 'Faltante';

  @override
  String get metrics_counting_window =>
      'Estadísticas de cada período de 5 minutos';

  @override
  String get onboarding_back_action => 'Volver';

  @override
  String get onboarding_cta_no_server => '¿Prefieres no subir datos?';

  @override
  String get onboarding_cta_title => '¿A dónde deben ir tus datos?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter usa la cámara de tu dispositivo y una IA integrada para detectar personas y vehículos en tiempo real.\\nCon tecnología de detección y seguimiento, cuenta automáticamente el flujo de personas y vehículos — todo se procesa en tu propio dispositivo.';

  @override
  String get onboarding_intro_text2 =>
      'Todo el procesamiento de IA ocurre localmente en tu dispositivo. No se sube ningún video, imagen, rostro ni identidad.\\nSolo se comparten resúmenes anónimos cada 5 minutos, con estadísticas de conteo, ocupación, entradas, salidas y tiempo de permanencia.';

  @override
  String get onboarding_intro_text3 =>
      'Solo inicia la app y déjala funcionando. Piyuo Counter recopila y guarda automáticamente los datos de tráfico de forma continua.\\nLos resúmenes de datos se guardan cada 5 minutos y se suben cada hora a Piyuo Cloud o a tu propio servidor.';

  @override
  String get onboarding_intro_title1 => 'Conteo de tráfico con IA';

  @override
  String get onboarding_intro_title2 => 'Privacidad desde el diseño';

  @override
  String get onboarding_intro_title3 => 'Funciona automáticamente 24/7';

  @override
  String get onboarding_next_action => 'Siguiente';

  @override
  String get onboarding_skip_action => 'Omitir introducción';

  @override
  String get onboarding_start_action => 'Comenzar';

  @override
  String get passed_by => 'Pasaron';

  @override
  String get passed_by_help =>
      'Cuenta las personas o vehículos que pasaron por esta área durante la ventana de conteo actual.\\n\\nCada persona o vehículo se cuenta solo una vez por cada paso a través del área.';

  @override
  String get payloads_screen_area => 'Área';

  @override
  String get payloads_screen_confidence => 'Confianza';

  @override
  String get payloads_screen_coverage => 'Cobertura';

  @override
  String get payloads_screen_delivered => 'Entregado';

  @override
  String get payloads_screen_failed_load =>
      'No se pudieron cargar las cargas recientes';

  @override
  String get payloads_screen_frame_processed => 'Fotogramas procesados';

  @override
  String get payloads_screen_hour_not_exists => 'Esta hora ya no existe.';

  @override
  String get payloads_screen_missing_time => 'Tiempo perdido';

  @override
  String get payloads_screen_no_payloads => 'Todavía no hay cargas.';

  @override
  String get payloads_screen_partial => 'La ventana terminó antes (parcial)';

  @override
  String get payloads_screen_partially => 'Entregado parcialmente';

  @override
  String get payloads_screen_payload_not_exists => 'Esta carga ya no existe.';

  @override
  String get payloads_screen_pending => 'Pendiente de entrega';

  @override
  String get payloads_screen_process_fps => 'FPS de procesamiento';

  @override
  String get payloads_screen_resend => 'Reenviar';

  @override
  String get payloads_screen_select_first =>
      'Seleccione primero al menos una fecha u hora.';

  @override
  String get payloads_screen_subtitle =>
      'Seleccione por fecha u hora para reenviar';

  @override
  String get payloads_screen_title => 'Cargas recientes';

  @override
  String get personal_custom_screen_build_server =>
      '¿Necesitas ayuda para configurar tu propio servidor?\\nConsulta nuestra documentación de la API y ejemplos de servidor.';

  @override
  String get personal_custom_screen_help_action =>
      'Abrir documentación de la API';

  @override
  String get personal_custom_screen_reset_action => 'Empezar de nuevo';

  @override
  String get personal_custom_success_screen_help =>
      'Pulsa Start abajo para comenzar el conteo.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Las estadísticas de tráfico se cargan automáticamente cada hora.\\nTambién puedes cargarlas manualmente desde la pantalla de registros de carga.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Tu servidor aún no necesita estar en línea.\\nEmpieza a contar ahora. Puedes terminar de crear y probar tu servidor más tarde. Las estadísticas de tráfico permanecerán en este dispositivo hasta que se carguen correctamente.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Las estadísticas de tráfico se enviarán a';

  @override
  String get personal_custom_success_screen_title => 'Tu servidor está listo';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Tu URL de Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Copiar URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL copiada';

  @override
  String get piyuo_server_screen_saving_action => 'Guardando...';

  @override
  String get piyuo_server_screen_start =>
      'Pulsa \"Start\" abajo para comenzar el conteo.';

  @override
  String get piyuo_server_screen_url_help =>
      'Tu panel personal de Piyuo Cloud está listo en esta URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Guarda esta URL para acceder a tu panel de tráfico desde otro dispositivo.';

  @override
  String get piyuo_server_screen_use_action => 'Usar Piyuo Cloud';

  @override
  String get privacy => 'Política de privacidad';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'Conteo de personas y vehículos con IA.';

  @override
  String get settings_screen_custom_subtitle =>
      'Envíe los datos de tráfico directamente a su backend o base de datos.';

  @override
  String get settings_screen_custom_title => 'Usar servidor personalizado';

  @override
  String get settings_screen_data_server_label => 'Servidor de datos';

  @override
  String get settings_screen_detection_target => 'Objetivo de detección';

  @override
  String get settings_screen_language_title => 'Idioma';

  @override
  String get settings_screen_local_subtitle =>
      'Guarde los datos de tráfico solo en este dispositivo. No se subirá nada.';

  @override
  String get settings_screen_local_title => 'Solo dispositivo local';

  @override
  String get settings_screen_misc_label => 'Varios';

  @override
  String get settings_screen_object_detection => 'Detección de objetos';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Guarda los datos de tráfico en Piyuo Cloud con paneles e información para tu negocio.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Esto borrará todos los datos y comenzará de nuevo. Esta acción no se puede deshacer.';

  @override
  String get settings_screen_reset_all_data_title =>
      '¿Restablecer todos los datos?';

  @override
  String get settings_screen_subscription_body =>
      'Administre su suscripción y los datos de facturación';

  @override
  String get settings_screen_subscription_title => 'Suscripción';

  @override
  String get start_screen_about => 'Acerca de';

  @override
  String get start_screen_server_none =>
      'Los datos se guardan solo en este dispositivo';

  @override
  String get start_screen_server_personal => 'Los datos se cargan cada hora a';

  @override
  String get start_screen_settings => 'Configuración';

  @override
  String get start_screen_upload_logs => 'Subir registros';

  @override
  String get start_screen_video_sources => 'Fuentes de video';

  @override
  String get stayed => 'Permanecieron';

  @override
  String get stayed_help =>
      'Cuenta las personas o vehículos que permanecieron en esta área durante al menos el Tiempo de Permanencia configurado.\\n\\nEl Tiempo de Permanencia predeterminado es de 15 segundos y puede cambiarse en Configuración.';

  @override
  String get target_pedestrian => 'Peatón';

  @override
  String get target_pedestrian_help =>
      'Cuenta personas con el modelo de detección de peatones';

  @override
  String get target_screen_subtitle =>
      'Elige el modelo de detección que deseas usar';

  @override
  String get target_vehicle => 'Vehículo';

  @override
  String get target_vehicle_help =>
      'Cuenta coches y otros vehículos con el modelo de vehículos';

  @override
  String get telemetry_error_connection_refused =>
      'No se pudo conectar con el servidor. Puede estar desconectado en este momento.';

  @override
  String get telemetry_error_connection_reset =>
      'La conexión se restableció. Verifica tu conexión a internet e inténtalo de nuevo.';

  @override
  String get telemetry_error_connection_timeout =>
      'La conexión tardó demasiado en responder. Verifica tu conexión a internet e inténtalo de nuevo.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'No se pudo encontrar la dirección del servidor. Verifica tu conexión a internet o la URL del servidor.';

  @override
  String get telemetry_error_http_error_status =>
      'El servidor rechazó la solicitud. Inténtalo de nuevo más tarde.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Ocurrió un error inesperado al comunicarse con el servidor.';

  @override
  String get telemetry_error_invalid_url =>
      'La dirección del servidor no es válida. Verifica tu configuración.';

  @override
  String get telemetry_error_network_error =>
      'Ocurrió un error de red. Verifica tu conexión a internet e inténtalo de nuevo.';

  @override
  String get telemetry_error_socket_error =>
      'Ocurrió un problema de conexión de red. Verifica tu conexión a internet.';

  @override
  String get telemetry_error_transport_exception =>
      'Algo salió mal al enviar los datos. Inténtalo de nuevo.';

  @override
  String get terms => 'Términos del servicio';

  @override
  String get upload_screen_attempt_time => 'Hora del intento:';

  @override
  String get upload_screen_error => 'Error:';

  @override
  String get upload_screen_failed => 'Falló';

  @override
  String get upload_screen_load_error =>
      'No se pudieron cargar los registros de carga.';

  @override
  String get upload_screen_log_not_exists =>
      'El registro de carga ya no está disponible.';

  @override
  String get upload_screen_next => 'Próxima carga a las ...';

  @override
  String get upload_screen_next_upload_prefix => 'Próxima carga a las ';

  @override
  String get upload_screen_no_data_server =>
      'Configure primero el servidor de datos.';

  @override
  String get upload_screen_no_logs => 'Aún no hay registros de carga.';

  @override
  String get upload_screen_payload_count => 'Número de cargas';

  @override
  String get upload_screen_payload_count_label => 'Número de cargas:';

  @override
  String get upload_screen_payload_size => 'Tamaño de la carga:';

  @override
  String get upload_screen_result => 'Resultado:';

  @override
  String get upload_screen_retry => 'Número de reintentos:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Correcto';

  @override
  String get upload_screen_today => 'Hoy';

  @override
  String get upload_screen_upload_now => 'Subir ahora';

  @override
  String get upload_screen_upload_success => 'Carga completada.';

  @override
  String get upload_screen_uploading => 'Subiendo...';

  @override
  String get upload_screen_yesterday => 'Ayer';

  @override
  String get url_screen_invalid_rtsp_error =>
      'Las URL RTSP deben incluir un nombre de host.';

  @override
  String get url_screen_invalid_url_error =>
      'Introduzca una URL válida con un esquema compatible.';

  @override
  String get url_screen_subtitle =>
      'Por favor, introduce la URL de transmisión en directo';

  @override
  String get url_screen_title => 'URL de transmisión en directo';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS-';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Introduzca una URL de transmisión en directo.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://ejemplo.com/transmision o rtsp://ejemplo.com/transmision';

  @override
  String get video_sources_back_camera => 'Cámara trasera';

  @override
  String get video_sources_camera => 'Cámara';

  @override
  String get video_sources_file => 'Archivo';

  @override
  String get video_sources_front_camera => 'Cámara frontal';

  @override
  String get video_sources_live_stream => 'URL de transmisión en directo';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Necesitas conceder permisos de cámara para utilizarla';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Cámara no encontrada';

  @override
  String get video_sources_screen_import_error =>
      'No se pudo importar el archivo de video.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Ve a ajustes y permite el acceso a fotos para esta aplicación.';

  @override
  String get video_sources_screen_select_camera =>
      'Toca para seleccionar esta cámara';

  @override
  String get video_sources_screen_select_file => 'Toca para elegir un archivo';

  @override
  String get video_sources_screen_select_live =>
      'Toca para configurar la URL de la transmisión en vivo';

  @override
  String get video_sources_webcam => 'Webcam';
}
