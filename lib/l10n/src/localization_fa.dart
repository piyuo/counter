// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class LocalizationFa extends Localization {
  LocalizationFa([String locale = 'fa']) : super(locale);

  @override
  String get about_screen_app_version => 'نسخه برنامه';

  @override
  String get about_screen_benchmark => 'آزمون کارایی';

  @override
  String get about_screen_models => 'مدل‌های تشخیص اشیاء';

  @override
  String get about_screen_opencv_build_info => 'اطلاعات ساخت OpenCV';

  @override
  String get about_screen_platform => 'پلتفرم';

  @override
  String get about_screen_title => 'درباره';

  @override
  String get add_video_screen_from => 'افزودن منبع ویدیو از';

  @override
  String get add_video_screen_title => 'افزودن منبع ویدیو';

  @override
  String get back => 'بازگشت';

  @override
  String get benchmark_screen_fps => 'فریم بر ثانیه';

  @override
  String get benchmark_screen_models => 'مدل‌های تشخیص اشیاء';

  @override
  String get benchmark_screen_recommended => 'مدل پیشنهادی';

  @override
  String get benchmark_screen_start_button => 'شروع آزمون کارایی';

  @override
  String get benchmark_screen_start_failed =>
      'شروع آزمون کارایی با خطا مواجه شد، کد خطا:';

  @override
  String get benchmark_screen_title => 'آزمون کارایی مدل‌ها';

  @override
  String get camera_screen_add_title => 'افزودن دوربین';

  @override
  String get camera_screen_back_camera => 'دوربین عقب';

  @override
  String get camera_screen_edit_title => 'انتخاب دوربین';

  @override
  String get camera_screen_front_camera => 'دوربین جلو';

  @override
  String get camera_screen_zoom_level => 'سطح بزرگنمایی';

  @override
  String get cancel => 'انصراف';

  @override
  String get close => 'بستن';

  @override
  String get color_screen_title => 'انتخاب رنگ';

  @override
  String get counter_screen_cooldown_desc =>
      'ورود مجدد نیاز به #0 ثانیه زمان انتظار پس از خروج از منطقه تشخیص دارد';

  @override
  String get counter_screen_cooldown_in_seconds => 'به ثانیه';

  @override
  String get counter_screen_cooldown_threshold => 'آستانه زمان انتظار';

  @override
  String get counter_screen_cooldown_time => 'زمان انتظار';

  @override
  String get counter_screen_enabled => 'فعال‌شده';

  @override
  String get counter_screen_enabled_error => 'خطا';

  @override
  String get counter_screen_enabled_error_content =>
      'شما باید ابتدا شمارشگر دیگری را فعال کنید، سپس می‌توانید این شمارشگر را غیرفعال کنید';

  @override
  String get counter_screen_name_error => 'نام شمارشگر نمی‌تواند خالی باشد';

  @override
  String get counter_screen_reentry_desc =>
      'اشیاء باید #0 بار وارد شوند، با #1 ثانیه زمان انتظار بین هر خروج و ورود مجدد، تا ورود مجدد را فعال کنند';

  @override
  String get counter_screen_reentry_threshold => 'آستانه ورود مجدد';

  @override
  String get counter_screen_reentry_title => 'شمارش ورود مجدد';

  @override
  String get counter_screen_show_on => 'نمایش روی صفحه';

  @override
  String get counter_screen_stagnant_consider => 'در نظر گرفتن به عنوان راکد';

  @override
  String get counter_screen_stagnant_desc =>
      'اشیائی که بیش از #0 ثانیه بدون حرکت بمانند، راکد در نظر گرفته می‌شوند';

  @override
  String get counter_screen_stagnant_desc_prefix => 'پیشوند توضیحات';

  @override
  String get counter_screen_stagnant_desc_suffix => 'پسوند توضیحات';

  @override
  String get counter_screen_stagnant_in_seconds => 'به ثانیه';

  @override
  String get counter_screen_stagnant_threshold => 'آستانه راکد';

  @override
  String get default_project_name => 'پروژه';

  @override
  String get default_video_name => 'منبع ویدیو';

  @override
  String get default_zone_name => 'منطقه تشخیص';

  @override
  String get detection_screen_confidence => 'اعتماد';

  @override
  String get detection_screen_confidence_desc =>
      'اعتماد بالاتر از #0 به عنوان تشخیص معتبر در نظر گرفته می‌شود';

  @override
  String get detection_screen_consider_valid =>
      'در نظر گرفتن به عنوان معتبر پس از';

  @override
  String get detection_screen_consider_valid_desc =>
      'ردیابی شیء پس از #0 به عنوان معتبر در نظر گرفته می‌شود';

  @override
  String get detection_screen_high => 'زیاد';

  @override
  String get detection_screen_lost => 'از دست رفته';

  @override
  String get detection_screen_lost_desc =>
      'بر اساس سرعت حرکت، زمان حذف اشیای گم شده را بین #0 و #1 به صورت پویا تعیین می‌کند';

  @override
  String get detection_screen_low => 'کم';

  @override
  String get detection_screen_match => 'تطابق';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold یک پارامتر کلیدی در ردیابی اشیاء است که میزان تطابق بین جعبه‌های تشخیص مختلف را اندازه‌گیری می‌کند. مقدار پایین‌تر ارتباط اشیاء را آسان‌تر می‌کند اما خطر ارتباطات اشتباه را افزایش می‌دهد. مقدار بالاتر در ارتباطات اشیاء سختگیرانه‌تر است اما ممکن است برخی تطابق‌های واقعی را از دست بدهد.';

  @override
  String get detection_screen_models => 'مدل‌ها';

  @override
  String get detection_screen_nms => 'حذف غیر بیشینه';

  @override
  String get detection_screen_nms_desc =>
      '#0 آستانه NMS پایین‌تر (مثلاً 0.3-0.4) جعبه‌های همپوشان را با سختگیری بیشتری حذف کرده و مثبت‌های کاذب را کاهش می‌دهد اما ممکن است افراد همپوشان را از دست بدهد. آستانه بالاتر (0.7-0.9) جعبه‌های بیشتری را حفظ می‌کند که ممکن است مثبت‌های کاذب را افزایش دهد اما افراد همپوشان را بهتر تشخیص می‌دهد.';

  @override
  String get detection_screen_reset => 'بازنشانی';

  @override
  String get detection_screen_reset_content =>
      'آیا مطمئن هستید که می‌خواهید تنظیمات تشخیص را بازنشانی کنید؟';

  @override
  String get detection_screen_title => 'تنظیمات تشخیص';

  @override
  String get error_content =>
      'خطای غیرمنتظره‌ای رخ داده است. آیا می‌خواهید گزارش خطا را با ایمیل ارسال کنید؟';

  @override
  String get error_oops => 'متأسفیم، مشکلی پیش آمده';

  @override
  String get error_report => 'ایمیل به ما';

  @override
  String get filter_screen_desc => 'یک محدوده فیلتر از لیست زیر انتخاب کنید';

  @override
  String get filter_screen_error_content =>
      'زمان پایان باید بزرگتر از زمان شروع باشد';

  @override
  String get filter_screen_error_custom => 'سفارشی';

  @override
  String get filter_screen_error_end => 'پایان';

  @override
  String get filter_screen_error_start => 'شروع';

  @override
  String get filter_screen_error_title => 'فیلتر';

  @override
  String get filter_screen_title => 'فیلتر';

  @override
  String get language_screen_language => 'زبان';

  @override
  String get no => 'خیر';

  @override
  String get objects_screen_desc =>
      'اهداف تشخیص مانند شخص، خودرو، اتوبوس و غیره را انتخاب کنید.';

  @override
  String get objects_screen_title => 'اشیاء';

  @override
  String get ok => 'تأیید';

  @override
  String get open_project_screen_desc =>
      'باز کردن پروژه‌های قبلی ایجاد شده، با نگهداری فقط ۲۰ مورد اخیر.';

  @override
  String get open_project_screen_no_project => 'هیچ پروژه‌ای یافت نشد.';

  @override
  String get open_project_screen_title => 'باز کردن پروژه';

  @override
  String get product_copyright => 'حق نشر © ۲۰۲۵';

  @override
  String get product_desc =>
      'با استفاده از بینایی کامپیوتری و هوش مصنوعی برای شمارش افراد، وسایل نقلیه، حیوانات خانگی و موارد دیگر.';

  @override
  String get product_name => 'شمارنده';

  @override
  String get project_screen_add_video_button => 'افزودن منبع ویدیو';

  @override
  String get project_screen_exit_button => 'خروج';

  @override
  String get project_screen_exit_confirm_content =>
      'خروج از پروژه باعث توقف شمارش می‌شود. آیا مطمئن هستید که می‌خواهید ادامه دهید؟';

  @override
  String get project_screen_exit_confirm_title => 'تأیید خروج از پروژه';

  @override
  String get project_screen_from_desc =>
      'ما سوابق ۲۴ ساعت اخیر را نگهداری می‌کنیم، بنابراین می‌توانید هر بازه زمانی مورد نیاز را مشاهده کنید.';

  @override
  String get project_screen_report_settings => 'تنظیمات';

  @override
  String get project_screen_title => 'پروژه';

  @override
  String get project_view_no_videos => 'هیچ منبع ویدیویی در دسترس نیست.';

  @override
  String get settings_screen_center_point_button => 'نمایش نقطه مرکزی روی هدف';

  @override
  String get settings_screen_center_point_desc =>
      'نقطه مرکزی به تعیین اینکه آیا هدف در منطقه برخورد قرار دارد کمک می‌کند.';

  @override
  String get settings_screen_center_point_title => 'نقطه مرکزی روی هدف';

  @override
  String get settings_screen_delete_button => 'حذف';

  @override
  String get settings_screen_delete_content =>
      'آیا مطمئن هستید که می‌خواهید این پروژه را حذف کنید؟';

  @override
  String get settings_screen_delete_header => 'حذف این پروژه';

  @override
  String get settings_screen_desc =>
      'تنظیم نام پروژه، پارامترهای تشخیص، پاک کردن شمارش.';

  @override
  String get settings_screen_lost_target_button => 'نمایش هدف گم‌شده';

  @override
  String get settings_screen_lost_target_desc =>
      'هنگامی که ردیابی شیء هدفی را از دست می‌دهد، این گزینه آن را قابل مشاهده می‌کند. به طور پیش‌فرض، اهداف گم‌شده نمایش داده نمی‌شوند.';

  @override
  String get settings_screen_lost_target_title => 'هدف گم‌شده';

  @override
  String get settings_screen_project_error => 'نام پروژه نمی‌تواند خالی باشد';

  @override
  String get settings_screen_project_id => 'شناسه پروژه';

  @override
  String get settings_screen_project_name => 'نام پروژه';

  @override
  String get settings_screen_project_name_place_holder =>
      'خیابان ولیعصر یا پارک ملت';

  @override
  String get settings_screen_random_count_button => 'افزودن شمارش تصادفی';

  @override
  String get settings_screen_reset_count_button => 'بازنشانی شمارش‌ها';

  @override
  String get settings_screen_reset_count_content =>
      'آیا مطمئن هستید که می‌خواهید تمام شمارش‌ها را بازنشانی کنید؟';

  @override
  String get settings_screen_reset_count_header =>
      'بازنشانی تمام شمارش‌ها در این پروژه';

  @override
  String get settings_screen_title => 'تنظیمات';

  @override
  String get submit => 'ارسال';

  @override
  String get url_screen_desc => 'لطفاً آدرس پخش زنده را وارد کنید';

  @override
  String get url_screen_title => 'آدرس پخش زنده';

  @override
  String get url_screen_url => 'آدرس';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream یا rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'افزودن نقطه به منطقه فعلی';

  @override
  String get video_screen_add_zone => 'افزودن منطقه تشخیص';

  @override
  String get video_screen_change_file => 'تغییر فایل';

  @override
  String get video_screen_delete_button => 'حذف';

  @override
  String get video_screen_delete_content =>
      'آیا مطمئن هستید که می‌خواهید این منبع ویدیو را حذف کنید؟';

  @override
  String get video_screen_delete_header => 'حذف این منبع ویدیو';

  @override
  String get video_screen_desc =>
      'مدیریت منابع ویدیو، افزودن یا تغییر مناطق تشخیص.';

  @override
  String get video_screen_detection => 'پارامترهای مدل';

  @override
  String get video_screen_edit_placeholder =>
      'دوربین درب جلو یا دوربین پارکینگ';

  @override
  String get video_screen_move_bottom => 'انتقال منطقه فعلی به پایین';

  @override
  String get video_screen_name_empty => 'نام منبع ویدیو نمی‌تواند خالی باشد.';

  @override
  String get video_screen_playback_14x => '۱/۴x';

  @override
  String get video_screen_playback_2x => '۲x';

  @override
  String get video_screen_playback_current => 'فعلی: ';

  @override
  String get video_screen_playback_speed => 'سرعت پخش';

  @override
  String get video_screen_remove_point => 'حذف نقطه از منطقه فعلی';

  @override
  String get video_screen_sources =>
      'پیکربندی منبع تصویر، اهداف تشخیص و پارامترهای مدل.';

  @override
  String get video_screen_targets => 'اهداف تشخیص';

  @override
  String get video_screen_tools => 'ابزارها';

  @override
  String get video_screen_video_name => 'نام منبع ویدیو';

  @override
  String get video_screen_zones => 'مناطق تشخیص';

  @override
  String get video_screen_zones_desc =>
      'از کشیدن و رها کردن برای تنظیم مناطق استفاده کنید';

  @override
  String get video_sources_camera => 'دوربین';

  @override
  String get video_sources_camera_denied => 'دسترسی به دوربین رد شد';

  @override
  String get video_sources_camera_denied_msg =>
      'لطفاً به تنظیمات بروید و دسترسی به دوربین را برای این برنامه مجاز کنید.';

  @override
  String get video_sources_camera_not_found_message =>
      'برای استفاده از دوربین نیاز به مجوز دسترسی دارید';

  @override
  String get video_sources_camera_not_found_title => 'دوربین پیدا نشد';

  @override
  String get video_sources_file => 'فایل';

  @override
  String get video_sources_live_stream => 'آدرس پخش زنده';

  @override
  String get video_sources_photos_denied => 'دسترسی به تصاویر رد شد';

  @override
  String get video_sources_photos_denied_msg =>
      'لطفاً به تنظیمات بروید و دسترسی به تصاویر را برای این برنامه مجاز کنید.';

  @override
  String get video_sources_photos_goto_settings => 'رفتن به تنظیمات';

  @override
  String get video_sources_webcam => 'وب‌کم';

  @override
  String get video_sources_webcam_not_found_message =>
      'لطفاً مجوز اپلیکیشن و اتصال وب‌کم را بررسی کنید';

  @override
  String get video_sources_webcam_not_found_title => 'وب‌کم پیدا نشد';

  @override
  String get webcam_manager_webcam => 'وب‌کم';

  @override
  String get webcam_screen_add_title => 'افزودن وب‌کم';

  @override
  String get webcam_screen_edit_title => 'انتخاب وب‌کم';

  @override
  String get wizard_screen_about => 'درباره';

  @override
  String get wizard_screen_desc => 'برای شروع شمارش، یک پروژه جدید ایجاد کنید.';

  @override
  String get wizard_screen_email_us => 'ایمیل به ما';

  @override
  String get wizard_screen_language => 'زبان';

  @override
  String get wizard_screen_new_project_from => 'پروژه جدید از';

  @override
  String get wizard_screen_open_projects => 'باز کردن پروژه موجود';

  @override
  String get wizard_screen_open_projects_tip =>
      'تمام پروژه‌ها به‌طور خودکار در دستگاه ذخیره می‌شوند';

  @override
  String get yes => 'بله';

  @override
  String get zone_screen_can_not_delete => 'نمی‌توان منطقه را حذف کرد';

  @override
  String get zone_screen_color => 'رنگ';

  @override
  String get zone_screen_delete_button => 'حذف';

  @override
  String get zone_screen_delete_content =>
      'آیا مطمئن هستید که می‌خواهید این منطقه را حذف کنید؟';

  @override
  String get zone_screen_delete_header => 'حذف این منطقه';

  @override
  String get zone_screen_desc =>
      'منطقه تشخیص می‌تواند انواع اشیاء برای تشخیص را تنظیم کند و شمارشگرهایی را برای نمایش انتخاب کند، مانند تشخیص‌شده، ایجادشده و واردشده.';

  @override
  String get zone_screen_name_placeholder =>
      'نام منطقه، مانند پیاده‌رو یا پارکینگ';

  @override
  String get zone_screen_one_zone_required => 'حداقل یک منطقه لازم است.';

  @override
  String get zone_screen_zone => 'منطقه';

  @override
  String get zone_screen_zone_color => 'رنگ منطقه';

  @override
  String get zone_screen_zone_name_required => 'نام منطقه نمی‌تواند خالی باشد';

  @override
  String get zone_screen_zone_show_summary => 'نمایش خلاصه در صفحه';
}
