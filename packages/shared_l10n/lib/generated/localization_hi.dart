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
  String get about_screen_email_us => 'हमें ईमेल करें';

  @override
  String get about_screen_platform => 'प्लेटफॉर्म';

  @override
  String get appeared => 'दिखाई दिए';

  @override
  String get appeared_help =>
      'उन लोगों या वाहनों की संख्या गिनता है जिनकी पहली पहचान की गई स्थिति इस क्षेत्र के भीतर थी।\\n\\nयह समझने में मदद करता है कि ट्रैकिंग कहाँ से शुरू होती है।\\n\\n(मुख्य रूप से उन्नत उपयोगकर्ताओं के लिए)';

  @override
  String get average_occupancy => 'औसत उपस्थिति';

  @override
  String get average_occupancy_help =>
      'वर्तमान गणना अवधि के दौरान इस क्षेत्र में लोगों या वाहनों की औसत संख्या दिखाता है।\\n\\nयह पूरे गणना समय के दौरान क्षेत्र की व्यस्तता को समझने में मदद करता है।';

  @override
  String get average_stay => 'औसत ठहराव समय';

  @override
  String get average_stay_help =>
      'इस क्षेत्र में लोगों या वाहनों के औसत ठहराव समय को दिखाता है।\\n\\nअधिक औसत ठहराव समय यह दिखा सकता है कि ग्राहक इस क्षेत्र में अधिक समय बिता रहे हैं।';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter आपके कैमरे और डिवाइस पर चलने वाले AI का उपयोग लोगों की गिनती के लिए करता है। पहले यह सुनिश्चित करें कि आपका डिवाइस संगत है।';

  @override
  String get camera_test_screen_instruction =>
      'कैमरे को लोगों की ओर करें। ऐप जिन लोगों का पता लगाएगा उनके चारों ओर बॉक्स दिखाएगा।';

  @override
  String get camera_test_screen_next => 'जारी रखने के लिए अगला दबाएँ।';

  @override
  String get camera_test_screen_start =>
      'शुरू करें पर टैप करें। यदि पूछा जाए, तो कैमरे की अनुमति दें।';

  @override
  String get camera_test_screen_test_failed => 'परीक्षण विफल!';

  @override
  String get camera_test_screen_test_passed => 'परीक्षण सफल!';

  @override
  String get camera_test_screen_title => 'एआई कैमरा परीक्षण';

  @override
  String get camera_test_screen_wait =>
      'AI के लोगों का पता लगाने की प्रतीक्षा…';

  @override
  String get cta_screen_custom => 'अपना सर्वर उपयोग करें';

  @override
  String get cta_screen_custom_help =>
      'ट्रैफ़िक डेटा सीधे अपने बैकएंड या डेटाबेस पर भेजें.';

  @override
  String get cta_screen_footer =>
      'जारी रखने पर, आप सेवा की शर्तों, गोपनीयता नीति और डेटा प्रोसेसिंग एग्रीमेंट से सहमत होते हैं।';

  @override
  String get cta_screen_invitation => 'आमंत्रण कोड का उपयोग करें';

  @override
  String get cta_screen_invitation_help =>
      'अपने व्यवस्थापक के आमंत्रण का उपयोग करके किसी मौजूदा संगठन से जुड़ें।';

  @override
  String get cta_screen_local => 'केवल इस डिवाइस पर';

  @override
  String get cta_screen_local_help =>
      'ट्रैफ़िक डेटा केवल इस डिवाइस पर संग्रहीत करें। कोई डेटा अपलोड नहीं किया जाता।';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud का उपयोग करें';

  @override
  String get cta_screen_piyuo_help =>
      'Piyuo Cloud में ट्रैफ़िक डेटा संग्रहीत करें और डैशबोर्ड व व्यावसायिक जानकारी प्राप्त करें.';

  @override
  String get cta_screen_premium => 'प्रीमियम';

  @override
  String get cta_screen_title =>
      'Piyuo Counter हर 5 मिनट में गुमनाम ट्रैफ़िक आँकड़े तैयार करता है।\\nचुनें कि आप अपना डेटा कैसे संग्रहीत करना और उपयोग करना चाहते हैं।';

  @override
  String get current_occupancy => 'वर्तमान संख्या';

  @override
  String get current_occupancy_help =>
      'इस क्षेत्र में लोगों या वाहनों की वर्तमान संख्या दिखाता है।\\n\\nयह संख्या रीयल-टाइम में अपडेट होती है और यह जांचने में मदद करती है कि AI पहचान स्क्रीन पर दिखाई देने वाली स्थिति से मेल खाती है। इसे अपलोड किए गए टेलीमेट्री डेटा में शामिल नहीं किया जाता।';

  @override
  String get custom_server_screen_bearer_saving_action => 'सहेजा जा रहा है...';

  @override
  String get custom_server_screen_server_url_label => 'सर्वर URL';

  @override
  String get detection_screen_confidence => 'विश्वास सीमा';

  @override
  String get detection_screen_confidence_dialog =>
      'यह तय करता है कि किसी व्यक्ति या वाहन को गिनने से पहले AI को कितना निश्चित होना चाहिए।\\nकम मान\\n• अधिक वस्तुएं पहचानता है\\n• दूर या आंशिक रूप से छिपी वस्तुओं के लिए बेहतर\\n• गलत पहचान बढ़ सकती है\\nअधिक मान\\n• केवल उच्च-विश्वास वाली पहचान गिनता है\\n• गलत पहचान कम करता है\\n• छोटी या मुश्किल वस्तुएं छूट सकती हैं\\nयदि ऐप लोगों या वाहनों को छोड़ रहा है, तो कम मान उपयोग करें।\\nयदि ऐप छाया, प्रतिबिंब या अन्य गलत वस्तुएं गिन रहा है, तो अधिक मान उपयोग करें।';

  @override
  String get detection_screen_confidence_help =>
      'किसी वस्तु की पहचान के लिए आवश्यक न्यूनतम विश्वास।';

  @override
  String get detection_screen_confidence_max_label => 'सख्त';

  @override
  String get detection_screen_confidence_min_label => 'कम';

  @override
  String get detection_screen_disappear => 'गायब होने की समय-सीमा';

  @override
  String get detection_screen_disappear_dialog =>
      'यह तय करता है कि किसी वस्तु का पता न चलने के बाद AI उसे \\अदृश्य\\ चिह्नित करने से पहले कितनी देर प्रतीक्षा करता है।\\nछोटे मान\\n• वस्तुओं को जल्दी अदृश्य चिह्नित करते हैं\\n• तेज़ यातायात के लिए बेहतर\\n• अस्थायी रूप से छिपी वस्तुओं को गलत तरीके से अदृश्य चिह्नित कर सकते हैं\\nबड़े मान\\n• वस्तुओं को अदृश्य चिह्नित करने से पहले अधिक प्रतीक्षा करते हैं\\n• जब वस्तुएं संक्षेप में अवरुद्ध या छूट जाती हैं तो बेहतर\\n• अदृश्य होने की घटनाओं में देरी करते हैं';

  @override
  String get detection_screen_disappear_help =>
      'AI द्वारा किसी वस्तु का पता न चलने के बाद उसे गायब मानने से पहले प्रतीक्षा करने का समय।';

  @override
  String get detection_screen_disappear_max_label => 'धीमा';

  @override
  String get detection_screen_disappear_min_label => 'तेज़';

  @override
  String get detection_screen_memory_dialog =>
      'यह तय करता है कि किसी वस्तु के गायब होने के बाद AI उसे कितनी देर याद रखता है।\\nयदि लोग या वाहन अक्सर अन्य वस्तुओं के पीछे छिप जाते हैं, तो यह मान बढ़ाएं।\\nयदि दृश्य छोड़ने के बाद वस्तुएं गलत तरीके से जुड़ जाती हैं, तो यह मान घटाएं।';

  @override
  String get detection_screen_min_presence => 'न्यूनतम उपस्थिति समय';

  @override
  String get detection_screen_min_presence_help =>
      'गिने जाने से पहले किसी वस्तु का कुछ समय तक दिखाई देना आवश्यक है। अधिक मान थोड़े समय की गलत पहचान को कम करने में मदद करते हैं।';

  @override
  String get detection_screen_min_presence_max_label => 'अधिक सुरक्षित';

  @override
  String get detection_screen_min_presence_min_label => 'तेज़';

  @override
  String get detection_screen_minimum_visible =>
      'वस्तुओं को गिनने से पहले इतनी देर तक दिखाई देना चाहिए।\\nसंक्षिप्त गलत पहचान को अनदेखा करने के लिए यह मान बढ़ाएं।\\nयदि तेज़ी से चलने वाले लोग या वाहन छूट रहे हैं, तो यह मान घटाएं।';

  @override
  String get detection_screen_new_track => 'नई ट्रैक सीमा';

  @override
  String get detection_screen_new_track_help =>
      'नए ऑब्जेक्ट की ट्रैकिंग शुरू करने के लिए आवश्यक न्यूनतम विश्वास। कम मान से डुप्लिकेट ट्रैक बन सकते हैं।';

  @override
  String get detection_screen_new_track_max_label => 'संयमित';

  @override
  String get detection_screen_new_track_min_label => 'आक्रामक';

  @override
  String get detection_screen_reset => 'रीसेट';

  @override
  String get detection_screen_reset_content =>
      'क्या आप सुनिश्चित हैं कि आप डिटेक्शन सेटिंग्स रीसेट करना चाहते हैं?';

  @override
  String get detection_screen_show_track_id => 'ট্রैক आईडी दिखाएं';

  @override
  String get detection_screen_show_track_id_help =>
      'इस विकल्प को सक्षम करें ताकि प्रत्येक ट्रैक की गई वस्तु के लिए अद्वितीय ट्रैक आईडी दिखाई दे।';

  @override
  String get detection_screen_stay => 'रुकने का समय';

  @override
  String get detection_screen_stay_help =>
      'किसी वस्तु को रुकना माने जाने से पहले उसे क्षेत्र में कितनी देर रहना होगा।';

  @override
  String get detection_screen_stay_max_label => 'विलंबित';

  @override
  String get detection_screen_stay_min_label => 'तुरंत';

  @override
  String get detection_screen_stay_threshold =>
      'यह तय करता है कि कोई वस्तु \\Stay\\ गिनती में कब योगदान देती है।\\nछोटे मान\\n• तुरंत ठहराव गिनते हैं\\n• त्वरित विश्लेषण के लिए बेहतर\\nबड़े मान\\n• संक्षिप्त गुजरने वाले यातायात को अनदेखा करते हैं\\n• अधिभोग मापने के लिए बेहतर';

  @override
  String get detection_screen_subtitle =>
      'AI द्वारा वस्तुओं की पहचान और ट्रैकिंग को समायोजित करें';

  @override
  String get detection_screen_title => 'ट्रैकिंग और गणना';

  @override
  String get detection_screen_track_dialog =>
      'यह तय करता है कि नई पहचानी गई वस्तु कब एक नया ट्रैक बनती है।\\nकम मान\\n• ट्रैकिंग जल्दी शुरू होती है\\n• तेज़ी से चलने वाली वस्तुओं के लिए बेहतर\\n• डुप्लीकेट ट्रैक बन सकते हैं\\nअधिक मान\\n• नया ट्रैक बनाने से पहले मजबूत सबूत चाहिए\\n• डुप्लीकेट ट्रैक कम करता है\\n• नई वस्तुओं की ट्रैकिंग में देरी हो सकती है';

  @override
  String get detection_screen_track_memory => 'ट्रैकिंग मेमोरी';

  @override
  String get detection_screen_track_memory_help =>
      'किसी वस्तु के अस्थायी रूप से खो जाने के बाद उसे कितनी देर तक ट्रैक किया जाए। अधिक समय छोटी रुकावटों के बाद ट्रैक वापस पाने में मदद करता है।';

  @override
  String get detection_screen_track_memory_max_label => 'लंबा';

  @override
  String get detection_screen_track_memory_min_label => 'छोटा';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter आपके कैमरे का उपयोग करके पैदल यात्रियों और वाहनों का रीयल-टाइम में पता लगाता है। इस डिवाइस में कैमरा उपलब्ध नहीं है.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'इस ऐप को अपने फ़ोन पर खोलकर देखें';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'कैमरे वाला स्मार्टफ़ोन या टैबलेट';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'iOS या Android डिवाइस की अनुशंसा की जाती है';

  @override
  String get device_not_supported_screen_requirements_title =>
      'आपको क्या चाहिए';

  @override
  String get device_not_supported_screen_title => 'कैमरा नहीं मिला';

  @override
  String get disappeared => 'गायब हुए';

  @override
  String get disappeared_help =>
      'उन लोगों या वाहनों की संख्या गिनता है जिनकी अंतिम पहचानी गई स्थिति इस क्षेत्र के भीतर थी।\\n\\nयदि निर्धारित Disappear Time तक व्यक्ति या वाहन का पता नहीं चलता, तो ट्रैकिंग समाप्त हो जाती है।\\n\\n(मुख्य रूप से उन्नत उपयोगकर्ताओं के लिए)';

  @override
  String get dpa => 'डेटा प्रोसेसिंग एग्रीमेंट';

  @override
  String get durationDaysShort => '%sदि';

  @override
  String get durationHoursShort => '%sघं';

  @override
  String get durationMinutesShort => '%sमि';

  @override
  String get durationSecondsShort => '%sसे';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'प्रवेश किया';

  @override
  String get entered_help =>
      'वर्तमान गणना अवधि के दौरान इस क्षेत्र में प्रवेश करने वाले लोगों या वाहनों की संख्या गिनता है।\\n\\nजब कोई व्यक्ति या वाहन क्षेत्र के बाहर से अंदर आता है, तो एक प्रवेश गिना जाता है।';

  @override
  String get exited => 'बाहर निकले';

  @override
  String get exited_help =>
      'वर्तमान गणना अवधि के दौरान इस क्षेत्र से बाहर जाने वाले लोगों या वाहनों की संख्या गिनता है।\\n\\nजब कोई व्यक्ति या वाहन क्षेत्र के अंदर से बाहर जाता है, तो एक निकास गिना जाता है।';

  @override
  String get language_screen_language => 'भाषा';

  @override
  String get language_screen_subtitle =>
      'ऐप में उपयोग की जाने वाली भाषा चुनें।';

  @override
  String get local_only_screen_body =>
      '\'केवल लोकल डिवाइस\' मोड आपको बिना कोई डेटा अपलोड किए AI कैमरा डिटेक्शन और ट्रैकिंग आज़माने देता है। सभी फुट ट्रैफिक आँकड़े केवल इसी डिवाइस पर प्रोसेस होते हैं, जो सर्वर से जुड़ने से पहले जाँचने के लिए बढ़िया है।';

  @override
  String get local_only_screen_use_action =>
      'केवल स्थानीय डिवाइस का उपयोग करें';

  @override
  String get local_screen_text =>
      'Piyuo Counter पूरी तरह इस डिवाइस पर चलेगा।\\nट्रैफ़िक आँकड़े केवल इसी डिवाइस पर संग्रहीत होंगे और अपलोड नहीं किए जाएँगे।\\nबाद में आप Settings से Piyuo Cloud या अपने सर्वर से जुड़ सकते हैं।';

  @override
  String get maximum_occupancy => 'अधिकतम उपस्थिति';

  @override
  String get maximum_occupancy_help =>
      'वर्तमान गणना अवधि के दौरान किसी भी समय इस क्षेत्र में मौजूद लोगों या वाहनों की अधिकतम संख्या दिखाता है।\\n\\nभीड़ या यातायात के सबसे व्यस्त समय की पहचान करने में उपयोगी।';

  @override
  String get maximum_stay => 'अधिकतम ठहराव समय';

  @override
  String get maximum_stay_help =>
      'वर्तमान गणना अवधि के दौरान किसी व्यक्ति या वाहन के इस क्षेत्र में सबसे लंबे समय तक ठहरने की अवधि दिखाता है।\\n\\nअसामान्य रूप से लंबे ठहराव या रुकने की पहचान करने में उपयोगी।';

  @override
  String get metric_events => 'इवेंट';

  @override
  String get metric_live => 'लाइव';

  @override
  String get metric_show_less => 'कम दिखाएँ';

  @override
  String get metric_show_more => 'और दिखाएँ';

  @override
  String get metric_statistics => 'सांख्यिकी';

  @override
  String get metrics_counting_all => 'सभी';

  @override
  String get metrics_counting_done => 'पूर्ण';

  @override
  String get metrics_counting_in_progress => 'प्रगति पर';

  @override
  String get metrics_counting_missing => 'अनुपस्थित';

  @override
  String get metrics_counting_window => 'हर 5 मिनट की अवधि के आँकड़े';

  @override
  String get onboarding_back_action => 'वापस';

  @override
  String get onboarding_cta_no_server => 'डेटा अपलोड नहीं करना चाहते?';

  @override
  String get onboarding_cta_title => 'आपका डेटा कहाँ भेजा जाए?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter आपके फ़ोन के कैमरे और उसी में मौजूद AI से लोगों और वाहनों को तुरंत पहचानता है।\\nपहचान और ट्रैकिंग तकनीक की मदद से, यह पैदल यात्रियों और वाहनों की आवाजाही अपने आप गिनता है — सब कुछ आपके फ़ोन पर ही होता है।';

  @override
  String get onboarding_intro_text2 =>
      'सारा AI प्रोसेसिंग आपके फ़ोन पर ही होता है। कोई वीडियो, तस्वीर, चेहरा या पहचान अपलोड नहीं की जाती।\\nसिर्फ़ हर 5 मिनट में गुमनाम सारांश साझा किया जाता है, जिसमें गिनती, अधिभोग, प्रवेश, निकास, और ठहराव समय के आँकड़े शामिल हैं।';

  @override
  String get onboarding_intro_text3 =>
      'बस ऐप शुरू करें और उसे चलने दें। Piyuo Counter अपने आप लगातार ट्रैफ़िक डेटा इकट्ठा करता और सहेजता है।\\nडेटा सारांश हर 5 मिनट में सहेजा जाता है और हर घंटे Piyuo Cloud या आपके अपने सर्वर पर अपलोड होता है।';

  @override
  String get onboarding_intro_title1 => 'एआई ट्रैफ़िक गणना';

  @override
  String get onboarding_intro_title2 => 'डिज़ाइन से ही गोपनीयता';

  @override
  String get onboarding_intro_title3 => '24/7 अपने आप चलता है';

  @override
  String get onboarding_next_action => 'अगला';

  @override
  String get onboarding_skip_action => 'परिचय छोड़ें';

  @override
  String get onboarding_start_action => 'शुरू करें';

  @override
  String get passed_by => 'गुज़रे';

  @override
  String get passed_by_help =>
      'वर्तमान गणना अवधि के दौरान इस क्षेत्र से गुजरने वाले लोगों या वाहनों की संख्या गिनता है।\\n\\nप्रत्येक व्यक्ति या वाहन को क्षेत्र से प्रत्येक बार गुजरने पर केवल एक बार गिना जाता है।';

  @override
  String get payloads_screen_area => 'क्षेत्र';

  @override
  String get payloads_screen_confidence => 'विश्वसनीयता';

  @override
  String get payloads_screen_coverage => 'कवरेज';

  @override
  String get payloads_screen_delivered => 'वितरित';

  @override
  String get payloads_screen_failed_load => 'हाल के पेलोड लोड करने में विफल';

  @override
  String get payloads_screen_frame_processed => 'प्रोसेस किए गए फ़्रेम';

  @override
  String get payloads_screen_hour_not_exists => 'यह घंटा अब मौजूद नहीं है।';

  @override
  String get payloads_screen_missing_time => 'छूटा हुआ समय';

  @override
  String get payloads_screen_no_payloads => 'अभी तक कोई पेलोड नहीं।';

  @override
  String get payloads_screen_partial => 'विंडो जल्दी समाप्त हुई (आंशिक)';

  @override
  String get payloads_screen_partially => 'आंशिक रूप से वितरित';

  @override
  String get payloads_screen_payload_not_exists => 'यह पेलोड अब मौजूद नहीं है।';

  @override
  String get payloads_screen_pending => 'प्रेषण लंबित';

  @override
  String get payloads_screen_process_fps => 'प्रोसेस FPS';

  @override
  String get payloads_screen_resend => 'फिर भेजें';

  @override
  String get payloads_screen_select_first =>
      'पहले कम से कम एक तारीख या घंटा चुनें।';

  @override
  String get payloads_screen_subtitle => 'फिर भेजने के लिए तारीख या घंटा चुनें';

  @override
  String get payloads_screen_title => 'हाल के पेलोड';

  @override
  String get personal_custom_screen_build_server =>
      'क्या अपना सर्वर सेट करने में सहायता चाहिए?\\nहमारा API दस्तावेज़ और सर्वर उदाहरण देखें।';

  @override
  String get personal_custom_screen_help_action => 'API दस्तावेज़ खोलें';

  @override
  String get personal_custom_screen_reset_action => 'फिर से शुरू करें';

  @override
  String get personal_custom_success_screen_help =>
      'गिनती शुरू करने के लिए नीचे Start पर टैप करें।';

  @override
  String get personal_custom_success_screen_help1 =>
      'ट्रैफ़िक आँकड़े हर घंटे अपने आप अपलोड होते हैं।\\nआप Upload Logs स्क्रीन से इन्हें मैन्युअल रूप से भी अपलोड कर सकते हैं。';

  @override
  String get personal_custom_success_screen_help2 =>
      'आपका सर्वर अभी ऑनलाइन होना ज़रूरी नहीं है।\\nअभी गिनती शुरू करें। बाद में आप अपना सर्वर पूरा बनाकर उसका परीक्षण कर सकते हैं। ट्रैफ़िक आँकड़े सफलतापूर्वक अपलोड होने तक इसी डिवाइस पर सुरक्षित रहेंगे।';

  @override
  String get personal_custom_success_screen_send_to =>
      'ट्रैफ़िक आँकड़े यहाँ भेजे जाएंगे';

  @override
  String get personal_custom_success_screen_title => 'आपका सर्वर तैयार है';

  @override
  String get piyuo_server_screen_cloud_url_label => 'आपका Piyuo Cloud URL';

  @override
  String get piyuo_server_screen_copy_action => 'URL कॉपी करें';

  @override
  String get piyuo_server_screen_copy_success => 'URL कॉपी हो गया';

  @override
  String get piyuo_server_screen_saving_action => 'सहेजा जा रहा है...';

  @override
  String get piyuo_server_screen_start =>
      'गिनती शुरू करने के लिए नीचे \"Start\" दबाएँ।';

  @override
  String get piyuo_server_screen_url_help =>
      'आपका व्यक्तिगत Piyuo Cloud डैशबोर्ड इस URL पर तैयार है।';

  @override
  String get piyuo_server_screen_url_remember =>
      'अपने ट्रैफ़िक डैशबोर्ड को किसी अन्य डिवाइस से खोलने के लिए इस URL को सुरक्षित रखें।';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloud का उपयोग करें';

  @override
  String get privacy => 'गोपनीयता नीति';

  @override
  String get product_copyright => 'कॉपीराइट © 2026';

  @override
  String get product_desc => 'एआई-संचालित लोगों और वाहनों की गणना।';

  @override
  String get settings_screen_custom_subtitle =>
      'ट्रैफ़िक डेटा सीधे अपने बैकएंड या डेटाबेस पर भेजें।';

  @override
  String get settings_screen_custom_title => 'कस्टम सर्वर का उपयोग करें';

  @override
  String get settings_screen_data_server_label => 'डेटा सर्वर';

  @override
  String get settings_screen_detection_target => 'पहचान लक्ष्य';

  @override
  String get settings_screen_language_title => 'भाषा';

  @override
  String get settings_screen_local_subtitle =>
      'ट्रैफ़िक डेटा केवल इस डिवाइस पर संग्रहीत करें। कुछ भी अपलोड नहीं किया जाएगा।';

  @override
  String get settings_screen_local_title => 'केवल स्थानीय डिवाइस';

  @override
  String get settings_screen_misc_label => 'विविध';

  @override
  String get settings_screen_object_detection => 'ऑब्जेक्ट पहचान';

  @override
  String get settings_screen_piyuo_subtitle =>
      'अपने ट्रैफ़िक डेटा को Piyuo Cloud में डैशबोर्ड और व्यावसायिक जानकारी के साथ सुरक्षित रखें.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'यह सभी डेटा मिटाकर फिर से शुरुआत करेगा। इस कार्रवाई को वापस नहीं किया जा सकता।';

  @override
  String get settings_screen_reset_all_data_title => 'सारा डेटा रीसेट करें?';

  @override
  String get settings_screen_subscription_body =>
      'अपनी सदस्यता और बिलिंग विवरण प्रबंधित करें';

  @override
  String get settings_screen_subscription_title => 'सदस्यता';

  @override
  String get start_screen_about => 'जानकारी';

  @override
  String get start_screen_server_none =>
      'डेटा केवल इसी डिवाइस पर संग्रहीत रहेगा';

  @override
  String get start_screen_server_personal => 'डेटा हर घंटे अपलोड किया जाता है';

  @override
  String get start_screen_settings => 'सेटिंग्स';

  @override
  String get start_screen_upload_logs => 'लॉग अपलोड करें';

  @override
  String get start_screen_video_sources => 'वीडियो स्रोत';

  @override
  String get stayed => 'रुके';

  @override
  String get stayed_help =>
      'इस क्षेत्र में कम से कम निर्धारित ठहराव समय तक रुके लोगों या वाहनों की संख्या गिनता है।\\n\\nडिफ़ॉल्ट Stay Time 15 सेकंड है और इसे Settings में बदला जा सकता है।';

  @override
  String get target_pedestrian => 'पैदल यात्री';

  @override
  String get target_pedestrian_help =>
      'पैदल यात्री पहचान मॉडल से लोगों की गिनती करें';

  @override
  String get target_screen_subtitle => 'कौन सा पहचान मॉडल उपयोग करना है, चुनें';

  @override
  String get target_vehicle => 'वाहन';

  @override
  String get target_vehicle_help =>
      'वाहन मॉडल से कारों और अन्य वाहनों की गिनती करें';

  @override
  String get telemetry_error_connection_refused =>
      'सर्वर से संपर्क नहीं हो सका। हो सकता है यह अभी ऑफ़लाइन हो।';

  @override
  String get telemetry_error_connection_reset =>
      'कनेक्शन रीसेट हो गया। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।';

  @override
  String get telemetry_error_connection_timeout =>
      'कनेक्शन को प्रतिक्रिया देने में बहुत समय लगा। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।';

  @override
  String get telemetry_error_database_error =>
      'डेटाबेस में लिखने में विफल रहा।';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'सर्वर का पता नहीं मिला। कृपया अपना इंटरनेट कनेक्शन या सर्वर URL जांचें।';

  @override
  String get telemetry_error_http_error_status =>
      'सर्वर ने अनुरोध अस्वीकार कर दिया। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get telemetry_error_http_unknown_error =>
      'सर्वर से संचार करते समय एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get telemetry_error_invalid_url =>
      'सर्वर का पता अमान्य है। कृपया अपनी सेटिंग्स जांचें।';

  @override
  String get telemetry_error_network_error =>
      'नेटवर्क में त्रुटि हुई। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।';

  @override
  String get telemetry_error_socket_error =>
      'नेटवर्क कनेक्शन में समस्या हुई। कृपया अपना इंटरनेट कनेक्शन जांचें।';

  @override
  String get telemetry_error_transport_exception =>
      'डेटा भेजते समय कुछ गड़बड़ हुई। कृपया पुनः प्रयास करें।';

  @override
  String get telemetry_error_unknown_error => 'एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get terms => 'सेवा की शर्तें';

  @override
  String get upload_screen_attempt_time => 'प्रयास का समय:';

  @override
  String get upload_screen_error => 'त्रुटि:';

  @override
  String get upload_screen_failed => 'विफल';

  @override
  String get upload_screen_load_error => 'अपलोड लॉग लोड नहीं किए जा सके।';

  @override
  String get upload_screen_log_not_exists => 'अपलोड लॉग अब उपलब्ध नहीं है।';

  @override
  String get upload_screen_next => 'अगला अपलोड ...';

  @override
  String get upload_screen_next_upload_prefix => 'अगला अपलोड ';

  @override
  String get upload_screen_no_data_server => 'कृपया पहले डेटा सर्वर सेट करें।';

  @override
  String get upload_screen_no_logs => 'अभी तक कोई अपलोड लॉग नहीं।';

  @override
  String get upload_screen_payload_count => 'पेलोड की संख्या';

  @override
  String get upload_screen_payload_count_label => 'पेलोड की संख्या:';

  @override
  String get upload_screen_payload_size => 'पेलोड आकार:';

  @override
  String get upload_screen_result => 'परिणाम:';

  @override
  String get upload_screen_retry => 'पुनः प्रयास की संख्या:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'सफल';

  @override
  String get upload_screen_today => 'आज';

  @override
  String get upload_screen_upload_now => 'अभी अपलोड करें';

  @override
  String get upload_screen_upload_success => 'अपलोड सफल।';

  @override
  String get upload_screen_uploading => 'अपलोड हो रहा है...';

  @override
  String get upload_screen_yesterday => 'कल';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP URL में होस्ट नाम होना चाहिए।';

  @override
  String get url_screen_invalid_url_error =>
      'समर्थित स्कीम के साथ मान्य URL दर्ज करें।';

  @override
  String get url_screen_subtitle => 'कृपया लाइव स्ट्रीम URL दर्ज करें';

  @override
  String get url_screen_title => 'लाइव स्ट्रीम URL';

  @override
  String get url_screen_unsupported_scheme_error => ' RTSP και RTSPS.';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'कृपया लाइव स्ट्रीम URL दर्ज करें।';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream या rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'रियर कैमरा';

  @override
  String get video_sources_camera => 'कैमरा';

  @override
  String get video_sources_file => 'फ़ाइल';

  @override
  String get video_sources_front_camera => 'फ्रंट कैमरा';

  @override
  String get video_sources_live_stream => 'लाइव स्ट्रीम URL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'कैमरा का उपयोग करने के लिए कैमरा अनुमति की आवश्यकता है';

  @override
  String get video_sources_screen_camera_not_found_title => 'कैमरा नहीं मिला';

  @override
  String get video_sources_screen_import_error =>
      'वीडियो फ़ाइल आयात नहीं हो सकी।';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'कृपया सेटिंग्स में जाएं और इस ऐप के लिए फ़ोटो एक्सेस अनुमति दें.';

  @override
  String get video_sources_screen_select_camera =>
      'इस कैमरे को चुनने के लिए टैप करें';

  @override
  String get video_sources_screen_select_file => 'फ़ाइल चुनने के लिए टैप करें';

  @override
  String get video_sources_screen_select_live =>
      'लाइव स्ट्रीम URL सेट करने के लिए टैप करें';

  @override
  String get video_sources_webcam => 'वेबकैम';
}
