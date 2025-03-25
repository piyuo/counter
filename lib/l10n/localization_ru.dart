// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class LocalizationRu extends Localization {
  LocalizationRu([String locale = 'ru']) : super(locale);

  @override
  String get product_name => 'Счетчик';

  @override
  String get product_desc => 'Использование компьютерного зрения и ИИ для подсчета людей, транспортных средств, животных и многого другого.';

  @override
  String get product_copyright => 'Авторские права © 2025';

  @override
  String get video_sources_webcam => 'Веб-камера';

  @override
  String get video_sources_live_stream => 'URL прямой трансляции';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_camera_not_found_title => 'Камера не найдена';

  @override
  String get video_sources_camera_not_found_message => 'Необходимо предоставить разрешение на использование камеры';

  @override
  String get video_sources_webcam_not_found_title => 'Веб-камера не найдена';

  @override
  String get video_sources_webcam_not_found_message => 'Пожалуйста, проверьте, подключена ли веб-камера';

  @override
  String get wizard_screen_desc => 'Создайте новый проект ниже, чтобы начать подсчет.';

  @override
  String get wizard_screen_new_project_from => 'Новый проект из';

  @override
  String get wizard_screen_language => 'Язык';

  @override
  String get wizard_screen_about => 'О программе';

  @override
  String get wizard_screen_open_projects_tip => 'Все проекты будут автоматически сохраняться локально';

  @override
  String get wizard_screen_open_projects => 'Открыть существующий проект';

  @override
  String get wizard_screen_email_us => 'Связаться с нами';

  @override
  String get language_screen_language => 'Язык';

  @override
  String get project_view_no_videos => 'Нет доступных источников видео.';

  @override
  String get about_screen_title => 'О программе';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get about_screen_app_version => 'Версия приложения';

  @override
  String get about_screen_models => 'Модели обнаружения объектов';

  @override
  String get about_screen_benchmark => 'Тестирование производительности';

  @override
  String get about_screen_opencv_build_info => 'Информация о сборке OpenCV';

  @override
  String get benchmark_screen_title => 'Тесты производительности моделей';

  @override
  String get benchmark_screen_recommended => 'Рекомендуемая модель';

  @override
  String get benchmark_screen_fps => 'Кадров в секунду';

  @override
  String get benchmark_screen_start_button => 'Начать тест производительности';

  @override
  String get benchmark_screen_start_failed => 'Не удалось запустить тест, код ошибки';

  @override
  String get benchmark_screen_models => 'Модели обнаружения объектов';

  @override
  String get project_screen_title => 'Проект';

  @override
  String get project_screen_exit_confirm_title => 'Подтвердите выход из проекта';

  @override
  String get project_screen_exit_confirm_content => 'Выход из проекта остановит подсчет. Вы уверены, что хотите продолжить?';

  @override
  String get project_screen_exit_button => 'Выйти';

  @override
  String get project_screen_add_video_button => 'Добавить источник видео';

  @override
  String get project_screen_from_desc => 'Мы храним скользящую 24-часовую запись, чтобы вы могли просмотреть любой временной интервал.';

  @override
  String get project_screen_report_settings => 'Настройки';

  @override
  String get filter_screen_title => 'Фильтр';

  @override
  String get filter_screen_desc => 'Выберите диапазон фильтрации из списка ниже';

  @override
  String get filter_screen_error_title => 'Фильтр';

  @override
  String get filter_screen_error_content => 'Время окончания должно быть больше времени начала';

  @override
  String get filter_screen_error_custom => 'Пользовательский';

  @override
  String get filter_screen_error_start => 'Начало';

  @override
  String get filter_screen_error_end => 'Конец';

  @override
  String get settings_screen_title => 'Настройки';

  @override
  String get settings_screen_desc => 'Установите имя проекта, параметры обнаружения, сброс счетчиков.';

  @override
  String get settings_screen_project_id => 'ID проекта';

  @override
  String get settings_screen_project_name => 'Название проекта';

  @override
  String get settings_screen_project_name_place_holder => 'ул. Ленина 123 или Парк Горького';

  @override
  String get settings_screen_project_error => 'Название проекта не может быть пустым';

  @override
  String get settings_screen_random_count_button => 'Добавить случайные подсчеты';

  @override
  String get settings_screen_reset_count_header => 'Сбросить все счетчики в этом проекте';

  @override
  String get settings_screen_reset_count_button => 'Сбросить счетчики';

  @override
  String get settings_screen_reset_count_content => 'Вы уверены, что хотите сбросить все счетчики?';

  @override
  String get settings_screen_delete_header => 'Удалить этот проект';

  @override
  String get settings_screen_delete_content => 'Вы уверены, что хотите удалить этот проект?';

  @override
  String get settings_screen_delete_button => 'Удалить';

  @override
  String get settings_screen_center_point_title => 'Центральная точка на цели';

  @override
  String get settings_screen_center_point_desc => 'Центральная точка помогает определить, находится ли цель в зоне попадания.';

  @override
  String get settings_screen_center_point_button => 'Показать центральную точку на цели';

  @override
  String get settings_screen_lost_target_title => 'Потерянная цель';

  @override
  String get settings_screen_lost_target_desc => 'Когда слежение за объектом теряет цель, эта опция делает ее видимой. По умолчанию потерянные цели не отображаются.';

  @override
  String get settings_screen_lost_target_button => 'Показать потерянную цель';

  @override
  String get detection_screen_title => 'Настройки обнаружения';

  @override
  String get detection_screen_models => 'Модели';

  @override
  String get detection_screen_confidence => 'Уверенность';

  @override
  String get detection_screen_confidence_desc => 'уверенность выше #0 считается действительным обнаружением';

  @override
  String get detection_screen_low => 'Низкая';

  @override
  String get detection_screen_high => 'Высокая';

  @override
  String get detection_screen_nms => 'Подавление не-максимумов';

  @override
  String get detection_screen_nms_desc => '#0 Более низкий порог NMS (например, 30%) будет агрессивнее удалять перекрывающиеся ограничивающие рамки, в то время как более высокий порог NMS (например, 0.6) позволит большее перекрытие';

  @override
  String get detection_screen_match => 'Совпадение';

  @override
  String get detection_screen_match_desc => 'Совпадение выше #0 считается одним и тем же объектом.';

  @override
  String get detection_screen_lost => 'Потеря';

  @override
  String get detection_screen_lost_desc => 'Отслеживаемый объект будет удален, если он потерян в течение #0';

  @override
  String get detection_screen_consider_valid => 'Считать действительным после';

  @override
  String get detection_screen_consider_valid_desc => 'Отслеживаемый объект будет считаться действительным после #0';

  @override
  String get detection_screen_reset => 'Сбросить';

  @override
  String get detection_screen_reset_content => 'Вы уверены, что хотите сбросить настройки обнаружения?';

  @override
  String get url_screen_title => 'URL прямой трансляции';

  @override
  String get url_screen_desc => 'Пожалуйста, введите URL прямой трансляции';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream или rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Добавить источник видео';

  @override
  String get add_video_screen_from => 'Добавить источник видео из';

  @override
  String get webcam_screen_add_title => 'Добавить веб-камеру';

  @override
  String get webcam_screen_edit_title => 'Выбрать веб-камеру';

  @override
  String get webcam_manager_webcam => 'Веб-камера';

  @override
  String get camera_screen_front_camera => 'Фронтальная камера';

  @override
  String get camera_screen_back_camera => 'Задняя камера';

  @override
  String get camera_screen_add_title => 'Добавить камеру';

  @override
  String get camera_screen_edit_title => 'Выбрать камеру';

  @override
  String get camera_screen_zoom_level => 'Уровень увеличения';

  @override
  String get video_screen_name_empty => 'Название источника видео не может быть пустым.';

  @override
  String get video_screen_desc => 'Управляйте источниками видео, добавляйте или изменяйте зоны обнаружения.';

  @override
  String get video_screen_video_name => 'Название источника видео';

  @override
  String get video_screen_edit_placeholder => 'Камера у входной двери или Камера на парковке';

  @override
  String get video_screen_change_file => 'Изменить файл';

  @override
  String get video_screen_add_zone => 'Добавить зону обнаружения';

  @override
  String get video_screen_zones => 'Зоны обнаружения';

  @override
  String get video_screen_zones_desc => 'Используйте перетаскивание для настройки зон';

  @override
  String get video_screen_tools => 'Инструменты';

  @override
  String get video_screen_move_bottom => 'Переместить текущую зону вниз';

  @override
  String get video_screen_add_point => 'Добавить точку в текущую зону';

  @override
  String get video_screen_remove_point => 'Удалить точку из текущей зоны';

  @override
  String get video_screen_playback_speed => 'Скорость воспроизведения';

  @override
  String get video_screen_playback_current => 'текущая: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Удалить этот источник видео';

  @override
  String get video_screen_delete_content => 'Вы уверены, что хотите удалить этот источник видео?';

  @override
  String get video_screen_delete_button => 'Удалить';

  @override
  String get video_screen_sources => 'Настройте источник изображения, цели обнаружения и параметры модели.';

  @override
  String get video_screen_targets => 'Цели обнаружения';

  @override
  String get video_screen_detection => 'Параметры модели';

  @override
  String get color_screen_title => 'Выберите цвет';

  @override
  String get zone_screen_desc => 'В зоне обнаружения можно установить типы объектов для обнаружения и выбрать счетчики для отображения, такие как Обнаружено, Появилось и Вошло.';

  @override
  String get zone_screen_name_placeholder => 'Название зоны, например Тротуар или Парковка';

  @override
  String get zone_screen_zone_color => 'Цвет зоны';

  @override
  String get zone_screen_color => 'Цвет';

  @override
  String get zone_screen_delete_header => 'Удалить эту зону';

  @override
  String get zone_screen_delete_content => 'Вы уверены, что хотите удалить эту зону?';

  @override
  String get zone_screen_delete_button => 'Удалить';

  @override
  String get zone_screen_can_not_delete => 'Невозможно удалить зону';

  @override
  String get zone_screen_one_zone_required => 'Требуется как минимум одна зона.';

  @override
  String get zone_screen_zone_name_required => 'Название зоны не может быть пустым';

  @override
  String get counter_screen_show_on => 'Показать на экране';

  @override
  String get counter_screen_enabled => 'Включено';

  @override
  String get counter_screen_reentry_threshold => 'Порог повторного входа';

  @override
  String get counter_screen_reentry_desc => 'Объекты должны входить #0 раз, с #1-секундным временем восстановления между каждым выходом и повторным входом, чтобы запустить счетчик повторного входа';

  @override
  String get counter_screen_reentry_title => 'Счетчик повторного входа';

  @override
  String get counter_screen_cooldown_threshold => 'Порог времени восстановления';

  @override
  String get counter_screen_cooldown_desc => 'Повторный вход требует #0-секундного времени восстановления после выхода из зоны обнаружения';

  @override
  String get counter_screen_cooldown_time => 'Время восстановления';

  @override
  String get counter_screen_cooldown_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_threshold => 'Порог застоя';

  @override
  String get counter_screen_stagnant_desc => 'Объекты, остающиеся неподвижными более #0 секунд, будут считаться застойными';

  @override
  String get counter_screen_stagnant_consider => 'Считать застойным';

  @override
  String get counter_screen_stagnant_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Префикс описания';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Суффикс описания';

  @override
  String get counter_screen_name_error => 'Название счетчика не может быть пустым';

  @override
  String get counter_screen_enabled_error => 'Ошибка';

  @override
  String get counter_screen_enabled_error_content => 'Вам нужно сначала включить другой счетчик, затем вы сможете отключить этот счетчик';

  @override
  String get objects_screen_title => 'Объекты';

  @override
  String get objects_screen_desc => 'Выберите цели для обнаружения: люди, автомобили, автобусы и т.д.';

  @override
  String get open_project_screen_title => 'Открыть проект';

  @override
  String get open_project_screen_desc => 'Открывайте ранее созданные проекты, сохраняя только 20 последних.';

  @override
  String get open_project_screen_no_project => 'Проекты не найдены.';

  @override
  String get default_project_name => 'Проект';

  @override
  String get default_video_name => 'Источник видео';

  @override
  String get default_zone_name => 'Зона обнаружения';

  @override
  String get error_oops => 'Упс, что-то пошло не так';

  @override
  String get error_content => 'Произошла непредвиденная ошибка. Хотите отправить отчет по электронной почте?';

  @override
  String get error_report => 'Написать нам';

  @override
  String get submit => 'Отправить';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Отмена';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get close => 'Закрыть';

  @override
  String get back => 'Назад';

  @override
  String get zone_screen_zone => 'Зона';

  @override
  String get zone_screen_zone_show_summary => 'Показать сводку на экране';
}

