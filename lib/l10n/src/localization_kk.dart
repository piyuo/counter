// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class LocalizationKk extends Localization {
  LocalizationKk([String locale = 'kk']) : super(locale);

  @override
  String get about_screen_app_version => 'Қолданба нұсқасы';

  @override
  String get about_screen_benchmark => 'Бенчмарк';

  @override
  String get about_screen_models => 'Объектілерді анықтау модельдері';

  @override
  String get about_screen_opencv_build_info => 'OpenCV құрастыру ақпараты';

  @override
  String get about_screen_platform => 'Платформа';

  @override
  String get about_screen_title => 'Туралы';

  @override
  String get add_video_screen_from => 'Бейне көзін қосу';

  @override
  String get add_video_screen_title => 'Бейне көзін қосу';

  @override
  String get back => 'Артқа';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Объектілерді анықтау модельдері';

  @override
  String get benchmark_screen_recommended => 'Ұсынылған модель';

  @override
  String get benchmark_screen_start_button => 'Бенчмаркты бастау';

  @override
  String get benchmark_screen_start_failed =>
      'Бенчмаркты бастау сәтсіз аяқталды, қате коды';

  @override
  String get benchmark_screen_title => 'Модельдер бенчмаркі';

  @override
  String get camera_screen_add_title => 'Камера қосу';

  @override
  String get camera_screen_back_camera => 'Артқы камера';

  @override
  String get camera_screen_edit_title => 'Камераны таңдау';

  @override
  String get camera_screen_front_camera => 'Алдыңғы камера';

  @override
  String get camera_screen_zoom_level => 'Масштабтау деңгейі';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get close => 'Жабу';

  @override
  String get color_screen_title => 'Түс таңдау';

  @override
  String get counter_screen_cooldown_desc =>
      'Қайта кіру үшін анықтау аймағынан шыққаннан кейін #0 секундтық салқындату қажет';

  @override
  String get counter_screen_cooldown_in_seconds => 'секунд ішінде';

  @override
  String get counter_screen_cooldown_threshold => 'Салқындату шегі';

  @override
  String get counter_screen_cooldown_time => 'Салқындату уақыты';

  @override
  String get counter_screen_enabled => 'Қосылған';

  @override
  String get counter_screen_enabled_error => 'Қате';

  @override
  String get counter_screen_enabled_error_content =>
      'Алдымен басқа санағышты қосу керек, содан кейін ғана бұл санағышты өшіре аласыз';

  @override
  String get counter_screen_name_error => 'Санағыш атауы бос болмауы керек';

  @override
  String get counter_screen_reentry_desc =>
      'Объектілер қайта кіруді іске қосу үшін #0 рет кіруі керек, әрбір шығу мен қайта кіру арасында #1 секундтық салқындату уақыты бар';

  @override
  String get counter_screen_reentry_threshold => 'Қайта кіру шегі';

  @override
  String get counter_screen_reentry_title => 'Қайта кіру саны';

  @override
  String get counter_screen_show_on => 'Экранда көрсету';

  @override
  String get counter_screen_stagnant_consider => 'Тоқтап қалған деп санау';

  @override
  String get counter_screen_stagnant_desc =>
      '#0 секундтан артық қозғалмай тұрған объектілер тоқтап қалған деп саналады';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Сипаттама алдындағы мәтін';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Сипаттама соңындағы мәтін';

  @override
  String get counter_screen_stagnant_in_seconds => 'секунд ішінде';

  @override
  String get counter_screen_stagnant_threshold => 'Тоқтап қалу шегі';

  @override
  String get default_project_name => 'Жоба';

  @override
  String get default_video_name => 'Бейне көзі';

  @override
  String get default_zone_name => 'Анықтау аймағы';

  @override
  String get detection_screen_confidence => 'Сенімділік';

  @override
  String get detection_screen_confidence_desc =>
      '#0 жоғары сенімділік жарамды анықтау ретінде қарастырылады';

  @override
  String get detection_screen_consider_valid => 'Жарамды деп санау';

  @override
  String get detection_screen_consider_valid_desc =>
      'Бақылау объектісі #0 кейін жарамды деп саналады';

  @override
  String get detection_screen_high => 'Жоғары';

  @override
  String get detection_screen_lost => 'Жоғалту';

  @override
  String get detection_screen_lost_desc =>
      'Қозғалыс жылдамдығына байланысты #0 мен #1 арасында жоғалған нысандарды жою уақытын динамикалық түрде анықтайды';

  @override
  String get detection_screen_low => 'Төмен';

  @override
  String get detection_screen_match => 'Сәйкестік';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold объектілерді бақылаудағы негізгі параметр ол әр түрлі анықтау жақтаулары арасындағы сәйкестік дәрежесін өлшейді. Төмен мән объектілерді байланыстыруды жеңілдетеді бірақ қате байланыстар қаупін арттырады. Жоғары мән объект байланыстарына қатаң болады бірақ кейбір шынайы сәйкестіктерді жіберіп алуы мүмкін.';

  @override
  String get detection_screen_models => 'Модельдер';

  @override
  String get detection_screen_nms => 'Максимум емес басу';

  @override
  String get detection_screen_nms_desc =>
      '#0 Төмен NMS шегі (мысалы 0.3-0.4) қабаттасқан жақтауларды қатаң жояды және жалған оң нәтижелерді азайтады бірақ қабаттасқан адамдарды жіберіп алуы мүмкін. Жоғары шек (0.7-0.9) көбірек жақтауларды сақтайды бұл жалған оң нәтижелерді арттыруы мүмкін бірақ қабаттасқан адамдарды жақсырақ анықтайды.';

  @override
  String get detection_screen_reset => 'Қалпына келтіру';

  @override
  String get detection_screen_reset_content =>
      'Анықтау параметрлерін қалпына келтіргіңіз келе ме?';

  @override
  String get detection_screen_title => 'Анықтау параметрлері';

  @override
  String get error_content =>
      'Күтпеген қате орын алды. Электрондық пошта есебін жібергіңіз келе ме?';

  @override
  String get error_oops => 'Қап, бірдеңе дұрыс жұмыс істемеді';

  @override
  String get error_report => 'Бізге хат жазу';

  @override
  String get filter_screen_desc => 'Төмендегі тізімнен сүзгі аралығын таңдаңыз';

  @override
  String get filter_screen_error_content =>
      'Аяқталу уақыты басталу уақытынан үлкен болуы керек';

  @override
  String get filter_screen_error_custom => 'Арнайы';

  @override
  String get filter_screen_error_end => 'Аяқталуы';

  @override
  String get filter_screen_error_start => 'Басталуы';

  @override
  String get filter_screen_error_title => 'Сүзгі';

  @override
  String get filter_screen_title => 'Сүзгі';

  @override
  String get language_screen_language => 'Тіл';

  @override
  String get no => 'Жоқ';

  @override
  String get objects_screen_desc =>
      'Адам, көлік, автобус т.б. сияқты анықтау нысандарын таңдаңыз.';

  @override
  String get objects_screen_title => 'Объектілер';

  @override
  String get ok => 'OK';

  @override
  String get open_project_screen_desc =>
      'Бұрын жасалған жобаларды ашыңыз, тек соңғы 20 жоба сақталады.';

  @override
  String get open_project_screen_no_project => 'Жоба табылмады.';

  @override
  String get open_project_screen_title => 'Жобаны ашу';

  @override
  String get product_copyright => 'Барлық құқықтар қорғалған © 2025';

  @override
  String get product_desc =>
      'Компьютерлік көру және жасанды интеллект арқылы адамдарды, көліктерді, үй жануарларын және т.б. санау.';

  @override
  String get product_name => 'Санауыш';

  @override
  String get project_screen_add_video_button => 'Бейне көзін қосу';

  @override
  String get project_screen_exit_button => 'Шығу';

  @override
  String get project_screen_exit_confirm_content =>
      'Жобадан шығу санауды тоқтатады. Жалғастырғыңыз келе ме?';

  @override
  String get project_screen_exit_confirm_title => 'Жобадан шығуды растау';

  @override
  String get project_screen_from_desc =>
      'Біз 24 сағаттық ақпаратты сақтаймыз, сондықтан сіз кез келген уақыт аралығын көре аласыз.';

  @override
  String get project_screen_report_settings => 'Параметрлер';

  @override
  String get project_screen_title => 'Жоба';

  @override
  String get project_view_no_videos => 'Бейне көзі жоқ.';

  @override
  String get settings_screen_center_point_button =>
      'Нысан орталық нүктесін көрсету';

  @override
  String get settings_screen_center_point_desc =>
      'Орталық нүкте нысанның қабылдану аймағында екенін анықтауға көмектеседі.';

  @override
  String get settings_screen_center_point_title => 'Нысанның орталық нүктесі';

  @override
  String get settings_screen_delete_button => 'Жою';

  @override
  String get settings_screen_delete_content => 'Осы жобаны жойғыңыз келе ме?';

  @override
  String get settings_screen_delete_header => 'Осы жобаны жою';

  @override
  String get settings_screen_desc =>
      'Жоба атауын, анықтау параметрлерін, санауды тазалауды орнатыңыз.';

  @override
  String get settings_screen_lost_target_button => 'Жоғалған нысанды көрсету';

  @override
  String get settings_screen_lost_target_desc =>
      'Объектті бақылау нысанды жоғалтқан кезде, бұл опция оны көрінетін етеді. Әдепкі бойынша, жоғалған нысандар көрсетілмейді.';

  @override
  String get settings_screen_lost_target_title => 'Жоғалған нысан';

  @override
  String get settings_screen_project_error => 'Жоба атауы бос болмауы керек';

  @override
  String get settings_screen_project_id => 'Жоба идентификаторы';

  @override
  String get settings_screen_project_name => 'Жоба атауы';

  @override
  String get settings_screen_project_name_place_holder =>
      '123 Абай даңғылы немесе Орталық саябақ';

  @override
  String get settings_screen_random_count_button => 'Кездейсоқ санау қосу';

  @override
  String get settings_screen_reset_count_button => 'Сандарды қалпына келтіру';

  @override
  String get settings_screen_reset_count_content =>
      'Барлық сандарды қалпына келтіргіңіз келе ме?';

  @override
  String get settings_screen_reset_count_header =>
      'Осы жобадағы барлық сандарды қалпына келтіру';

  @override
  String get settings_screen_title => 'Параметрлер';

  @override
  String get submit => 'Жіберу';

  @override
  String get url_screen_desc => 'Тікелей эфир URL мекенжайын енгізіңіз';

  @override
  String get url_screen_title => 'Тікелей эфир URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream немесе rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'Ағымдағы аймаққа нүкте қосу';

  @override
  String get video_screen_add_zone => 'Анықтау аймағын қосу';

  @override
  String get video_screen_change_file => 'Файлды өзгерту';

  @override
  String get video_screen_delete_button => 'Жою';

  @override
  String get video_screen_delete_content => 'Осы бейне көзін жойғыңыз келе ме?';

  @override
  String get video_screen_delete_header => 'Осы бейне көзін жою';

  @override
  String get video_screen_desc =>
      'Бейне көздерін басқару, анықтау аймақтарын қосу немесе өзгерту.';

  @override
  String get video_screen_detection => 'Модель параметрлері';

  @override
  String get video_screen_edit_placeholder =>
      'Алдыңғы есік камерасы немесе Тұрақ камерасы';

  @override
  String get video_screen_move_bottom => 'Ағымдағы аймақты төменге жылжыту';

  @override
  String get video_screen_name_empty => 'Бейне атауы бос болмауы керек.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'ағымдағы: ';

  @override
  String get video_screen_playback_speed => 'Ойнату жылдамдығы';

  @override
  String get video_screen_remove_point => 'Ағымдағы аймақтан нүктені жою';

  @override
  String get video_screen_sources =>
      'Кескін көзін, анықтау нысандарын және модель параметрлерін конфигурациялау.';

  @override
  String get video_screen_targets => 'Анықтау нысандары';

  @override
  String get video_screen_tools => 'Құралдар';

  @override
  String get video_screen_video_name => 'Бейне көзінің атауы';

  @override
  String get video_screen_zones => 'Анықтау аймақтары';

  @override
  String get video_screen_zones_desc =>
      'Аймақтарды реттеу үшін сүйреу және тастауды пайдаланыңыз';

  @override
  String get video_sources_camera => 'Камера';

  @override
  String get video_sources_camera_denied => 'Камераға қол жеткізу мүмкін емес';

  @override
  String get video_sources_camera_denied_msg =>
      'Параметрлерге өтіп бұл қолданбаға камераға қол жеткізу рұқсатын беріңіз.';

  @override
  String get video_sources_camera_not_found_message =>
      'Камераны пайдалану үшін камера рұқсатын беру қажет';

  @override
  String get video_sources_camera_not_found_title => 'Камера табылмады';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_live_stream => 'Тікелей эфир URL';

  @override
  String get video_sources_photos_denied =>
      'Фотосуреттерге қол жеткізу мүмкін емес';

  @override
  String get video_sources_photos_denied_msg =>
      'Параметрлерге өтіп бұл қолданбаға фотосуреттерге қол жеткізу рұқсатын беріңіз.';

  @override
  String get video_sources_photos_goto_settings => 'Параметрлерге өту';

  @override
  String get video_sources_webcam => 'Веб-камера';

  @override
  String get video_sources_webcam_not_found_message =>
      'Қолданбаның рұқсатын және веб-камераны қосуды тексеріңіз';

  @override
  String get video_sources_webcam_not_found_title => 'Веб-камера табылмады';

  @override
  String get webcam_manager_webcam => 'Веб-камера';

  @override
  String get webcam_screen_add_title => 'Веб-камера қосу';

  @override
  String get webcam_screen_edit_title => 'Веб-камераны таңдау';

  @override
  String get wizard_screen_about => 'Туралы';

  @override
  String get wizard_screen_desc =>
      'Санауды бастау үшін төменде жаңа жоба жасаңыз.';

  @override
  String get wizard_screen_email_us => 'Бізге хат жазу';

  @override
  String get wizard_screen_language => 'Тіл';

  @override
  String get wizard_screen_new_project_from => 'Жаңа жоба құру';

  @override
  String get wizard_screen_open_projects => 'Бар жобаны ашу';

  @override
  String get wizard_screen_open_projects_tip =>
      'Барлық жобалар жергілікті құрылғыда автоматты түрде сақталады';

  @override
  String get yes => 'Иә';

  @override
  String get zone_screen_can_not_delete => 'Аймақты жою мүмкін емес';

  @override
  String get zone_screen_color => 'Түс';

  @override
  String get zone_screen_delete_button => 'Жою';

  @override
  String get zone_screen_delete_content => 'Осы аймақты жойғыңыз келе ме?';

  @override
  String get zone_screen_delete_header => 'Осы аймақты жою';

  @override
  String get zone_screen_desc =>
      'Анықтау аймағы анықталатын объект түрлерін орнатуға және Анықталған, Пайда болған және Кірген сияқты қандай санағыштарды көрсетуді таңдауға мүмкіндік береді.';

  @override
  String get zone_screen_name_placeholder =>
      'Аймақ атауы, мысалы Жаяу жүргінші жолы немесе Тұрақ';

  @override
  String get zone_screen_one_zone_required => 'Кем дегенде бір аймақ қажет.';

  @override
  String get zone_screen_zone => 'Аймақ';

  @override
  String get zone_screen_zone_color => 'Аймақ түсі';

  @override
  String get zone_screen_zone_name_required => 'Аймақ атауы бос болмауы керек';

  @override
  String get zone_screen_zone_show_summary => 'Экранда қорытынды көрсету';
}
