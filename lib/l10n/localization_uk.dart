// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class LocalizationUk extends Localization {
  LocalizationUk([String locale = 'uk']) : super(locale);

  @override
  String get product_name => 'Vision Counter';

  @override
  String get product_desc => 'Використання комп\'ютерного зору та штучного інтелекту для підрахунку людей, транспортних засобів, домашніх тварин та іншого.';

  @override
  String get product_copyright => 'Авторське право © 2025';

  @override
  String get video_sources_webcam => 'Веб-камера';

  @override
  String get video_sources_live_stream => 'URL трансляції';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_camera_not_found_title => 'Камеру не знайдено';

  @override
  String get video_sources_camera_not_found_message => 'Потрібно надати дозвіл на використання камери';

  @override
  String get video_sources_webcam_not_found_title => 'Веб-камеру не знайдено';

  @override
  String get video_sources_webcam_not_found_message => 'Перевірте, чи підключена веб-камера';

  @override
  String get wizard_screen_desc => 'Створіть новий проєкт нижче, щоб розпочати підрахунок.';

  @override
  String get wizard_screen_new_project_from => 'Новий проєкт з';

  @override
  String get wizard_screen_language => 'Мова';

  @override
  String get wizard_screen_about => 'Про програму';

  @override
  String get wizard_screen_open_projects_tip => 'Усі проєкти будуть автоматично збережені локально';

  @override
  String get wizard_screen_open_projects => 'Відкрити наявний проєкт';

  @override
  String get wizard_screen_email_us => 'Написати нам';

  @override
  String get language_screen_language => 'Мова';

  @override
  String get project_view_no_videos => 'Немає доступних відеоджерел.';

  @override
  String get about_screen_title => 'Про програму';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get about_screen_app_version => 'Версія програми';

  @override
  String get about_screen_models => 'Моделі виявлення об\'єктів';

  @override
  String get about_screen_benchmark => 'Тестування продуктивності';

  @override
  String get about_screen_opencv_build_info => 'Інформація про збірку OpenCV';

  @override
  String get benchmark_screen_title => 'Тестування моделей';

  @override
  String get benchmark_screen_recommended => 'Рекомендована модель';

  @override
  String get benchmark_screen_fps => 'Кадрів на секунду';

  @override
  String get benchmark_screen_start_button => 'Почати тестування';

  @override
  String get benchmark_screen_start_failed => 'Не вдалося запустити тестування, код помилки';

  @override
  String get benchmark_screen_models => 'Моделі виявлення об\'єктів';

  @override
  String get project_screen_title => 'Проєкт';

  @override
  String get project_screen_exit_confirm_title => 'Підтвердити вихід з проєкту';

  @override
  String get project_screen_exit_confirm_content => 'Вихід з проєкту зупинить підрахунок. Ви впевнені, що хочете продовжити?';

  @override
  String get project_screen_exit_button => 'Вийти';

  @override
  String get project_screen_add_video_button => 'Додати відеоджерело';

  @override
  String get project_screen_from_desc => 'Ми ведемо запис за останні 24 години, тому ви можете переглянути будь-який потрібний часовий проміжок.';

  @override
  String get project_screen_report_settings => 'Налаштування';

  @override
  String get filter_screen_title => 'Фільтр';

  @override
  String get filter_screen_desc => 'Виберіть діапазон фільтрації зі списку нижче';

  @override
  String get filter_screen_error_title => 'Фільтр';

  @override
  String get filter_screen_error_content => 'Час закінчення має бути пізніше часу початку';

  @override
  String get filter_screen_error_custom => 'Користувацький';

  @override
  String get filter_screen_error_start => 'Початок';

  @override
  String get filter_screen_error_end => 'Кінець';

  @override
  String get settings_screen_title => 'Налаштування';

  @override
  String get settings_screen_desc => 'Встановіть назву проєкту, параметри виявлення, скидання підрахунку.';

  @override
  String get settings_screen_project_id => 'ID проєкту';

  @override
  String get settings_screen_project_name => 'Назва проєкту';

  @override
  String get settings_screen_project_name_place_holder => 'вул. Хрещатик, 1 або Парк Шевченка';

  @override
  String get settings_screen_project_error => 'Назва проєкту не може бути порожньою';

  @override
  String get settings_screen_random_count_button => 'Додати випадкові підрахунки';

  @override
  String get settings_screen_reset_count_header => 'Скинути всі підрахунки в цьому проєкті';

  @override
  String get settings_screen_reset_count_button => 'Скинути підрахунки';

  @override
  String get settings_screen_reset_count_content => 'Ви впевнені, що хочете скинути всі підрахунки?';

  @override
  String get settings_screen_delete_header => 'Видалити цей проєкт';

  @override
  String get settings_screen_delete_content => 'Ви впевнені, що хочете видалити цей проєкт?';

  @override
  String get settings_screen_delete_button => 'Видалити';

  @override
  String get settings_screen_center_point_title => 'Центральна точка на цілі';

  @override
  String get settings_screen_center_point_desc => 'Центральна точка допомагає визначити, чи знаходиться ціль у зоні влучання.';

  @override
  String get settings_screen_center_point_button => 'Показати центральну точку на цілі';

  @override
  String get settings_screen_lost_target_title => 'Втрачена ціль';

  @override
  String get settings_screen_lost_target_desc => 'Коли відстеження об\'єкта втрачає ціль, ця опція робить її видимою. За замовчуванням втрачені цілі не відображаються.';

  @override
  String get settings_screen_lost_target_button => 'Показати втрачену ціль';

  @override
  String get detection_screen_title => 'Налаштування виявлення';

  @override
  String get detection_screen_models => 'Моделі';

  @override
  String get detection_screen_confidence => 'Достовірність';

  @override
  String get detection_screen_confidence_desc => 'достовірність вище #0 вважається коректним виявленням';

  @override
  String get detection_screen_low => 'Низька';

  @override
  String get detection_screen_high => 'Висока';

  @override
  String get detection_screen_nms => 'Придушення немаксимумів';

  @override
  String get detection_screen_nms_desc => '#0 Нижчий поріг NMS (наприклад, 30%) більш агресивно видаляє перекриваючі обмежувальні рамки, тоді як вищий поріг NMS (наприклад, 0.6) дозволяє більше перекриття';

  @override
  String get detection_screen_match => 'Збіг';

  @override
  String get detection_screen_match_desc => 'Збіг понад #0 вважається тим самим об\'єктом.';

  @override
  String get detection_screen_lost => 'Втрачено';

  @override
  String get detection_screen_lost_desc => 'Відстежуваний об\'єкт буде видалено, якщо він втрачений протягом #0';

  @override
  String get detection_screen_consider_valid => 'Вважати дійсним після';

  @override
  String get detection_screen_consider_valid_desc => 'Відстежуваний об\'єкт буде вважатися дійсним після #0';

  @override
  String get detection_screen_reset => 'Скинути';

  @override
  String get detection_screen_reset_content => 'Ви впевнені, що хочете скинути налаштування виявлення?';

  @override
  String get url_screen_title => 'URL трансляції';

  @override
  String get url_screen_desc => 'Будь ласка, введіть URL трансляції';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream або rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Додати відеоджерело';

  @override
  String get add_video_screen_from => 'Додати відеоджерело з';

  @override
  String get webcam_screen_add_title => 'Додати веб-камеру';

  @override
  String get webcam_screen_edit_title => 'Вибрати веб-камеру';

  @override
  String get webcam_manager_webcam => 'Веб-камера';

  @override
  String get camera_screen_front_camera => 'Фронтальна камера';

  @override
  String get camera_screen_back_camera => 'Задня камера';

  @override
  String get camera_screen_add_title => 'Додати камеру';

  @override
  String get camera_screen_edit_title => 'Вибрати камеру';

  @override
  String get camera_screen_zoom_level => 'Рівень масштабування';

  @override
  String get video_screen_name_empty => 'Назва відеоджерела не може бути порожньою.';

  @override
  String get video_screen_desc => 'Керування відеоджерелами, додавання або зміна зон виявлення.';

  @override
  String get video_screen_video_name => 'Назва відеоджерела';

  @override
  String get video_screen_edit_placeholder => 'Камера біля вхідних дверей або Камера на стоянці';

  @override
  String get video_screen_change_file => 'Змінити файл';

  @override
  String get video_screen_add_zone => 'Додати зону виявлення';

  @override
  String get video_screen_zones => 'Зони виявлення';

  @override
  String get video_screen_zones_desc => 'Використовуйте перетягування для налаштування зон';

  @override
  String get video_screen_tools => 'Інструменти';

  @override
  String get video_screen_move_bottom => 'Перемістити поточну зону вниз';

  @override
  String get video_screen_add_point => 'Додати точку до поточної зони';

  @override
  String get video_screen_remove_point => 'Видалити точку з поточної зони';

  @override
  String get video_screen_playback_speed => 'Швидкість відтворення';

  @override
  String get video_screen_playback_current => 'поточна: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Видалити це відеоджерело';

  @override
  String get video_screen_delete_content => 'Ви впевнені, що хочете видалити це відеоджерело?';

  @override
  String get video_screen_delete_button => 'Видалити';

  @override
  String get video_screen_sources => 'Налаштування джерела зображення, цілей виявлення та параметрів моделі.';

  @override
  String get video_screen_targets => 'Цілі виявлення';

  @override
  String get video_screen_detection => 'Параметри моделі';

  @override
  String get color_screen_title => 'Вибрати колір';

  @override
  String get zone_screen_desc => 'Зона виявлення може встановлювати типи об\'єктів для виявлення та вибирати, які лічильники відображати, такі як Виявлено, Створено та Увійшло.';

  @override
  String get zone_screen_name_placeholder => 'Назва зони, наприклад Тротуар або Стоянка';

  @override
  String get zone_screen_zone_color => 'Колір зони';

  @override
  String get zone_screen_color => 'Колір';

  @override
  String get zone_screen_delete_header => 'Видалити цю зону';

  @override
  String get zone_screen_delete_content => 'Ви впевнені, що хочете видалити цю зону?';

  @override
  String get zone_screen_delete_button => 'Видалити';

  @override
  String get zone_screen_can_not_delete => 'Неможливо видалити зону';

  @override
  String get zone_screen_one_zone_required => 'Потрібна принаймні одна зона.';

  @override
  String get zone_screen_zone_name_required => 'Назва зони не може бути порожньою';

  @override
  String get counter_screen_show_on => 'Показати на екрані';

  @override
  String get counter_screen_enabled => 'Увімкнено';

  @override
  String get counter_screen_reentry_threshold => 'Поріг повторного входу';

  @override
  String get counter_screen_reentry_desc => 'Об\'єкти повинні увійти #0 разів, з періодом охолодження #1 секунд між кожним виходом і повторним входом, щоб активувати повторний вхід';

  @override
  String get counter_screen_reentry_title => 'Лічильник повторних входів';

  @override
  String get counter_screen_cooldown_threshold => 'Поріг охолодження';

  @override
  String get counter_screen_cooldown_desc => 'Повторний вхід вимагає періоду охолодження #0 секунд після виходу із зони виявлення';

  @override
  String get counter_screen_cooldown_time => 'Час охолодження';

  @override
  String get counter_screen_cooldown_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_threshold => 'Поріг нерухомості';

  @override
  String get counter_screen_stagnant_desc => 'Об\'єкти, що залишаються нерухомими більше #0 секунд, вважатимуться застійними';

  @override
  String get counter_screen_stagnant_consider => 'Вважати нерухомим';

  @override
  String get counter_screen_stagnant_in_seconds => 'в секундах';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Префікс опису';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Суфікс опису';

  @override
  String get counter_screen_name_error => 'Назва лічильника не може бути порожньою';

  @override
  String get counter_screen_enabled_error => 'Помилка';

  @override
  String get counter_screen_enabled_error_content => 'Вам потрібно спочатку ввімкнути інший лічильник, перш ніж вимкнути цей';

  @override
  String get objects_screen_title => 'Об\'єкти';

  @override
  String get objects_screen_desc => 'Вибрати цілі виявлення, такі як людина, автомобіль, автобус тощо.';

  @override
  String get open_project_screen_title => 'Відкрити проєкт';

  @override
  String get open_project_screen_desc => 'Відкрийте раніше створені проєкти, зберігаючи тільки 20 останніх.';

  @override
  String get open_project_screen_no_project => 'Проєктів не знайдено.';

  @override
  String get default_project_name => 'Проєкт';

  @override
  String get default_video_name => 'Відеоджерело';

  @override
  String get default_zone_name => 'Зона виявлення';

  @override
  String get error_oops => 'Ой, щось пішло не так';

  @override
  String get error_content => 'Сталася неочікувана помилка. Хочете надіслати звіт електронною поштою?';

  @override
  String get error_report => 'Написати нам';

  @override
  String get submit => 'Надіслати';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Скасувати';

  @override
  String get yes => 'Так';

  @override
  String get no => 'Ні';

  @override
  String get close => 'Закрити';

  @override
  String get back => 'Назад';
}