/// The translations for Russian, as used in Kazakhstan (`ru_KZ`).
class LocalizationRuKz extends LocalizationRu {
  LocalizationRuKz(): super('ru_KZ');

  @override
  String get product_name => 'Счетчик';

  @override
  String get product_desc => 'Подсчет людей, транспортных средств, домашних животных и многого другого с помощью компьютерного зрения и искусственного интеллекта.';

  @override
  String get product_copyright => 'Авторское право © 2025';

  @override
  String get video_sources_webcam => 'Веб-камера';

  @override
  String get video_sources_live_stream => 'URL прямой трансляции';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_camera_not_found_title => 'Камера не найдена';

  @override
  String get video_sources_camera_not_found_message => 'Необходимо предоставить разрешение на использование камеры';

  @override
  String get video_sources_webcam_not_found_title => 'Веб-камера не найдена';

  @override
  String get video_sources_webcam_not_found_message => 'Пожалуйста, проверьте, подключена ли веб-камера';

  @override
  String get wizard_screen_desc => 'Создайте новый проект, чтобы начать подсчет.';

  @override
  String get wizard_screen_new_project_from => 'Новый проект из';

  @override
  String get wizard_screen_language => 'Язык';

  @override
  String get wizard_screen_about => 'О программе';

  @override
  String get wizard_screen_open_projects_tip => 'Все проекты автоматически сохраняются локально';

