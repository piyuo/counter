// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class LocalizationMn extends Localization {
  LocalizationMn([String locale = 'mn']) : super(locale);

  @override
  String get product_name => 'Тоологч';

  @override
  String get product_desc =>
      'Компьютер хараа ба хиймэл оюун ухааныг ашиглан хүмүүс, тээврийн хэрэгсэл, гэрийн тэжээвэр амьтад болон бусад зүйлсийг тоолох.';

  @override
  String get product_copyright => 'Зохиогчийн эрх © 2025';

  @override
  String get video_sources_webcam => 'Вэб камер';

  @override
  String get video_sources_live_stream => 'Шууд дамжуулалтын URL';

  @override
  String get video_sources_file => 'Файл';

  @override
  String get video_sources_camera => 'Камер';

  @override
  String get video_sources_camera_not_found_title => 'Камер олдсонгүй';

  @override
  String get video_sources_camera_not_found_message =>
      'Камерыг ашиглахын тулд камерын зөвшөөрөл өгөх шаардлагатай';

  @override
  String get video_sources_webcam_not_found_title => 'Вэб камер олдсонгүй';

  @override
  String get video_sources_webcam_not_found_message =>
      'Аппын зөвшөөрөл болон вэб камерын холболтыг шалгана уу';

  @override
  String get wizard_screen_desc =>
      'Тоололт эхлүүлэхийн тулд доорх шинэ төсөл үүсгэнэ үү.';

  @override
  String get wizard_screen_new_project_from => 'Дараахаас шинэ төсөл үүсгэх';

  @override
  String get wizard_screen_language => 'Хэл';

  @override
  String get wizard_screen_about => 'Тухай';

  @override
  String get wizard_screen_open_projects_tip =>
      'Бүх төслүүд автоматаар орон нутагт хадгалагдана';

  @override
  String get wizard_screen_open_projects => 'Одоо байгаа төслийг нээх';

  @override
  String get wizard_screen_email_us => 'Бидэнд и-мэйл илгээх';

  @override
  String get language_screen_language => 'Хэл';

  @override
  String get project_view_no_videos => 'Видео эх сурвалж байхгүй байна.';

  @override
  String get about_screen_title => 'Тухай';

  @override
  String get about_screen_platform => 'Платформ';

  @override
  String get about_screen_app_version => 'Аппликейшны хувилбар';

  @override
  String get about_screen_models => 'Объект илрүүлэх загварууд';

  @override
  String get about_screen_benchmark => 'Гүйцэтгэлийн шалгуур';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Бүтээлтийн мэдээлэл';

  @override
  String get benchmark_screen_title => 'Загварын гүйцэтгэлийн шалгуур';

  @override
  String get benchmark_screen_recommended => 'Санал болгож буй загвар';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Гүйцэтгэлийн шалгуур эхлүүлэх';

  @override
  String get benchmark_screen_start_failed =>
      'Гүйцэтгэлийн шалгуур эхлүүлж чадсангүй, алдааны код нь';

  @override
  String get benchmark_screen_models => 'Объект илрүүлэх загварууд';

  @override
  String get project_screen_title => 'Төсөл';

  @override
  String get project_screen_exit_confirm_title =>
      'Төслөөс гарахаа баталгаажуулна уу';

  @override
  String get project_screen_exit_confirm_content =>
      'Төслийг орхих нь тоололтыг зогсооно. Та үргэлжлүүлэхдээ итгэлтэй байна уу?';

  @override
  String get project_screen_exit_button => 'Гарах';

  @override
  String get project_screen_add_video_button => 'Видео эх сурвалж нэмэх';

  @override
  String get project_screen_from_desc =>
      'Бид 24 цагийн тасралтгүй бичлэгтэй тул хэрэгтэй цаг хугацааны хэсгийг харах боломжтой.';

  @override
  String get project_screen_report_settings => 'Тохиргоо';

  @override
  String get filter_screen_title => 'Шүүлтүүр';

  @override
  String get filter_screen_desc =>
      'Доорх жагсаалтаас шүүлтүүрийн хүрээг сонгоно уу';

  @override
  String get filter_screen_error_title => 'Шүүлтүүр';

  @override
  String get filter_screen_error_content =>
      'Төгсгөлийн цаг эхлэлийн цагаас их байх ёстой';

  @override
  String get filter_screen_error_custom => 'Өөрийн';

  @override
  String get filter_screen_error_start => 'Эхлэх';

  @override
  String get filter_screen_error_end => 'Төгсөх';

  @override
  String get settings_screen_title => 'Тохиргоо';

  @override
  String get settings_screen_desc =>
      'Төслийн нэр, илрүүлэх параметрүүд, тоололт цэвэрлэхийг тохируулна уу.';

  @override
  String get settings_screen_project_id => 'Төслийн дугаар';

  @override
  String get settings_screen_project_name => 'Төслийн нэр';

  @override
  String get settings_screen_project_name_place_holder =>
      '123 Гол гудамж эсвэл Парк өргөн чөлөө';

  @override
  String get settings_screen_project_error =>
      'Төслийн нэр хоосон байж болохгүй';

  @override
  String get settings_screen_random_count_button => 'Санамсаргүй тоололт нэмэх';

  @override
  String get settings_screen_reset_count_header =>
      'Энэ төслийн бүх тоололтыг дахин тохируулах';

  @override
  String get settings_screen_reset_count_button => 'Тоололтыг дахин тохируулах';

  @override
  String get settings_screen_reset_count_content =>
      'Та бүх тоололтыг дахин тохируулахдаа итгэлтэй байна уу?';

  @override
  String get settings_screen_delete_header => 'Энэ төслийг устгах';

  @override
  String get settings_screen_delete_content =>
      'Та энэ төслийг устгахдаа итгэлтэй байна уу?';

  @override
  String get settings_screen_delete_button => 'Устгах';

  @override
  String get settings_screen_center_point_title => 'Зорилтот объектын төв цэг';

  @override
  String get settings_screen_center_point_desc =>
      'Төв цэг нь зорилтот объект онох бүсэд байгаа эсэхийг тодорхойлоход тусална.';

  @override
  String get settings_screen_center_point_button =>
      'Зорилтот объектын төв цэгийг харуулах';

  @override
  String get settings_screen_lost_target_title => 'Алдагдсан зорилтот объект';

  @override
  String get settings_screen_lost_target_desc =>
      'Объект хянах үйл явц зорилтот объектыг алдсан үед энэ сонголт түүнийг харагдахуйц болгоно. Анхны тохиргоогоор алдагдсан зорилтот объектууд харагдахгүй.';

  @override
  String get settings_screen_lost_target_button =>
      'Алдагдсан зорилтот объектыг харуулах';

  @override
  String get detection_screen_title => 'Илрүүлэх тохиргоо';

  @override
  String get detection_screen_models => 'Загварууд';

  @override
  String get detection_screen_confidence => 'Итгэл хэмжээ';

  @override
  String get detection_screen_confidence_desc =>
      '#0-аас дээш итгэл хэмжээг хүчинтэй илрүүлэлт гэж үзнэ';

  @override
  String get detection_screen_low => 'Бага';

  @override
  String get detection_screen_high => 'Өндөр';

  @override
  String get detection_screen_nms => 'Максимум Бус Дарангуйлал';

  @override
  String get detection_screen_nms_desc =>
      '#0 Бага NMS босго (жишээлбэл 0.3-0.4) давхцсан хайрцгуудыг илүү хатуу арилгаж хуурамч эерэг үр дүнг бууруулдаг боловч давхцсан хүмүүсийг алгасаж болно. Өндөр босго (0.7-0.9) илүү олон хайрцаг хадгалдаг нь хуурамч эерэг үр дүнг нэмэгдүүлж болох ч давхцсан хүмүүсийг илүү сайн илрүүлдэг.';

  @override
  String get detection_screen_match => 'Тохирол';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold нь объект хянахад чухал параметр бөгөөд өөр өөр илрүүлэлтийн хайрцгуудын хоорондын таарцын түвшинг хэмждэг. Бага утга нь объектуудыг холбоход илүү хялбар болгодог боловч буруу холболтын эрсдэлийг нэмэгдүүлдэг. Өндөр утга нь объект холболтод илүү хатуу боловч зарим бодит таарцыг алдаж болно.';

  @override
  String get detection_screen_lost => 'Алдагдсан';

  @override
  String get detection_screen_lost_desc =>
      'Хөдөлгөөний хурдаас хамааран #0-с #1 хүртэлх алдагдсан объектуудыг устгах хугацааг динамикаар тодорхойлно';

  @override
  String get detection_screen_consider_valid => 'Хүчинтэй гэж үзэх';

  @override
  String get detection_screen_consider_valid_desc =>
      'Хянаж буй объектыг #0 дараа хүчинтэй гэж үзнэ';

  @override
  String get detection_screen_reset => 'Дахин тохируулах';

  @override
  String get detection_screen_reset_content =>
      'Та илрүүлэх тохиргоог дахин тохируулахдаа итгэлтэй байна уу?';

  @override
  String get url_screen_title => 'Шууд дамжуулалтын URL';

  @override
  String get url_screen_desc => 'Шууд дамжуулалтын URL-ийг оруулна уу';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream эсвэл rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Видео эх сурвалж нэмэх';

  @override
  String get add_video_screen_from => 'Дараахаас видео эх сурвалж нэмэх';

  @override
  String get webcam_screen_add_title => 'Вэб камер нэмэх';

  @override
  String get webcam_screen_edit_title => 'Вэб камер сонгох';

  @override
  String get webcam_manager_webcam => 'Вэб камер';

  @override
  String get camera_screen_front_camera => 'Урд камер';

  @override
  String get camera_screen_back_camera => 'Хойд камер';

  @override
  String get camera_screen_add_title => 'Камер нэмэх';

  @override
  String get camera_screen_edit_title => 'Камер сонгох';

  @override
  String get camera_screen_zoom_level => 'Өсгөлтийн түвшин';

  @override
  String get video_screen_name_empty => 'Видеоны нэр хоосон байж болохгүй.';

  @override
  String get video_screen_desc =>
      'Видео эх сурвалжуудыг удирдах, илрүүлэх бүсүүдийг нэмэх эсвэл өөрчлөх.';

  @override
  String get video_screen_video_name => 'Видео эх сурвалжийн нэр';

  @override
  String get video_screen_edit_placeholder =>
      'Хаалганы камер эсвэл Зогсоолын камер';

  @override
  String get video_screen_change_file => 'Файл солих';

  @override
  String get video_screen_add_zone => 'Илрүүлэх бүс нэмэх';

  @override
  String get video_screen_zones => 'Илрүүлэх бүсүүд';

  @override
  String get video_screen_zones_desc =>
      'Бүсүүдийг тохируулахын тулд чирж орхих аргыг ашиглана уу';

  @override
  String get video_screen_tools => 'Хэрэгслүүд';

  @override
  String get video_screen_move_bottom => 'Одоогийн бүсийг доош шилжүүлэх';

  @override
  String get video_screen_add_point => 'Одоогийн бүсэд цэг нэмэх';

  @override
  String get video_screen_remove_point => 'Одоогийн бүсээс цэг хасах';

  @override
  String get video_screen_playback_speed => 'Тоглуулах хурд';

  @override
  String get video_screen_playback_current => 'одоогийн: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Энэ видео эх сурвалжийг устгах';

  @override
  String get video_screen_delete_content =>
      'Та энэ видео эх сурвалжийг устгахдаа итгэлтэй байна уу?';

  @override
  String get video_screen_delete_button => 'Устгах';

  @override
  String get video_screen_sources =>
      'Зураг эх сурвалж, илрүүлэх зорилтот объектууд, загварын параметрүүдийг тохируулах.';

  @override
  String get video_screen_targets => 'Илрүүлэх зорилтот объектууд';

  @override
  String get video_screen_detection => 'Загварын параметрүүд';

  @override
  String get color_screen_title => 'Өнгө сонгох';

  @override
  String get zone_screen_desc =>
      'Илрүүлэх бүс нь илрүүлэх объектын төрлүүдийг тохируулж, Илрүүлсэн, Тооцогдсон, Орсон гэх мэт харуулах тоологчдыг сонгох боломжтой.';

  @override
  String get zone_screen_name_placeholder =>
      'Бүсийн нэр, жишээлбэл Явган зам эсвэл Зогсоол';

  @override
  String get zone_screen_zone_color => 'Бүсийн өнгө';

  @override
  String get zone_screen_color => 'Өнгө';

  @override
  String get zone_screen_delete_header => 'Энэ бүсийг устгах';

  @override
  String get zone_screen_delete_content =>
      'Та энэ бүсийг устгахдаа итгэлтэй байна уу?';

  @override
  String get zone_screen_delete_button => 'Устгах';

  @override
  String get zone_screen_can_not_delete => 'Бүсийг устгах боломжгүй';

  @override
  String get zone_screen_one_zone_required =>
      'Наад зах нь нэг бүс шаардлагатай.';

  @override
  String get zone_screen_zone_name_required =>
      'Бүсийн нэр хоосон байж болохгүй';

  @override
  String get counter_screen_show_on => 'Дэлгэц дээр харуулах';

  @override
  String get counter_screen_enabled => 'Идэвхжүүлсэн';

  @override
  String get counter_screen_reentry_threshold => 'Дахин орох босго';

  @override
  String get counter_screen_reentry_desc =>
      'Объектууд нь #0 удаа орж, гарах бүрийн дараа #1 секундын хөргөлттэй байх ёстой ба дахин орох үед дахин орох үйлдлийг бүртгэнэ';

  @override
  String get counter_screen_reentry_title => 'Дахин орох тоо';

  @override
  String get counter_screen_cooldown_threshold => 'Хөргөлтийн босго';

  @override
  String get counter_screen_cooldown_desc =>
      'Дахин орохын тулд илрүүлэх бүсээс гарсны дараа #0 секундын хөргөлтийн хугацаа шаардлагатай';

  @override
  String get counter_screen_cooldown_time => 'Хөргөлтийн хугацаа';

  @override
  String get counter_screen_cooldown_in_seconds => 'секундээр';

  @override
  String get counter_screen_stagnant_threshold => 'Зогсонги байдлын босго';

  @override
  String get counter_screen_stagnant_desc =>
      '#0 секундээс илүү хугацаанд хөдөлгөөнгүй байгаа объектуудыг зогсонги гэж үзэх болно';

  @override
  String get counter_screen_stagnant_consider => 'Зогсонги гэж үзэх';

  @override
  String get counter_screen_stagnant_in_seconds => 'секундээр';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Тайлбарын угтвар';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Тайлбарын төгсгөвөр';

  @override
  String get counter_screen_name_error => 'Тоологчийн нэр хоосон байж болохгүй';

  @override
  String get counter_screen_enabled_error => 'Алдаа';

  @override
  String get counter_screen_enabled_error_content =>
      'Та эхлээд өөр тоологчийг идэвхжүүлэх хэрэгтэй, дараа нь энэ тоологчийг идэвхгүй болгох боломжтой';

  @override
  String get objects_screen_title => 'Объектууд';

  @override
  String get objects_screen_desc =>
      'Хүн, машин, автобус зэрэг илрүүлэх зорилтот объектуудыг сонгоно уу.';

  @override
  String get open_project_screen_title => 'Төсөл нээх';

  @override
  String get open_project_screen_desc =>
      'Өмнө үүсгэсэн төслүүдийг нээх, зөвхөн сүүлийн 20-г хадгалах.';

  @override
  String get open_project_screen_no_project => 'Төсөл олдсонгүй.';

  @override
  String get default_project_name => 'Төсөл';

  @override
  String get default_video_name => 'Видео эх сурвалж';

  @override
  String get default_zone_name => 'Илрүүлэх бүс';

  @override
  String get error_oops => 'Уучлаарай, ямар нэгэн зүйл буруу боллоо';

  @override
  String get error_content =>
      'Гэнэтийн алдаа гарлаа. Та и-мэйл тайлан илгээхийг хүсч байна уу?';

  @override
  String get error_report => 'Бидэнд и-мэйл илгээх';

  @override
  String get submit => 'Илгээх';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Цуцлах';

  @override
  String get yes => 'Тийм';

  @override
  String get no => 'Үгүй';

  @override
  String get close => 'Хаах';

  @override
  String get back => 'Буцах';

  @override
  String get zone_screen_zone => 'Бүс';

  @override
  String get zone_screen_zone_show_summary => 'Дэлгэцэд хураангуйг харуулах';

  @override
  String get video_sources_photos_denied => 'Зураг руу нэвтрэх эрхгүй';

  @override
  String get video_sources_photos_goto_settings => 'Тохиргоо руу орох';

  @override
  String get video_sources_camera_denied => 'Камерт нэвтрэх эрхгүй';

  @override
  String get video_sources_photos_denied_msg =>
      'Тохиргоо руу орж энэ аппд зураг үзэх зөвшөөрөл өгнө үү.';

  @override
  String get video_sources_camera_denied_msg =>
      'Тохиргоо руу орж энэ аппд камер хэрэглэх зөвшөөрөл өгнө үү.';
}
