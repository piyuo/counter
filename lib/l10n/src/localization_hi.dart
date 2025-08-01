// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class LocalizationHi extends Localization {
  LocalizationHi([String locale = 'hi']) : super(locale);

  @override
  String get about_screen_app_version => 'ऐप वर्शन';

  @override
  String get about_screen_benchmark => 'बेंचमार्क';

  @override
  String get about_screen_models => 'ऑब्जेक्ट डिटेक्शन मॉडल';

  @override
  String get about_screen_opencv_build_info => 'OpenCV बिल्ड जानकारी';

  @override
  String get about_screen_platform => 'प्लेटफॉर्म';

  @override
  String get about_screen_title => 'जानकारी';

  @override
  String get add_video_screen_from => 'इससे वीडियो स्रोत जोड़ें';

  @override
  String get add_video_screen_title => 'वीडियो स्रोत जोड़ें';

  @override
  String get back => 'वापस';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'ऑब्जेक्ट डिटेक्शन मॉडल';

  @override
  String get benchmark_screen_recommended => 'अनुशंसित मॉडल';

  @override
  String get benchmark_screen_start_button => 'बेंचमार्क शुरू करें';

  @override
  String get benchmark_screen_start_failed =>
      'बेंचमार्क शुरू करने में विफल, त्रुटि कोड है';

  @override
  String get benchmark_screen_title => 'मॉडल बेंचमार्क';

  @override
  String get camera_screen_add_title => 'कैमरा जोड़ें';

  @override
  String get camera_screen_back_camera => 'बैक कैमरा';

  @override
  String get camera_screen_edit_title => 'कैमरा चुनें';

  @override
  String get camera_screen_front_camera => 'फ्रंट कैमरा';

  @override
  String get camera_screen_zoom_level => 'ज़ूम स्तर';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get close => 'बंद करें';

  @override
  String get color_screen_title => 'रंग चुनें';

  @override
  String get counter_screen_cooldown_desc =>
      'डिटेक्शन ज़ोन से बाहर निकलने के बाद री-एंट्री के लिए #0 सेकंड का कूलडाउन आवश्यक है';

  @override
  String get counter_screen_cooldown_in_seconds => 'सेकंड में';

  @override
  String get counter_screen_cooldown_threshold => 'कूलडाउन थ्रेशोल्ड';

  @override
  String get counter_screen_cooldown_time => 'कूलडाउन समय';

  @override
  String get counter_screen_enabled => 'सक्षम';

  @override
  String get counter_screen_enabled_error => 'त्रुटि';

  @override
  String get counter_screen_enabled_error_content =>
      'आपको पहले अन्य काउंटर को सक्षम करना होगा, फिर आप इस काउंटर को अक्षम कर सकते हैं';

  @override
  String get counter_screen_name_error => 'काउंटर का नाम खाली नहीं हो सकता';

  @override
  String get counter_screen_reentry_desc =>
      'ऑब्जेक्ट को #0 बार प्रवेश करना होगा, प्रत्येक एग्जिट और री-एंट्री के बीच #1 सेकंड का कूलडाउन होगा, री-एंट्री ट्रिगर करने के लिए';

  @override
  String get counter_screen_reentry_threshold => 'री-एंट्री थ्रेशोल्ड';

  @override
  String get counter_screen_reentry_title => 'री-एंट्री गिनती';

  @override
  String get counter_screen_show_on => 'स्क्रीन पर दिखाएं';

  @override
  String get counter_screen_stagnant_consider => 'स्थिर के रूप में माना जाए';

  @override
  String get counter_screen_stagnant_desc =>
      '#0 सेकंड से अधिक समय तक स्थिर रहने वाले ऑब्जेक्ट को स्थिर माना जाएगा';

  @override
  String get counter_screen_stagnant_desc_prefix => 'विवरण प्रीफिक्स';

  @override
  String get counter_screen_stagnant_desc_suffix => 'विवरण सफिक्स';

  @override
  String get counter_screen_stagnant_in_seconds => 'सेकंड में';

  @override
  String get counter_screen_stagnant_threshold => 'स्थिर थ्रेशोल्ड';

  @override
  String get default_project_name => 'प्रोजेक्ट';

  @override
  String get default_video_name => 'वीडियो स्रोत';

  @override
  String get default_zone_name => 'डिटेक्शन ज़ोन';

  @override
  String get detection_screen_confidence => 'कॉन्फिडेंस';

  @override
  String get detection_screen_confidence_desc =>
      '#0 से अधिक कॉन्फिडेंस को वैध डिटेक्शन माना जाता है';

  @override
  String get detection_screen_consider_valid => 'इसके बाद वैध माना जाएगा';

  @override
  String get detection_screen_consider_valid_desc =>
      '#0 के बाद ट्रैक ऑब्जेक्ट को वैध माना जाएगा';

  @override
  String get detection_screen_high => 'उच्च';

  @override
  String get detection_screen_lost => 'खोया';

  @override
  String get detection_screen_lost_desc =>
      'गति के आधार पर #0 से #1 के बीच खोई वस्तुओं को हटाने का समय गतिशील रूप से निर्धारित करता है';

  @override
  String get detection_screen_low => 'निम्न';

  @override
  String get detection_screen_match => 'मिलान';

  @override
  String get detection_screen_match_desc =>
      '#0 मैचथ्रेशोल्ड ऑब्जेक्ट ट्रैकिंग में एक महत्वपूर्ण पैरामीटर है जो विभिन्न डिटेक्शन बॉक्स के बीच मिलान की डिग्री को मापता है। कम मान ऑब्जेक्ट एसोसिएशन को आसान बनाता है लेकिन गलत एसोसिएशन का जोखिम बढ़ाता है। उच्च मान ऑब्जेक्ट एसोसिएशन पर अधिक सख्त है लेकिन कुछ सच्चे मिलान छूट सकते हैं।';

  @override
  String get detection_screen_models => 'मॉडल';

  @override
  String get detection_screen_nms => 'नॉन-मैक्सिमम सप्रेशन';

  @override
  String get detection_screen_nms_desc =>
      '#0 कम NMS थ्रेशोल्ड (जैसे 0.3-0.4) ओवरलैपिंग बॉक्स को अधिक सख्ती से हटाता है और फॉल्स पॉजिटिव को कम करता है लेकिन ओवरलैपिंग लोगों को छोड़ सकता है। उच्च थ्रेशोल्ड (0.7-0.9) अधिक बॉक्स रखता है जो फॉल्स पॉजिटिव बढ़ा सकता है लेकिन ओवरलैपिंग लोगों को बेहतर ढंग से पहचानता है।';

  @override
  String get detection_screen_reset => 'रीसेट';

  @override
  String get detection_screen_reset_content =>
      'क्या आप सुनिश्चित हैं कि आप डिटेक्शन सेटिंग्स रीसेट करना चाहते हैं?';

  @override
  String get detection_screen_title => 'डिटेक्शन सेटिंग्स';

  @override
  String get error_content =>
      'एक अप्रत्याशित त्रुटि हुई। क्या आप ईमेल रिपोर्ट सबमिट करना चाहेंगे?';

  @override
  String get error_oops => 'ओह, कुछ गलत हो गया';

  @override
  String get error_report => 'हमें ईमेल करें';

  @override
  String get filter_screen_desc => 'नीचे दी गई सूची से फ़िल्टर रेंज चुनें';

  @override
  String get filter_screen_error_content =>
      'समाप्ति समय प्रारंभ समय से अधिक होना चाहिए';

  @override
  String get filter_screen_error_custom => 'कस्टम';

  @override
  String get filter_screen_error_end => 'अंत';

  @override
  String get filter_screen_error_start => 'प्रारंभ';

  @override
  String get filter_screen_error_title => 'फ़िल्टर';

  @override
  String get filter_screen_title => 'फ़िल्टर';

  @override
  String get language_screen_language => 'भाषा';

  @override
  String get no => 'नहीं';

  @override
  String get objects_screen_desc =>
      'व्यक्ति, कार, बस आदि जैसे डिटेक्शन लक्ष्य चुनें।';

  @override
  String get objects_screen_title => 'ऑब्जेक्ट्स';

  @override
  String get ok => 'ठीक है';

  @override
  String get open_project_screen_desc =>
      'पहले बनाए गए प्रोजेक्ट खोलें, केवल हाल के 20 प्रोजेक्ट रखें।';

  @override
  String get open_project_screen_no_project => 'कोई प्रोजेक्ट नहीं मिला।';

  @override
  String get open_project_screen_title => 'प्रोजेक्ट खोलें';

  @override
  String get product_copyright => 'कॉपीराइट © 2025';

  @override
  String get product_desc =>
      'कंप्यूटर विज़न और एआई का उपयोग करके लोगों, वाहनों, पालतू जानवरों और अन्य चीज़ों की गिनती करें।';

  @override
  String get product_name => 'काउंटर';

  @override
  String get project_screen_add_video_button => 'वीडियो स्रोत जोड़ें';

  @override
  String get project_screen_exit_button => 'बाहर निकलें';

  @override
  String get project_screen_exit_confirm_content =>
      'प्रोजेक्ट छोड़ने से गिनती बंद हो जाएगी। क्या आप वाकई जारी रखना चाहते हैं?';

  @override
  String get project_screen_exit_confirm_title =>
      'प्रोजेक्ट से बाहर निकलने की पुष्टि करें';

  @override
  String get project_screen_from_desc =>
      'हम 24 घंटे का रोलिंग रिकॉर्ड रखते हैं, ताकि आप जरूरत के अनुसार किसी भी समय का हिस्सा देख सकें।';

  @override
  String get project_screen_report_settings => 'सेटिंग्स';

  @override
  String get project_screen_title => 'प्रोजेक्ट';

  @override
  String get project_view_no_videos => 'कोई वीडियो स्रोत उपलब्ध नहीं है।';

  @override
  String get settings_screen_center_point_button =>
      'लक्ष्य पर केंद्र बिंदु दिखाएं';

  @override
  String get settings_screen_center_point_desc =>
      'केंद्र बिंदु यह निर्धारित करने में मदद करता है कि लक्ष्य हिट ज़ोन के भीतर है या नहीं।';

  @override
  String get settings_screen_center_point_title => 'लक्ष्य पर केंद्र बिंदु';

  @override
  String get settings_screen_delete_button => 'हटाएं';

  @override
  String get settings_screen_delete_content =>
      'क्या आप सुनिश्चित हैं कि आप इस प्रोजेक्ट को हटाना चाहते हैं?';

  @override
  String get settings_screen_delete_header => 'इस प्रोजेक्ट को हटाएं';

  @override
  String get settings_screen_desc =>
      'प्रोजेक्ट नाम, डिटेक्शन पैरामीटर, गिनती साफ़ करना सेट करें।';

  @override
  String get settings_screen_lost_target_button => 'खोया हुआ लक्ष्य दिखाएं';

  @override
  String get settings_screen_lost_target_desc =>
      'जब ऑब्जेक्ट ट्रैकिंग किसी लक्ष्य को खो देती है, तो यह विकल्प उसे दिखाता है। डिफ़ॉल्ट रूप से, खोए हुए लक्ष्य नहीं दिखाए जाते हैं।';

  @override
  String get settings_screen_lost_target_title => 'खोया हुआ लक्ष्य';

  @override
  String get settings_screen_project_error =>
      'प्रोजेक्ट का नाम खाली नहीं हो सकता';

  @override
  String get settings_screen_project_id => 'प्रोजेक्ट आईडी';

  @override
  String get settings_screen_project_name => 'प्रोजेक्ट का नाम';

  @override
  String get settings_screen_project_name_place_holder =>
      '123 मुख्य सड़क या पार्क एवेन्यू';

  @override
  String get settings_screen_random_count_button => 'यादृच्छिक गिनती जोड़ें';

  @override
  String get settings_screen_reset_count_button => 'गिनती रीसेट करें';

  @override
  String get settings_screen_reset_count_content =>
      'क्या आप सुनिश्चित हैं कि आप सभी गिनती रीसेट करना चाहते हैं?';

  @override
  String get settings_screen_reset_count_header =>
      'इस प्रोजेक्ट में सभी गिनती रीसेट करें';

  @override
  String get settings_screen_title => 'सेटिंग्स';

  @override
  String get submit => 'सबमिट';

  @override
  String get url_screen_desc => 'कृपया लाइव स्ट्रीम URL दर्ज करें';

  @override
  String get url_screen_title => 'लाइव स्ट्रीम URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream या rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'वर्तमान ज़ोन में बिंदु जोड़ें';

  @override
  String get video_screen_add_zone => 'डिटेक्शन ज़ोन जोड़ें';

  @override
  String get video_screen_change_file => 'फाइल बदलें';

  @override
  String get video_screen_delete_button => 'हटाएं';

  @override
  String get video_screen_delete_content =>
      'क्या आप सुनिश्चित हैं कि आप इस वीडियो स्रोत को हटाना चाहते हैं?';

  @override
  String get video_screen_delete_header => 'इस वीडियो स्रोत को हटाएं';

  @override
  String get video_screen_desc =>
      'वीडियो स्रोतों का प्रबंधन करें, डिटेक्शन ज़ोन जोड़ें या संशोधित करें।';

  @override
  String get video_screen_detection => 'मॉडल पैरामीटर';

  @override
  String get video_screen_edit_placeholder =>
      'फ्रंट डोर कैम या पार्किंग लॉट कैम';

  @override
  String get video_screen_move_bottom => 'वर्तमान ज़ोन को नीचे ले जाएं';

  @override
  String get video_screen_name_empty => 'वीडियो का नाम खाली नहीं हो सकता।';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'वर्तमान: ';

  @override
  String get video_screen_playback_speed => 'प्लेबैक स्पीड';

  @override
  String get video_screen_remove_point => 'वर्तमान ज़ोन से बिंदु हटाएं';

  @override
  String get video_screen_sources =>
      'इमेज स्रोत, डिटेक्शन लक्ष्य और मॉडल पैरामीटर कॉन्फ़िगर करें।';

  @override
  String get video_screen_targets => 'डिटेक्शन लक्ष्य';

  @override
  String get video_screen_tools => 'टूल्स';

  @override
  String get video_screen_video_name => 'वीडियो स्रोत का नाम';

  @override
  String get video_screen_zones => 'डिटेक्शन ज़ोन';

  @override
  String get video_screen_zones_desc =>
      'ज़ोन समायोजित करने के लिए ड्रैग और ड्रॉप का उपयोग करें';

  @override
  String get video_sources_camera => 'कैमरा';

  @override
  String get video_sources_camera_denied => 'कैमरे तक पहुंच अस्वीकृत';

  @override
  String get video_sources_camera_denied_msg =>
      'कृपया सेटिंग्स में जाएं और इस ऐप के लिए कैमरा एक्सेस अनुमति दें.';

  @override
  String get video_sources_camera_not_found_message =>
      'कैमरा का उपयोग करने के लिए कैमरा अनुमति की आवश्यकता है';

  @override
  String get video_sources_camera_not_found_title => 'कैमरा नहीं मिला';

  @override
  String get video_sources_file => 'फ़ाइल';

  @override
  String get video_sources_live_stream => 'लाइव स्ट्रीम URL';

  @override
  String get video_sources_photos_denied => 'फ़ोटो तक पहुंच अस्वीकृत';

  @override
  String get video_sources_photos_denied_msg =>
      'कृपया सेटिंग्स में जाएं और इस ऐप के लिए फ़ोटो एक्सेस अनुमति दें.';

  @override
  String get video_sources_photos_goto_settings => 'सेटिंग्स पर जाएं';

  @override
  String get video_sources_webcam => 'वेबकैम';

  @override
  String get video_sources_webcam_not_found_message =>
      'कृपया ऐप की अनुमति और वेबकैम कनेक्शन की जाँच करें';

  @override
  String get video_sources_webcam_not_found_title => 'वेबकैम नहीं मिला';

  @override
  String get webcam_manager_webcam => 'वेबकैम';

  @override
  String get webcam_screen_add_title => 'वेबकैम जोड़ें';

  @override
  String get webcam_screen_edit_title => 'वेबकैम चुनें';

  @override
  String get wizard_screen_about => 'जानकारी';

  @override
  String get wizard_screen_desc =>
      'गिनती शुरू करने के लिए नीचे एक नया प्रोजेक्ट बनाएं।';

  @override
  String get wizard_screen_email_us => 'हमें ईमेल करें';

  @override
  String get wizard_screen_language => 'भाषा';

  @override
  String get wizard_screen_new_project_from => 'इससे नया प्रोजेक्ट';

  @override
  String get wizard_screen_open_projects => 'मौजूदा प्रोजेक्ट खोलें';

  @override
  String get wizard_screen_open_projects_tip =>
      'सभी प्रोजेक्ट्स स्वचालित रूप से स्थानीय रूप से सहेजे जाएंगे';

  @override
  String get yes => 'हां';

  @override
  String get zone_screen_can_not_delete => 'ज़ोन हटा नहीं सकते';

  @override
  String get zone_screen_color => 'रंग';

  @override
  String get zone_screen_delete_button => 'हटाएं';

  @override
  String get zone_screen_delete_content =>
      'क्या आप सुनिश्चित हैं कि आप इस ज़ोन को हटाना चाहते हैं?';

  @override
  String get zone_screen_delete_header => 'इस ज़ोन को हटाएं';

  @override
  String get zone_screen_desc =>
      'डिटेक्शन ज़ोन में डिटेक्ट करने के लिए ऑब्जेक्ट के प्रकार और प्रदर्शित करने के लिए काउंटर चुन सकते हैं, जैसे कि डिटेक्टेड, स्पॉन्ड और एंटर्ड।';

  @override
  String get zone_screen_name_placeholder =>
      'ज़ोन का नाम, जैसे फुटपाथ या पार्किंग लॉट';

  @override
  String get zone_screen_one_zone_required => 'कम से कम एक ज़ोन आवश्यक है।';

  @override
  String get zone_screen_zone => 'ज़ोन';

  @override
  String get zone_screen_zone_color => 'ज़ोन का रंग';

  @override
  String get zone_screen_zone_name_required => 'ज़ोन का नाम खाली नहीं हो सकता';

  @override
  String get zone_screen_zone_show_summary => 'स्क्रीन पर सारांश दिखाएं';
}