  @override
  String get wizard_screen_open_projects => 'Открыть существующий проект';

  @override
  String get wizard_screen_email_us => 'Написать нам';

  @override
  String get language_screen_language => 'Язык';

  @override
  String get project_view_no_videos => 'Нет доступных источников видео.';

  @override
  String get about_screen_title => 'О программе';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get about_screen_app_version => 'Версия приложения';

  @override
  String get about_screen_models => 'Модели обнаружения объектов';

  @override
  String get about_screen_benchmark => 'Тестирование производительности';

  @override
  String get about_screen_opencv_build_info => 'Информация о сборке OpenCV';

  @override
  String get benchmark_screen_title => 'Тесты производительности моделей';

  @override
  String get benchmark_screen_recommended => 'Рекомендуемая модель';

  @override
  String get benchmark_screen_fps => 'Кадров в секунду';

  @override
  String get benchmark_screen_start_button => 'Начать тестирование';

  @override
  String get benchmark_screen_start_failed => 'Не удалось начать тестирование, код ошибки';

  @override
  String get benchmark_screen_models => 'Модели обнаружения объектов';

  @override
  String get project_screen_title => 'Проект';

  @override
  String get project_screen_exit_confirm_title => 'Подтвердите выход из проекта';

  @override
  String get project_screen_exit_confirm_content => 'При выходе из проекта подсчет будет остановлен. Вы действительно хотите продолжить?';

