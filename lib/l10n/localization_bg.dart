// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class LocalizationBg extends Localization {
  LocalizationBg([String locale = 'bg']) : super(locale);

  @override
  String get product_name => 'Брояч';

  @override
  String get product_desc => 'Използване на компютърно зрение и изкуствен интелект за броене на хора, превозни средства, домашни любимци и други.';

  @override
  String get product_copyright => 'Авторско право © 2025';

  @override
  String get video_sources_webcam => 'Уеб камера';

  @override
  String get video_sources_live_stream => 'URL на живо предаване';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_camera_not_found_title => 'Камерата не е намерена';

  @override
  String get video_sources_camera_not_found_message => 'Необходимо е да дадете разрешение за достъп до камерата';

  @override
  String get video_sources_webcam_not_found_title => 'Уеб камерата не е намерена';

  @override
  String get video_sources_webcam_not_found_message => 'Моля, проверете дали има свързана уеб камера';

  @override
  String get wizard_screen_desc => 'Създайте нов проект по-долу, за да започнете броене.';

  @override
  String get wizard_screen_new_project_from => 'Нов проект от';

  @override
  String get wizard_screen_language => 'Език';

  @override
  String get wizard_screen_about => 'За нас';

  @override
  String get wizard_screen_open_projects_tip => 'Всички проекти ще бъдат автоматично запазени локално';

  @override
  String get wizard_screen_open_projects => 'Отваряне на съществуващ проект';

  @override
  String get wizard_screen_email_us => 'Пишете ни';

  @override
  String get language_screen_language => 'Език';

  @override
  String get project_view_no_videos => 'Няма налични видео източници.';

  @override
  String get about_screen_title => 'За нас';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get about_screen_app_version => 'Версия на приложението';

  @override
  String get about_screen_models => 'Модели за разпознаване на обекти';

  @override
  String get about_screen_benchmark => 'Тест за производителност';

  @override
  String get about_screen_opencv_build_info => 'Информация за компилацията на OpenCV';

  @override
  String get benchmark_screen_title => 'Тестове на моделите';

  @override
  String get benchmark_screen_recommended => 'Препоръчан модел';

  @override
  String get benchmark_screen_fps => 'Кадри в секунда';

  @override
  String get benchmark_screen_start_button => 'Стартиране на теста';

  @override
  String get benchmark_screen_start_failed => 'Неуспешно стартиране на теста, кодът на грешката е';

  @override
  String get benchmark_screen_models => 'Модели за разпознаване на обекти';

  @override
  String get project_screen_title => 'Проект';

  @override
  String get project_screen_exit_confirm_title => 'Потвърдете изход от проекта';

  @override
  String get project_screen_exit_confirm_content => 'Напускането на проекта ще спре броенето. Сигурни ли сте, че искате да продължите?';

  @override
  String get project_screen_exit_button => 'Изход';

  @override
  String get project_screen_add_video_button => 'Добавяне на видео източник';

  @override
  String get project_screen_from_desc => 'Поддържаме 24-часов запис, така че можете да прегледате всеки времеви отрязък, който ви е необходим.';

  @override
  String get project_screen_report_settings => 'Настройки';

  @override
  String get filter_screen_title => 'Филтър';

  @override
  String get filter_screen_desc => 'Изберете обхват на филтъра от списъка по-долу';

  @override
  String get filter_screen_error_title => 'Филтър';

  @override
  String get filter_screen_error_content => 'Крайното време трябва да е по-голямо от началното време';

  @override
  String get filter_screen_error_custom => 'По избор';

  @override
  String get filter_screen_error_start => 'Начало';

  @override
  String get filter_screen_error_end => 'Край';

  @override
  String get settings_screen_title => 'Настройки';

  @override
  String get settings_screen_desc => 'Задайте име на проекта, параметри на разпознаване, изчистване на броенето.';

  @override
  String get settings_screen_project_id => 'ИД на проекта';

  @override
  String get settings_screen_project_name => 'Име на проекта';

  @override
  String get settings_screen_project_name_place_holder => 'ул. Витоша 123 или Парк Борисова градина';

  @override
  String get settings_screen_project_error => 'Името на проекта не може да бъде празно';

  @override
  String get settings_screen_random_count_button => 'Добавяне на случайни броения';

  @override
  String get settings_screen_reset_count_header => 'Нулиране на всички броения в този проект';

  @override
  String get settings_screen_reset_count_button => 'Нулиране на броенията';

  @override
  String get settings_screen_reset_count_content => 'Сигурни ли сте, че искате да нулирате всички броения?';

  @override
  String get settings_screen_delete_header => 'Изтриване на този проект';

  @override
  String get settings_screen_delete_content => 'Сигурни ли сте, че искате да изтриете този проект?';

  @override
  String get settings_screen_delete_button => 'Изтриване';

  @override
  String get settings_screen_center_point_title => 'Централна точка върху целта';

  @override
  String get settings_screen_center_point_desc => 'Централната точка помага да се определи дали целта е в зоната на засичане.';

  @override
  String get settings_screen_center_point_button => 'Показване на централна точка върху целта';

  @override
  String get settings_screen_lost_target_title => 'Изгубена цел';

  @override
  String get settings_screen_lost_target_desc => 'Когато проследяването на обект загуби цел, тази опция я прави видима. По подразбиране изгубените цели не се показват.';

  @override
  String get settings_screen_lost_target_button => 'Показване на изгубени цели';

  @override
  String get detection_screen_title => 'Настройки на разпознаването';

  @override
  String get detection_screen_models => 'Модели';

  @override
  String get detection_screen_confidence => 'Увереност';

  @override
  String get detection_screen_confidence_desc => 'увереност над #0 се счита за валидно разпознаване';

  @override
  String get detection_screen_low => 'Ниска';

  @override
  String get detection_screen_high => 'Висока';

  @override
  String get detection_screen_nms => 'Потискане на немаксимуми';

  @override
  String get detection_screen_nms_desc => '#0 По-нисък праг на NMS (напр. 30%) ще премахне по-агресивно припокриващи се рамки, докато по-висок праг на NMS (напр. 0.6) ще позволи повече припокриване';

  @override
  String get detection_screen_match => 'Съвпадение';

  @override
  String get detection_screen_match_desc => 'Съвпадение над #0 се счита за същия обект.';

  @override
  String get detection_screen_lost => 'Изгубен';

  @override
  String get detection_screen_lost_desc => 'Проследяваният обект ще бъде премахнат, ако е изгубен за #0';

  @override
  String get detection_screen_consider_valid => 'Считане за валиден след';

  @override
  String get detection_screen_consider_valid_desc => 'Проследяваният обект ще се счита за валиден след #0';

  @override
  String get detection_screen_reset => 'Нулиране';

  @override
  String get detection_screen_reset_content => 'Сигурни ли сте, че искате да нулирате настройките на разпознаването?';

  @override
  String get url_screen_title => 'URL на живо предаване';

  @override
  String get url_screen_desc => 'Моля, въведете URL адреса на живото предаване';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream или rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Добавяне на видео източник';

  @override
  String get add_video_screen_from => 'Добавяне на видео източник от';

  @override
  String get webcam_screen_add_title => 'Добавяне на уеб камера';

  @override
  String get webcam_screen_edit_title => 'Избор на уеб камера';

  @override
  String get webcam_manager_webcam => 'Уеб камера';

  @override
  String get camera_screen_front_camera => 'Предна камера';

  @override
  String get camera_screen_back_camera => 'Задна камера';

  @override
  String get camera_screen_add_title => 'Добавяне на камера';

  @override
  String get camera_screen_edit_title => 'Избор на камера';

  @override
  String get camera_screen_zoom_level => 'Ниво на мащабиране';

  @override
  String get video_screen_name_empty => 'Името на видеото не може да бъде празно.';

  @override
  String get video_screen_desc => 'Управление на видео източници, добавяне или променяне на зони за разпознаване.';

  @override
  String get video_screen_video_name => 'Име на видео източник';

  @override
  String get video_screen_edit_placeholder => 'Камера на входната врата или Камера на паркинга';

  @override
  String get video_screen_change_file => 'Промяна на файла';

  @override
  String get video_screen_add_zone => 'Добавяне на зона за разпознаване';

  @override
  String get video_screen_zones => 'Зони за разпознаване';

  @override
  String get video_screen_zones_desc => 'Използвайте плъзгане за настройка на зоните';

  @override
  String get video_screen_tools => 'Инструменти';

  @override
  String get video_screen_move_bottom => 'Преместване на текущата зона най-отдолу';

  @override
  String get video_screen_add_point => 'Добавяне на точка към текущата зона';

  @override
  String get video_screen_remove_point => 'Премахване на точка от текущата зона';

  @override
  String get video_screen_playback_speed => 'Скорост на възпроизвеждане';

  @override
  String get video_screen_playback_current => 'текуща: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Изтриване на този видео източник';

  @override
  String get video_screen_delete_content => 'Сигурни ли сте, че искате да изтриете този видео източник?';

  @override
  String get video_screen_delete_button => 'Изтриване';

  @override
  String get video_screen_sources => 'Конфигуриране на източник на изображения, цели за разпознаване и параметри на модела.';

  @override
  String get video_screen_targets => 'Цели за разпознаване';

  @override
  String get video_screen_detection => 'Параметри на модела';

  @override
  String get color_screen_title => 'Избор на цвят';

  @override
  String get zone_screen_desc => 'Зоната за разпознаване може да зададе типовете обекти за разпознаване и да избере кои броячи да се показват, като Разпознати, Появили се и Влезли.';

  @override
  String get zone_screen_name_placeholder => 'Име на зоната, например Тротоар или Паркинг';

  @override
  String get zone_screen_zone_color => 'Цвят на зоната';

  @override
  String get zone_screen_color => 'Цвят';

  @override
  String get zone_screen_delete_header => 'Изтриване на тази зона';

  @override
  String get zone_screen_delete_content => 'Сигурни ли сте, че искате да изтриете тази зона?';

  @override
  String get zone_screen_delete_button => 'Изтриване';

  @override
  String get zone_screen_can_not_delete => 'Не може да се изтрие зоната';

  @override
  String get zone_screen_one_zone_required => 'Необходима е поне една зона.';

  @override
  String get zone_screen_zone_name_required => 'Името на зоната не може да бъде празно';

  @override
  String get counter_screen_show_on => 'Показване на екрана';

  @override
  String get counter_screen_enabled => 'Активиран';

  @override
  String get counter_screen_reentry_threshold => 'Праг за повторно влизане';

  @override
  String get counter_screen_reentry_desc => 'Обектите трябва да влязат #0 пъти, с #1 секунди време за охлаждане между всяко излизане и повторно влизане, за да се задейства повторно влизане';

  @override
  String get counter_screen_reentry_title => 'Брой повторни влизания';

  @override
  String get counter_screen_cooldown_threshold => 'Праг на охлаждане';

  @override
  String get counter_screen_cooldown_desc => 'Повторното влизане изисква #0 секунди охлаждане след излизане от зоната за разпознаване';

  @override
  String get counter_screen_cooldown_time => 'Време за охлаждане';

  @override
  String get counter_screen_cooldown_in_seconds => 'в секунди';

  @override
  String get counter_screen_stagnant_threshold => 'Праг на застой';

  @override
  String get counter_screen_stagnant_desc => 'Обекти, които остават неподвижни за повече от #0 секунди, ще се считат за застояли';

  @override
  String get counter_screen_stagnant_consider => 'Считане за застоял';

  @override
  String get counter_screen_stagnant_in_seconds => 'в секунди';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Представка за описание';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Суфикс за описание';

  @override
  String get counter_screen_name_error => 'Името на брояча не може да бъде празно';

  @override
  String get counter_screen_enabled_error => 'Грешка';

  @override
  String get counter_screen_enabled_error_content => 'Трябва първо да активирате друг брояч, след което можете да деактивирате този брояч';

  @override
  String get objects_screen_title => 'Обекти';

  @override
  String get objects_screen_desc => 'Изберете цели за разпознаване като човек, кола, автобус и др.';

  @override
  String get open_project_screen_title => 'Отваряне на проект';

  @override
  String get open_project_screen_desc => 'Отворете предишно създадени проекти, като се запазват само последните 20.';

  @override
  String get open_project_screen_no_project => 'Няма намерен проект.';

  @override
  String get default_project_name => 'Проект';

  @override
  String get default_video_name => 'Видео източник';

  @override
  String get default_zone_name => 'Зона за разпознаване';

  @override
  String get error_oops => 'Упс, нещо се обърка';

  @override
  String get error_content => 'Възникна неочаквана грешка. Искате ли да изпратите имейл доклад?';

  @override
  String get error_report => 'Изпратете ни имейл';

  @override
  String get submit => 'Изпращане';

  @override
  String get ok => 'ОК';

  @override
  String get cancel => 'Отказ';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Не';

  @override
  String get close => 'Затваряне';

  @override
  String get back => 'Назад';

  @override
  String get zone_screen_zone => 'Зона';

  @override
  String get zone_screen_zone_show_summary => 'Покажи обобщение на екрана';

  @override
  String get video_sources_photos_denied => 'Достъпът до снимки е отказан';
}
