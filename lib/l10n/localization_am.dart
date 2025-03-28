// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class LocalizationAm extends Localization {
  LocalizationAm([String locale = 'am']) : super(locale);

  @override
  String get product_name => 'ቆጣሪ';

  @override
  String get product_desc => 'Համակարգչային տեսողության և արհեստական բանականության միջոցով հաշվել մարդկանց, տրանսպորտային միջոցները, կենդանիներին և այլն։';

  @override
  String get product_copyright => 'Հեղինակային իրավունք © 2025';

  @override
  String get video_sources_webcam => 'Վեբ տեսախցիկ';

  @override
  String get video_sources_live_stream => 'Ուղիղ հեռարձակման URL';

  @override
  String get video_sources_file => 'Ֆայլ';

  @override
  String get video_sources_camera => 'Տեսախցիկ';

  @override
  String get video_sources_camera_not_found_title => 'Տեսախցիկը չի գտնվել';

  @override
  String get video_sources_camera_not_found_message => 'Տեսախցիկն օգտագործելու համար անհրաժեշտ է թույլտվություն տալ';

  @override
  String get video_sources_webcam_not_found_title => 'Վեբ տեսախցիկը չի գտնվել';

  @override
  String get video_sources_webcam_not_found_message => 'Խնդրում ենք ստուգել հավելվածի թույլտվությունը և կապակցումը';

  @override
  String get wizard_screen_desc => 'Ստեղծեք նոր նախագիծ հաշվարկն սկսելու համար։';

  @override
  String get wizard_screen_new_project_from => 'Նոր նախագիծ՝ սկսած';

  @override
  String get wizard_screen_language => 'Լեզու';

  @override
  String get wizard_screen_about => 'Մասին';

  @override
  String get wizard_screen_open_projects_tip => 'Բոլոր նախագծերը ավտոմատ կերպով կպահպանվեն տեղական սարքում';

  @override
  String get wizard_screen_open_projects => 'Բացել գոյություն ունեցող նախագիծ';

  @override
  String get wizard_screen_email_us => 'Էլ․ նամակ ուղարկել';

  @override
  String get language_screen_language => 'Լեզու';

  @override
  String get project_view_no_videos => 'Տեսանյութի աղբյուր չկա։';

  @override
  String get about_screen_title => 'Մասին';

  @override
  String get about_screen_platform => 'Հարթակ';

  @override
  String get about_screen_app_version => 'Հավելվածի տարբերակ';

  @override
  String get about_screen_models => 'Օբյեկտների հայտնաբերման մոդելներ';

  @override
  String get about_screen_benchmark => 'Թեստավորում';

  @override
  String get about_screen_opencv_build_info => 'OpenCV-ի կառուցման տեղեկություն';

  @override
  String get benchmark_screen_title => 'Մոդելների թեստավորում';

  @override
  String get benchmark_screen_recommended => 'Առաջարկվող մոդել';

  @override
  String get benchmark_screen_fps => 'Կադր/վրկ';

  @override
  String get benchmark_screen_start_button => 'Սկսել թեստավորումը';

  @override
  String get benchmark_screen_start_failed => 'Թեստավորումը չհաջողվեց սկսել, սխալի կոդը՝';

  @override
  String get benchmark_screen_models => 'Օբյեկտների հայտնաբերման մոդելներ';

  @override
  String get project_screen_title => 'Նախագիծ';

  @override
  String get project_screen_exit_confirm_title => 'Հաստատեք նախագծից դուրս գալը';

  @override
  String get project_screen_exit_confirm_content => 'Նախագծից դուրս գալը կդադարեցնի հաշվարկը։ Դուք վստա՞հ եք, որ ցանկանում եք շարունակել։';

  @override
  String get project_screen_exit_button => 'Դուրս գալ';

  @override
  String get project_screen_add_video_button => 'Ավելացնել տեսանյութի աղբյուր';

  @override
  String get project_screen_from_desc => 'Մենք պահպանում ենք 24 ժամյա շարունակական գրառում, այնպես որ դուք կարող եք դիտել ցանկացած ժամանակահատված։';

  @override
  String get project_screen_report_settings => 'Կարգավորումներ';

  @override
  String get filter_screen_title => 'Զտիչ';

  @override
  String get filter_screen_desc => 'Ընտրեք զտիչի միջակայք ստորև ցուցակից';

  @override
  String get filter_screen_error_title => 'Զտիչ';

  @override
  String get filter_screen_error_content => 'Ավարտի ժամանակը պետք է մեծ լինի սկզբի ժամանակից';

  @override
  String get filter_screen_error_custom => 'Հարմարեցված';

  @override
  String get filter_screen_error_start => 'Սկիզբ';

  @override
  String get filter_screen_error_end => 'Ավարտ';

  @override
  String get settings_screen_title => 'Կարգավորումներ';

  @override
  String get settings_screen_desc => 'Սահմանեք նախագծի անունը, հայտնաբերման պարամետրերը, հաշվարկի զրոյացումը։';

  @override
  String get settings_screen_project_id => 'Նախագծի ID';

  @override
  String get settings_screen_project_name => 'Նախագծի անունը';

  @override
  String get settings_screen_project_name_place_holder => 'Գլխավոր 123 փող. կամ Մաշտոցի պողոտա';

  @override
  String get settings_screen_project_error => 'Նախագծի անունը չի կարող դատարկ լինել';

  @override
  String get settings_screen_random_count_button => 'Ավելացնել պատահական հաշվարկներ';

  @override
  String get settings_screen_reset_count_header => 'Վերականգնել այս նախագծի բոլոր հաշվարկները';

  @override
  String get settings_screen_reset_count_button => 'Վերականգնել հաշվարկները';

  @override
  String get settings_screen_reset_count_content => 'Դուք վստա՞հ եք, որ ցանկանում եք վերականգնել բոլոր հաշվարկները։';

  @override
  String get settings_screen_delete_header => 'Ջնջել այս նախագիծը';

  @override
  String get settings_screen_delete_content => 'Դուք վստա՞հ եք, որ ցանկանում եք ջնջել այս նախագիծը։';

  @override
  String get settings_screen_delete_button => 'Ջնջել';

  @override
  String get settings_screen_center_point_title => 'Թիրախի կենտրոնական կետ';

  @override
  String get settings_screen_center_point_desc => 'Կենտրոնական կետը օգնում է որոշել, թե արդյոք թիրախը գտնվում է հարվածի գոտում։';

  @override
  String get settings_screen_center_point_button => 'Ցույց տալ թիրախի կենտրոնական կետը';

  @override
  String get settings_screen_lost_target_title => 'Կորած թիրախ';

  @override
  String get settings_screen_lost_target_desc => 'Երբ օբյեկտի հետևելիությունը կորցնում է թիրախը, այս տարբերակը դարձնում է այն տեսանելի։ Լռելյայն, կորած թիրախները չեն ցուցադրվում։';

  @override
  String get settings_screen_lost_target_button => 'Ցույց տալ կորած թիրախը';

  @override
  String get detection_screen_title => 'Հայտնաբերման կարգավորումներ';

  @override
  String get detection_screen_models => 'Մոդելներ';

  @override
  String get detection_screen_confidence => 'Վստահություն';

  @override
  String get detection_screen_confidence_desc => '#0-ից բարձր վստահությունը համարվում է վավեր հայտնաբերում';

  @override
  String get detection_screen_low => 'Ցածր';

  @override
  String get detection_screen_high => 'Բարձր';

  @override
  String get detection_screen_nms => 'Ոչ առավելագույն ճնշում';

  @override
  String get detection_screen_nms_desc => '#0 ዝቅተኛ NMS መጠን (ለምሳሌ 0.3-0.4) ተደራራቢ ሳጥኖችን በጥብቅ ያስወግዳል ግን ተደራራቢ ሰዎችን ሊ놓 ይችላል። ከፍተኛ መጠን (0.7-0.9) ተጨማሪ ሳጥኖችን ያስቀርል እንዲሁም ተደራራቢ ሰዎችን በተሻለ ሁኔታ ያገኛል.';

  @override
  String get detection_screen_match => 'Համապատասխանություն';

  @override
  String get detection_screen_match_desc => '#0 matchThreshold በነገሮች መከታተል ላይ ወሳኝ ፓራሜትር ሲሆን በተለያዩ መለያ ሳጥኖች መካከል ያለውን ተዛማጅነት ይለካል፡፡ ዝቅተኛ ዋጋ ነገሮችን ለማገናኘት ቀላል ያደርገዋል ነገር ግን የተሳሳተ ግንኙነት አደጋን ይጨምራል፤ ከፍተኛ ዋጋ ለነገሮች ግንኙነት የበለጠ ጥብቅ ነው ነገር ግን አንዳንድ እውነተኛ ግንኙነቶችን ሊ놓 ይችላል።';

  @override
  String get detection_screen_lost => 'Կորած';

  @override
  String get detection_screen_lost_desc => 'Հետևվող օբյեկտը կհեռացվի, եթե այն կորած է #0';

  @override
  String get detection_screen_consider_valid => 'Համարել վավեր հետո';

  @override
  String get detection_screen_consider_valid_desc => 'Հետևվող օբյեկտը կհամարվի վավեր #0 հետո';

  @override
  String get detection_screen_reset => 'Վերականգնել';

  @override
  String get detection_screen_reset_content => 'Դուք վստա՞հ եք, որ ցանկանում եք վերականգնել հայտնաբերման կարգավորումները։';

  @override
  String get url_screen_title => 'Ուղիղ հեռարձակման URL';

  @override
  String get url_screen_desc => 'Խնդրում ենք մուտքագրել ուղիղ հեռարձակման URL-ը';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream կամ rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Ավելացնել տեսանյութի աղբյուր';

  @override
  String get add_video_screen_from => 'Ավելացնել տեսանյութի աղբյուր հետևյալից';

  @override
  String get webcam_screen_add_title => 'Ավելացնել վեբ տեսախցիկ';

  @override
  String get webcam_screen_edit_title => 'Ընտրել վեբ տեսախցիկ';

  @override
  String get webcam_manager_webcam => 'Վեբ տեսախցիկ';

  @override
  String get camera_screen_front_camera => 'Առջևի տեսախցիկ';

  @override
  String get camera_screen_back_camera => 'Հետևի տեսախցիկ';

  @override
  String get camera_screen_add_title => 'Ավելացնել տեսախցիկ';

  @override
  String get camera_screen_edit_title => 'Ընտրել տեսախցիկ';

  @override
  String get camera_screen_zoom_level => 'Մասշտաբի մակարդակ';

  @override
  String get video_screen_name_empty => 'Տեսանյութի անունը չի կարող դատարկ լինել։';

  @override
  String get video_screen_desc => 'Կառավարել տեսանյութի աղբյուրները, ավելացնել կամ փոփոխել հայտնաբերման գոտիները։';

  @override
  String get video_screen_video_name => 'Տեսանյութի աղբյուրի անուն';

  @override
  String get video_screen_edit_placeholder => 'Մուտքի դռան տեսախցիկ կամ Կայանատեղիի տեսախցիկ';

  @override
  String get video_screen_change_file => 'Փոխել ֆայլը';

  @override
  String get video_screen_add_zone => 'Ավելացնել հայտնաբերման գոտի';

  @override
  String get video_screen_zones => 'Հայտնաբերման գոտիներ';

  @override
  String get video_screen_zones_desc => 'Օգտագործեք քաշել և գցել գոտիները կարգավորելու համար';

  @override
  String get video_screen_tools => 'Գործիքներ';

  @override
  String get video_screen_move_bottom => 'Տեղափոխել ընթացիկ գոտին ներքև';

  @override
  String get video_screen_add_point => 'Ավելացնել կետ ընթացիկ գոտուն';

  @override
  String get video_screen_remove_point => 'Հեռացնել կետը ընթացիկ գոտուց';

  @override
  String get video_screen_playback_speed => 'Նվագարկման արագություն';

  @override
  String get video_screen_playback_current => 'ընթացիկ: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Ջնջել այս տեսանյութի աղբյուրը';

  @override
  String get video_screen_delete_content => 'Դուք վստա՞հ եք, որ ցանկանում եք ջնջել այս տեսանյութի աղբյուրը։';

  @override
  String get video_screen_delete_button => 'Ջնջել';

  @override
  String get video_screen_sources => 'Կազմաձևել պատկերի աղբյուրը, հայտնաբերման թիրախները և մոդելի պարամետրերը։';

  @override
  String get video_screen_targets => 'Հայտնաբերման թիրախներ';

  @override
  String get video_screen_detection => 'Մոդելի պարամետրեր';

  @override
  String get color_screen_title => 'Ընտրել գույն';

  @override
  String get zone_screen_desc => 'Հայտնաբերման գոտին կարող է սահմանել հայտնաբերման օբյեկտների տեսակները և ընտրել, թե որ հաշվիչները ցուցադրել, ինչպիսիք են Հայտնաբերված, Ստեղծված և Մուտք գործած։';

  @override
  String get zone_screen_name_placeholder => 'Գոտու անունը, ինչպես օրինակ Մայթ կամ Կայանատեղի';

  @override
  String get zone_screen_zone_color => 'Գոտու գույն';

  @override
  String get zone_screen_color => 'Գույն';

  @override
  String get zone_screen_delete_header => 'Ջնջել այս գոտին';

  @override
  String get zone_screen_delete_content => 'Դուք վստա՞հ եք, որ ցանկանում եք ջնջել այս գոտին։';

  @override
  String get zone_screen_delete_button => 'Ջնջել';

  @override
  String get zone_screen_can_not_delete => 'Չի կարող ջնջել գոտին';

  @override
  String get zone_screen_one_zone_required => 'Առնվազն մեկ գոտի է պահանջվում։';

  @override
  String get zone_screen_zone_name_required => 'Գոտու անունը չի կարող դատարկ լինել';

  @override
  String get counter_screen_show_on => 'Ցույց տալ էկրանին';

  @override
  String get counter_screen_enabled => 'Միացված';

  @override
  String get counter_screen_reentry_threshold => 'Վերամուտքի շեմ';

  @override
  String get counter_screen_reentry_desc => 'Օբյեկտները պետք է մուտք գործեն #0 անգամ, յուրաքանչյուր ելքի և վերամուտքի միջև #1 վայրկյան հովացման ժամանակով, վերամուտքի գործարկման համար';

  @override
  String get counter_screen_reentry_title => 'Վերամուտքի հաշվարկ';

  @override
  String get counter_screen_cooldown_threshold => 'Հովացման շեմ';

  @override
  String get counter_screen_cooldown_desc => 'Վերամուտքը պահանջում է #0 վայրկյան հովացում հայտնաբերման գոտուց դուրս գալուց հետո';

  @override
  String get counter_screen_cooldown_time => 'Հովացման ժամանակ';

  @override
  String get counter_screen_cooldown_in_seconds => 'վայրկյաններով';

  @override
  String get counter_screen_stagnant_threshold => 'Անշարժության շեմ';

  @override
  String get counter_screen_stagnant_desc => 'Օբյեկտները, որոնք մնում են անշարժ ավելի քան #0 վայրկյան, կհամարվեն լճացած';

  @override
  String get counter_screen_stagnant_consider => 'Համարել լճացած';

  @override
  String get counter_screen_stagnant_in_seconds => 'վայրկյաններով';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Նկարագրության նախածանց';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Նկարագրության վերջածանց';

  @override
  String get counter_screen_name_error => 'Հաշվիչի անունը չի կարող դատարկ լինել';

  @override
  String get counter_screen_enabled_error => 'Սխալ';

  @override
  String get counter_screen_enabled_error_content => 'Դուք պետք է նախ միացնեք այլ հաշվիչ, այնուհետև կարող եք անջատել այս հաշվիչը';

  @override
  String get objects_screen_title => 'Օբյեկտներ';

  @override
  String get objects_screen_desc => 'Ընտրեք հայտնաբերման թիրախներ, ինչպես օրինակ մարդ, մեքենա, ավտոբուս և այլն։';

  @override
  String get open_project_screen_title => 'Բացել նախագիծ';

  @override
  String get open_project_screen_desc => 'Բացեք նախկինում ստեղծված նախագծերը՝ պահպանելով միայն վերջին 20-ը։';

  @override
  String get open_project_screen_no_project => 'Նախագիծ չի գտնվել։';

  @override
  String get default_project_name => 'Նախագիծ';

  @override
  String get default_video_name => 'Տեսանյութի աղբյուր';

  @override
  String get default_zone_name => 'Հայտնաբերման գոտի';

  @override
  String get error_oops => 'Վայ, ինչ-որ բան սխալ է գնացել';

  @override
  String get error_content => 'Անսպասելի սխալ է տեղի ունեցել։ Կցանկանայի՞ք ուղարկել էլ․ նամակով հաշվետվություն։';

  @override
  String get error_report => 'Էլ․ նամակ ուղարկել';

  @override
  String get submit => 'Ուղարկել';

  @override
  String get ok => 'Լավ';

  @override
  String get cancel => 'Չեղարկել';

  @override
  String get yes => 'Այո';

  @override
  String get no => 'Ոչ';

  @override
  String get close => 'Փակել';

  @override
  String get back => 'Հետ';

  @override
  String get zone_screen_zone => 'Գոտի';

  @override
  String get zone_screen_zone_show_summary => 'Ամփոփումը ցույց տալ էկրանին';

  @override
  String get video_sources_photos_denied => 'ፎቶዎችን ለማግኘት ተከልክሏል';

  @override
  String get video_sources_photos_goto_settings => 'ወደ ቅንብሮች ሂድ';

  @override
  String get video_sources_camera_denied => 'ወደ ካሜራ መዳረሻ ተከልክሏል';

  @override
  String get video_sources_photos_denied_msg => 'ወደ ቅንብሮች ሂድና ለዚህ መተግበሪያ የፎቶ መዳረሻ ፍቃድ ይፍቀዱ።';

  @override
  String get video_sources_camera_denied_msg => 'ወደ ቅንብሮች ሂድና ለዚህ መተግበሪያ የካሜራ መዳረሻ ፍቃድ ይፍቀዱ።';
}