  @override
  String get project_screen_exit_button => 'Выход';

  @override
  String get project_screen_add_video_button => 'Добавить источник видео';

  @override
  String get project_screen_from_desc => 'Мы храним данные за последние 24 часа, поэтому вы можете просмотреть любой временной отрезок.';

  @override
  String get project_screen_report_settings => 'Настройки';

  @override
  String get filter_screen_title => 'Фильтр';

  @override
  String get filter_screen_desc => 'Выберите диапазон фильтра из списка ниже';

  @override
  String get filter_screen_error_title => 'Фильтр';

  @override
  String get filter_screen_error_content => 'Время окончания должно быть больше времени начала';

  @override
  String get filter_screen_error_custom => 'Пользовательский';

  @override
  String get filter_screen_error_start => 'Начало';

  @override
  String get filter_screen_error_end => 'Конец';

  @override
  String get settings_screen_title => 'Настройки';

  @override
  String get settings_screen_desc => 'Установите имя проекта, параметры обнаружения, сброс счетчиков.';

  @override
  String get settings_screen_project_id => 'ID проекта';

  @override
  String get settings_screen_project_name => 'Название проекта';

  @override
  String get settings_screen_project_name_place_holder => 'пр. Достык 123 или Парк Горького';

  @override
  String get settings_screen_project_error => 'Название проекта не может быть пустым';

  @override
  String get settings_screen_random_count_button => 'Добавить случайные подсчеты';

  @override
  String get settings_screen_reset_count_header => 'Сбросить все счетчики в этом проекте';

  @override
  String get settings_screen_reset_count_button => 'Сбросить счетчики';

  @override
  String get settings_screen_reset_count_content => 'Вы уверены, что хотите сбросить все счетчики?';

  @override
  String get settings_screen_delete_header => 'Удалить этот проект';

  @override
  String get settings_screen_delete_content => 'Вы уверены, что хотите удалить этот проект?';

  @override
  String get settings_screen_delete_button => 'Удалить';

  @override
  String get settings_screen_center_point_title => 'Центральная точка на цели';

  @override
  String get settings_screen_center_point_desc => 'Центральная точка помогает определить, находится ли цель в зоне обнаружения.';

  @override
  String get settings_screen_center_point_button => 'Показать центральную точку на цели';

  @override
  String get settings_screen_lost_target_title => 'Потерянная цель';

  @override
  String get settings_screen_lost_target_desc => 'Когда система теряет цель, эта опция делает её видимой. По умолчанию потерянные цели не отображаются.';

  @override
  String get settings_screen_lost_target_button => 'Показать потерянную цель';

  @override
  String get detection_screen_title => 'Настройки обнаружения';

  @override
  String get detection_screen_models => 'Модели';

  @override
  String get detection_screen_confidence => 'Достоверность';

  @override
  String get detection_screen_confidence_desc => 'достоверность выше #0 считается действительным обнаружением';

  @override
  String get detection_screen_low => 'Низкая';

  @override
  String get detection_screen_high => 'Высокая';

  @override
  String get detection_screen_nms => 'Подавление немаксимумов';

  @override
  String get detection_screen_nms_desc => '#0 Более низкий порог NMS (например, 30%) агрессивнее удаляет перекрывающиеся ограничивающие рамки, а более высокий порог NMS (например, 0.6) допускает больше перекрытия';

  @override
  String get detection_screen_match => 'Совпадение';

  @override
  String get detection_screen_match_desc => 'Совпадение выше #0 считается одним и тем же объектом.';

  @override
  String get detection_screen_lost => 'Потеря';

  @override
  String get detection_screen_lost_desc => 'Отслеживаемый объект будет удален, если он потерян в течение #0';

