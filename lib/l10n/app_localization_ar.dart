// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationAr extends AppLocalization {
  AppLocalizationAr([String locale = 'ar']) : super(locale);

  @override
  String get product_name => 'عداد الرؤية';

  @override
  String get product_desc => 'استخدام الرؤية الحاسوبية والذكاء الاصطناعي لعد الأشخاص والمركبات والحيوانات الأليفة والمزيد.';

  @override
  String get product_copyright => 'حقوق النشر © 2025';

  @override
  String get video_sources_webcam => 'كاميرا الويب';

  @override
  String get video_sources_live_stream => 'رابط البث المباشر';

  @override
  String get video_sources_file => 'ملف';

  @override
  String get video_sources_camera => 'الكاميرا';

  @override
  String get video_sources_camera_not_found_title => 'الكاميرا غير موجودة';

  @override
  String get video_sources_camera_not_found_message => 'يجب منح إذن استخدام الكاميرا لاستخدامها';

  @override
  String get video_sources_webcam_not_found_title => 'كاميرا الويب غير موجودة';

  @override
  String get video_sources_webcam_not_found_message => 'يرجى التحقق من توصيل كاميرا الويب';

  @override
  String get wizard_screen_desc => 'قم بإنشاء مشروع جديد أدناه للبدء في العد.';

  @override
  String get wizard_screen_new_project_from => 'مشروع جديد من';

  @override
  String get wizard_screen_language => 'اللغة';

  @override
  String get wizard_screen_about => 'حول';

  @override
  String get wizard_screen_open_projects_tip => 'سيتم حفظ جميع المشاريع محليًا تلقائيًا';

  @override
  String get wizard_screen_open_projects => 'فتح مشروع موجود';

  @override
  String get wizard_screen_email_us => 'راسلنا عبر البريد الإلكتروني';

  @override
  String get language_screen_language => 'اللغة';

  @override
  String get project_view_no_videos => 'لا يوجد مصدر فيديو متاح.';

  @override
  String get about_screen_title => 'حول';

  @override
  String get about_screen_platform => 'المنصة';

  @override
  String get about_screen_app_version => 'إصدار التطبيق';

  @override
  String get about_screen_models => 'نماذج كشف الأجسام';

  @override
  String get about_screen_benchmark => 'اختبار الأداء';

  @override
  String get about_screen_opencv_build_info => 'معلومات بناء OpenCV';

  @override
  String get benchmark_screen_title => 'اختبارات أداء النماذج';

  @override
  String get benchmark_screen_recommended => 'النموذج الموصى به';

  @override
  String get benchmark_screen_fps => 'إطار في الثانية';

  @override
  String get benchmark_screen_start_button => 'بدء اختبار الأداء';

  @override
  String get benchmark_screen_start_failed => 'فشل بدء اختبار الأداء، رمز الخطأ هو';

  @override
  String get benchmark_screen_models => 'نماذج كشف الأجسام';

  @override
  String get project_screen_title => 'المشروع';

  @override
  String get project_screen_exit_confirm_title => 'تأكيد الخروج من المشروع';

  @override
  String get project_screen_exit_confirm_content => 'مغادرة المشروع ستوقف العد. هل أنت متأكد أنك تريد المتابعة؟';

  @override
  String get project_screen_exit_button => 'خروج';

  @override
  String get project_screen_add_video_button => 'إضافة مصدر فيديو';

  @override
  String get project_screen_from_desc => 'نحتفظ بسجل دوار لمدة 24 ساعة، لذا يمكنك عرض أي شريحة زمنية تحتاجها.';

  @override
  String get project_screen_report_settings => 'الإعدادات';

  @override
  String get filter_screen_title => 'تصفية';

  @override
  String get filter_screen_desc => 'حدد نطاق تصفية من القائمة أدناه';

  @override
  String get filter_screen_error_title => 'تصفية';

  @override
  String get filter_screen_error_content => 'يجب أن يكون وقت الانتهاء أكبر من وقت البدء';

  @override
  String get filter_screen_error_custom => 'مخصص';

  @override
  String get filter_screen_error_start => 'البدء';

  @override
  String get filter_screen_error_end => 'الانتهاء';

  @override
  String get settings_screen_title => 'الإعدادات';

  @override
  String get settings_screen_desc => 'ضبط اسم المشروع، معلمات الكشف، مسح العد.';

  @override
  String get settings_screen_project_id => 'معرف المشروع';

  @override
  String get settings_screen_project_name => 'اسم المشروع';

  @override
  String get settings_screen_project_name_place_holder => '123 الشارع الرئيسي أو حي العليا';

  @override
  String get settings_screen_project_error => 'لا يمكن أن يكون اسم المشروع فارغًا';

  @override
  String get settings_screen_random_count_button => 'إضافة عدّات عشوائية';

  @override
  String get settings_screen_reset_count_header => 'إعادة تعيين جميع العدّات في هذا المشروع';

  @override
  String get settings_screen_reset_count_button => 'إعادة تعيين العدّات';

  @override
  String get settings_screen_reset_count_content => 'هل أنت متأكد أنك تريد إعادة تعيين جميع العدّات؟';

  @override
  String get settings_screen_delete_header => 'حذف هذا المشروع';

  @override
  String get settings_screen_delete_content => 'هل أنت متأكد أنك تريد حذف هذا المشروع؟';

  @override
  String get settings_screen_delete_button => 'حذف';

  @override
  String get settings_screen_center_point_title => 'نقطة المركز على الهدف';

  @override
  String get settings_screen_center_point_desc => 'تساعد نقطة المركز في تحديد ما إذا كان الهدف ضمن منطقة الإصابة.';

  @override
  String get settings_screen_center_point_button => 'عرض نقطة المركز على الهدف';

  @override
  String get settings_screen_lost_target_title => 'الهدف المفقود';

  @override
  String get settings_screen_lost_target_desc => 'عندما يفقد تتبع الكائن هدفًا، يجعل هذا الخيار الهدف مرئيًا. افتراضيًا، لا يتم عرض الأهداف المفقودة.';

  @override
  String get settings_screen_lost_target_button => 'عرض الهدف المفقود';

  @override
  String get detection_screen_title => 'إعدادات الكشف';

  @override
  String get detection_screen_models => 'النماذج';

  @override
  String get detection_screen_confidence => 'الثقة';

  @override
  String get detection_screen_confidence_desc => 'الثقة أعلى من #0 تعتبر كشفًا صالحًا';

  @override
  String get detection_screen_low => 'منخفض';

  @override
  String get detection_screen_high => 'مرتفع';

  @override
  String get detection_screen_nms => 'قمع غير الحد الأقصى';

  @override
  String get detection_screen_nms_desc => '#0 عتبة NMS المنخفضة (مثل 30٪) ستزيل المربعات المحيطة المتداخلة بشكل أكثر فعالية، بينما عتبة NMS الأعلى (مثل 0.6) ستسمح بتداخل أكبر';

  @override
  String get detection_screen_match => 'تطابق';

  @override
  String get detection_screen_match_desc => 'التطابق أعلى من #0 يعتبر نفس الكائن.';

  @override
  String get detection_screen_lost => 'مفقود';

  @override
  String get detection_screen_lost_desc => 'سيتم إزالة الكائن المتتبع إذا فُقد لمدة #0';

  @override
  String get detection_screen_consider_valid => 'اعتباره صالحًا بعد';

  @override
  String get detection_screen_consider_valid_desc => 'سيعتبر الكائن المتتبع صالحًا بعد #0';

  @override
  String get detection_screen_reset => 'إعادة تعيين';

  @override
  String get detection_screen_reset_content => 'هل أنت متأكد أنك تريد إعادة تعيين إعدادات الكشف؟';

  @override
  String get url_screen_title => 'رابط البث المباشر';

  @override
  String get url_screen_desc => 'الرجاء إدخال رابط البث المباشر';

  @override
  String get url_screen_url => 'الرابط';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream أو rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'إضافة مصدر فيديو';

  @override
  String get add_video_screen_from => 'إضافة مصدر فيديو من';

  @override
  String get webcam_screen_add_title => 'إضافة كاميرا ويب';

  @override
  String get webcam_screen_edit_title => 'اختيار كاميرا ويب';

  @override
  String get webcam_manager_webcam => 'كاميرا ويب';

  @override
  String get camera_screen_front_camera => 'الكاميرا الأمامية';

  @override
  String get camera_screen_back_camera => 'الكاميرا الخلفية';

  @override
  String get camera_screen_add_title => 'إضافة كاميرا';

  @override
  String get camera_screen_edit_title => 'اختيار كاميرا';

  @override
  String get camera_screen_zoom_level => 'مستوى التكبير';

  @override
  String get video_screen_name_empty => 'لا يمكن أن يكون اسم الفيديو فارغًا.';

  @override
  String get video_screen_desc => 'إدارة مصادر الفيديو، إضافة أو تعديل مناطق الكشف.';

  @override
  String get video_screen_video_name => 'اسم مصدر الفيديو';

  @override
  String get video_screen_edit_placeholder => 'كاميرا الباب الأمامي أو كاميرا موقف السيارات';

  @override
  String get video_screen_change_file => 'تغيير الملف';

  @override
  String get video_screen_add_zone => 'إضافة منطقة كشف';

  @override
  String get video_screen_zones => 'مناطق الكشف';

  @override
  String get video_screen_zones_desc => 'استخدم السحب والإفلات لتعديل المناطق';

  @override
  String get video_screen_tools => 'الأدوات';

  @override
  String get video_screen_move_bottom => 'نقل المنطقة الحالية إلى الأسفل';

  @override
  String get video_screen_add_point => 'إضافة نقطة إلى المنطقة الحالية';

  @override
  String get video_screen_remove_point => 'إزالة نقطة من المنطقة الحالية';

  @override
  String get video_screen_playback_speed => 'سرعة التشغيل';

  @override
  String get video_screen_playback_current => 'الحالي: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'حذف مصدر الفيديو هذا';

  @override
  String get video_screen_delete_content => 'هل أنت متأكد أنك تريد حذف مصدر الفيديو هذا؟';

  @override
  String get video_screen_delete_button => 'حذف';

  @override
  String get video_screen_sources => 'تكوين مصدر الصورة، أهداف الكشف، ومعلمات النموذج.';

  @override
  String get video_screen_targets => 'أهداف الكشف';

  @override
  String get video_screen_detection => 'معلمات النموذج';

  @override
  String get color_screen_title => 'اختر لونًا';

  @override
  String get zone_screen_desc => 'يمكن لمنطقة الكشف تحديد أنواع الكائنات المراد اكتشافها واختيار العدادات التي سيتم عرضها، مثل تم الكشف، تم الظهور، ودخل.';

  @override
  String get zone_screen_name_placeholder => 'اسم المنطقة، مثل الرصيف أو موقف السيارات';

  @override
  String get zone_screen_zone_color => 'لون المنطقة';

  @override
  String get zone_screen_color => 'اللون';

  @override
  String get zone_screen_delete_header => 'حذف هذه المنطقة';

  @override
  String get zone_screen_delete_content => 'هل أنت متأكد أنك تريد حذف هذه المنطقة؟';

  @override
  String get zone_screen_delete_button => 'حذف';

  @override
  String get zone_screen_can_not_delete => 'لا يمكن حذف المنطقة';

  @override
  String get zone_screen_one_zone_required => 'مطلوب منطقة واحدة على الأقل.';

  @override
  String get zone_screen_zone_name_required => 'لا يمكن أن يكون اسم المنطقة فارغًا';

  @override
  String get counter_screen_show_on => 'عرض على الشاشة';

  @override
  String get counter_screen_enabled => 'مفعّل';

  @override
  String get counter_screen_reentry_threshold => 'عتبة إعادة الدخول';

  @override
  String get counter_screen_reentry_desc => 'يجب أن تدخل الكائنات #0 مرات، مع وقت تهدئة #1 ثانية بين كل خروج وإعادة دخول، لتفعيل إعادة الدخول';

  @override
  String get counter_screen_reentry_title => 'عد إعادة الدخول';

  @override
  String get counter_screen_cooldown_threshold => 'عتبة التهدئة';

  @override
  String get counter_screen_cooldown_desc => 'تتطلب إعادة الدخول وقت تهدئة #0 ثانية بعد الخروج من منطقة الكشف';

  @override
  String get counter_screen_cooldown_time => 'وقت التهدئة';

  @override
  String get counter_screen_cooldown_in_seconds => 'بالثواني';

  @override
  String get counter_screen_stagnant_threshold => 'عتبة الركود';

  @override
  String get counter_screen_stagnant_desc => 'الكائنات التي تبقى ثابتة لأكثر من #0 ثانية ستعتبر راكدة';

  @override
  String get counter_screen_stagnant_consider => 'اعتبارها راكدة';

  @override
  String get counter_screen_stagnant_in_seconds => 'بالثواني';

  @override
  String get counter_screen_stagnant_desc_prefix => 'بادئة الوصف';

  @override
  String get counter_screen_stagnant_desc_suffix => 'لاحقة الوصف';

  @override
  String get counter_screen_name_error => 'لا يمكن أن يكون اسم العداد فارغًا';

  @override
  String get counter_screen_enabled_error => 'خطأ';

  @override
  String get counter_screen_enabled_error_content => 'تحتاج إلى تفعيل عداد آخر أولاً، ثم يمكنك تعطيل هذا العداد';

  @override
  String get objects_screen_title => 'الكائنات';

  @override
  String get objects_screen_desc => 'اختر أهداف الكشف مثل شخص، سيارة، حافلة، إلخ.';

  @override
  String get open_project_screen_title => 'فتح مشروع';

  @override
  String get open_project_screen_desc => 'افتح المشاريع التي تم إنشاؤها سابقًا، مع الاحتفاظ بأحدث 20 مشروعًا فقط.';

  @override
  String get open_project_screen_no_project => 'لم يتم العثور على مشروع.';

  @override
  String get default_project_name => 'مشروع';

  @override
  String get default_video_name => 'مصدر فيديو';

  @override
  String get default_zone_name => 'منطقة كشف';

  @override
  String get error_oops => 'عذرًا، حدث خطأ ما';

  @override
  String get error_content => 'حدث خطأ غير متوقع. هل ترغب في إرسال تقرير بالبريد الإلكتروني؟';

  @override
  String get error_report => 'راسلنا عبر البريد الإلكتروني';

  @override
  String get submit => 'إرسال';

  @override
  String get ok => 'موافق';

  @override
  String get cancel => 'إلغاء';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get close => 'إغلاق';

  @override
  String get back => 'رجوع';
}
