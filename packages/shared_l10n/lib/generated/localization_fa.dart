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
  String get about_screen_email_us => 'ایمیل به ما';

  @override
  String get about_screen_platform => 'پلتفرم';

  @override
  String get appeared => 'ظاهر شد';

  @override
  String get appeared_help =>
      'تعداد افراد یا وسایل نقلیه‌ای را که اولین موقعیت شناسایی‌شده آن‌ها داخل این ناحیه بوده است محاسبه می‌کند.\\n\\nبرای درک محل شروع ردیابی مفید است.\\n\\n(عمدتاً برای کاربران پیشرفته)';

  @override
  String get average_occupancy => 'میانگین تعداد';

  @override
  String get average_occupancy_help =>
      'میانگین تعداد افراد یا وسایل نقلیه در این ناحیه را در طول پنجره شمارش فعلی نشان می‌دهد.\\n\\nاین مقدار نشان می‌دهد که این ناحیه در طول کل پنجره شمارش چقدر شلوغ بوده است.';

  @override
  String get average_stay => 'میانگین زمان ماندگاری';

  @override
  String get average_stay_help =>
      'میانگین مدت زمانی را که افراد یا وسایل نقلیه در این ناحیه مانده‌اند نشان می‌دهد.\\n\\nمیانگین زمان بیشتر ممکن است نشان دهد که مشتریان زمان بیشتری را در این ناحیه سپری می‌کنند.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter از دوربین و هوش مصنوعی روی دستگاه برای شمارش افراد استفاده می‌کند. ابتدا مطمئن شویم دستگاه شما سازگار است.';

  @override
  String get camera_test_screen_instruction =>
      'دوربین را به سمت افراد بگیرید. برنامه دور هر فردی که تشخیص دهد کادر می‌کشد.';

  @override
  String get camera_test_screen_next => 'برای ادامه روی «بعدی» بزنید.';

  @override
  String get camera_test_screen_start =>
      'روی «شروع» بزنید. اگر از شما خواسته شد، دسترسی به دوربین را مجاز کنید.';

  @override
  String get camera_test_screen_test_failed => 'آزمایش ناموفق بود!';

  @override
  String get camera_test_screen_test_passed => 'آزمایش با موفقیت انجام شد!';

  @override
  String get camera_test_screen_title => 'آزمایش دوربین هوش مصنوعی';

  @override
  String get camera_test_screen_wait =>
      'در انتظار شناسایی افراد توسط هوش مصنوعی…';

  @override
  String get cta_screen_custom => 'استفاده از سرور خود';

  @override
  String get cta_screen_custom_help =>
      'داده‌های تردد را مستقیماً به بک‌اند یا پایگاه داده خود ارسال کنید.';

  @override
  String get cta_screen_footer =>
      'با ادامه، شما با شرایط استفاده، سیاست حفظ حریم خصوصی و توافق‌نامه پردازش داده‌ها موافقت می‌کنید.';

  @override
  String get cta_screen_invitation => 'استفاده از کد دعوت';

  @override
  String get cta_screen_invitation_help =>
      'با استفاده از دعوت‌نامه مدیر، به یک سازمان موجود بپیوندید.';

  @override
  String get cta_screen_local => 'فقط روی این دستگاه';

  @override
  String get cta_screen_local_help =>
      'داده‌های تردد را فقط روی این دستگاه ذخیره کنید. هیچ داده‌ای بارگذاری نمی‌شود.';

  @override
  String get cta_screen_piyuo => 'استفاده از Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'داده‌های تردد را در Piyuo Cloud همراه با داشبوردها و تحلیل‌های کسب‌وکار ذخیره کنید.';

  @override
  String get cta_screen_premium => 'پریمیوم';

  @override
  String get cta_screen_title =>
      'Piyuo Counter هر ۵ دقیقه آمار ناشناس تردد ایجاد می‌کند.\\nانتخاب کنید چگونه داده‌های خود را ذخیره کرده و به آن‌ها دسترسی داشته باشید.';

  @override
  String get current_occupancy => 'تعداد فعلی';

  @override
  String get current_occupancy_help =>
      'تعداد فعلی افراد یا وسایل نقلیه در این ناحیه را نشان می‌دهد.\\n\\nاین عدد به‌صورت لحظه‌ای به‌روزرسانی می‌شود و برای بررسی مطابقت تشخیص هوش مصنوعی با آنچه روی صفحه می‌بینید مفید است. این مقدار در داده‌های تله‌متری ارسالی قرار نمی‌گیرد.';

  @override
  String get custom_server_screen_bearer_saving_action => 'در حال ذخیره...';

  @override
  String get custom_server_screen_server_url_label => 'آدرس سرور';

  @override
  String get detection_screen_confidence => 'آستانه اطمینان';

  @override
  String get detection_screen_confidence_dialog =>
      'مشخص می‌کند هوش مصنوعی قبل از شمارش یک فرد یا خودرو چقدر باید مطمئن باشد.\\nمقادیر پایین‌تر\\n• اشیای بیشتری را شناسایی می‌کند\\n• برای اشیای دور یا نیمه‌پنهان بهتر است\\n• ممکن است تشخیص‌های اشتباه را افزایش دهد\\nمقادیر بالاتر\\n• فقط تشخیص‌های با اطمینان بالا را می‌شمارد\\n• تشخیص‌های اشتباه را کاهش می‌دهد\\n• ممکن است اشیای کوچک یا دشوار را از دست بدهد\\nاگر برنامه افراد یا خودروها را تشخیص نمی‌دهد، مقدار پایین‌تری استفاده کنید.\\nاگر برنامه سایه، انعکاس یا اشیای اشتباه دیگر را می‌شمارد، مقدار بالاتری استفاده کنید.';

  @override
  String get detection_screen_confidence_help =>
      'حداقل اطمینان مورد نیاز برای تشخیص یک شیء.';

  @override
  String get detection_screen_confidence_max_label => 'سخت‌گیر';

  @override
  String get detection_screen_confidence_min_label => 'آسان‌گیر';

  @override
  String get detection_screen_disappear => 'مهلت ناپدید شدن';

  @override
  String get detection_screen_disappear_dialog =>
      'مشخص می‌کند هوش مصنوعی چه مدت صبر می‌کند قبل از اینکه یک شیء را پس از عدم شناسایی، ناپدید علامت‌گذاری کند.\\nمقادیر کوتاه‌تر\\n• اشیا را سریع‌تر ناپدید علامت می‌زند\\n• برای ترافیک سریع بهتر است\\n• ممکن است اشیای موقتاً پنهان را به اشتباه ناپدید علامت بزند\\nمقادیر طولانی‌تر\\n• قبل از علامت‌گذاری ناپدید، بیشتر صبر می‌کند\\n• زمانی که اشیا کوتاه‌مدت مسدود یا از دست می‌روند بهتر است\\n• رویدادهای ناپدید شدن را به تأخیر می‌اندازد';

  @override
  String get detection_screen_disappear_help =>
      'مدت زمانی که هوش مصنوعی پس از توقف تشخیص، پیش از علامت‌گذاری شیء به‌عنوان ناپدیدشده صبر می‌کند.';

  @override
  String get detection_screen_disappear_max_label => 'کند';

  @override
  String get detection_screen_disappear_min_label => 'سریع';

  @override
  String get detection_screen_memory_dialog =>
      'مشخص می‌کند هوش مصنوعی چه مدت یک شیء را پس از ناپدید شدن به خاطر می‌سپارد.\\nاگر افراد یا خودروها اغلب پشت اشیای دیگر پنهان می‌شوند، این مقدار را افزایش دهید.\\nاگر اشیا پس از ترک صحنه به‌اشتباه به هم متصل می‌شوند، این مقدار را کاهش دهید.';

  @override
  String get detection_screen_min_presence => 'حداقل زمان حضور';

  @override
  String get detection_screen_min_presence_help =>
      'یک شیء باید مدتی قابل مشاهده باشد تا شمارش شود. مقادیر بیشتر به کاهش تشخیص‌های اشتباه کوتاه‌مدت کمک می‌کنند.';

  @override
  String get detection_screen_min_presence_max_label => 'ایمن‌تر';

  @override
  String get detection_screen_min_presence_min_label => 'سریع‌تر';

  @override
  String get detection_screen_minimum_visible =>
      'اشیا باید به این مدت قابل مشاهده باقی بمانند تا شمارش شوند.\\nاین مقدار را افزایش دهید تا تشخیص‌های اشتباه کوتاه نادیده گرفته شوند.\\nاین مقدار را کاهش دهید اگر افراد یا خودروهای سریع‌الحرکت از دست می‌روند.';

  @override
  String get detection_screen_new_track => 'آستانه شروع ردیابی';

  @override
  String get detection_screen_new_track_help =>
      'حداقل اطمینان برای شروع ردیابی یک شیء جدید. مقادیر کمتر ممکن است ردیابی‌های تکراری ایجاد کنند.';

  @override
  String get detection_screen_new_track_max_label => 'محافظه‌کارانه';

  @override
  String get detection_screen_new_track_min_label => 'تهاجمی';

  @override
  String get detection_screen_reset => 'بازنشانی';

  @override
  String get detection_screen_reset_content =>
      'آیا مطمئن هستید که می‌خواهید تنظیمات تشخیص را بازنشانی کنید؟';

  @override
  String get detection_screen_show_track_id => 'نمایش شناسه تتبع';

  @override
  String get detection_screen_show_track_id_help =>
      'برای نمایش شناسه‌های تتبع منحصر به‌فرد برای هر کائنی که تتبع می‌شود، این گزینه را فعال کنید.';

  @override
  String get detection_screen_stay => 'زمان ماندن';

  @override
  String get detection_screen_stay_help =>
      'مدت زمانی که یک شیء باید در محدوده بماند تا به‌عنوان ماندن شمارش شود.';

  @override
  String get detection_screen_stay_max_label => 'با تأخیر';

  @override
  String get detection_screen_stay_min_label => 'فوری';

  @override
  String get detection_screen_stay_threshold =>
      'مشخص می‌کند یک شیء چه زمانی در شمارش «توقف» مؤثر است.\\nمقادیر کوتاه‌تر\\n• توقف را فوراً می‌شمارد\\n• برای تحلیل سریع بهتر است\\nمقادیر طولانی‌تر\\n• عبور کوتاه‌مدت را نادیده می‌گیرد\\n• برای اندازه‌گیری اشغال بهتر است';

  @override
  String get detection_screen_subtitle =>
      'نحوه تشخیص و دنبال کردن اشیا توسط هوش مصنوعی را تنظیم کنید';

  @override
  String get detection_screen_title => 'ردیابی و شمارش';

  @override
  String get detection_screen_track_dialog =>
      'مشخص می‌کند یک شیء تازه‌شناسایی‌شده چه زمانی به یک مسیر جدید تبدیل می‌شود.\\nمقادیر پایین‌تر\\n• ردیابی زودتر شروع می‌شود\\n• برای اشیای سریع‌الحرکت بهتر است\\n• ممکن است مسیرهای تکراری ایجاد کند\\nمقادیر بالاتر\\n• قبل از ایجاد مسیر جدید به شواهد قوی‌تری نیاز دارد\\n• مسیرهای تکراری را کاهش می‌دهد\\n• ممکن است ردیابی اشیای جدید را به تأخیر بیندازد';

  @override
  String get detection_screen_track_memory => 'حافظه ردیابی';

  @override
  String get detection_screen_track_memory_help =>
      'مدت زمانی که پس از گم شدن موقت، ردیابی یک شیء ادامه پیدا می‌کند. مقادیر بیشتر به بازیابی پس از پوشانده شدن کوتاه کمک می‌کنند.';

  @override
  String get detection_screen_track_memory_max_label => 'طولانی';

  @override
  String get detection_screen_track_memory_min_label => 'کوتاه';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter از دوربین شما برای تشخیص عابران پیاده و وسایل نقلیه به‌صورت لحظه‌ای استفاده می‌کند. این دستگاه دوربین در دسترس ندارد.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'این برنامه را روی گوشی خود باز کنید';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'یک گوشی هوشمند یا تبلت با دوربین';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'دستگاه iOS یا Android توصیه می‌شود';

  @override
  String get device_not_supported_screen_requirements_title =>
      'آنچه نیاز دارید';

  @override
  String get device_not_supported_screen_title => 'دوربین یافت نشد';

  @override
  String get disappeared => 'ناپدید شد';

  @override
  String get disappeared_help =>
      'تعداد افراد یا وسایل نقلیه‌ای را که آخرین موقعیت شناسایی‌شده آن‌ها داخل این ناحیه بوده است محاسبه می‌کند.\\n\\nاگر فرد یا وسیله نقلیه تا پایان زمان ناپدید شدن تنظیم‌شده دیگر شناسایی نشود، ردیابی پایان می‌یابد.\\n\\n(عمدتاً برای کاربران پیشرفته)';

  @override
  String get dpa => 'توافق‌نامه پردازش داده‌ها';

  @override
  String get durationDaysShort => '%sر';

  @override
  String get durationHoursShort => '%sس';

  @override
  String get durationMinutesShort => '%sد';

  @override
  String get durationSecondsShort => '%sث';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'وارد شد';

  @override
  String get entered_help =>
      'تعداد افراد یا وسایل نقلیه‌ای را که در طول پنجره شمارش فعلی وارد این ناحیه شده‌اند محاسبه می‌کند.\\n\\nورود زمانی شمارش می‌شود که یک فرد یا وسیله نقلیه از خارج ناحیه به داخل آن حرکت کند.';

  @override
  String get exited => 'خارج شد';

  @override
  String get exited_help =>
      'تعداد افراد یا وسایل نقلیه‌ای را که در طول پنجره شمارش فعلی از این ناحیه خارج شده‌اند محاسبه می‌کند.\\n\\nخروج زمانی شمارش می‌شود که یک فرد یا وسیله نقلیه از داخل ناحیه به خارج آن حرکت کند.';

  @override
  String get language_screen_language => 'زبان';

  @override
  String get language_screen_subtitle =>
      'زبان مورد استفاده در برنامه را انتخاب کنید.';

  @override
  String get local_only_screen_body =>
      'حالت «فقط دستگاه محلی» به شما امکان می‌دهد تشخیص و ردیابی دوربین با هوش مصنوعی را بدون آپلود هیچ داده‌ای امتحان کنید. همه آمار تردد افراد فقط روی همین دستگاه پردازش می‌شود، مناسب برای آزمایش قبل از اتصال به سرور.';

  @override
  String get local_only_screen_use_action => 'فقط از دستگاه محلی استفاده کنید';

  @override
  String get local_screen_text =>
      'Piyuo Counter به‌طور کامل روی این دستگاه اجرا می‌شود.\\nآمار تردد فقط روی این دستگاه ذخیره می‌شود و بارگذاری نخواهد شد.\\nبعداً می‌توانید از بخش تنظیمات به Piyuo Cloud یا سرور خود متصل شوید.';

  @override
  String get maximum_occupancy => 'حداکثر تعداد';

  @override
  String get maximum_occupancy_help =>
      'بیشترین تعداد افراد یا وسایل نقلیه موجود در این ناحیه را به‌طور هم‌زمان در طول پنجره شمارش فعلی نشان می‌دهد.\\n\\nبرای شناسایی اوج شلوغی یا ترافیک مفید است.';

  @override
  String get maximum_stay => 'حداکثر زمان ماندگاری';

  @override
  String get maximum_stay_help =>
      'بیشترین مدت زمانی را که یک فرد یا وسیله نقلیه در این ناحیه طی پنجره شمارش فعلی مانده است نشان می‌دهد.\\n\\nبرای شناسایی توقف‌ها یا بازدیدهای غیرعادی طولانی مفید است.';

  @override
  String get metric_events => 'رویدادها';

  @override
  String get metric_live => 'زنده';

  @override
  String get metric_show_less => 'نمایش کمتر';

  @override
  String get metric_show_more => 'نمایش بیشتر';

  @override
  String get metric_statistics => 'آمار';

  @override
  String get metrics_counting_all => 'همه';

  @override
  String get metrics_counting_done => 'تکمیل‌شده';

  @override
  String get metrics_counting_in_progress => 'در حال انجام';

  @override
  String get metrics_counting_missing => 'مفقود';

  @override
  String get metrics_counting_window => 'آمار برای هر بازه ۵ دقیقه‌ای';

  @override
  String get onboarding_back_action => 'بازگشت';

  @override
  String get onboarding_cta_no_server =>
      'ترجیح می‌دهید داده‌ای بارگذاری نکنید؟';

  @override
  String get onboarding_cta_title => 'داده‌های شما به کجا ارسال شوند؟';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter با دوربین گوشی و هوش مصنوعی داخلی، افراد و خودروها را همان لحظه شناسایی می‌کند.\\nبا فناوری شناسایی و ردیابی، به‌طور خودکار تردد عابران پیاده و خودروها را می‌شمارد — همه چیز روی همان دستگاه شما انجام می‌شود.';

  @override
  String get onboarding_intro_text2 =>
      'تمام پردازش هوش مصنوعی روی همان دستگاه شما انجام می‌شود. هیچ ویدیو، تصویر، چهره یا هویتی آپلود نمی‌شود.\\nفقط خلاصه‌های ناشناس هر ۵ دقیقه به اشتراک گذاشته می‌شود، شامل آمار تعداد، اشغال، ورود، خروج و مدت توقف.';

  @override
  String get onboarding_intro_text3 =>
      'فقط برنامه را اجرا کنید و بگذارید کار کند. Piyuo Counter به‌طور مداوم داده‌های ترافیک را جمع‌آوری و ذخیره می‌کند.\\nخلاصه داده‌ها هر ۵ دقیقه ذخیره و هر ساعت به Piyuo Cloud یا سرور شخصی شما آپلود می‌شود.';

  @override
  String get onboarding_intro_title1 => 'شمارش تردد با هوش مصنوعی';

  @override
  String get onboarding_intro_title2 => 'حریم خصوصی از ابتدا';

  @override
  String get onboarding_intro_title3 => 'به‌صورت خودکار ۲۴ ساعته اجرا می‌شود';

  @override
  String get onboarding_next_action => 'بعدی';

  @override
  String get onboarding_skip_action => 'رد کردن معرفی';

  @override
  String get onboarding_start_action => 'شروع';

  @override
  String get passed_by => 'عبور کرده';

  @override
  String get passed_by_help =>
      'تعداد افراد یا وسایل نقلیه‌ای را که در طول پنجره شمارش فعلی از این ناحیه عبور کرده‌اند محاسبه می‌کند.\\n\\nهر فرد یا وسیله نقلیه برای هر بار عبور از ناحیه فقط یک بار شمارش می‌شود.';

  @override
  String get payloads_screen_area => 'ناحیه';

  @override
  String get payloads_screen_confidence => 'اطمینان';

  @override
  String get payloads_screen_coverage => 'پوشش';

  @override
  String get payloads_screen_delivered => 'تحویل شد';

  @override
  String get payloads_screen_failed_load => 'بارگیری بسته‌های اخیر ناموفق بود';

  @override
  String get payloads_screen_frame_processed => 'فریم‌های پردازش‌شده';

  @override
  String get payloads_screen_hour_not_exists => 'این ساعت دیگر وجود ندارد.';

  @override
  String get payloads_screen_missing_time => 'زمان از دست‌رفته';

  @override
  String get payloads_screen_no_payloads => 'هنوز بسته‌ای وجود ندارد.';

  @override
  String get payloads_screen_partial => 'بازه زودتر پایان یافت (ناقص)';

  @override
  String get payloads_screen_partially => 'تحویل جزئی';

  @override
  String get payloads_screen_payload_not_exists => 'این بسته دیگر وجود ندارد.';

  @override
  String get payloads_screen_pending => 'در انتظار ارسال';

  @override
  String get payloads_screen_process_fps => 'FPS پردازش';

  @override
  String get payloads_screen_resend => 'ارسال مجدد';

  @override
  String get payloads_screen_select_first =>
      'ابتدا حداقل یک تاریخ یا ساعت را انتخاب کنید.';

  @override
  String get payloads_screen_subtitle =>
      'برای ارسال مجدد بر اساس تاریخ یا ساعت انتخاب کنید';

  @override
  String get payloads_screen_title => 'بسته‌های اخیر';

  @override
  String get personal_custom_screen_build_server =>
      'برای راه‌اندازی سرور خود به کمک نیاز دارید؟\\nمستندات API و نمونه‌های سرور ما را ببینید.';

  @override
  String get personal_custom_screen_help_action => 'باز کردن مستندات API';

  @override
  String get personal_custom_screen_reset_action => 'شروع دوباره';

  @override
  String get personal_custom_success_screen_help =>
      'برای شروع شمارش، روی Start در پایین بزنید.';

  @override
  String get personal_custom_success_screen_help1 =>
      'آمار تردد هر ساعت به‌صورت خودکار بارگذاری می‌شود.\\nهمچنین می‌توانید از صفحه گزارش‌های بارگذاری آن‌ها را دستی ارسال کنید.';

  @override
  String get personal_custom_success_screen_help2 =>
      'سرور شما هنوز لازم نیست آنلاین باشد.\\nهمین حالا شمارش را شروع کنید. بعداً می‌توانید ساخت و آزمایش سرور خود را کامل کنید. آمار تردد تا زمان بارگذاری موفق روی این دستگاه باقی می‌ماند.';

  @override
  String get personal_custom_success_screen_send_to =>
      'آمار ترافیک به این آدرس ارسال خواهد شد';

  @override
  String get personal_custom_success_screen_title => 'سرور شما آماده است';

  @override
  String get piyuo_server_screen_cloud_url_label => 'آدرس Piyuo Cloud شما';

  @override
  String get piyuo_server_screen_copy_action => 'کپی URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL کپی شد';

  @override
  String get piyuo_server_screen_saving_action => 'در حال ذخیره...';

  @override
  String get piyuo_server_screen_start =>
      'برای شروع شمارش، روی \"Start\" در پایین بزنید.';

  @override
  String get piyuo_server_screen_url_help =>
      'داشبورد شخصی Piyuo Cloud شما در این نشانی آماده است.';

  @override
  String get piyuo_server_screen_url_remember =>
      'این نشانی را ذخیره کنید تا از دستگاه دیگری به داشبورد تردد خود دسترسی داشته باشید.';

  @override
  String get piyuo_server_screen_use_action => 'استفاده از Piyuo Cloud';

  @override
  String get privacy => 'سیاست حفظ حریم خصوصی';

  @override
  String get product_copyright => 'حق نشر © ۲۰۲۶';

  @override
  String get product_desc => 'شمارش افراد و وسایل نقلیه با هوش مصنوعی.';

  @override
  String get settings_screen_custom_subtitle =>
      'داده‌های تردد را مستقیماً به سرور یا پایگاه داده خود ارسال کنید.';

  @override
  String get settings_screen_custom_title => 'استفاده از سرور سفارشی';

  @override
  String get settings_screen_data_server_label => 'سرور داده';

  @override
  String get settings_screen_detection_target => 'هدف تشخیص';

  @override
  String get settings_screen_language_title => 'زبان';

  @override
  String get settings_screen_local_subtitle =>
      'داده‌های تردد را فقط روی این دستگاه ذخیره کنید. چیزی بارگذاری نمی‌شود.';

  @override
  String get settings_screen_local_title => 'فقط دستگاه محلی';

  @override
  String get settings_screen_misc_label => 'متفرقه';

  @override
  String get settings_screen_object_detection => 'تشخیص اشیا';

  @override
  String get settings_screen_piyuo_subtitle =>
      'داده‌های تردد را در Piyuo Cloud ذخیره کنید و از داشبوردها و تحلیل‌های کسب‌وکار بهره ببرید.';

  @override
  String get settings_screen_piyuo_title => 'ابر Piyuo';

  @override
  String get settings_screen_reset_all_data_body =>
      'با این کار همه داده‌ها پاک می‌شوند و همه چیز از ابتدا شروع می‌شود. این عمل قابل بازگشت نیست.';

  @override
  String get settings_screen_reset_all_data_title =>
      'همه داده‌ها بازنشانی شوند؟';

  @override
  String get settings_screen_subscription_body =>
      'اشتراک و اطلاعات صورتحساب خود را مدیریت کنید';

  @override
  String get settings_screen_subscription_title => 'اشتراک';

  @override
  String get start_screen_about => 'درباره';

  @override
  String get start_screen_server_none =>
      'داده‌ها فقط روی این دستگاه ذخیره می‌شوند';

  @override
  String get start_screen_server_personal =>
      'داده‌ها هر ساعت در این آدرس بارگذاری می‌شوند:';

  @override
  String get start_screen_settings => 'تنظیمات';

  @override
  String get start_screen_upload_logs => 'بارگذاری گزارش‌ها';

  @override
  String get start_screen_video_sources => 'منابع ویدیو';

  @override
  String get stayed => 'ماندند';

  @override
  String get stayed_help =>
      'تعداد افراد یا وسایل نقلیه‌ای را که حداقل به مدت زمان ماندگاری تنظیم‌شده در این ناحیه باقی مانده‌اند محاسبه می‌کند.\\n\\nزمان ماندگاری پیش‌فرض ۱۵ ثانیه است و در تنظیمات قابل تغییر است.';

  @override
  String get target_pedestrian => 'عابر پیاده';

  @override
  String get target_pedestrian_help =>
      'افراد را با مدل تشخیص عابر پیاده شمارش کنید';

  @override
  String get target_screen_subtitle => 'مدل تشخیص موردنظر را انتخاب کنید';

  @override
  String get target_vehicle => 'وسیله نقلیه';

  @override
  String get target_vehicle_help =>
      'خودروها و سایر وسایل نقلیه را با مدل تشخیص خودرو شمارش کنید';

  @override
  String get telemetry_error_connection_refused =>
      'اتصال به سرور برقرار نشد. ممکن است سرور در حال حاضر آفلاین باشد.';

  @override
  String get telemetry_error_connection_reset =>
      'اتصال بازنشانی شد. لطفاً اتصال اینترنت خود را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get telemetry_error_connection_timeout =>
      'پاسخ‌دهی اتصال بیش از حد طول کشید. لطفاً اتصال اینترنت خود را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'آدرس سرور یافت نشد. لطفاً اتصال اینترنت یا آدرس سرور را بررسی کنید.';

  @override
  String get telemetry_error_http_error_status =>
      'سرور درخواست را رد کرد. لطفاً بعداً دوباره تلاش کنید.';

  @override
  String get telemetry_error_http_unknown_error =>
      'هنگام ارتباط با سرور خطای غیرمنتظره‌ای رخ داد.';

  @override
  String get telemetry_error_invalid_url =>
      'آدرس سرور نامعتبر است. لطفاً تنظیمات خود را بررسی کنید.';

  @override
  String get telemetry_error_network_error =>
      'خطای شبکه رخ داد. لطفاً اتصال اینترنت خود را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get telemetry_error_socket_error =>
      'مشکلی در اتصال شبکه رخ داد. لطفاً اتصال اینترنت خود را بررسی کنید.';

  @override
  String get telemetry_error_transport_exception =>
      'هنگام ارسال داده مشکلی پیش آمد. لطفاً دوباره تلاش کنید.';

  @override
  String get terms => 'شرایط استفاده از خدمات';

  @override
  String get upload_screen_attempt_time => 'زمان تلاش:';

  @override
  String get upload_screen_error => 'خطا:';

  @override
  String get upload_screen_failed => 'ناموفق';

  @override
  String get upload_screen_load_error =>
      'بارگیری گزارش‌های بارگذاری ناموفق بود.';

  @override
  String get upload_screen_log_not_exists =>
      'گزارش بارگذاری دیگر در دسترس نیست.';

  @override
  String get upload_screen_next => 'بارگذاری بعدی در ...';

  @override
  String get upload_screen_next_upload_prefix => 'بارگذاری بعدی در ';

  @override
  String get upload_screen_no_data_server =>
      'لطفاً ابتدا سرور داده را تنظیم کنید.';

  @override
  String get upload_screen_no_logs => 'هنوز گزارشی از بارگذاری وجود ندارد.';

  @override
  String get upload_screen_payload_count => 'تعداد بسته‌ها';

  @override
  String get upload_screen_payload_count_label => 'تعداد بسته‌ها:';

  @override
  String get upload_screen_payload_size => 'اندازه بسته:';

  @override
  String get upload_screen_result => 'نتیجه:';

  @override
  String get upload_screen_retry => 'تعداد تلاش‌های مجدد:';

  @override
  String get upload_screen_size_kb => 'کیلوبایت';

  @override
  String get upload_screen_success => 'موفق';

  @override
  String get upload_screen_today => 'امروز';

  @override
  String get upload_screen_upload_now => 'اکنون بارگذاری کنید';

  @override
  String get upload_screen_upload_success => 'بارگذاری موفق بود.';

  @override
  String get upload_screen_uploading => 'در حال بارگذاری...';

  @override
  String get upload_screen_yesterday => 'دیروز';

  @override
  String get url_screen_invalid_rtsp_error =>
      'نشانی RTSP باید شامل نام میزبان باشد.';

  @override
  String get url_screen_invalid_url_error =>
      'یک نشانی اینترنتی معتبر با پروتکل پشتیبانی‌شده وارد کنید.';

  @override
  String get url_screen_subtitle => 'لطفاً آدرس پخش زنده را وارد کنید';

  @override
  String get url_screen_title => 'آدرس پخش زنده';

  @override
  String get url_screen_unsupported_scheme_error =>
      ' RTSP- und RTSPS-URLs unterstützt.';

  @override
  String get url_screen_url => 'آدرس';

  @override
  String get url_screen_url_empty_error =>
      'لطفاً نشانی اینترنتی پخش زنده را وارد کنید.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream یا rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'دوربین عقب';

  @override
  String get video_sources_camera => 'دوربین';

  @override
  String get video_sources_file => 'فایل';

  @override
  String get video_sources_front_camera => 'دوربین جلو';

  @override
  String get video_sources_live_stream => 'آدرس پخش زنده';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'برای استفاده از دوربین نیاز به مجوز دسترسی دارید';

  @override
  String get video_sources_screen_camera_not_found_title => 'دوربین پیدا نشد';

  @override
  String get video_sources_screen_import_error =>
      'وارد کردن فایل ویدیو انجام نشد.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'لطفاً به تنظیمات بروید و دسترسی به تصاویر را برای این برنامه مجاز کنید.';

  @override
  String get video_sources_screen_select_camera =>
      'برای انتخاب این دوربین ضربه بزنید';

  @override
  String get video_sources_screen_select_file => 'برای انتخاب فایل ضربه بزنید';

  @override
  String get video_sources_screen_select_live =>
      'برای تنظیم نشانی پخش زنده ضربه بزنید';

  @override
  String get video_sources_webcam => 'وب‌کم';
}