  @override
  String get detection_screen_consider_valid => 'Считать действительным после';

  @override
  String get detection_screen_consider_valid_desc => 'Отслеживаемый объект будет считаться действительным после #0';

  @override
  String get detection_screen_reset => 'Сбросить';

  @override
  String get detection_screen_reset_content => 'Вы уверены, что хотите сбросить настройки обнаружения?';

  @override
  String get url_screen_title => 'URL прямой трансляции';

  @override
  String get url_screen_desc => 'Пожалуйста, введите URL прямой трансляции';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream или rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Добавить источник видео';

  @override
  String get add_video_screen_from => 'Добавить источник видео из';

  @override
  String get webcam_screen_add_title => 'Добавить веб-камеру';

  @override
  String get webcam_screen_edit_title => 'Выбрать веб-камеру';

  @override
  String get webcam_manager_webcam => 'Веб-камера';

  @override
  String get camera_screen_front_camera => 'Фронтальная камера';

  @override
  String get camera_screen_back_camera => 'Задняя камера';

  @override
  String get camera_screen_add_title => 'Добавить камеру';

  @override
  String get camera_screen_edit_title => 'Выбрать камеру';

  @override
  String get camera_screen_zoom_level => 'Уровень масштабирования';

  @override
  String get video_screen_name_empty => 'Название источника видео не может быть пустым.';

  @override
  String get video_screen_desc => 'Управляйте источниками видео, добавляйте или изменяйте зоны обнаружения.';

  @override
  String get video_screen_video_name => 'Название источника видео';

  @override
  String get video_screen_edit_placeholder => 'Камера у входа или Камера на парковке';

  @override
  String get video_screen_change_file => 'Изменить файл';

  @override
  String get video_screen_add_zone => 'Добавить зону обнаружения';

  @override
  String get video_screen_zones => 'Зоны обнаружения';

  @override
  String get video_screen_zones_desc => 'Используйте перетаскивание для настройки зон';

  @override
  String get video_screen_tools => 'Инструменты';

  @override
  String get video_screen_move_bottom => 'Переместить текущую зону вниз';

  @override
  String get video_screen_add_point => 'Добавить точку в текущую зону';

  @override
  String get video_screen_remove_point => 'Удалить точку из текущей зоны';

  @override
  String get video_screen_playback_speed => 'Скорость воспроизведения';

  @override
  String get video_screen_playback_current => 'текущая: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Удалить этот источник видео';

  @override
  String get video_screen_delete_content => 'Вы уверены, что хотите удалить этот источник видео?';

  @override
  String get video_screen_delete_button => 'Удалить';

  @override
  String get video_screen_sources => 'Настройте источник изображения, цели обнаружения и параметры модели.';

  @override
  String get video_screen_targets => 'Цели обнаружения';

  @override
  String get video_screen_detection => 'Параметры модели';

  @override
  String get color_screen_title => 'Выбрать цвет';

  @override
  String get zone_screen_desc => 'Зона обнаружения позволяет установить типы объектов для обнаружения и выбрать счетчики для отображения, такие как Обнаружено, Появилось и Вошло.';

  @override
  String get zone_screen_name_placeholder => 'Название зоны, например Тротуар или Парковка';

  @override
  String get zone_screen_zone_color => 'Цвет зоны';

  @override
  String get zone_screen_color => 'Цвет';

  @override
  String get zone_screen_delete_header => 'Удалить эту зону';

  @override
  String get zone_screen_delete_content => 'Вы уверены, что хотите удалить эту зону?';

  @override
  String get zone_screen_delete_button => 'Удалить';

  @override
  String get zone_screen_can_not_delete => 'Невозможно удалить зону';

  @override
  String get zone_screen_one_zone_required => 'Требуется минимум одна зона.';

  @override
  String get zone_screen_zone_name_required => 'Название зоны не может быть пустым';

  @override
  String get counter_screen_show_on => 'Показать на экране';

  @override
  String get counter_screen_enabled => 'Включено';

  @override
  String get counter_screen_reentry_threshold => 'Порог повторного входа';

  @override
  String get counter_screen_reentry_desc => 'Объекты должны войти #0 раз с задержкой #1 секунд между каждым выходом и повторным входом, чтобы активировать счетчик повторного входа';

  @override
  String get counter_screen_reentry_title => 'Счетчик повторного входа';

  @override
  String get counter_screen_cooldown_threshold => 'Порог задержки';

  @override
  String get counter_screen_cooldown_desc => 'Повторный вход требует задержки #0 секунд после выхода из зоны обнаружения';

  @override
  String get counter_screen_cooldown_time => 'Время задержки';

  @override
  String get counter_screen_cooldown_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_threshold => 'Порог застоя';

  @override
  String get counter_screen_stagnant_desc => 'Объекты, остающиеся неподвижными более #0 секунд, будут считаться застоявшимися';

