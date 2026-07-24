// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class LocalizationHe extends Localization {
  LocalizationHe([String locale = 'he']) : super(locale);

  @override
  String get about_screen_app_version => 'גרסת אפליקציה';

  @override
  String get about_screen_email_us => 'שלח לנו אימייל';

  @override
  String get about_screen_platform => 'פלטפורמה';

  @override
  String get appeared => 'הופיעו';

  @override
  String get appeared_help =>
      'סופר אנשים או כלי רכב שהמיקום הראשון שזוהה עבורם היה בתוך אזור זה.\\n\\nמסייע להבין היכן מתחיל המעקב.\\n\\n(מיועד בעיקר למשתמשים מתקדמים)';

  @override
  String get average_occupancy => 'תפוסה ממוצעת';

  @override
  String get average_occupancy_help =>
      'מציג את מספר האנשים או כלי הרכב הממוצע באזור זה במהלך חלון הספירה הנוכחי.\\n\\nמסייע להבין עד כמה האזור היה עמוס לאורך כל חלון הספירה.';

  @override
  String get average_stay => 'משך שהייה ממוצע';

  @override
  String get average_stay_help =>
      'מציג את משך השהייה הממוצע של אנשים או כלי רכב באזור זה.\\n\\nמשך שהייה ממוצע ארוך יותר עשוי להעיד שלקוחות מבלים יותר זמן באזור זה.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter משתמש במצלמה וב-AI שפועל במכשיר כדי לספור אנשים. תחילה נוודא שהמכשיר שלך תואם.';

  @override
  String get camera_test_screen_instruction =>
      'כוונו את המצלמה לעבר אנשים. האפליקציה תציג מסגרות סביב כל אדם שתזהה.';

  @override
  String get camera_test_screen_next => 'הקישו על הבא כדי להמשיך.';

  @override
  String get camera_test_screen_start =>
      'הקישו על התחל. אם תתבקשו, אפשרו גישה למצלמה.';

  @override
  String get camera_test_screen_test_failed => 'הבדיקה נכשלה!';

  @override
  String get camera_test_screen_test_passed => 'הבדיקה הצליחה!';

  @override
  String get camera_test_screen_title => 'בדיקת מצלמת AI';

  @override
  String get camera_test_screen_wait => 'ממתין ל-AI שיזהה אנשים…';

  @override
  String get cta_screen_custom => 'השתמש בשרת שלך';

  @override
  String get cta_screen_custom_help =>
      'שלח נתוני תנועה ישירות לשרת או למסד הנתונים שלך.';

  @override
  String get cta_screen_footer =>
      'בהמשך, אתה מסכים לתנאי השירות, למדיניות הפרטיות ולהסכם עיבוד הנתונים.';

  @override
  String get cta_screen_invitation => 'השתמש בקוד הזמנה';

  @override
  String get cta_screen_invitation_help =>
      'הצטרפו לארגון קיים באמצעות הזמנה מהמנהל.';

  @override
  String get cta_screen_local => 'במכשיר זה בלבד';

  @override
  String get cta_screen_local_help =>
      'שמור את נתוני התנועה רק במכשיר זה. שום דבר לא מועלה.';

  @override
  String get cta_screen_piyuo => 'השתמש ב-Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'שמור נתוני תנועה ב-Piyuo Cloud עם לוחות מחוונים ותובנות עסקיות.';

  @override
  String get cta_screen_premium => 'פרימיום';

  @override
  String get cta_screen_title =>
      'Piyuo Counter יוצר סטטיסטיקות תנועה אנונימיות כל 5 דקות.\\nבחר כיצד ברצונך לשמור ולגשת לנתונים שלך.';

  @override
  String get current_occupancy => 'מספר נוכחי';

  @override
  String get current_occupancy_help =>
      'מציג את המספר הנוכחי של אנשים או כלי רכב באזור זה.\\n\\nהמספר מתעדכן בזמן אמת ומסייע לוודא שזיהוי ה-AI תואם למה שמופיע על המסך. הוא אינו נכלל בנתוני הטלמטריה הנשלחים.';

  @override
  String get custom_server_screen_bearer_saving_action => 'שומר...';

  @override
  String get custom_server_screen_server_url_label => 'כתובת השרת';

  @override
  String get detection_screen_confidence => 'סף ביטחון';

  @override
  String get detection_screen_confidence_dialog =>
      'קובע עד כמה הבינה המלאכותית צריכה להיות בטוחה לפני ספירת אדם או רכב.\\nערכים נמוכים יותר\\n• מזהים יותר אובייקטים\\n• טובים יותר לאובייקטים רחוקים או חלקית מוסתרים\\n• עלולים להגביר זיהויים שגויים\\nערכים גבוהים יותר\\n• סופרים רק זיהויים בביטחון גבוה\\n• מפחיתים זיהויים שגויים\\n• עלולים לפספס אובייקטים קטנים או קשים\\nהשתמש בערך נמוך יותר אם האפליקציה מפספסת אנשים או רכבים.\\nהשתמש בערך גבוה יותר אם האפליקציה סופרת צללים, השתקפויות או אובייקטים שגויים אחרים.';

  @override
  String get detection_screen_confidence_help =>
      'רמת הביטחון המינימלית הנדרשת לזיהוי אובייקט.';

  @override
  String get detection_screen_confidence_max_label => 'מחמיר';

  @override
  String get detection_screen_confidence_min_label => 'גמיש';

  @override
  String get detection_screen_disappear => 'פסק זמן להיעלמות';

  @override
  String get detection_screen_disappear_dialog =>
      'קובע כמה זמן הבינה המלאכותית ממתינה לפני סימון אובייקט כנעלם לאחר שהוא כבר לא מזוהה.\\nערכים קצרים יותר\\n• מסמנים אובייקטים כנעלמים מהר יותר\\n• טובים יותר לתנועה מהירה\\n• עלולים לסמן אובייקטים שהוסתרו זמנית כנעלמים\\nערכים ארוכים יותר\\n• ממתינים זמן רב יותר לפני סימון אובייקטים כנעלמים\\n• טובים יותר כשאובייקטים חסומים או מפוספסים לזמן קצר\\n• מעכבים אירועי היעלמות';

  @override
  String get detection_screen_disappear_help =>
      'משך הזמן שה-AI ממתין לפני סימון אובייקט כנעלם לאחר שהוא מפסיק לזהות אותו.';

  @override
  String get detection_screen_disappear_max_label => 'איטי';

  @override
  String get detection_screen_disappear_min_label => 'מהיר';

  @override
  String get detection_screen_memory_dialog =>
      'קובע כמה זמן הבינה המלאכותית זוכרת אובייקט לאחר שהוא נעלם.\\nהגדל ערך זה אם אנשים או רכבים מוסתרים לעיתים קרובות מאחורי אובייקטים אחרים.\\nהקטן ערך זה אם אובייקטים מקושרים בטעות לאחר עזיבת הזירה.';

  @override
  String get detection_screen_min_presence => 'זמן נוכחות מינימלי';

  @override
  String get detection_screen_min_presence_help =>
      'אובייקט חייב להישאר גלוי לפני שייספר. ערכים גבוהים יותר מסייעים להפחית זיהויים שגויים קצרים.';

  @override
  String get detection_screen_min_presence_max_label => 'בטוח יותר';

  @override
  String get detection_screen_min_presence_min_label => 'מהיר יותר';

  @override
  String get detection_screen_minimum_visible =>
      'אובייקטים חייבים להישאר גלויים למשך זמן זה לפני שהם נספרים.\\nהגדל ערך זה כדי להתעלם מזיהויים שגויים קצרים.\\nהקטן ערך זה אם אנשים או רכבים נעים במהירות מפוספסים.';

  @override
  String get detection_screen_new_track => 'סף התחלת מעקב';

  @override
  String get detection_screen_new_track_help =>
      'רמת הביטחון המינימלית להתחלת מעקב אחר אובייקט חדש. ערכים נמוכים עלולים ליצור מעקבים כפולים.';

  @override
  String get detection_screen_new_track_max_label => 'שמרני';

  @override
  String get detection_screen_new_track_min_label => 'אגרסיבי';

  @override
  String get detection_screen_reset => 'איפוס';

  @override
  String get detection_screen_reset_content =>
      'האם אתה בטוח שברצונך לאפס את הגדרות הזיהוי?';

  @override
  String get detection_screen_show_track_id => 'הצג את ID המעקב';

  @override
  String get detection_screen_show_track_id_help =>
      'הפעל אפשרות זו כדי להציג מזהי עקיבה ייחודיים לכל אובייקט שעוקב אחריו.';

  @override
  String get detection_screen_stay => 'זמן שהייה';

  @override
  String get detection_screen_stay_help =>
      'משך הזמן שאובייקט חייב להישאר באזור לפני שייחשב כשהייה.';

  @override
  String get detection_screen_stay_max_label => 'מושהה';

  @override
  String get detection_screen_stay_min_label => 'מיידי';

  @override
  String get detection_screen_stay_threshold =>
      'קובע מתי אובייקט תורם לספירת \\שהייה\\.\\nערכים קצרים יותר\\n• סופרים שהייה מיד\\n• טובים יותר לניתוח מהיר\\nערכים ארוכים יותר\\n• מתעלמים ממעבר קצר\\n• טובים יותר למדידת תפוסה';

  @override
  String get detection_screen_subtitle =>
      'כוון כיצד הבינה המלאכותית מזהה ועוקבת אחר אובייקטים';

  @override
  String get detection_screen_title => 'מעקב וספירה';

  @override
  String get detection_screen_track_dialog =>
      'קובע מתי אובייקט שזוהה לאחרונה הופך למסלול מעקב חדש.\\nערכים נמוכים יותר\\n• המעקב מתחיל מוקדם יותר\\n• טובים יותר לאובייקטים נעים במהירות\\n• עלולים ליצור מסלולים כפולים\\nערכים גבוהים יותר\\n• דורשים הוכחה חזקה יותר לפני יצירת מסלול חדש\\n• מפחיתים מסלולים כפולים\\n• עלולים לעכב מעקב אחר אובייקטים חדשים';

  @override
  String get detection_screen_track_memory => 'זיכרון מעקב';

  @override
  String get detection_screen_track_memory_help =>
      'משך הזמן להמשך מעקב אחרי אובייקט לאחר שאבד זמנית. ערכים גבוהים מסייעים בהתאוששות לאחר הסתרה קצרה.';

  @override
  String get detection_screen_track_memory_max_label => 'ארוך';

  @override
  String get detection_screen_track_memory_min_label => 'קצר';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter משתמש במצלמה שלך כדי לזהות הולכי רגל וכלי רכב בזמן אמת. למכשיר זה אין מצלמה זמינה.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'נסה לפתוח את האפליקציה בטלפון שלך';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'סמארטפון או טאבלט עם מצלמה';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'מומלץ מכשיר iOS או Android';

  @override
  String get device_not_supported_screen_requirements_title => 'מה צריך';

  @override
  String get device_not_supported_screen_title => 'לא נמצאה מצלמה';

  @override
  String get disappeared => 'נעלמו';

  @override
  String get disappeared_help =>
      'סופר אנשים או כלי רכב שהמיקום האחרון שזוהה עבורם היה בתוך אזור זה.\\n\\nהמעקב מסתיים לאחר זמן ההיעלמות שהוגדר אם האדם או כלי הרכב אינם מזוהים עוד.\\n\\n(מיועד בעיקר למשתמשים מתקדמים)';

  @override
  String get dpa => 'הסכם עיבוד נתונים';

  @override
  String get durationDaysShort => '%sי';

  @override
  String get durationHoursShort => '%sשע';

  @override
  String get durationMinutesShort => '%sדק';

  @override
  String get durationSecondsShort => '%sשנ';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'נכנסו';

  @override
  String get entered_help =>
      'סופר אנשים או כלי רכב שנכנסו לאזור זה במהלך חלון הספירה הנוכחי.\\n\\nכניסה נספרת כאשר אדם או כלי רכב עוברים מחוץ לאזור אל תוך האזור.';

  @override
  String get exited => 'יצאו';

  @override
  String get exited_help =>
      'סופר אנשים או כלי רכב שיצאו מאזור זה במהלך חלון הספירה הנוכחי.\\n\\nיציאה נספרת כאשר אדם או כלי רכב עוברים מתוך האזור אל מחוצה לו.';

  @override
  String get language_screen_language => 'שפה';

  @override
  String get language_screen_subtitle => 'בחר את השפה שבה תשתמש האפליקציה.';

  @override
  String get local_only_screen_body =>
      'מצב \'מכשיר מקומי בלבד\' מאפשר לך לנסות זיהוי ומעקב מצלמה מבוסס בינה מלאכותית מבלי להעלות נתונים. כל נתוני התנועה מעובדים רק במכשיר הזה, מושלם לבדיקה לפני חיבור לשרת.';

  @override
  String get local_only_screen_use_action => 'השתמש במכשיר המקומי בלבד';

  @override
  String get local_screen_text =>
      'Piyuo Counter יפעל כולו במכשיר זה.\\nנתוני הסטטיסטיקה יישמרו במכשיר זה בלבד ולא יועלו.\\nבהמשך תוכל להתחבר ל-Piyuo Cloud או לשרת שלך דרך ההגדרות.';

  @override
  String get maximum_occupancy => 'תפוסה מרבית';

  @override
  String get maximum_occupancy_help =>
      'מציג את המספר הגבוה ביותר של אנשים או כלי רכב שנמצאו באזור זה בו-זמנית במהלך חלון הספירה הנוכחי.\\n\\nמסייע לזהות זמני עומס או שיאי תנועה.';

  @override
  String get maximum_stay => 'משך שהייה מרבי';

  @override
  String get maximum_stay_help =>
      'מציג את משך השהייה הארוך ביותר של אדם או כלי רכב באזור זה במהלך חלון הספירה הנוכחי.\\n\\nמסייע לזהות ביקורים או עצירות ארוכים במיוחד.';

  @override
  String get metric_events => 'אירועים';

  @override
  String get metric_live => 'בשידור חי';

  @override
  String get metric_show_less => 'הצג פחות';

  @override
  String get metric_show_more => 'הצג עוד';

  @override
  String get metric_statistics => 'סטטיסטיקות';

  @override
  String get metrics_counting_all => 'הכול';

  @override
  String get metrics_counting_done => 'הושלם';

  @override
  String get metrics_counting_in_progress => 'בתהליך';

  @override
  String get metrics_counting_missing => 'חסר';

  @override
  String get metrics_counting_window => 'סטטיסטיקות לכל פרק זמן של 5 דקות';

  @override
  String get onboarding_back_action => 'חזרה';

  @override
  String get onboarding_cta_no_server => 'מעדיפים לא להעלות נתונים?';

  @override
  String get onboarding_cta_title => 'לאן יישלחו הנתונים שלך?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter משתמש במצלמה של המכשיר שלך ובבינה מלאכותית מובנית כדי לזהות אנשים ורכבים בזמן אמת.\\nבזכות טכנולוגיית זיהוי ומעקב, הוא סופר אוטומטית תנועת הולכי רגל ורכבים — הכול קורה ישירות במכשיר שלך.';

  @override
  String get onboarding_intro_text2 =>
      'כל עיבוד ה-AI מתבצע מקומית במכשיר שלך. שום וידאו, תמונות, פרצופים או זהויות לא מועלים.\\nרק סיכומים אנונימיים כל 5 דקות משותפים, כולל ספירות, תפוסה, כניסות, יציאות וזמן שהייה.';

  @override
  String get onboarding_intro_text3 =>
      'פשוט הפעל את האפליקציה והשאר אותה פועלת. Piyuo Counter אוסף ושומר נתוני תנועה באופן רציף ואוטומטי.\\nסיכומי הנתונים נשמרים כל 5 דקות ומועלים כל שעה ל-Piyuo Cloud או לשרת שלך.';

  @override
  String get onboarding_intro_title1 => 'ספירת תנועה באמצעות AI';

  @override
  String get onboarding_intro_title2 => 'פרטיות תחילה';

  @override
  String get onboarding_intro_title3 => 'פועל אוטומטית 24/7';

  @override
  String get onboarding_next_action => 'הבא';

  @override
  String get onboarding_skip_action => 'דלג על ההקדמה';

  @override
  String get onboarding_start_action => 'התחל';

  @override
  String get passed_by => 'עברו';

  @override
  String get passed_by_help =>
      'סופר אנשים או כלי רכב שעברו דרך אזור זה במהלך חלון הספירה הנוכחי.\\n\\nכל אדם או כלי רכב נספר פעם אחת בלבד עבור כל מעבר באזור.';

  @override
  String get payloads_screen_area => 'אזור';

  @override
  String get payloads_screen_confidence => 'רמת ביטחון';

  @override
  String get payloads_screen_coverage => 'כיסוי';

  @override
  String get payloads_screen_delivered => 'נמסר';

  @override
  String get payloads_screen_failed_load => 'טעינת המטענים האחרונים נכשלה';

  @override
  String get payloads_screen_frame_processed => 'פריימים שעובדו';

  @override
  String get payloads_screen_hour_not_exists => 'שעה זו כבר אינה קיימת.';

  @override
  String get payloads_screen_missing_time => 'זמן חסר';

  @override
  String get payloads_screen_no_payloads => 'אין עדיין מטענים.';

  @override
  String get payloads_screen_partial => 'החלון הסתיים מוקדם (חלקי)';

  @override
  String get payloads_screen_partially => 'נמסר חלקית';

  @override
  String get payloads_screen_payload_not_exists => 'מטען זה כבר אינו קיים.';

  @override
  String get payloads_screen_pending => 'ממתין למסירה';

  @override
  String get payloads_screen_process_fps => 'עיבוד FPS';

  @override
  String get payloads_screen_resend => 'שלח שוב';

  @override
  String get payloads_screen_select_first =>
      'בחר תחילה לפחות תאריך או שעה אחת.';

  @override
  String get payloads_screen_subtitle => 'בחר לפי תאריך או שעה לשליחה מחדש';

  @override
  String get payloads_screen_title => 'מטענים אחרונים';

  @override
  String get personal_custom_screen_build_server =>
      'זקוק לעזרה בהגדרת השרת שלך?\\nעיין בתיעוד ה-API ובדוגמאות השרת שלנו.';

  @override
  String get personal_custom_screen_help_action => 'פתח את תיעוד ה-API';

  @override
  String get personal_custom_screen_reset_action => 'התחל מחדש';

  @override
  String get personal_custom_success_screen_help =>
      'הקש על Start למטה כדי להתחיל בספירה.';

  @override
  String get personal_custom_success_screen_help1 =>
      'הסטטיסטיקות מועלות אוטומטית כל שעה.\\nניתן גם להעלות אותן ידנית ממסך יומני ההעלאה.';

  @override
  String get personal_custom_success_screen_help2 =>
      'השרת שלך עדיין לא צריך להיות מקוון.\\nהתחל לספור עכשיו. תוכל להשלים את בניית השרת שלך ולבדוק אותו מאוחר יותר. נתוני התנועה יישארו במכשיר זה עד שיועלו בהצלחה.';

  @override
  String get personal_custom_success_screen_send_to => 'נתוני התנועה יישלחו אל';

  @override
  String get personal_custom_success_screen_title => 'השרת שלך מוכן';

  @override
  String get piyuo_server_screen_cloud_url_label => 'כתובת ה-Piyuo Cloud שלך';

  @override
  String get piyuo_server_screen_copy_action => 'העתק URL';

  @override
  String get piyuo_server_screen_copy_success => 'כתובת ה-URL הועתקה';

  @override
  String get piyuo_server_screen_saving_action => 'שומר...';

  @override
  String get piyuo_server_screen_start =>
      'לחץ על \"Start\" למטה כדי להתחיל בספירה.';

  @override
  String get piyuo_server_screen_url_help =>
      'לוח המחוונים האישי שלך ב-Piyuo Cloud מוכן בכתובת URL זו.';

  @override
  String get piyuo_server_screen_url_remember =>
      'שמור כתובת URL זו כדי לגשת ללוח המחוונים שלך ממכשיר אחר.';

  @override
  String get piyuo_server_screen_use_action => 'השתמש ב-Piyuo Cloud';

  @override
  String get privacy => 'מדיניות פרטיות';

  @override
  String get product_copyright => 'כל הזכויות שמורות © 2026';

  @override
  String get product_desc => 'ספירת אנשים וכלי רכב באמצעות בינה מלאכותית.';

  @override
  String get settings_screen_custom_subtitle =>
      'שלח נתוני תנועה ישירות לשרת או למסד הנתונים שלך.';

  @override
  String get settings_screen_custom_title => 'השתמש בשרת מותאם אישית';

  @override
  String get settings_screen_data_server_label => 'שרת נתונים';

  @override
  String get settings_screen_detection_target => 'יעד הזיהוי';

  @override
  String get settings_screen_language_title => 'שפה';

  @override
  String get settings_screen_local_subtitle =>
      'אחסן נתוני תנועה במכשיר זה בלבד. שום דבר לא יועלה.';

  @override
  String get settings_screen_local_title => 'המכשיר המקומי בלבד';

  @override
  String get settings_screen_misc_label => 'שונות';

  @override
  String get settings_screen_object_detection => 'זיהוי אובייקטים';

  @override
  String get settings_screen_piyuo_subtitle =>
      'שמור את נתוני התנועה ב-Piyuo Cloud עם לוחות מחוונים ותובנות עסקיות.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'פעולה זו תמחק את כל הנתונים ותתחיל מחדש. לא ניתן לבטל פעולה זו.';

  @override
  String get settings_screen_reset_all_data_title => 'לאפס את כל הנתונים?';

  @override
  String get settings_screen_subscription_body =>
      'נהל את המינוי ופרטי החיוב שלך';

  @override
  String get settings_screen_subscription_title => 'מינוי';

  @override
  String get start_screen_about => 'אודות';

  @override
  String get start_screen_server_none => 'הנתונים נשמרים במכשיר זה בלבד';

  @override
  String get start_screen_server_personal => 'הנתונים מועלים מדי שעה אל';

  @override
  String get start_screen_settings => 'הגדרות';

  @override
  String get start_screen_upload_logs => 'העלאת יומנים';

  @override
  String get start_screen_video_sources => 'מקורות וידאו';

  @override
  String get stayed => 'שהו';

  @override
  String get stayed_help =>
      'סופר אנשים או כלי רכב שנשארו באזור זה לפחות למשך זמן השהייה שהוגדר.\\n\\nברירת המחדל של זמן השהייה היא 15 שניות וניתן לשנות אותה בהגדרות.';

  @override
  String get target_pedestrian => 'הולך רגל';

  @override
  String get target_pedestrian_help =>
      'ספור אנשים באמצעות מודל זיהוי הולכי רגל';

  @override
  String get target_screen_subtitle => 'בחר את מודל הזיהוי שבו ברצונך להשתמש';

  @override
  String get target_vehicle => 'רכב';

  @override
  String get target_vehicle_help =>
      'ספור מכוניות וכלי רכב אחרים באמצעות מודל זיהוי כלי רכב';

  @override
  String get telemetry_error_connection_refused =>
      'לא ניתן להתחבר לשרת. ייתכן שהוא לא זמין כרגע.';

  @override
  String get telemetry_error_connection_reset =>
      'החיבור אופס. בדוק את חיבור האינטרנט שלך ונסה שוב.';

  @override
  String get telemetry_error_connection_timeout =>
      'החיבור התעכב יותר מדי בתגובה. בדוק את חיבור האינטרנט שלך ונסה שוב.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'לא ניתן היה למצוא את כתובת השרת. בדוק את חיבור האינטרנט או את כתובת ה-URL של השרת.';

  @override
  String get telemetry_error_http_error_status =>
      'השרת דחה את הבקשה. נסה שוב מאוחר יותר.';

  @override
  String get telemetry_error_http_unknown_error =>
      'אירעה שגיאה בלתי צפויה בעת התקשורת עם השרת.';

  @override
  String get telemetry_error_invalid_url =>
      'כתובת השרת אינה תקינה. בדוק את ההגדרות שלך.';

  @override
  String get telemetry_error_network_error =>
      'אירעה שגיאת רשת. בדוק את חיבור האינטרנט שלך ונסה שוב.';

  @override
  String get telemetry_error_socket_error =>
      'אירעה בעיית חיבור לרשת. בדוק את חיבור האינטרנט שלך.';

  @override
  String get telemetry_error_transport_exception =>
      'משהו השתבש בעת שליחת הנתונים. נסה שוב.';

  @override
  String get terms => 'תנאי השירות';

  @override
  String get upload_screen_attempt_time => 'זמן הניסיון:';

  @override
  String get upload_screen_error => 'שגיאה:';

  @override
  String get upload_screen_failed => 'נכשל';

  @override
  String get upload_screen_load_error => 'לא ניתן לטעון את יומני ההעלאה.';

  @override
  String get upload_screen_log_not_exists => 'יומן ההעלאה אינו זמין עוד.';

  @override
  String get upload_screen_next => 'ההעלאה הבאה ב־...';

  @override
  String get upload_screen_next_upload_prefix => 'ההעלאה הבאה ב־';

  @override
  String get upload_screen_no_data_server => 'אנא הגדר תחילה את שרת הנתונים.';

  @override
  String get upload_screen_no_logs => 'אין עדיין יומני העלאה.';

  @override
  String get upload_screen_payload_count => 'מספר מטענים';

  @override
  String get upload_screen_payload_count_label => 'מספר מטענים:';

  @override
  String get upload_screen_payload_size => 'גודל המטען:';

  @override
  String get upload_screen_result => 'תוצאה:';

  @override
  String get upload_screen_retry => 'מספר ניסיונות חוזרים:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'הצלחה';

  @override
  String get upload_screen_today => 'היום';

  @override
  String get upload_screen_upload_now => 'העלה עכשיו';

  @override
  String get upload_screen_upload_success => 'ההעלאה הצליחה.';

  @override
  String get upload_screen_uploading => 'מעלה...';

  @override
  String get upload_screen_yesterday => 'אתמול';

  @override
  String get url_screen_invalid_rtsp_error =>
      'כתובות RTSP חייבות לכלול שם מארח.';

  @override
  String get url_screen_invalid_url_error =>
      'הזן כתובת URL חוקית עם פרוטוקול נתמך.';

  @override
  String get url_screen_subtitle => 'אנא הזן את כתובת השידור החי';

  @override
  String get url_screen_title => 'כתובת שידור חי';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => 'כתובת URL';

  @override
  String get url_screen_url_empty_error => 'אנא הזן כתובת URL של שידור חי.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream או rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'מצלמה אחורית';

  @override
  String get video_sources_camera => 'מצלמה';

  @override
  String get video_sources_file => 'קובץ';

  @override
  String get video_sources_front_camera => 'מצלמה קדמית';

  @override
  String get video_sources_live_stream => 'כתובת שידור חי';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'יש לאשר הרשאת מצלמה כדי להשתמש במצלמה';

  @override
  String get video_sources_screen_camera_not_found_title => 'מצלמה לא נמצאה';

  @override
  String get video_sources_screen_import_error =>
      'לא ניתן לייבא את קובץ הווידאו.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'אנא עבור להגדרות ואפשר גישה לתמונות עבור אפליקציה זו.';

  @override
  String get video_sources_screen_select_camera => 'הקש כדי לבחור מצלמה זו';

  @override
  String get video_sources_screen_select_file => 'הקש כדי לבחור קובץ';

  @override
  String get video_sources_screen_select_live =>
      'הקש כדי להגדיר את כתובת ה-URL של השידור החי';

  @override
  String get video_sources_webcam => 'מצלמת רשת';
}
