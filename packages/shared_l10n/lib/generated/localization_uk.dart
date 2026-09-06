// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class LocalizationUk extends Localization {
  LocalizationUk([String locale = 'uk']) : super(locale);

  @override
  String get about_screen_app_version => 'Версія програми';

  @override
  String get about_screen_email_us => 'Написати нам';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get appeared => 'З\'явилися';

  @override
  String get appeared_help =>
      'Підраховує людей або транспортні засоби, перша виявлена позиція яких була всередині цієї зони.\\n\\nДопомагає зрозуміти, де починається відстеження.\\n\\n(Переважно для досвідчених користувачів)';

  @override
  String get average_occupancy => 'Середня кількість';

  @override
  String get average_occupancy_help =>
      'Показує середню кількість людей або транспортних засобів у цій зоні протягом поточного вікна підрахунку.\\n\\nДопомагає оцінити, наскільки завантаженою була ця зона протягом усього періоду підрахунку.';

  @override
  String get average_stay => 'Середній час перебування';

  @override
  String get average_stay_help =>
      'Показує середній час, який люди або транспортні засоби перебували в цій зоні.\\n\\nДовший середній час перебування може свідчити, що відвідувачі проводять у цій зоні більше часу.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter використовує камеру та ШІ на пристрої для підрахунку людей. Спочатку переконаймося, що ваш пристрій сумісний.';

  @override
  String get camera_test_screen_instruction =>
      'Наведіть камеру на людей. Застосунок покаже рамки навколо виявлених людей.';

  @override
  String get camera_test_screen_next => 'Натисніть «Далі», щоб продовжити.';

  @override
  String get camera_test_screen_start =>
      'Натисніть «Почати». Якщо буде запит, дозвольте доступ до камери.';

  @override
  String get camera_test_screen_test_failed => 'Тест не пройдено!';

  @override
  String get camera_test_screen_test_passed => 'Тест успішний!';

  @override
  String get camera_test_screen_title => 'Тест AI-камери';

  @override
  String get camera_test_screen_wait => 'Очікування, поки ШІ виявить людей…';

  @override
  String get cta_screen_custom => 'Використати власний сервер';

  @override
  String get cta_screen_custom_help =>
      'Надсилайте дані про трафік безпосередньо до власного сервера або бази даних.';

  @override
  String get cta_screen_footer =>
      'Продовжуючи, ви погоджуєтеся з Умовами використання, Політикою конфіденційності та Угодою про обробку даних.';

  @override
  String get cta_screen_invitation => 'Використати код запрошення';

  @override
  String get cta_screen_invitation_help =>
      'Приєднайтеся до існуючої організації за допомогою запрошення від адміністратора.';

  @override
  String get cta_screen_local => 'Лише на цьому пристрої';

  @override
  String get cta_screen_local_help =>
      'Зберігайте дані про трафік лише на цьому пристрої. Нічого не завантажується.';

  @override
  String get cta_screen_piyuo => 'Використати Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Зберігайте дані про трафік у Piyuo Cloud із панелями керування та бізнес-аналітикою.';

  @override
  String get cta_screen_premium => 'Преміум';

  @override
  String get cta_screen_title =>
      'Piyuo Counter створює анонімну статистику трафіку кожні 5 хвилин.\\nВиберіть, як ви хочете зберігати дані та отримувати до них доступ.';

  @override
  String get current_occupancy => 'Поточна кількість';

  @override
  String get current_occupancy_help =>
      'Показує поточну кількість людей або транспортних засобів у цій зоні.\\n\\nЦе значення оновлюється в реальному часі та допомагає перевірити, чи відповідає виявлення AI тому, що ви бачите на екрані. Воно не входить до завантажених телеметричних даних.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Збереження...';

  @override
  String get custom_server_screen_server_url_label => 'URL сервера';

  @override
  String get detection_screen_confidence => 'Поріг впевненості';

  @override
  String get detection_screen_confidence_dialog =>
      'Визначає, наскільки впевненим має бути ШІ перед підрахунком людини або транспортного засобу.\\nНижчі значення\\n• Виявляють більше об\'єктів\\n• Краще для віддалених або частково прихованих об\'єктів\\n• Можуть збільшити кількість хибних виявлень\\nВищі значення\\n• Рахують лише виявлення з високою достовірністю\\n• Зменшують хибні виявлення\\n• Можуть пропустити малі або складні об\'єкти\\nВикористовуйте нижче значення, якщо додаток пропускає людей або транспорт.\\nВикористовуйте вище значення, якщо додаток рахує тіні, відображення або інші хибні об\'єкти.';

  @override
  String get detection_screen_confidence_help =>
      'Мінімальна впевненість, необхідна для виявлення об\'єкта.';

  @override
  String get detection_screen_confidence_max_label => 'Суворий';

  @override
  String get detection_screen_confidence_min_label => 'М\'який';

  @override
  String get detection_screen_disappear => 'Тайм-аут зникнення';

  @override
  String get detection_screen_disappear_dialog =>
      'Визначає, як довго ШІ чекає, перш ніж позначити об\'єкт як зниклий після того, як його більше не виявляють.\\nКоротші значення\\n• Швидше позначають об\'єкти як зниклі\\n• Краще для швидкого руху\\n• Можуть помилково позначити тимчасово приховані об\'єкти як зниклі\\nДовші значення\\n• Довше чекають перед позначенням об\'єктів як зниклих\\n• Краще, коли об\'єкти ненадовго заблоковані або пропущені\\n• Затримують події зникнення';

  @override
  String get detection_screen_disappear_help =>
      'Як довго ШІ чекатиме, перш ніж позначити об\'єкт як зниклий після того, як перестане його виявляти.';

  @override
  String get detection_screen_disappear_max_label => 'Повільно';

  @override
  String get detection_screen_disappear_min_label => 'Швидко';

  @override
  String get detection_screen_memory_dialog =>
      'Визначає, як довго ШІ пам\'ятає об\'єкт після його зникнення.\\nЗбільште це значення, якщо люди або транспорт часто ховаються за іншими об\'єктами.\\nЗменшіть це значення, якщо об\'єкти неправильно пов\'язуються після виходу зі сцени.';

  @override
  String get detection_screen_min_presence => 'Мінімальний час присутності';

  @override
  String get detection_screen_min_presence_help =>
      'Об\'єкт має залишатися видимим, перш ніж буде зарахований. Більші значення допомагають зменшити короткочасні хибні виявлення.';

  @override
  String get detection_screen_min_presence_max_label => 'Безпечніше';

  @override
  String get detection_screen_min_presence_min_label => 'Швидше';

  @override
  String get detection_screen_minimum_visible =>
      'Об\'єкти повинні залишатися видимими протягом цього часу, перш ніж їх порахують.\\nЗбільште це значення, щоб ігнорувати короткочасні хибні виявлення.\\nЗменшіть це значення, якщо швидкорухомих людей або транспорт пропускають.';

  @override
  String get detection_screen_new_track => 'Поріг нового відстеження';

  @override
  String get detection_screen_new_track_help =>
      'Мінімальна впевненість для початку відстеження нового об\'єкта. Нижчі значення можуть створювати дублікати відстеження.';

  @override
  String get detection_screen_new_track_max_label => 'Консервативно';

  @override
  String get detection_screen_new_track_min_label => 'Агресивно';

  @override
  String get detection_screen_reset => 'Скинути';

  @override
  String get detection_screen_reset_content =>
      'Ви впевнені, що хочете скинути налаштування виявлення?';

  @override
  String get detection_screen_show_track_id => 'Показати ID відстеження';

  @override
  String get detection_screen_show_track_id_help =>
      'Увімкніть цей параметр, щоб відобразити унікальні ID відстеження для кожного об\'єкта, який відслідковується.';

  @override
  String get detection_screen_stay => 'Час перебування';

  @override
  String get detection_screen_stay_help =>
      'Скільки часу об\'єкт має перебувати в зоні, перш ніж буде зарахований як перебування.';

  @override
  String get detection_screen_stay_max_label => 'Із затримкою';

  @override
  String get detection_screen_stay_min_label => 'Миттєво';

  @override
  String get detection_screen_stay_threshold =>
      'Визначає, коли об\'єкт враховується в підрахунку перебування.\\nКоротші значення\\n• Одразу рахують перебування\\n• Краще для швидкого аналізу\\nДовші значення\\n• Ігнорують короткочасний прохідний трафік\\n• Краще для вимірювання заповненості';

  @override
  String get detection_screen_subtitle =>
      'Налаштуйте, як ШІ виявляє та відстежує об\'єкти.';

  @override
  String get detection_screen_title => 'Відстеження та підрахунок';

  @override
  String get detection_screen_track_dialog =>
      'Визначає, коли новий виявлений об\'єкт стає новим треком.\\nНижчі значення\\n• Відстеження починається раніше\\n• Краще для швидкорухомих об\'єктів\\n• Можуть створювати дубльовані треки\\nВищі значення\\n• Потребують сильніших доказів перед створенням нового треку\\n• Зменшують дубльовані треки\\n• Можуть затримувати відстеження нових об\'єктів';

  @override
  String get detection_screen_track_memory => 'Пам\'ять відстеження';

  @override
  String get detection_screen_track_memory_help =>
      'Як довго продовжувати відстеження об\'єкта після його тимчасової втрати. Більші значення допомагають відновити відстеження після коротких перекриттів.';

  @override
  String get detection_screen_track_memory_max_label => 'Довга';

  @override
  String get detection_screen_track_memory_min_label => 'Коротка';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter використовує камеру для виявлення пішоходів і транспортних засобів у реальному часі. На цьому пристрої немає доступної камери.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Спробуйте відкрити цей застосунок на телефоні';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Смартфон або планшет із камерою';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Рекомендується пристрій iOS або Android';

  @override
  String get device_not_supported_screen_requirements_title => 'Що потрібно';

  @override
  String get device_not_supported_screen_title => 'Камеру не знайдено';

  @override
  String get disappeared => 'Зникли';

  @override
  String get disappeared_help =>
      'Підраховує людей або транспортні засоби, остання виявлена позиція яких була всередині цієї зони.\\n\\nВідстеження завершується після закінчення налаштованого часу зникнення, якщо людину або транспортний засіб більше не виявлено.\\n\\n(Переважно для досвідчених користувачів)';

  @override
  String get dpa => 'Угода про обробку даних';

  @override
  String get durationDaysShort => '%sд';

  @override
  String get durationHoursShort => '%sгод';

  @override
  String get durationMinutesShort => '%sхв';

  @override
  String get durationSecondsShort => '%sсек';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Увійшли';

  @override
  String get entered_help =>
      'Підраховує людей або транспортні засоби, які увійшли до цієї зони під час поточного вікна підрахунку.\\n\\nВхід враховується, коли людина або транспортний засіб переміщується ззовні всередину зони.';

  @override
  String get exited => 'Вийшли';

  @override
  String get exited_help =>
      'Підраховує людей або транспортні засоби, які вийшли з цієї зони під час поточного вікна підрахунку.\\n\\nВихід враховується, коли людина або транспортний засіб переміщується зсередини зони назовні.';

  @override
  String get language_screen_language => 'Мова';

  @override
  String get language_screen_subtitle =>
      'Виберіть мову, яка використовуватиметься в застосунку.';

  @override
  String get local_only_screen_body =>
      'Режим «Лише локальний пристрій» дає змогу спробувати виявлення та відстеження за допомогою ШІ-камери без завантаження будь-яких даних. Уся статистика пішохідного трафіку обробляється лише на цьому пристрої, чудово підходить для тестування перед підключенням до сервера.';

  @override
  String get local_only_screen_use_action =>
      'Використовувати лише локальний пристрій';

  @override
  String get local_screen_text =>
      'Piyuo Counter працюватиме повністю на цьому пристрої.\\nСтатистика трафіку зберігатиметься лише на цьому пристрої та не завантажуватиметься.\\nПізніше ви зможете підключитися до Piyuo Cloud або власного сервера в Налаштуваннях.';

  @override
  String get maximum_occupancy => 'Максимальна кількість';

  @override
  String get maximum_occupancy_help =>
      'Показує найбільшу кількість людей або транспортних засобів, що одночасно перебували в цій зоні протягом поточного вікна підрахунку.\\n\\nДопомагає визначити пікові рівні відвідуваності або трафіку.';

  @override
  String get maximum_stay => 'Максимальний час перебування';

  @override
  String get maximum_stay_help =>
      'Показує найдовший час, протягом якого людина або транспортний засіб перебували в цій зоні під час поточного вікна підрахунку.\\n\\nДопомагає виявляти незвично довгі відвідування або зупинки.';

  @override
  String get metric_events => 'Події';

  @override
  String get metric_live => 'Наживо';

  @override
  String get metric_show_less => 'Показати менше';

  @override
  String get metric_show_more => 'Показати більше';

  @override
  String get metric_statistics => 'Статистика';

  @override
  String get metrics_counting_all => 'Усі';

  @override
  String get metrics_counting_done => 'Завершено';

  @override
  String get metrics_counting_in_progress => 'У процесі';

  @override
  String get metrics_counting_missing => 'Відсутні';

  @override
  String get metrics_counting_window =>
      'Статистика для кожного 5-хвилинного періоду';

  @override
  String get onboarding_back_action => 'Назад';

  @override
  String get onboarding_cta_no_server => 'Не хочете надсилати дані?';

  @override
  String get onboarding_cta_title => 'Куди надсилати ваші дані?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter використовує камеру пристрою та вбудований ШІ, щоб одразу розпізнавати людей і транспорт.\\nЗавдяки технології виявлення й відстеження додаток автоматично рахує потік пішоходів і транспорту — усе обробляється прямо на вашому пристрої.';

  @override
  String get onboarding_intro_text2 =>
      'Уся обробка ШІ відбувається локально на вашому пристрої. Жодне відео, зображення, обличчя чи особисті дані не завантажуються.\\nПередаються лише анонімні зведення кожні 5 хвилин, включно зі статистикою підрахунків, заповненості, входів, виходів і часу перебування.';

  @override
  String get onboarding_intro_text3 =>
      'Просто запустіть додаток і залиште його працювати. Piyuo Counter автоматично й безперервно збирає та зберігає дані про трафік.\\nЗведення даних зберігаються кожні 5 хвилин і завантажуються щогодини до Piyuo Cloud або вашого власного сервера.';

  @override
  String get onboarding_intro_title1 => 'Підрахунок трафіку за допомогою ШІ';

  @override
  String get onboarding_intro_title2 => 'Конфіденційність насамперед';

  @override
  String get onboarding_intro_title3 => 'Автоматично працює 24/7';

  @override
  String get onboarding_next_action => 'Далі';

  @override
  String get onboarding_skip_action => 'Пропустити вступ';

  @override
  String get onboarding_start_action => 'Почати';

  @override
  String get passed_by => 'Пройшли';

  @override
  String get passed_by_help =>
      'Підраховує людей або транспортні засоби, які пройшли через цю зону під час поточного вікна підрахунку.\\n\\nКожна людина або транспортний засіб враховується лише один раз за кожне проходження через зону.';

  @override
  String get payloads_screen_area => 'Область';

  @override
  String get payloads_screen_confidence => 'Впевненість';

  @override
  String get payloads_screen_coverage => 'Покриття';

  @override
  String get payloads_screen_delivered => 'Доставлено';

  @override
  String get payloads_screen_failed_load =>
      'Не вдалося завантажити останні payload-и';

  @override
  String get payloads_screen_frame_processed => 'Оброблені кадри';

  @override
  String get payloads_screen_hour_not_exists => 'Ця година більше не існує.';

  @override
  String get payloads_screen_missing_time => 'Втрачений час';

  @override
  String get payloads_screen_no_payloads => 'Поки немає payload-ів.';

  @override
  String get payloads_screen_partial => 'Вікно завершилося раніше (частково)';

  @override
  String get payloads_screen_partially => 'Доставлено частково';

  @override
  String get payloads_screen_payload_not_exists =>
      'Цей payload більше не існує.';

  @override
  String get payloads_screen_pending => 'Очікує доставлення';

  @override
  String get payloads_screen_process_fps => 'FPS обробки';

  @override
  String get payloads_screen_resend => 'Надіслати повторно';

  @override
  String get payloads_screen_select_first =>
      'Спочатку виберіть принаймні одну дату або годину.';

  @override
  String get payloads_screen_subtitle =>
      'Виберіть дату або годину для повторного надсилання';

  @override
  String get payloads_screen_title => 'Останні payload-и';

  @override
  String get personal_custom_screen_build_server =>
      'Потрібна допомога з налаштуванням власного сервера?\\nПерегляньте нашу документацію API та приклади серверів.';

  @override
  String get personal_custom_screen_help_action => 'Відкрити документацію API';

  @override
  String get personal_custom_screen_reset_action => 'Почати спочатку';

  @override
  String get personal_custom_success_screen_help =>
      'Натисніть Start нижче, щоб почати підрахунок.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Статистика трафіку автоматично завантажується щогодини.\\nВи також можете завантажити її вручну з екрана журналу завантажень.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Ваш сервер ще не обов’язково має бути онлайн.\\nПочніть підрахунок уже зараз. Ви зможете завершити налаштування та протестувати свій сервер пізніше. Статистика трафіку залишатиметься на цьому пристрої, доки її не буде успішно завантажено.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Статистика трафіку буде надіслана до';

  @override
  String get personal_custom_success_screen_title => 'Ваш сервер готовий';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Ваш URL Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Копіювати URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL скопійовано';

  @override
  String get piyuo_server_screen_saving_action => 'Збереження...';

  @override
  String get piyuo_server_screen_start =>
      'Натисніть \"Start\" нижче, щоб почати підрахунок.';

  @override
  String get piyuo_server_screen_url_help =>
      'Ваша особиста панель Piyuo Cloud доступна за цією URL-адресою.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Збережіть цю URL-адресу, щоб отримати доступ до панелі статистики з іншого пристрою.';

  @override
  String get piyuo_server_screen_use_action => 'Використовувати Piyuo Cloud';

  @override
  String get privacy => 'Політика конфіденційності';

  @override
  String get product_copyright => 'Авторське право © 2026';

  @override
  String get product_desc =>
      'Підрахунок людей і транспортних засобів за допомогою ШІ.';

  @override
  String get settings_screen_custom_subtitle =>
      'Надсилайте дані про трафік безпосередньо на свій сервер або в базу даних.';

  @override
  String get settings_screen_custom_title => 'Використовувати власний сервер';

  @override
  String get settings_screen_data_server_label => 'Сервер даних';

  @override
  String get settings_screen_detection_target => 'Ціль виявлення';

  @override
  String get settings_screen_language_title => 'Мова';

  @override
  String get settings_screen_local_subtitle =>
      'Зберігайте дані про трафік лише на цьому пристрої. Нічого не завантажується.';

  @override
  String get settings_screen_local_title => 'Лише локальний пристрій';

  @override
  String get settings_screen_misc_label => 'Інше';

  @override
  String get settings_screen_object_detection => 'Виявлення об\'єктів';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Зберігайте дані про трафік у Piyuo Cloud із панелями керування та бізнес-аналітикою.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Це видалить усі дані та дозволить почати спочатку. Цю дію неможливо скасувати.';

  @override
  String get settings_screen_reset_all_data_title => 'Скинути всі дані?';

  @override
  String get settings_screen_subscription_body =>
      'Керуйте підпискою та платіжними даними';

  @override
  String get settings_screen_subscription_title => 'Підписка';

  @override
  String get start_screen_about => 'Про програму';

  @override
  String get start_screen_server_none =>
      'Дані зберігаються лише на цьому пристрої';

  @override
  String get start_screen_server_personal => 'Дані завантажуються щогодини до';

  @override
  String get start_screen_settings => 'Налаштування';

  @override
  String get start_screen_upload_logs => 'Завантажити журнали';

  @override
  String get start_screen_video_sources => 'Джерела відео';

  @override
  String get stayed => 'Залишилися';

  @override
  String get stayed_help =>
      'Підраховує людей або транспортні засоби, які перебували в цій зоні щонайменше протягом заданого часу перебування.\\n\\nТиповий час перебування становить 15 секунд і може бути змінений в Налаштуваннях.';

  @override
  String get target_pedestrian => 'Пішохід';

  @override
  String get target_pedestrian_help =>
      'Підраховуйте людей за допомогою моделі виявлення пішоходів';

  @override
  String get target_screen_subtitle => 'Виберіть модель виявлення';

  @override
  String get target_vehicle => 'Транспорт';

  @override
  String get target_vehicle_help =>
      'Підраховуйте автомобілі та інші транспортні засоби за допомогою моделі виявлення транспорту';

  @override
  String get telemetry_error_connection_refused =>
      'Не вдалося з\'єднатися із сервером. Можливо, він зараз недоступний.';

  @override
  String get telemetry_error_connection_reset =>
      'З\'єднання було скинуто. Перевірте підключення до інтернету та повторіть спробу.';

  @override
  String get telemetry_error_connection_timeout =>
      'З\'єднання занадто довго не відповідало. Перевірте підключення до інтернету та повторіть спробу.';

  @override
  String get telemetry_error_database_error =>
      'Не вдалося виконати запис до бази даних.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Не вдалося знайти адресу сервера. Перевірте підключення до інтернету або URL сервера.';

  @override
  String get telemetry_error_http_error_status =>
      'Сервер відхилив запит. Спробуйте пізніше.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Під час обміну даними із сервером сталася неочікувана помилка.';

  @override
  String get telemetry_error_invalid_url =>
      'Адреса сервера недійсна. Перевірте налаштування.';

  @override
  String get telemetry_error_network_error =>
      'Виникла мережева помилка. Перевірте підключення до інтернету та повторіть спробу.';

  @override
  String get telemetry_error_socket_error =>
      'Виникла проблема з мережевим підключенням. Перевірте підключення до інтернету.';

  @override
  String get telemetry_error_transport_exception =>
      'Під час надсилання даних щось пішло не так. Спробуйте ще раз.';

  @override
  String get telemetry_error_unknown_error => 'Сталася неочікувана помилка.';

  @override
  String get terms => 'Умови користування сервісом';

  @override
  String get upload_screen_attempt_time => 'Час спроби:';

  @override
  String get upload_screen_error => 'Помилка:';

  @override
  String get upload_screen_failed => 'Не вдалося';

  @override
  String get upload_screen_load_error =>
      'Не вдалося завантажити журнали завантаження.';

  @override
  String get upload_screen_log_not_exists =>
      'Журнал завантаження більше недоступний.';

  @override
  String get upload_screen_next => 'Наступне завантаження ...';

  @override
  String get upload_screen_next_upload_prefix => 'Наступне завантаження ';

  @override
  String get upload_screen_no_data_server =>
      'Спочатку налаштуйте сервер даних.';

  @override
  String get upload_screen_no_logs => 'Поки немає журналів завантаження.';

  @override
  String get upload_screen_payload_count => 'Кількість payload-ів';

  @override
  String get upload_screen_payload_count_label => 'Кількість payload-ів:';

  @override
  String get upload_screen_payload_size => 'Розмір payload-а:';

  @override
  String get upload_screen_result => 'Результат:';

  @override
  String get upload_screen_retry => 'Кількість повторних спроб:';

  @override
  String get upload_screen_size_kb => 'КБ';

  @override
  String get upload_screen_success => 'Успішно';

  @override
  String get upload_screen_today => 'Сьогодні';

  @override
  String get upload_screen_upload_now => 'Завантажити зараз';

  @override
  String get upload_screen_upload_success => 'Завантаження успішне.';

  @override
  String get upload_screen_uploading => 'Завантаження...';

  @override
  String get upload_screen_yesterday => 'Учора';

  @override
  String get url_screen_invalid_rtsp_error =>
      'URL RTSP має містити ім\'я хоста.';

  @override
  String get url_screen_invalid_url_error =>
      'Введіть правильний URL із підтримуваною схемою.';

  @override
  String get url_screen_subtitle => 'Будь ласка, введіть URL трансляції';

  @override
  String get url_screen_title => 'URL трансляції';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Введіть URL прямої трансляції.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream або rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Задня камера';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_front_camera => 'Передня камера';

  @override
  String get video_sources_live_stream => 'URL трансляції';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Потрібно надати дозвіл на використання камери';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Камеру не знайдено';

  @override
  String get video_sources_screen_import_error =>
      'Не вдалося імпортувати відеофайл.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Перейдіть до налаштувань і дозвольте доступ до фото для цього додатка.';

  @override
  String get video_sources_screen_select_camera =>
      'Торкніться, щоб вибрати цю камеру';

  @override
  String get video_sources_screen_select_file => 'Торкніться, щоб вибрати файл';

  @override
  String get video_sources_screen_select_live =>
      'Торкніться, щоб встановити URL прямої трансляції';

  @override
  String get video_sources_webcam => 'Веб-камера';
}