  @override
  String get counter_screen_stagnant_consider => 'Считать застоявшимся';

  @override
  String get counter_screen_stagnant_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Префикс описания';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Суффикс описания';

  @override
  String get counter_screen_name_error => 'Название счетчика не может быть пустым';

  @override
  String get counter_screen_enabled_error => 'Ошибка';

  @override
  String get counter_screen_enabled_error_content => 'Сначала необходимо включить другой счетчик, затем вы сможете отключить этот счетчик';

  @override
  String get objects_screen_title => 'Объекты';

  @override
  String get objects_screen_desc => 'Выберите цели обнаружения, такие как человек, автомобиль, автобус и т.д.';

  @override
  String get open_project_screen_title => 'Открыть проект';

  @override
  String get open_project_screen_desc => 'Открыть ранее созданные проекты, сохраняя только 20 последних.';

  @override
  String get open_project_screen_no_project => 'Проекты не найдены.';

  @override
  String get default_project_name => 'Проект';

  @override
  String get default_video_name => 'Источник видео';

  @override
  String get default_zone_name => 'Зона обнаружения';

  @override
  String get error_oops => 'Упс, что-то пошло не так';

  @override
  String get error_content => 'Произошла непредвиденная ошибка. Хотите отправить отчет по электронной почте?';

  @override
  String get error_report => 'Написать нам';

  @override
  String get submit => 'Отправить';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Отмена';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get close => 'Закрыть';

  @override
  String get back => 'Назад';

  @override
  String get zone_screen_zone => 'Зона';

  @override
  String get zone_screen_zone_show_summary => 'Показать сводку на экране';
}

/// The translations for Russian, as used in Ukraine (`ru_UA`).
class LocalizationRuUa extends LocalizationRu {
  LocalizationRuUa(): super('ru_UA');

  @override
  String get product_name => 'Лічильник';

  @override
  String get product_desc => 'Использование компьютерного зрения и ИИ для подсчета людей, транспортных средств, домашних животных и многого другого.';

  @override
  String get product_copyright => 'Авторское право © 2025';

  @override
  String get video_sources_webcam => 'Веб-камера';

  @override
  String get video_sources_live_stream => 'URL прямой трансляции';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_camera_not_found_title => 'Камера не найдена';

  @override
  String get video_sources_camera_not_found_message => 'Необходимо предоставить разрешение на использование камеры';

  @override
  String get video_sources_webcam_not_found_title => 'Веб-камера не найдена';

  @override
  String get video_sources_webcam_not_found_message => 'Пожалуйста, проверьте подключение веб-камеры';

  @override
  String get wizard_screen_desc => 'Создайте новый проект ниже, чтобы начать подсчет.';

  @override
  String get wizard_screen_new_project_from => 'Новый проект из';

  @override
  String get wizard_screen_language => 'Язык';

  @override
  String get wizard_screen_about => 'О программе';

  @override
  String get wizard_screen_open_projects_tip => 'Все проекты автоматически сохраняются локально';

  @override
  String get wizard_screen_open_projects => 'Открыть существующий проект';

  @override
  String get wizard_screen_email_us => 'Написать нам';

  @override
  String get language_screen_language => 'Язык';

  @override
  String get project_view_no_videos => 'Нет доступных источников видео.';

  @override
  String get about_screen_title => 'О программе';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get about_screen_app_version => 'Версия приложения';

  @override
  String get about_screen_models => 'Модели обнаружения объектов';

  @override
  String get about_screen_benchmark => 'Тестирование производительности';

  @override
  String get about_screen_opencv_build_info => 'Информация о сборке OpenCV';

  @override
  String get benchmark_screen_title => 'Тестирование моделей';

  @override
  String get benchmark_screen_recommended => 'Рекомендуемая модель';

  @override
  String get benchmark_screen_fps => 'Кадров в секунду';

  @override
  String get benchmark_screen_start_button => 'Начать тестирование';

  @override
  String get benchmark_screen_start_failed => 'Не удалось начать тестирование, код ошибки';

  @override
  String get benchmark_screen_models => 'Модели обнаружения объектов';

  @override
  String get project_screen_title => 'Проект';

  @override
  String get project_screen_exit_confirm_title => 'Подтвердите выход из проекта';

  @override
  String get project_screen_exit_confirm_content => 'Выход из проекта остановит подсчет. Вы уверены, что хотите продолжить?';

  @override
  String get project_screen_exit_button => 'Выход';

  @override
  String get project_screen_add_video_button => 'Добавить источник видео';

  @override
  String get project_screen_from_desc => 'Мы храним данные за последние 24 часа, поэтому вы можете просмотреть любой временной отрезок.';

  @override
  String get project_screen_report_settings => 'Настройки';

  @override
  String get filter_screen_title => 'Фильтр';

