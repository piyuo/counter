// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class LocalizationRu extends Localization {
  LocalizationRu([String locale = 'ru']) : super(locale);

  @override
  String get about_screen_app_version => 'Версия приложения';

  @override
  String get about_screen_email_us => 'Связаться с нами';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get appeared => 'Появились';

  @override
  String get appeared_help =>
      'Подсчитывает людей или транспортные средства, чья первая обнаруженная позиция находилась внутри этой области.\\n\\nПомогает понять, где начинается отслеживание.\\n\\n(В первую очередь для опытных пользователей)';

  @override
  String get average_occupancy => 'Средняя заполняемость';

  @override
  String get average_occupancy_help =>
      'Показывает среднее количество людей или транспортных средств в этой области за текущее окно подсчета.\\n\\nПомогает оценить, насколько загруженной была эта область на протяжении всего периода подсчета.';

  @override
  String get average_stay => 'Среднее время пребывания';

  @override
  String get average_stay_help =>
      'Показывает среднее время, которое люди или транспортные средства находились в этой области.\\n\\nБолее длительное среднее время пребывания может означать, что посетители проводят в этой области больше времени.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter использует камеру и ИИ на устройстве для подсчёта людей. Сначала убедимся, что ваше устройство совместимо.';

  @override
  String get camera_test_screen_instruction =>
      'Наведите камеру на людей. Приложение покажет рамки вокруг обнаруженных людей.';

  @override
  String get camera_test_screen_next => 'Нажмите «Далее», чтобы продолжить.';

  @override
  String get camera_test_screen_start =>
      'Нажмите «Начать». Если потребуется, разрешите доступ к камере.';

  @override
  String get camera_test_screen_test_failed => 'Тест не пройден!';

  @override
  String get camera_test_screen_test_passed => 'Тест пройден!';

  @override
  String get camera_test_screen_title => 'Тест AI-камеры';

  @override
  String get camera_test_screen_wait => 'Ожидание обнаружения людей ИИ…';

  @override
  String get cta_screen_custom => 'Использовать свой сервер';

  @override
  String get cta_screen_custom_help =>
      'Отправляйте данные о трафике напрямую в свой сервер или базу данных.';

  @override
  String get cta_screen_footer =>
      'Продолжая, вы соглашаетесь с Условиями использования, Политикой конфиденциальности и Соглашением об обработке данных.';

  @override
  String get cta_screen_invitation => 'Использовать код приглашения';

  @override
  String get cta_screen_invitation_help =>
      'Присоединитесь к существующей организации с помощью приглашения от администратора.';

  @override
  String get cta_screen_local => 'Только на этом устройстве';

  @override
  String get cta_screen_local_help =>
      'Храните данные о трафике только на этом устройстве. Ничего не загружается.';

  @override
  String get cta_screen_piyuo => 'Использовать Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Храните данные о трафике в Piyuo Cloud с панелями мониторинга и бизнес-аналитикой.';

  @override
  String get cta_screen_premium => 'Премиум';

  @override
  String get cta_screen_title =>
      'Piyuo Counter создает анонимную статистику трафика каждые 5 минут.\\nВыберите, как вы хотите хранить данные и получать к ним доступ.';

  @override
  String get current_occupancy => 'Текущее количество';

  @override
  String get current_occupancy_help =>
      'Показывает текущее количество людей или транспортных средств в этой области.\\n\\nЭто значение обновляется в реальном времени и помогает проверить, соответствует ли обнаружение AI тому, что вы видите на экране. Оно не включается в отправляемые данные телеметрии.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Сохранение...';

  @override
  String get custom_server_screen_server_url_label => 'URL сервера';

  @override
  String get detection_screen_confidence => 'Порог уверенности';

  @override
  String get detection_screen_confidence_dialog =>
      'Определяет, насколько уверен должен быть ИИ перед подсчётом человека или транспортного средства.\\nБолее низкие значения\\n• Обнаруживают больше объектов\\n• Лучше для дальних или частично скрытых объектов\\n• Могут увеличить количество ложных обнаружений\\nБолее высокие значения\\n• Считают только объекты с высокой достоверностью\\n• Уменьшают ложные обнаружения\\n• Могут пропустить мелкие или сложные объекты\\nИспользуйте более низкое значение, если приложение пропускает людей или транспорт.\\nИспользуйте более высокое значение, если приложение считает тени, отражения или другие ложные объекты.';

  @override
  String get detection_screen_confidence_help =>
      'Минимальная уверенность, необходимая для обнаружения объекта.';

  @override
  String get detection_screen_confidence_max_label => 'Строгий';

  @override
  String get detection_screen_confidence_min_label => 'Низкий';

  @override
  String get detection_screen_disappear => 'Тайм-аут исчезновения';

  @override
  String get detection_screen_disappear_dialog =>
      'Определяет, как долго ИИ ждёт, прежде чем пометить объект как исчезнувший после того, как он перестаёт обнаруживаться.\\nБолее короткие значения\\n• Быстрее помечают объекты как исчезнувшие\\n• Лучше для быстрого движения\\n• Могут ошибочно пометить временно скрытые объекты как исчезнувшие\\nБолее длинные значения\\n• Дольше ждут перед пометкой объектов как исчезнувших\\n• Лучше, когда объекты ненадолго блокируются или пропускаются\\n• Задерживают события исчезновения';

  @override
  String get detection_screen_disappear_help =>
      'Как долго ИИ ждёт, прежде чем пометить объект как исчезнувший после того, как перестанет его обнаруживать.';

  @override
  String get detection_screen_disappear_max_label => 'Медленно';

  @override
  String get detection_screen_disappear_min_label => 'Быстро';

  @override
  String get detection_screen_memory_dialog =>
      'Определяет, как долго ИИ помнит объект после его исчезновения.\\nУвеличьте это значение, если люди или транспорт часто скрываются за другими объектами.\\nУменьшите это значение, если объекты неправильно связываются после ухода из кадра.';

  @override
  String get detection_screen_min_presence => 'Минимальное время присутствия';

  @override
  String get detection_screen_min_presence_help =>
      'Объект должен оставаться видимым, прежде чем будет засчитан. Более высокие значения помогают уменьшить кратковременные ложные обнаружения.';

  @override
  String get detection_screen_min_presence_max_label => 'Безопаснее';

  @override
  String get detection_screen_min_presence_min_label => 'Быстрее';

  @override
  String get detection_screen_minimum_visible =>
      'Объекты должны оставаться видимыми в течение этого времени, прежде чем они будут подсчитаны.\\nУвеличьте это значение, чтобы игнорировать кратковременные ложные обнаружения.\\nУменьшите это значение, если быстро движущиеся люди или транспорт пропускаются.';

  @override
  String get detection_screen_new_track => 'Порог нового отслеживания';

  @override
  String get detection_screen_new_track_help =>
      'Минимальная уверенность для начала отслеживания нового объекта. Низкие значения могут создавать дублирующиеся треки.';

  @override
  String get detection_screen_new_track_max_label => 'Консервативно';

  @override
  String get detection_screen_new_track_min_label => 'Агрессивно';

  @override
  String get detection_screen_reset => 'Сбросить';

  @override
  String get detection_screen_reset_content =>
      'Вы уверены, что хотите сбросить настройки обнаружения?';

  @override
  String get detection_screen_show_track_id => 'Показать ID отслеживания';

  @override
  String get detection_screen_show_track_id_help =>
      'Включите этот параметр, чтобы отобразить уникальные ID отслеживания для каждого отслеживаемого объекта.';

  @override
  String get detection_screen_stay => 'Время пребывания';

  @override
  String get detection_screen_stay_help =>
      'Сколько времени объект должен оставаться в зоне, прежде чем будет засчитан как пребывание.';

  @override
  String get detection_screen_stay_max_label => 'С задержкой';

  @override
  String get detection_screen_stay_min_label => 'Мгновенно';

  @override
  String get detection_screen_stay_threshold =>
      'Определяет, когда объект учитывается в подсчёте пребывания.\\nБолее короткие значения\\n• Учитывают пребывание сразу\\n• Лучше для быстрого анализа\\nБолее длинные значения\\n• Игнорируют кратковременный проходящий трафик\\n• Лучше для измерения заполненности';

  @override
  String get detection_screen_subtitle =>
      'Настройте, как ИИ обнаруживает и отслеживает объекты.';

  @override
  String get detection_screen_title => 'Отслеживание и подсчет';

  @override
  String get detection_screen_track_dialog =>
      'Определяет, когда новый обнаруженный объект становится новым треком.\\nБолее низкие значения\\n• Отслеживание начинается раньше\\n• Лучше для быстро движущихся объектов\\n• Могут создавать дублирующиеся треки\\nБолее высокие значения\\n• Требуют более веских доказательств перед созданием нового трека\\n• Уменьшают количество дублирующихся треков\\n• Могут задерживать отслеживание новых объектов';

  @override
  String get detection_screen_track_memory => 'Память отслеживания';

  @override
  String get detection_screen_track_memory_help =>
      'Как долго продолжать отслеживание объекта после его временной потери. Более высокие значения помогают восстановить отслеживание после кратковременного перекрытия.';

  @override
  String get detection_screen_track_memory_max_label => 'Длинная';

  @override
  String get detection_screen_track_memory_min_label => 'Короткая';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter использует камеру для обнаружения пешеходов и транспортных средств в реальном времени. На этом устройстве нет доступной камеры.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Попробуйте открыть это приложение на телефоне';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Смартфон или планшет с камерой';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Рекомендуется устройство iOS или Android';

  @override
  String get device_not_supported_screen_requirements_title => 'Что нужно';

  @override
  String get device_not_supported_screen_title => 'Камера не найдена';

  @override
  String get disappeared => 'Исчезли';

  @override
  String get disappeared_help =>
      'Подсчитывает людей или транспортные средства, чья последняя обнаруженная позиция находилась внутри этой области.\\n\\nОтслеживание завершается после заданного времени исчезновения, если человек или транспортное средство больше не обнаруживаются.\\n\\n(В первую очередь для опытных пользователей)';

  @override
  String get dpa => 'Соглашение об обработке данных';

  @override
  String get durationDaysShort => '%sд';

  @override
  String get durationHoursShort => '%sч';

  @override
  String get durationMinutesShort => '%sмин';

  @override
  String get durationSecondsShort => '%sсек';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Вошли';

  @override
  String get entered_help =>
      'Подсчитывает людей или транспортные средства, вошедших в эту область в течение текущего окна подсчета.\\n\\nВход учитывается, когда человек или транспортное средство перемещается извне внутрь области.';

  @override
  String get exited => 'Вышли';

  @override
  String get exited_help =>
      'Подсчитывает людей или транспортные средства, покинувших эту область в течение текущего окна подсчета.\\n\\nВыход учитывается, когда человек или транспортное средство перемещается изнутри области наружу.';

  @override
  String get language_screen_language => 'Язык';

  @override
  String get language_screen_subtitle =>
      'Выберите язык, который будет использоваться в приложении.';

  @override
  String get local_only_screen_body =>
      'Режим «Только локальное устройство» позволяет опробовать обнаружение и отслеживание с помощью ИИ-камеры без загрузки данных. Вся статистика посещаемости обрабатывается только на этом устройстве, отлично подходит для тестирования перед подключением к серверу.';

  @override
  String get local_only_screen_use_action =>
      'Использовать только локальное устройство';

  @override
  String get local_screen_text =>
      'Piyuo Counter будет работать полностью на этом устройстве.\\nСтатистика трафика будет храниться только на этом устройстве и не будет загружаться.\\nПозже вы сможете подключиться к Piyuo Cloud или своему серверу через Настройки.';

  @override
  String get maximum_occupancy => 'Максимальная заполняемость';

  @override
  String get maximum_occupancy_help =>
      'Показывает максимальное количество людей или транспортных средств, одновременно находившихся в этой области в течение текущего окна подсчета.\\n\\nПолезно для определения пиковых периодов посещаемости или трафика.';

  @override
  String get maximum_stay => 'Максимальное время пребывания';

  @override
  String get maximum_stay_help =>
      'Показывает максимальное время, которое человек или транспортное средство находились в этой области в течение текущего окна подсчета.\\n\\nПолезно для выявления необычно длительных посещений или остановок.';

  @override
  String get metric_events => 'События';

  @override
  String get metric_live => 'В реальном времени';

  @override
  String get metric_show_less => 'Показать меньше';

  @override
  String get metric_show_more => 'Показать больше';

  @override
  String get metric_statistics => 'Статистика';

  @override
  String get metrics_counting_all => 'Все';

  @override
  String get metrics_counting_done => 'Завершено';

  @override
  String get metrics_counting_in_progress => 'В процессе';

  @override
  String get metrics_counting_missing => 'Отсутствует';

  @override
  String get metrics_counting_window =>
      'Статистика для каждого 5-минутного периода';

  @override
  String get onboarding_back_action => 'Назад';

  @override
  String get onboarding_cta_no_server => 'Не хотите отправлять данные?';

  @override
  String get onboarding_cta_title => 'Куда отправлять ваши данные?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter использует камеру устройства и встроенный ИИ, чтобы узнавать людей и машины прямо на месте.\\nБлагодаря технологии обнаружения и отслеживания приложение автоматически считает пешеходный и автомобильный поток — всё обрабатывается прямо на вашем устройстве.';

  @override
  String get onboarding_intro_text2 =>
      'Вся обработка ИИ происходит локально на вашем устройстве. Видео, изображения, лица и личные данные никуда не отправляются.\\nПередаются только анонимные сводки каждые 5 минут — статистика по количеству, заполненности, входам, выходам и времени пребывания.';

  @override
  String get onboarding_intro_text3 =>
      'Просто запустите приложение и оставьте его работать. Piyuo Counter непрерывно и автоматически собирает и сохраняет данные о трафике.\\nСводки данных сохраняются каждые 5 минут и загружаются каждый час в Piyuo Cloud или на ваш собственный сервер.';

  @override
  String get onboarding_intro_title1 => 'Подсчёт трафика с ИИ';

  @override
  String get onboarding_intro_title2 => 'Конфиденциальность прежде всего';

  @override
  String get onboarding_intro_title3 => 'Работает автоматически 24/7';

  @override
  String get onboarding_next_action => 'Далее';

  @override
  String get onboarding_skip_action => 'Пропустить введение';

  @override
  String get onboarding_start_action => 'Начать';

  @override
  String get passed_by => 'Прошли';

  @override
  String get passed_by_help =>
      'Подсчитывает людей или транспортные средства, прошедших через эту область в течение текущего окна подсчета.\\n\\nКаждый человек или транспортное средство учитывается только один раз за каждый проход через область.';

  @override
  String get payloads_screen_area => 'Область';

  @override
  String get payloads_screen_confidence => 'Уверенность';

  @override
  String get payloads_screen_coverage => 'Покрытие';

  @override
  String get payloads_screen_delivered => 'Доставлено';

  @override
  String get payloads_screen_failed_load =>
      'Не удалось загрузить последние данные';

  @override
  String get payloads_screen_frame_processed => 'Обработанные кадры';

  @override
  String get payloads_screen_hour_not_exists =>
      'Этот час больше не существует.';

  @override
  String get payloads_screen_missing_time => 'Пропущенное время';

  @override
  String get payloads_screen_no_payloads => 'Пока нет данных.';

  @override
  String get payloads_screen_partial => 'Окно завершилось раньше (частично)';

  @override
  String get payloads_screen_partially => 'Доставлено частично';

  @override
  String get payloads_screen_payload_not_exists =>
      'Эти данные больше не существуют.';

  @override
  String get payloads_screen_pending => 'Ожидает доставки';

  @override
  String get payloads_screen_process_fps => 'FPS обработки';

  @override
  String get payloads_screen_resend => 'Повторно отправить';

  @override
  String get payloads_screen_select_first =>
      'Сначала выберите хотя бы одну дату или час.';

  @override
  String get payloads_screen_subtitle =>
      'Выберите дату или час для повторной отправки';

  @override
  String get payloads_screen_title => 'Последние данные';

  @override
  String get personal_custom_screen_build_server =>
      'Нужна помощь с настройкой собственного сервера?\\nПосмотрите нашу документацию API и примеры серверов.';

  @override
  String get personal_custom_screen_help_action => 'Открыть документацию API';

  @override
  String get personal_custom_screen_reset_action => 'Начать заново';

  @override
  String get personal_custom_success_screen_help =>
      'Нажмите Start ниже, чтобы начать подсчёт.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Статистика трафика автоматически загружается каждый час.\\nВы также можете загрузить её вручную с экрана журналов загрузки.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Ваш сервер пока не должен быть в сети.\\nНачните подсчёт прямо сейчас. Позже вы сможете завершить настройку и тестирование своего сервера. Статистика трафика останется на этом устройстве до успешной загрузки.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Статистика трафика будет отправлена на';

  @override
  String get personal_custom_success_screen_title => 'Ваш сервер готов';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Ваш URL Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Копировать URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL скопирован';

  @override
  String get piyuo_server_screen_saving_action => 'Сохранение...';

  @override
  String get piyuo_server_screen_start =>
      'Нажмите \"Start\" ниже, чтобы начать подсчет.';

  @override
  String get piyuo_server_screen_url_help =>
      'Ваша персональная панель Piyuo Cloud доступна по этому URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Сохраните этот URL, чтобы открывать панель статистики с другого устройства.';

  @override
  String get piyuo_server_screen_use_action => 'Использовать Piyuo Cloud';

  @override
  String get privacy => 'Политика конфиденциальности';

  @override
  String get product_copyright => 'Авторские права © 2026';

  @override
  String get product_desc =>
      'Подсчет людей и транспортных средств с помощью ИИ.';

  @override
  String get settings_screen_custom_subtitle =>
      'Отправляйте данные о трафике напрямую на свой сервер или в базу данных.';

  @override
  String get settings_screen_custom_title => 'Использовать свой сервер';

  @override
  String get settings_screen_data_server_label => 'Сервер данных';

  @override
  String get settings_screen_detection_target => 'Цель обнаружения';

  @override
  String get settings_screen_language_title => 'Язык';

  @override
  String get settings_screen_local_subtitle =>
      'Храните данные о трафике только на этом устройстве. Ничего не загружается.';

  @override
  String get settings_screen_local_title => 'Только локальное устройство';

  @override
  String get settings_screen_misc_label => 'Разное';

  @override
  String get settings_screen_object_detection => 'Обнаружение объектов';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Храните данные о трафике в Piyuo Cloud с панелями мониторинга и бизнес-аналитикой.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Это удалит все данные и позволит начать заново. Это действие нельзя отменить.';

  @override
  String get settings_screen_reset_all_data_title => 'Сбросить все данные?';

  @override
  String get settings_screen_subscription_body =>
      'Управление подпиской и платежными данными';

  @override
  String get settings_screen_subscription_title => 'Подписка';

  @override
  String get start_screen_about => 'О программе';

  @override
  String get start_screen_server_none =>
      'Данные хранятся только на этом устройстве';

  @override
  String get start_screen_server_personal => 'Данные загружаются каждый час на';

  @override
  String get start_screen_settings => 'Настройки';

  @override
  String get start_screen_upload_logs => 'Загрузить журналы';

  @override
  String get start_screen_video_sources => 'Источники видео';

  @override
  String get stayed => 'Остались';

  @override
  String get stayed_help =>
      'Подсчитывает людей или транспортные средства, которые находились в этой области не менее заданного времени пребывания.\\n\\nПо умолчанию время пребывания составляет 15 секунд и может быть изменено в настройках.';

  @override
  String get target_pedestrian => 'Пешеход';

  @override
  String get target_pedestrian_help =>
      'Подсчитывайте людей с помощью модели обнаружения пешеходов';

  @override
  String get target_screen_subtitle => 'Выберите модель обнаружения';

  @override
  String get target_vehicle => 'Транспорт';

  @override
  String get target_vehicle_help =>
      'Подсчитывайте автомобили и другой транспорт с помощью модели обнаружения транспорта';

  @override
  String get telemetry_error_connection_refused =>
      'Не удалось подключиться к серверу. Возможно, он сейчас недоступен.';

  @override
  String get telemetry_error_connection_reset =>
      'Соединение было сброшено. Проверьте подключение к интернету и повторите попытку.';

  @override
  String get telemetry_error_connection_timeout =>
      'Время ожидания ответа истекло. Проверьте подключение к интернету и повторите попытку.';

  @override
  String get telemetry_error_database_error =>
      'Не удалось выполнить запись в базу данных.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Не удалось найти адрес сервера. Проверьте подключение к интернету или URL сервера.';

  @override
  String get telemetry_error_http_error_status =>
      'Сервер отклонил запрос. Повторите попытку позже.';

  @override
  String get telemetry_error_http_unknown_error =>
      'При обмене данными с сервером произошла непредвиденная ошибка.';

  @override
  String get telemetry_error_invalid_url =>
      'Неверный адрес сервера. Проверьте настройки.';

  @override
  String get telemetry_error_network_error =>
      'Произошла сетевая ошибка. Проверьте подключение к интернету и повторите попытку.';

  @override
  String get telemetry_error_socket_error =>
      'Произошла проблема с сетевым подключением. Проверьте подключение к интернету.';

  @override
  String get telemetry_error_transport_exception =>
      'При отправке данных что-то пошло не так. Повторите попытку.';

  @override
  String get telemetry_error_unknown_error =>
      'Произошла непредвиденная ошибка.';

  @override
  String get terms => 'Условия использования';

  @override
  String get upload_screen_attempt_time => 'Время попытки:';

  @override
  String get upload_screen_error => 'Ошибка:';

  @override
  String get upload_screen_failed => 'Не удалось';

  @override
  String get upload_screen_load_error =>
      'Не удалось загрузить журнал загрузки.';

  @override
  String get upload_screen_log_not_exists =>
      'Журнал загрузки больше недоступен.';

  @override
  String get upload_screen_next => 'Следующая загрузка в ...';

  @override
  String get upload_screen_next_upload_prefix => 'Следующая загрузка в ';

  @override
  String get upload_screen_no_data_server => 'Сначала настройте сервер данных.';

  @override
  String get upload_screen_no_logs => 'Пока нет журналов загрузки.';

  @override
  String get upload_screen_payload_count => 'Количество данных';

  @override
  String get upload_screen_payload_count_label => 'Количество данных:';

  @override
  String get upload_screen_payload_size => 'Размер данных:';

  @override
  String get upload_screen_result => 'Результат:';

  @override
  String get upload_screen_retry => 'Количество повторных попыток:';

  @override
  String get upload_screen_size_kb => 'КБ';

  @override
  String get upload_screen_success => 'Успешно';

  @override
  String get upload_screen_today => 'Сегодня';

  @override
  String get upload_screen_upload_now => 'Загрузить сейчас';

  @override
  String get upload_screen_upload_success => 'Загрузка выполнена.';

  @override
  String get upload_screen_uploading => 'Загрузка...';

  @override
  String get upload_screen_yesterday => 'Вчера';

  @override
  String get url_screen_invalid_rtsp_error =>
      'URL RTSP должен содержать имя хоста.';

  @override
  String get url_screen_invalid_url_error =>
      'Введите корректный URL с поддерживаемой схемой.';

  @override
  String get url_screen_subtitle => 'Пожалуйста, введите URL прямой трансляции';

  @override
  String get url_screen_title => 'URL прямой трансляции';

  @override
  String get url_screen_unsupported_scheme_error =>
      'נתמכות רק כתובות URL מסוג HTTP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Введите URL прямой трансляции.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream или rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Задняя камера';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_front_camera => 'Передняя камера';

  @override
  String get video_sources_live_stream => 'URL прямой трансляции';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Необходимо предоставить разрешение на использование камеры';

  @override
  String get video_sources_screen_camera_not_found_title => 'Камера не найдена';

  @override
  String get video_sources_screen_import_error =>
      'Не удалось импортировать видеофайл.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Перейдите в настройки и разрешите доступ к фото для этого приложения.';

  @override
  String get video_sources_screen_select_camera =>
      'Нажмите, чтобы выбрать эту камеру';

  @override
  String get video_sources_screen_select_file => 'Нажмите, чтобы выбрать файл';

  @override
  String get video_sources_screen_select_live =>
      'Нажмите, чтобы задать URL прямой трансляции';

  @override
  String get video_sources_webcam => 'Веб-камера';
}
