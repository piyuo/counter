// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class LocalizationMr extends Localization {
  LocalizationMr([String locale = 'mr']) : super(locale);

  @override
  String get product_name => 'व्हिजन काउंटर';

  @override
  String get product_desc => 'कंप्युटर व्हिजन आणि एआय वापरून लोक, वाहने, पाळीव प्राणी आणि इतर गोष्टींची मोजणी करा.';

  @override
  String get product_copyright => 'कॉपीराइट © 2025';

  @override
  String get video_sources_webcam => 'वेबकॅम';

  @override
  String get video_sources_live_stream => 'लाइव स्ट्रीम URL';

  @override
  String get video_sources_file => 'फाइल';

  @override
  String get video_sources_camera => 'कॅमेरा';

  @override
  String get video_sources_camera_not_found_title => 'कॅमेरा सापडला नाही';

  @override
  String get video_sources_camera_not_found_message => 'कॅमेरा वापरण्यासाठी कॅमेरा परवानगी देणे आवश्यक आहे';

  @override
  String get video_sources_webcam_not_found_title => 'वेबकॅम सापडला नाही';

  @override
  String get video_sources_webcam_not_found_message => 'कृपया कोणताही वेबकॅम जोडला आहे का ते तपासा';

  @override
  String get wizard_screen_desc => 'मोजणी सुरू करण्यासाठी खाली नवीन प्रकल्प तयार करा.';

  @override
  String get wizard_screen_new_project_from => 'नवीन प्रकल्प';

  @override
  String get wizard_screen_language => 'भाषा';

  @override
  String get wizard_screen_about => 'माहिती';

  @override
  String get wizard_screen_open_projects_tip => 'सर्व प्रकल्प स्थानिक पातळीवर स्वयंचलितपणे साठवले जातील';

  @override
  String get wizard_screen_open_projects => 'विद्यमान प्रकल्प उघडा';

  @override
  String get wizard_screen_email_us => 'आम्हाला ईमेल करा';

  @override
  String get language_screen_language => 'भाषा';

  @override
  String get project_view_no_videos => 'कोणताही व्हिडिओ स्त्रोत उपलब्ध नाही.';

  @override
  String get about_screen_title => 'माहिती';

  @override
  String get about_screen_platform => 'प्लॅटफॉर्म';

  @override
  String get about_screen_app_version => 'अॅप आवृत्ती';

  @override
  String get about_screen_models => 'ऑब्जेक्ट डिटेक्शन मॉडेल्स';

  @override
  String get about_screen_benchmark => 'बेंचमार्क';

  @override
  String get about_screen_opencv_build_info => 'OpenCV बिल्ड माहिती';

  @override
  String get benchmark_screen_title => 'मॉडेल बेंचमार्क';

  @override
  String get benchmark_screen_recommended => 'अनुशंसित मॉडेल';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'बेंचमार्क सुरू करा';

  @override
  String get benchmark_screen_start_failed => 'बेंचमार्क सुरू करण्यात अयशस्वी, त्रुटी कोड आहे';

  @override
  String get benchmark_screen_models => 'ऑब्जेक्ट डिटेक्शन मॉडेल्स';

  @override
  String get project_screen_title => 'प्रकल्प';

  @override
  String get project_screen_exit_confirm_title => 'प्रकल्पातून बाहेर पडण्याची पुष्टी करा';

  @override
  String get project_screen_exit_confirm_content => 'प्रकल्पातून बाहेर पडल्यास मोजणी थांबेल. तुम्हाला नक्की पुढे जायचे आहे का?';

  @override
  String get project_screen_exit_button => 'बाहेर पडा';

  @override
  String get project_screen_add_video_button => 'व्हिडिओ स्त्रोत जोडा';

  @override
  String get project_screen_from_desc => 'आम्ही 24 तासांचा रोलिंग रेकॉर्ड ठेवतो, जेणेकरून आपण आवश्यक असलेला कोणताही वेळेचा तुकडा पाहू शकता.';

  @override
  String get project_screen_report_settings => 'सेटिंग्ज';

  @override
  String get filter_screen_title => 'फिल्टर';

  @override
  String get filter_screen_desc => 'खालील यादीतून फिल्टर रेंज निवडा';

  @override
  String get filter_screen_error_title => 'फिल्टर';

  @override
  String get filter_screen_error_content => 'शेवटची वेळ सुरुवातीच्या वेळेपेक्षा अधिक असावी';

  @override
  String get filter_screen_error_custom => 'कस्टम';

  @override
  String get filter_screen_error_start => 'सुरुवात';

  @override
  String get filter_screen_error_end => 'शेवट';

  @override
  String get settings_screen_title => 'सेटिंग्ज';

  @override
  String get settings_screen_desc => 'प्रकल्प नाव, डिटेक्शन पॅरामीटर्स, मोजणी साफ करणे सेट करा.';

  @override
  String get settings_screen_project_id => 'प्रकल्प आयडी';

  @override
  String get settings_screen_project_name => 'प्रकल्प नाव';

  @override
  String get settings_screen_project_name_place_holder => '123 मेन स्ट्रीट किंवा पार्क एव्हेन्यू';

  @override
  String get settings_screen_project_error => 'प्रकल्प नाव रिकामे असू शकत नाही';

  @override
  String get settings_screen_random_count_button => 'यादृच्छिक मोजणी जोडा';

  @override
  String get settings_screen_reset_count_header => 'या प्रकल्पातील सर्व मोजणी रीसेट करा';

  @override
  String get settings_screen_reset_count_button => 'मोजणी रीसेट करा';

  @override
  String get settings_screen_reset_count_content => 'तुम्हाला नक्की सर्व मोजणी रीसेट करायची आहे का?';

  @override
  String get settings_screen_delete_header => 'हा प्रकल्प हटवा';

  @override
  String get settings_screen_delete_content => 'तुम्हाला नक्की हा प्रकल्प हटवायचा आहे का?';

  @override
  String get settings_screen_delete_button => 'हटवा';

  @override
  String get settings_screen_center_point_title => 'लक्ष्यावर केंद्र बिंदू';

  @override
  String get settings_screen_center_point_desc => 'केंद्र बिंदू लक्ष्य हिट झोनमध्ये आहे की नाही हे निर्धारित करण्यात मदत करतो.';

  @override
  String get settings_screen_center_point_button => 'लक्ष्यावर केंद्र बिंदू दाखवा';

  @override
  String get settings_screen_lost_target_title => 'गमावलेले लक्ष्य';

  @override
  String get settings_screen_lost_target_desc => 'जेव्हा ऑब्जेक्ट ट्रॅकिंग लक्ष्य गमावते, तेव्हा हा पर्याय दृश्यमान करतो. डीफॉल्टनुसार, गमावलेली लक्ष्ये दाखवली जात नाहीत.';

  @override
  String get settings_screen_lost_target_button => 'गमावलेले लक्ष्य दाखवा';

  @override
  String get detection_screen_title => 'डिटेक्शन सेटिंग्ज';

  @override
  String get detection_screen_models => 'मॉडेल्स';

  @override
  String get detection_screen_confidence => 'विश्वास स्तर';

  @override
  String get detection_screen_confidence_desc => '#0 पेक्षा जास्त विश्वास स्तर वैध शोध मानला जातो';

  @override
  String get detection_screen_low => 'कमी';

  @override
  String get detection_screen_high => 'जास्त';

  @override
  String get detection_screen_nms => 'नॉन-मॅक्सिमम सप्रेशन';

  @override
  String get detection_screen_nms_desc => '#0 कमी NMS थ्रेशोल्ड (उदा., 30%) अधिक आक्रमकपणे ओव्हरलॅपिंग बाउंडिंग बॉक्स काढून टाकेल, तर उच्च NMS थ्रेशोल्ड (उदा., 0.6) अधिक ओव्हरलॅप करण्याची अनुमती देईल';

  @override
  String get detection_screen_match => 'जुळणी';

  @override
  String get detection_screen_match_desc => '#0 पेक्षा जास्त जुळणी त्याच वस्तू म्हणून मानली जाते.';

  @override
  String get detection_screen_lost => 'गमावलेले';

  @override
  String get detection_screen_lost_desc => '#0 साठी गमावल्यास ट्रॅक ऑब्जेक्ट काढून टाकला जाईल';

  @override
  String get detection_screen_consider_valid => 'नंतर वैध मानले';

  @override
  String get detection_screen_consider_valid_desc => '#0 नंतर ट्रॅक ऑब्जेक्ट वैध मानला जाईल';

  @override
  String get detection_screen_reset => 'रीसेट';

  @override
  String get detection_screen_reset_content => 'तुम्हाला नक्की डिटेक्शन सेटिंग्ज रीसेट करायच्या आहेत का?';

  @override
  String get url_screen_title => 'लाइव स्ट्रीम URL';

  @override
  String get url_screen_desc => 'कृपया लाइव स्ट्रीम URL प्रविष्ट करा';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream किंवा rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'व्हिडिओ स्त्रोत जोडा';

  @override
  String get add_video_screen_from => 'यातून व्हिडिओ स्त्रोत जोडा';

  @override
  String get webcam_screen_add_title => 'वेबकॅम जोडा';

  @override
  String get webcam_screen_edit_title => 'वेबकॅम निवडा';

  @override
  String get webcam_manager_webcam => 'वेबकॅम';

  @override
  String get camera_screen_front_camera => 'समोरचा कॅमेरा';

  @override
  String get camera_screen_back_camera => 'मागचा कॅमेरा';

  @override
  String get camera_screen_add_title => 'कॅमेरा जोडा';

  @override
  String get camera_screen_edit_title => 'कॅमेरा निवडा';

  @override
  String get camera_screen_zoom_level => 'झूम स्तर';

  @override
  String get video_screen_name_empty => 'व्हिडिओ नाव रिकामे असू शकत नाही.';

  @override
  String get video_screen_desc => 'व्हिडिओ स्त्रोत व्यवस्थापित करा, डिटेक्शन झोन जोडा किंवा सुधारित करा.';

  @override
  String get video_screen_video_name => 'व्हिडिओ स्त्रोत नाव';

  @override
  String get video_screen_edit_placeholder => 'दरवाजासमोरील कॅम किंवा पार्किंग लॉट कॅम';

  @override
  String get video_screen_change_file => 'फाइल बदला';

  @override
  String get video_screen_add_zone => 'डिटेक्शन झोन जोडा';

  @override
  String get video_screen_zones => 'डिटेक्शन झोन';

  @override
  String get video_screen_zones_desc => 'ड्रॅग आणि ड्रॉप वापरून झोन समायोजित करा';

  @override
  String get video_screen_tools => 'साधने';

  @override
  String get video_screen_move_bottom => 'सध्याचा झोन तळाशी हलवा';

  @override
  String get video_screen_add_point => 'सध्याच्या झोनमध्ये बिंदू जोडा';

  @override
  String get video_screen_remove_point => 'सध्याच्या झोनमधून बिंदू काढा';

  @override
  String get video_screen_playback_speed => 'प्लेबॅक गती';

  @override
  String get video_screen_playback_current => 'सध्याची: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'हा व्हिडिओ स्त्रोत हटवा';

  @override
  String get video_screen_delete_content => 'तुम्हाला नक्की हा व्हिडिओ स्त्रोत हटवायचा आहे का?';

  @override
  String get video_screen_delete_button => 'हटवा';

  @override
  String get video_screen_sources => 'इमेज स्त्रोत, डिटेक्शन लक्ष्ये आणि मॉडेल पॅरामीटर्स कॉन्फिगर करा.';

  @override
  String get video_screen_targets => 'डिटेक्शन लक्ष्ये';

  @override
  String get video_screen_detection => 'मॉडेल पॅरामीटर्स';

  @override
  String get color_screen_title => 'रंग निवडा';

  @override
  String get zone_screen_desc => 'डिटेक्शन झोनमध्ये शोधल्या जाणाऱ्या वस्तूंचे प्रकार सेट करता येतील आणि शोधलेल्या, उत्पन्न झालेल्या आणि प्रवेश केलेल्या सारखे कोणते काउंटर दर्शवायचे ते निवडता येईल.';

  @override
  String get zone_screen_name_placeholder => 'झोनचे नाव, जसे फूटपाथ किंवा पार्किंग लॉट';

  @override
  String get zone_screen_zone_color => 'झोन रंग';

  @override
  String get zone_screen_color => 'रंग';

  @override
  String get zone_screen_delete_header => 'हा झोन हटवा';

  @override
  String get zone_screen_delete_content => 'तुम्हाला नक्की हा झोन हटवायचा आहे का?';

  @override
  String get zone_screen_delete_button => 'हटवा';

  @override
  String get zone_screen_can_not_delete => 'झोन हटवू शकत नाही';

  @override
  String get zone_screen_one_zone_required => 'किमान एक झोन आवश्यक आहे.';

  @override
  String get zone_screen_zone_name_required => 'झोन नाव रिकामे असू शकत नाही';

  @override
  String get counter_screen_show_on => 'स्क्रीनवर दाखवा';

  @override
  String get counter_screen_enabled => 'सक्षम';

  @override
  String get counter_screen_reentry_threshold => 'पुन्हा-प्रवेश थ्रेशोल्ड';

  @override
  String get counter_screen_reentry_desc => 'वस्तूंनी #0 वेळा प्रवेश करणे आवश्यक आहे, प्रत्येक बाहेर जाणे आणि पुन्हा-प्रवेश दरम्यान #1 सेकंद कूलडाउन सह, पुन्हा-प्रवेश ट्रिगर करण्यासाठी';

  @override
  String get counter_screen_reentry_title => 'पुन्हा-प्रवेश मोजणी';

  @override
  String get counter_screen_cooldown_threshold => 'कूलडाउन थ्रेशोल्ड';

  @override
  String get counter_screen_cooldown_desc => 'डिटेक्शन झोनमधून बाहेर पडल्यानंतर पुन्हा-प्रवेशासाठी #0 सेकंद कूलडाउन आवश्यक आहे';

  @override
  String get counter_screen_cooldown_time => 'कूलडाउन वेळ';

  @override
  String get counter_screen_cooldown_in_seconds => 'सेकंदांमध्ये';

  @override
  String get counter_screen_stagnant_threshold => 'स्थिर थ्रेशोल्ड';

  @override
  String get counter_screen_stagnant_desc => '#0 सेकंदांपेक्षा जास्त काळ स्थिर राहिलेल्या वस्तू स्थिर मानल्या जातील';

  @override
  String get counter_screen_stagnant_consider => 'स्थिर म्हणून मानले';

  @override
  String get counter_screen_stagnant_in_seconds => 'सेकंदांमध्ये';

  @override
  String get counter_screen_stagnant_desc_prefix => 'वर्णन प्रीफिक्स';

  @override
  String get counter_screen_stagnant_desc_suffix => 'वर्णन सफिक्स';

  @override
  String get counter_screen_name_error => 'काउंटरचे नाव रिकामे असू शकत नाही';

  @override
  String get counter_screen_enabled_error => 'त्रुटी';

  @override
  String get counter_screen_enabled_error_content => 'आपल्याला प्रथम इतर काउंटर सक्षम करणे आवश्यक आहे, नंतर आपण हा काउंटर अक्षम करू शकता';

  @override
  String get objects_screen_title => 'वस्तू';

  @override
  String get objects_screen_desc => 'व्यक्ती, कार, बस इत्यादी डिटेक्शन लक्ष्ये निवडा.';

  @override
  String get open_project_screen_title => 'प्रकल्प उघडा';

  @override
  String get open_project_screen_desc => 'पूर्वी तयार केलेले प्रकल्प उघडा, केवळ नवीनतम 20 ठेवा.';

  @override
  String get open_project_screen_no_project => 'कोणताही प्रकल्प आढळला नाही.';

  @override
  String get default_project_name => 'प्रकल्प';

  @override
  String get default_video_name => 'व्हिडिओ स्त्रोत';

  @override
  String get default_zone_name => 'डिटेक्शन झोन';

  @override
  String get error_oops => 'अरेरे, काहीतरी चूक झाली';

  @override
  String get error_content => 'अनपेक्षित त्रुटी आली. तुम्हाला ईमेल अहवाल सादर करायचा आहे का?';

  @override
  String get error_report => 'आम्हाला ईमेल करा';

  @override
  String get submit => 'सबमिट करा';

  @override
  String get ok => 'ठीक आहे';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get yes => 'होय';

  @override
  String get no => 'नाही';

  @override
  String get close => 'बंद करा';

  @override
  String get back => 'मागे';
}