  @override
  String get filter_screen_desc => 'Выберите диапазон фильтрации из списка ниже';

  @override
  String get filter_screen_error_title => 'Фильтр';

  @override
  String get filter_screen_error_content => 'Время окончания должно быть больше времени начала';

  @override
  String get filter_screen_error_custom => 'Пользовательский';

  @override
  String get filter_screen_error_start => 'Начало';

  @override
  String get filter_screen_error_end => 'Конец';

  @override
  String get settings_screen_title => 'Настройки';

  @override
  String get settings_screen_desc => 'Установите имя проекта, параметры обнаружения, сброс счетчиков.';

  @override
  String get settings_screen_project_id => 'ID проекта';

  @override
  String get settings_screen_project_name => 'Название проекта';

  @override
  String get settings_screen_project_name_place_holder => 'ул. Крещатик, 1 или Парк Шевченко';

  @override
  String get settings_screen_project_error => 'Название проекта не может быть пустым';

  @override
  String get settings_screen_random_count_button => 'Добавить случайные значения';

  @override
  String get settings_screen_reset_count_header => 'Сбросить все счетчики в этом проекте';

  @override
  String get settings_screen_reset_count_button => 'Сбросить счетчики';

  @override
  String get settings_screen_reset_count_content => 'Вы уверены, что хотите сбросить все счетчики?';

  @override
  String get settings_screen_delete_header => 'Удалить этот проект';

  @override
  String get settings_screen_delete_content => 'Вы уверены, что хотите удалить этот проект?';

  @override
  String get settings_screen_delete_button => 'Удалить';

  @override
  String get settings_screen_center_point_title => 'Центральная точка на цели';

  @override
  String get settings_screen_center_point_desc => 'Центральная точка помогает определить, находится ли цель в зоне попадания.';

  @override
  String get settings_screen_center_point_button => 'Показать центральную точку на цели';

  @override
  String get settings_screen_lost_target_title => 'Потерянная цель';

  @override
  String get settings_screen_lost_target_desc => 'Когда отслеживание объекта теряет цель, эта опция делает её видимой. По умолчанию потерянные цели не отображаются.';

  @override
  String get settings_screen_lost_target_button => 'Показать потерянную цель';

  @override
  String get detection_screen_title => 'Настройки обнаружения';

  @override
  String get detection_screen_models => 'Модели';

  @override
  String get detection_screen_confidence => 'Уверенность';

  @override
  String get detection_screen_confidence_desc => 'уверенность выше #0 считается действительным обнаружением';

  @override
  String get detection_screen_low => 'Низкая';

  @override
  String get detection_screen_high => 'Высокая';

  @override
  String get detection_screen_nms => 'Подавление немаксимумов';

  @override
  String get detection_screen_nms_desc => '#0 Более низкий порог NMS (например, 30%) будет более агрессивно удалять перекрывающиеся ограничивающие рамки, в то время как более высокий порог NMS (например, 0.6) позволит большее перекрытие';

  @override
  String get detection_screen_match => 'Совпадение';

  @override
  String get detection_screen_match_desc => 'Совпадение выше #0 считается тем же объектом.';

  @override
  String get detection_screen_lost => 'Потеря';

  @override
  String get detection_screen_lost_desc => 'Отслеживаемый объект будет удален, если он потерян в течение #0';

  @override
  String get detection_screen_consider_valid => 'Считать действительным после';

  @override
  String get detection_screen_consider_valid_desc => 'Отслеживаемый объект будет считаться действительным после #0';

  @override
  String get detection_screen_reset => 'Сброс';

  @override
  String get detection_screen_reset_content => 'Вы уверены, что хотите сбросить настройки обнаружения?';

  @override
  String get url_screen_title => 'URL прямой трансляции';

  @override
  String get url_screen_desc => 'Пожалуйста, введите URL прямой трансляции';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream или rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Добавить источник видео';

  @override
  String get add_video_screen_from => 'Добавить источник видео из';

  @override
  String get webcam_screen_add_title => 'Добавить веб-камеру';

  @override
  String get webcam_screen_edit_title => 'Выбрать веб-камеру';

  @override
  String get webcam_manager_webcam => 'Веб-камера';

  @override
  String get camera_screen_front_camera => 'Фронтальная камера';

  @override
  String get camera_screen_back_camera => 'Основная камера';

  @override
  String get camera_screen_add_title => 'Добавить камеру';

  @override
  String get camera_screen_edit_title => 'Выбрать камеру';

  @override
  String get camera_screen_zoom_level => 'Уровень масштабирования';

  @override
  String get video_screen_name_empty => 'Название источника видео не может быть пустым.';

  @override
  String get video_screen_desc => 'Управление источниками видео, добавление или изменение зон обнаружения.';

  @override
  String get video_screen_video_name => 'Название источника видео';

  @override
  String get video_screen_edit_placeholder => 'Камера у входа или Камера на парковке';

