// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class LocalizationHe extends Localization {
  LocalizationHe([String locale = 'he']) : super(locale);

  @override
  String get product_name => 'מונה';

  @override
  String get product_desc => 'שימוש בראייה ממוחשבת ובינה מלאכותית לספירת אנשים, כלי רכב, חיות מחמד ועוד.';

  @override
  String get product_copyright => 'כל הזכויות שמורות © 2025';

  @override
  String get video_sources_webcam => 'מצלמת רשת';

  @override
  String get video_sources_live_stream => 'כתובת שידור חי';

  @override
  String get video_sources_file => 'קובץ';

  @override
  String get video_sources_camera => 'מצלמה';

  @override
  String get video_sources_camera_not_found_title => 'מצלמה לא נמצאה';

  @override
  String get video_sources_camera_not_found_message => 'יש לאשר הרשאת מצלמה כדי להשתמש במצלמה';

  @override
  String get video_sources_webcam_not_found_title => 'מצלמת רשת לא נמצאה';

  @override
  String get video_sources_webcam_not_found_message => 'אנא בדוק אם יש מצלמת רשת מחוברת';

  @override
  String get wizard_screen_desc => 'צור פרויקט חדש למטה כדי להתחיל בספירה.';

  @override
  String get wizard_screen_new_project_from => 'פרויקט חדש מ-';

  @override
  String get wizard_screen_language => 'שפה';

  @override
  String get wizard_screen_about => 'אודות';

  @override
  String get wizard_screen_open_projects_tip => 'כל הפרויקטים יישמרו מקומית באופן אוטומטי';

  @override
  String get wizard_screen_open_projects => 'פתח פרויקט קיים';

  @override
  String get wizard_screen_email_us => 'שלח לנו אימייל';

  @override
  String get language_screen_language => 'שפה';

  @override
  String get project_view_no_videos => 'אין מקור וידאו זמין.';

  @override
  String get about_screen_title => 'אודות';

  @override
  String get about_screen_platform => 'פלטפורמה';

  @override
  String get about_screen_app_version => 'גרסת אפליקציה';

  @override
  String get about_screen_models => 'מודלים לזיהוי עצמים';

  @override
  String get about_screen_benchmark => 'בדיקות ביצועים';

  @override
  String get about_screen_opencv_build_info => 'מידע בנייה OpenCV';

  @override
  String get benchmark_screen_title => 'בדיקות ביצועי מודלים';

  @override
  String get benchmark_screen_recommended => 'מודל מומלץ';

  @override
  String get benchmark_screen_fps => 'פריימים לשנייה';

  @override
  String get benchmark_screen_start_button => 'התחל בדיקת ביצועים';

  @override
  String get benchmark_screen_start_failed => 'נכשל בהפעלת בדיקת ביצועים, קוד השגיאה הוא';

  @override
  String get benchmark_screen_models => 'מודלים לזיהוי עצמים';

  @override
  String get project_screen_title => 'פרויקט';

  @override
  String get project_screen_exit_confirm_title => 'אשר יציאה מהפרויקט';

  @override
  String get project_screen_exit_confirm_content => 'עזיבת הפרויקט תפסיק את הספירה. האם אתה בטוח שברצונך להמשיך?';

  @override
  String get project_screen_exit_button => 'יציאה';

  @override
  String get project_screen_add_video_button => 'הוסף מקור וידאו';

  @override
  String get project_screen_from_desc => 'אנו שומרים רשומה מתגלגלת של 24 שעות, כך שתוכל לצפות בכל פרק זמן שתצטרך.';

  @override
  String get project_screen_report_settings => 'הגדרות';

  @override
  String get filter_screen_title => 'סינון';

  @override
  String get filter_screen_desc => 'בחר טווח סינון מהרשימה למטה';

  @override
  String get filter_screen_error_title => 'סינון';

  @override
  String get filter_screen_error_content => 'זמן הסיום חייב להיות גדול מזמן ההתחלה';

  @override
  String get filter_screen_error_custom => 'מותאם אישית';

  @override
  String get filter_screen_error_start => 'התחלה';

  @override
  String get filter_screen_error_end => 'סיום';

  @override
  String get settings_screen_title => 'הגדרות';

  @override
  String get settings_screen_desc => 'הגדר שם פרויקט, פרמטרים לזיהוי, איפוס ספירה.';

  @override
  String get settings_screen_project_id => 'מזהה פרויקט';

  @override
  String get settings_screen_project_name => 'שם פרויקט';

  @override
  String get settings_screen_project_name_place_holder => 'רחוב הרצל 123 או שדרות רוטשילד';

  @override
  String get settings_screen_project_error => 'שם הפרויקט אינו יכול להיות ריק';

  @override
  String get settings_screen_random_count_button => 'הוסף ספירות אקראיות';

  @override
  String get settings_screen_reset_count_header => 'אפס את כל הספירות בפרויקט זה';

  @override
  String get settings_screen_reset_count_button => 'אפס ספירות';

  @override
  String get settings_screen_reset_count_content => 'האם אתה בטוח שברצונך לאפס את כל הספירות?';

  @override
  String get settings_screen_delete_header => 'מחק פרויקט זה';

  @override
  String get settings_screen_delete_content => 'האם אתה בטוח שברצונך למחוק פרויקט זה?';

  @override
  String get settings_screen_delete_button => 'מחק';

  @override
  String get settings_screen_center_point_title => 'נקודת מרכז על המטרה';

  @override
  String get settings_screen_center_point_desc => 'נקודת המרכז עוזרת לקבוע אם המטרה נמצאת באזור הפגיעה.';

  @override
  String get settings_screen_center_point_button => 'הצג נקודת מרכז על המטרה';

  @override
  String get settings_screen_lost_target_title => 'מטרה אבודה';

  @override
  String get settings_screen_lost_target_desc => 'כאשר מעקב אחר אובייקט מאבד מטרה, אפשרות זו הופכת אותה לגלויה. כברירת מחדל, מטרות אבודות אינן מוצגות.';

  @override
  String get settings_screen_lost_target_button => 'הצג מטרה אבודה';

  @override
  String get detection_screen_title => 'הגדרות זיהוי';

  @override
  String get detection_screen_models => 'מודלים';

  @override
  String get detection_screen_confidence => 'רמת ביטחון';

  @override
  String get detection_screen_confidence_desc => 'רמת ביטחון מעל #0 נחשבת כזיהוי תקין';

  @override
  String get detection_screen_low => 'נמוך';

  @override
  String get detection_screen_high => 'גבוה';

  @override
  String get detection_screen_nms => 'דיכוי לא-מקסימלי';

  @override
  String get detection_screen_nms_desc => '#0 סף NMS נמוך יותר (למשל 30%) יסיר באופן אגרסיבי יותר תיבות חופפות, בעוד שסף NMS גבוה יותר (למשל 0.6) יאפשר יותר חפיפה';

  @override
  String get detection_screen_match => 'התאמה';

  @override
  String get detection_screen_match_desc => 'התאמה מעל #0 נחשבת לאותו אובייקט.';

  @override
  String get detection_screen_lost => 'אבוד';

  @override
  String get detection_screen_lost_desc => 'מעקב אחר אובייקט יוסר אם הוא אבוד למשך #0';

  @override
  String get detection_screen_consider_valid => 'החשב כתקף אחרי';

  @override
  String get detection_screen_consider_valid_desc => 'מעקב אחר אובייקט ייחשב כתקף אחרי #0';

  @override
  String get detection_screen_reset => 'איפוס';

  @override
  String get detection_screen_reset_content => 'האם אתה בטוח שברצונך לאפס את הגדרות הזיהוי?';

  @override
  String get url_screen_title => 'כתובת שידור חי';

  @override
  String get url_screen_desc => 'אנא הזן את כתובת השידור החי';

  @override
  String get url_screen_url => 'כתובת URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream או rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'הוסף מקור וידאו';

  @override
  String get add_video_screen_from => 'הוסף מקור וידאו מ-';

  @override
  String get webcam_screen_add_title => 'הוסף מצלמת רשת';

  @override
  String get webcam_screen_edit_title => 'בחר מצלמת רשת';

  @override
  String get webcam_manager_webcam => 'מצלמת רשת';

  @override
  String get camera_screen_front_camera => 'מצלמה קדמית';

  @override
  String get camera_screen_back_camera => 'מצלמה אחורית';

  @override
  String get camera_screen_add_title => 'הוסף מצלמה';

  @override
  String get camera_screen_edit_title => 'בחר מצלמה';

  @override
  String get camera_screen_zoom_level => 'רמת זום';

  @override
  String get video_screen_name_empty => 'שם הוידאו אינו יכול להיות ריק.';

  @override
  String get video_screen_desc => 'נהל מקורות וידאו, הוסף או שנה אזורי זיהוי.';

  @override
  String get video_screen_video_name => 'שם מקור וידאו';

  @override
  String get video_screen_edit_placeholder => 'מצלמת דלת כניסה או מצלמת חניון';

  @override
  String get video_screen_change_file => 'שנה קובץ';

  @override
  String get video_screen_add_zone => 'הוסף אזור זיהוי';

  @override
  String get video_screen_zones => 'אזורי זיהוי';

  @override
  String get video_screen_zones_desc => 'השתמש בגרור ושחרר כדי להתאים אזורים';

  @override
  String get video_screen_tools => 'כלים';

  @override
  String get video_screen_move_bottom => 'העבר את האזור הנוכחי לתחתית';

  @override
  String get video_screen_add_point => 'הוסף נקודה לאזור הנוכחי';

  @override
  String get video_screen_remove_point => 'הסר נקודה מהאזור הנוכחי';

  @override
  String get video_screen_playback_speed => 'מהירות הפעלה';

  @override
  String get video_screen_playback_current => 'נוכחי: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'מחק מקור וידאו זה';

  @override
  String get video_screen_delete_content => 'האם אתה בטוח שברצונך למחוק מקור וידאו זה?';

  @override
  String get video_screen_delete_button => 'מחק';

  @override
  String get video_screen_sources => 'הגדר מקור תמונה, מטרות זיהוי ופרמטרים של מודל.';

  @override
  String get video_screen_targets => 'מטרות זיהוי';

  @override
  String get video_screen_detection => 'פרמטרים של מודל';

  @override
  String get color_screen_title => 'בחר צבע';

  @override
  String get zone_screen_desc => 'אזור הזיהוי יכול להגדיר את סוגי האובייקטים לזיהוי ולבחור אילו מונים להציג, כגון זוהה, נוצר ונכנס.';

  @override
  String get zone_screen_name_placeholder => 'שם האזור, כמו מדרכה או חניון';

  @override
  String get zone_screen_zone_color => 'צבע אזור';

  @override
  String get zone_screen_color => 'צבע';

  @override
  String get zone_screen_delete_header => 'מחק אזור זה';

  @override
  String get zone_screen_delete_content => 'האם אתה בטוח שברצונך למחוק אזור זה?';

  @override
  String get zone_screen_delete_button => 'מחק';

  @override
  String get zone_screen_can_not_delete => 'לא ניתן למחוק אזור';

  @override
  String get zone_screen_one_zone_required => 'נדרש לפחות אזור אחד.';

  @override
  String get zone_screen_zone_name_required => 'שם האזור אינו יכול להיות ריק';

  @override
  String get counter_screen_show_on => 'הצג על המסך';

  @override
  String get counter_screen_enabled => 'מופעל';

  @override
  String get counter_screen_reentry_threshold => 'סף כניסה חוזרת';

  @override
  String get counter_screen_reentry_desc => 'אובייקטים חייבים להיכנס #0 פעמים, עם זמן צינון של #1 שניות בין כל יציאה וכניסה מחודשת, כדי להפעיל כניסה חוזרת';

  @override
  String get counter_screen_reentry_title => 'ספירת כניסה חוזרת';

  @override
  String get counter_screen_cooldown_threshold => 'סף צינון';

  @override
  String get counter_screen_cooldown_desc => 'כניסה חוזרת דורשת זמן צינון של #0 שניות לאחר יציאה מאזור הזיהוי';

  @override
  String get counter_screen_cooldown_time => 'זמן צינון';

  @override
  String get counter_screen_cooldown_in_seconds => 'בשניות';

  @override
  String get counter_screen_stagnant_threshold => 'סף קיפאון';

  @override
  String get counter_screen_stagnant_desc => 'אובייקטים שנשארים במקום למשך יותר מ-#0 שניות ייחשבו כקפואים';

  @override
  String get counter_screen_stagnant_consider => 'החשב כקפוא';

  @override
  String get counter_screen_stagnant_in_seconds => 'בשניות';

  @override
  String get counter_screen_stagnant_desc_prefix => 'קידומת תיאור';

  @override
  String get counter_screen_stagnant_desc_suffix => 'סיומת תיאור';

  @override
  String get counter_screen_name_error => 'שם המונה אינו יכול להיות ריק';

  @override
  String get counter_screen_enabled_error => 'שגיאה';

  @override
  String get counter_screen_enabled_error_content => 'עליך להפעיל מונה אחר תחילה, ואז תוכל להשבית מונה זה';

  @override
  String get objects_screen_title => 'אובייקטים';

  @override
  String get objects_screen_desc => 'בחר מטרות זיהוי כמו אדם, מכונית, אוטובוס וכו\'.';

  @override
  String get open_project_screen_title => 'פתח פרויקט';

  @override
  String get open_project_screen_desc => 'פתח פרויקטים שנוצרו בעבר, שומר רק את 20 האחרונים.';

  @override
  String get open_project_screen_no_project => 'לא נמצא פרויקט.';

  @override
  String get default_project_name => 'פרויקט';

  @override
  String get default_video_name => 'מקור וידאו';

  @override
  String get default_zone_name => 'אזור זיהוי';

  @override
  String get error_oops => 'אופס, משהו השתבש';

  @override
  String get error_content => 'אירעה שגיאה בלתי צפויה. האם תרצה לשלוח דוח באימייל?';

  @override
  String get error_report => 'שלח לנו אימייל';

  @override
  String get submit => 'שלח';

  @override
  String get ok => 'אישור';

  @override
  String get cancel => 'ביטול';

  @override
  String get yes => 'כן';

  @override
  String get no => 'לא';

  @override
  String get close => 'סגור';

  @override
  String get back => 'חזור';

  @override
  String get zone_screen_zone => 'אזור';

  @override
  String get zone_screen_zone_show_summary => 'הצג סיכום על המסך';

  @override
  String get video_sources_photos_denied => 'גישה לתמונות נדחתה';
}