  @override
  String get video_screen_change_file => 'Изменить файл';

  @override
  String get video_screen_add_zone => 'Добавить зону обнаружения';

  @override
  String get video_screen_zones => 'Зоны обнаружения';

  @override
  String get video_screen_zones_desc => 'Используйте перетаскивание для настройки зон';

  @override
  String get video_screen_tools => 'Инструменты';

  @override
  String get video_screen_move_bottom => 'Переместить текущую зону вниз';

  @override
  String get video_screen_add_point => 'Добавить точку в текущую зону';

  @override
  String get video_screen_remove_point => 'Удалить точку из текущей зоны';

  @override
  String get video_screen_playback_speed => 'Скорость воспроизведения';

  @override
  String get video_screen_playback_current => 'текущая: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Удалить этот источник видео';

  @override
  String get video_screen_delete_content => 'Вы уверены, что хотите удалить этот источник видео?';

  @override
  String get video_screen_delete_button => 'Удалить';

  @override
  String get video_screen_sources => 'Настройка источника изображения, целей обнаружения и параметров модели.';

  @override
  String get video_screen_targets => 'Цели обнаружения';

  @override
  String get video_screen_detection => 'Параметры модели';

  @override
  String get color_screen_title => 'Выбрать цвет';

  @override
  String get zone_screen_desc => 'В зоне обнаружения можно установить типы объектов для обнаружения и выбрать, какие счетчики отображать, например, Обнаружено, Появилось и Вошло.';

  @override
  String get zone_screen_name_placeholder => 'Название зоны, например Тротуар или Парковка';

  @override
  String get zone_screen_zone_color => 'Цвет зоны';

  @override
  String get zone_screen_color => 'Цвет';

  @override
  String get zone_screen_delete_header => 'Удалить эту зону';

  @override
  String get zone_screen_delete_content => 'Вы уверены, что хотите удалить эту зону?';

  @override
  String get zone_screen_delete_button => 'Удалить';

  @override
  String get zone_screen_can_not_delete => 'Невозможно удалить зону';

  @override
  String get zone_screen_one_zone_required => 'Требуется как минимум одна зона.';

  @override
  String get zone_screen_zone_name_required => 'Название зоны не может быть пустым';

  @override
  String get counter_screen_show_on => 'Показать на экране';

  @override
  String get counter_screen_enabled => 'Включено';

  @override
  String get counter_screen_reentry_threshold => 'Порог повторного входа';

  @override
  String get counter_screen_reentry_desc => 'Объекты должны войти #0 раз, с #1 секундным перерывом между каждым выходом и повторным входом, чтобы активировать повторный вход';

  @override
  String get counter_screen_reentry_title => 'Счетчик повторных входов';

  @override
  String get counter_screen_cooldown_threshold => 'Порог перерыва';

  @override
  String get counter_screen_cooldown_desc => 'Повторный вход требует #0 секундного перерыва после выхода из зоны обнаружения';

  @override
  String get counter_screen_cooldown_time => 'Время перерыва';

  @override
  String get counter_screen_cooldown_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_threshold => 'Порог застоя';

  @override
  String get counter_screen_stagnant_desc => 'Объекты, остающиеся неподвижными более #0 секунд, будут считаться застоявшимися';

  @override
  String get counter_screen_stagnant_consider => 'Считать застоявшимся';

  @override
  String get counter_screen_stagnant_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Префикс описания';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Суффикс описания';

  @override
  String get counter_screen_name_error => 'Название счетчика не может быть пустым';

  @override
  String get counter_screen_enabled_error => 'Ошибка';

  @override
  String get counter_screen_enabled_error_content => 'Сначала нужно включить другой счетчик, затем можно отключить этот счетчик';

  @override
  String get objects_screen_title => 'Объекты';

  @override
  String get objects_screen_desc => 'Выберите цели обнаружения, такие как человек, автомобиль, автобус и т.д.';

  @override
  String get open_project_screen_title => 'Открыть проект';

  @override
  String get open_project_screen_desc => 'Открыть ранее созданные проекты, сохраняя только 20 последних.';

  @override
  String get open_project_screen_no_project => 'Проекты не найдены.';

  @override
  String get default_project_name => 'Проект';

  @override
  String get default_video_name => 'Источник видео';

  @override
  String get default_zone_name => 'Зона обнаружения';

  @override
  String get error_oops => 'Упс, что-то пошло не так';

  @override
  String get error_content => 'Произошла непредвиденная ошибка. Хотите отправить отчет по электронной почте?';

  @override
  String get error_report => 'Написать нам';

  @override
  String get submit => 'Отправить';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Отмена';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get close => 'Закрыть';

  @override
  String get back => 'Назад';

  @override
  String get zone_screen_zone => 'Зона';

  @override
  String get zone_screen_zone_show_summary => 'Показати зведення на екрані';
}
