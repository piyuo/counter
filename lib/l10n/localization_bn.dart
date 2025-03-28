// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class LocalizationBn extends Localization {
  LocalizationBn([String locale = 'bn']) : super(locale);

  @override
  String get product_name => 'কাউন্টার';

  @override
  String get product_desc => 'কম্পিউটার ভিশন এবং এআই ব্যবহার করে মানুষ, যানবাহন, পোষা প্রাণী এবং আরও অনেক কিছু গণনা করুন।';

  @override
  String get product_copyright => 'কপিরাইট © ২০২৫';

  @override
  String get video_sources_webcam => 'ওয়েবক্যাম';

  @override
  String get video_sources_live_stream => 'লাইভ স্ট্রিম URL';

  @override
  String get video_sources_file => 'ফাইল';

  @override
  String get video_sources_camera => 'ক্যামেরা';

  @override
  String get video_sources_camera_not_found_title => 'ক্যামেরা পাওয়া যায়নি';

  @override
  String get video_sources_camera_not_found_message => 'ক্যামেরা ব্যবহার করতে অনুমতি প্রদান করুন';

  @override
  String get video_sources_webcam_not_found_title => 'ওয়েবক্যাম পাওয়া যায়নি';

  @override
  String get video_sources_webcam_not_found_message => 'অ্যাপ্লিকেশনকে ক্যামেরা অনুমতি এবং সংযোগ যাচাই করুন';

  @override
  String get wizard_screen_desc => 'গণনা শুরু করতে নিচে একটি নতুন প্রজেক্ট তৈরি করুন।';

  @override
  String get wizard_screen_new_project_from => 'উৎস থেকে নতুন প্রজেক্ট';

  @override
  String get wizard_screen_language => 'ভাষা';

  @override
  String get wizard_screen_about => 'সম্পর্কে';

  @override
  String get wizard_screen_open_projects_tip => 'সমস্ত প্রজেক্ট স্বয়ংক্রিয়ভাবে স্থানীয়ভাবে সংরক্ষণ করা হবে';

  @override
  String get wizard_screen_open_projects => 'বিদ্যমান প্রজেক্ট খুলুন';

  @override
  String get wizard_screen_email_us => 'আমাদের ইমেইল করুন';

  @override
  String get language_screen_language => 'ভাষা';

  @override
  String get project_view_no_videos => 'কোনো ভিডিও উৎস নেই।';

  @override
  String get about_screen_title => 'সম্পর্কে';

  @override
  String get about_screen_platform => 'প্ল্যাটফর্ম';

  @override
  String get about_screen_app_version => 'অ্যাপ ভার্সন';

  @override
  String get about_screen_models => 'অবজেক্ট ডিটেকশন মডেল';

  @override
  String get about_screen_benchmark => 'বেঞ্চমার্ক';

  @override
  String get about_screen_opencv_build_info => 'OpenCV বিল্ড তথ্য';

  @override
  String get benchmark_screen_title => 'মডেল বেঞ্চমার্ক';

  @override
  String get benchmark_screen_recommended => 'প্রস্তাবিত মডেল';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'বেঞ্চমার্ক শুরু করুন';

  @override
  String get benchmark_screen_start_failed => 'বেঞ্চমার্ক শুরু করতে ব্যর্থ, ত্রুটি কোড হল';

  @override
  String get benchmark_screen_models => 'অবজেক্ট ডিটেকশন মডেল';

  @override
  String get project_screen_title => 'প্রজেক্ট';

  @override
  String get project_screen_exit_confirm_title => 'প্রজেক্ট থেকে বের হওয়া নিশ্চিত করুন';

  @override
  String get project_screen_exit_confirm_content => 'প্রজেক্ট ছেড়ে যাওয়া গণনা বন্ধ করবে। আপনি কি চালিয়ে যেতে চান?';

  @override
  String get project_screen_exit_button => 'প্রস্থান';

  @override
  String get project_screen_add_video_button => 'ভিডিও উৎস যোগ করুন';

  @override
  String get project_screen_from_desc => 'আমরা ২৪ ঘন্টার রেকর্ড রাখি, তাই আপনি যেকোনো সময় দেখতে পারেন।';

  @override
  String get project_screen_report_settings => 'সেটিংস';

  @override
  String get filter_screen_title => 'ফিল্টার';

  @override
  String get filter_screen_desc => 'নিচের তালিকা থেকে একটি ফিল্টার রেঞ্জ নির্বাচন করুন';

  @override
  String get filter_screen_error_title => 'ফিল্টার';

  @override
  String get filter_screen_error_content => 'শেষ সময় শুরুর সময়ের চেয়ে বেশি হতে হবে';

  @override
  String get filter_screen_error_custom => 'কাস্টম';

  @override
  String get filter_screen_error_start => 'শুরু';

  @override
  String get filter_screen_error_end => 'শেষ';

  @override
  String get settings_screen_title => 'সেটিংস';

  @override
  String get settings_screen_desc => 'প্রজেক্টের নাম, ডিটেকশন পরামিতি, গণনা পরিষ্কার সেট করুন।';

  @override
  String get settings_screen_project_id => 'প্রজেক্ট আইডি';

  @override
  String get settings_screen_project_name => 'প্রজেক্টের নাম';

  @override
  String get settings_screen_project_name_place_holder => '১২৩ মেইন স্ট্রিট বা পার্ক এভিনিউ';

  @override
  String get settings_screen_project_error => 'প্রজেক্টের নাম খালি রাখা যাবে না';

  @override
  String get settings_screen_random_count_button => 'এলোমেলো গণনা যোগ করুন';

  @override
  String get settings_screen_reset_count_header => 'এই প্রজেক্টের সমস্ত গণনা রিসেট করুন';

  @override
  String get settings_screen_reset_count_button => 'গণনা রিসেট করুন';

  @override
  String get settings_screen_reset_count_content => 'আপনি কি নিশ্চিত যে আপনি সমস্ত গণনা রিসেট করতে চান?';

  @override
  String get settings_screen_delete_header => 'এই প্রজেক্ট মুছুন';

  @override
  String get settings_screen_delete_content => 'আপনি কি নিশ্চিত যে আপনি এই প্রজেক্ট মুছতে চান?';

  @override
  String get settings_screen_delete_button => 'মুছুন';

  @override
  String get settings_screen_center_point_title => 'লক্ষ্যবস্তুর মধ্যবিন্দু';

  @override
  String get settings_screen_center_point_desc => 'মধ্যবিন্দু নির্ধারণ করতে সাহায্য করে লক্ষ্যবস্তু হিট জোনের ভিতরে আছে কিনা।';

  @override
  String get settings_screen_center_point_button => 'লক্ষ্যবস্তুর মধ্যবিন্দু দেখান';

  @override
  String get settings_screen_lost_target_title => 'হারানো লক্ষ্যবস্তু';

  @override
  String get settings_screen_lost_target_desc => 'যখন অবজেক্ট ট্র্যাকিং একটি লক্ষ্যবস্তু হারায়, এই অপশন এটি দৃশ্যমান করে। ডিফল্টভাবে, হারানো লক্ষ্যবস্তু দেখানো হয় না।';

  @override
  String get settings_screen_lost_target_button => 'হারানো লক্ষ্যবস্তু দেখান';

  @override
  String get detection_screen_title => 'ডিটেকশন সেটিংস';

  @override
  String get detection_screen_models => 'মডেল';

  @override
  String get detection_screen_confidence => 'কনফিডেন্স';

  @override
  String get detection_screen_confidence_desc => '#0 এর চেয়ে বেশি কনফিডেন্স বৈধ ডিটেকশন হিসাবে বিবেচিত হবে';

  @override
  String get detection_screen_low => 'কম';

  @override
  String get detection_screen_high => 'বেশি';

  @override
  String get detection_screen_nms => 'নন-ম্যাক্সিমাম সাপ্রেশন';

  @override
  String get detection_screen_nms_desc => '#0 কম NMS থ্রেশহোল্ড (যেমন, ৩০%) আরও আক্রমণাত্মকভাবে ওভারল্যাপিং বাউন্ডিং বক্স সরিয়ে ফেলবে, যখন উচ্চ NMS থ্রেশহোল্ড (যেমন, ০.৬) আরও ওভারল্যাপ অনুমতি দেবে';

  @override
  String get detection_screen_match => 'মিল';

  @override
  String get detection_screen_match_desc => '#0 এর বেশি মিল একই অবজেক্ট হিসাবে বিবেচিত হবে।';

  @override
  String get detection_screen_lost => 'হারিয়ে গেছে';

  @override
  String get detection_screen_lost_desc => '#0 সময়ের জন্য হারিয়ে গেলে ট্র্যাক অবজেক্ট সরানো হবে';

  @override
  String get detection_screen_consider_valid => 'বৈধ হিসাবে বিবেচনা করুন';

  @override
  String get detection_screen_consider_valid_desc => '#0 পরে ট্র্যাক অবজেক্ট বৈধ হিসাবে বিবেচিত হবে';

  @override
  String get detection_screen_reset => 'রিসেট';

  @override
  String get detection_screen_reset_content => 'আপনি কি নিশ্চিত যে আপনি ডিটেকশন সেটিংস রিসেট করতে চান?';

  @override
  String get url_screen_title => 'লাইভ স্ট্রিম URL';

  @override
  String get url_screen_desc => 'লাইভ স্ট্রিম URL লিখুন';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream বা rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'ভিডিও উৎস যোগ করুন';

  @override
  String get add_video_screen_from => 'যোগ করুন ভিডিও উৎস থেকে';

  @override
  String get webcam_screen_add_title => 'ওয়েবক্যাম যোগ করুন';

  @override
  String get webcam_screen_edit_title => 'ওয়েবক্যাম বেছে নিন';

  @override
  String get webcam_manager_webcam => 'ওয়েবক্যাম';

  @override
  String get camera_screen_front_camera => 'সামনের ক্যামেরা';

  @override
  String get camera_screen_back_camera => 'পিছনের ক্যামেরা';

  @override
  String get camera_screen_add_title => 'ক্যামেরা যোগ করুন';

  @override
  String get camera_screen_edit_title => 'ক্যামেরা বেছে নিন';

  @override
  String get camera_screen_zoom_level => 'জুম লেভেল';

  @override
  String get video_screen_name_empty => 'ভিডিওর নাম খালি রাখা যাবে না।';

  @override
  String get video_screen_desc => 'ভিডিও উৎস পরিচালনা করুন, ডিটেকশন জোন যোগ করুন বা পরিবর্তন করুন।';

  @override
  String get video_screen_video_name => 'ভিডিও উৎসের নাম';

  @override
  String get video_screen_edit_placeholder => 'সামনের দরজার ক্যাম বা পার্কিং লট ক্যাম';

  @override
  String get video_screen_change_file => 'ফাইল পরিবর্তন করুন';

  @override
  String get video_screen_add_zone => 'ডিটেকশন জোন যোগ করুন';

  @override
  String get video_screen_zones => 'ডিটেকশন জোন';

  @override
  String get video_screen_zones_desc => 'জোন সামঞ্জস্য করতে ড্র্যাগ এন্ড ড্রপ ব্যবহার করুন';

  @override
  String get video_screen_tools => 'টুলস';

  @override
  String get video_screen_move_bottom => 'বর্তমান জোন নীচে সরান';

  @override
  String get video_screen_add_point => 'বর্তমান জোনে পয়েন্ট যোগ করুন';

  @override
  String get video_screen_remove_point => 'বর্তমান জোন থেকে পয়েন্ট সরান';

  @override
  String get video_screen_playback_speed => 'প্লেব্যাক স্পিড';

  @override
  String get video_screen_playback_current => 'বর্তমান: ';

  @override
  String get video_screen_playback_14x => '১/৪x';

  @override
  String get video_screen_playback_2x => '২x';

  @override
  String get video_screen_delete_header => 'এই ভিডিও উৎস মুছুন';

  @override
  String get video_screen_delete_content => 'আপনি কি নিশ্চিত যে আপনি এই ভিডিও উৎস মুছতে চান?';

  @override
  String get video_screen_delete_button => 'মুছুন';

  @override
  String get video_screen_sources => 'ইমেজ উৎস, ডিটেকশন লক্ষ্যবস্তু এবং মডেল পরামিতি কনফিগার করুন।';

  @override
  String get video_screen_targets => 'ডিটেকশন লক্ষ্যবস্তু';

  @override
  String get video_screen_detection => 'মডেল পরামিতি';

  @override
  String get color_screen_title => 'একটি রঙ বেছে নিন';

  @override
  String get zone_screen_desc => 'ডিটেকশন জোন বিভিন্ন ধরনের অবজেক্ট সনাক্ত করতে এবং কোন কাউন্টার দেখাবে তা নির্বাচন করতে পারে, যেমন ডিটেক্টেড, স্পন্ড এবং এন্টারড।';

  @override
  String get zone_screen_name_placeholder => 'জোনের নাম, যেমন ফুটপাত বা পার্কিং লট';

  @override
  String get zone_screen_zone_color => 'জোনের রঙ';

  @override
  String get zone_screen_color => 'রঙ';

  @override
  String get zone_screen_delete_header => 'এই জোন মুছুন';

  @override
  String get zone_screen_delete_content => 'আপনি কি নিশ্চিত যে আপনি এই জোন মুছতে চান?';

  @override
  String get zone_screen_delete_button => 'মুছুন';

  @override
  String get zone_screen_can_not_delete => 'জোন মুছতে পারবেন না';

  @override
  String get zone_screen_one_zone_required => 'অন্তত একটি জোন প্রয়োজন।';

  @override
  String get zone_screen_zone_name_required => 'জোনের নাম খালি রাখা যাবে না';

  @override
  String get counter_screen_show_on => 'স্ক্রিনে দেখান';

  @override
  String get counter_screen_enabled => 'সক্রিয়';

  @override
  String get counter_screen_reentry_threshold => 'পুনঃপ্রবেশের থ্রেশহোল্ড';

  @override
  String get counter_screen_reentry_desc => 'অবজেক্টকে #0 বার প্রবেশ করতে হবে, প্রতিটি প্রস্থান এবং পুনঃপ্রবেশের মধ্যে #1 সেকেন্ড কুলডাউন সহ, পুনঃপ্রবেশ ট্রিগার করতে';

  @override
  String get counter_screen_reentry_title => 'পুনঃপ্রবেশের গণনা';

  @override
  String get counter_screen_cooldown_threshold => 'কুলডাউন থ্রেশহোল্ড';

  @override
  String get counter_screen_cooldown_desc => 'ডিটেকশন জোন থেকে বেরিয়ে যাওয়ার পরে পুনঃপ্রবেশের জন্য #0 সেকেন্ড কুলডাউন প্রয়োজন';

  @override
  String get counter_screen_cooldown_time => 'কুলডাউন সময়';

  @override
  String get counter_screen_cooldown_in_seconds => 'সেকেন্ডে';

  @override
  String get counter_screen_stagnant_threshold => 'স্থবির থ্রেশহোল্ড';

  @override
  String get counter_screen_stagnant_desc => '#0 সেকেন্ডের বেশি সময় ধরে স্থির থাকা অবজেক্ট স্থবির হিসাবে বিবেচিত হবে';

  @override
  String get counter_screen_stagnant_consider => 'স্থবির হিসাবে বিবেচনা করুন';

  @override
  String get counter_screen_stagnant_in_seconds => 'সেকেন্ডে';

  @override
  String get counter_screen_stagnant_desc_prefix => 'বর্ণনা প্রিফিক্স';

  @override
  String get counter_screen_stagnant_desc_suffix => 'বর্ণনা সাফিক্স';

  @override
  String get counter_screen_name_error => 'কাউন্টার নাম খালি রাখা যাবে না';

  @override
  String get counter_screen_enabled_error => 'ত্রুটি';

  @override
  String get counter_screen_enabled_error_content => 'আপনাকে অন্য কাউন্টার সক্রিয় করতে হবে, তারপর আপনি এই কাউন্টার নিষ্ক্রিয় করতে পারবেন';

  @override
  String get objects_screen_title => 'অবজেক্ট';

  @override
  String get objects_screen_desc => 'ডিটেকশন লক্ষ্যবস্তু যেমন ব্যক্তি, গাড়ি, বাস ইত্যাদি বেছে নিন।';

  @override
  String get open_project_screen_title => 'প্রজেক্ট খুলুন';

  @override
  String get open_project_screen_desc => 'পূর্বে তৈরি করা প্রজেক্ট খুলুন, শুধুমাত্র সর্বশেষ ২০টি রাখা হবে।';

  @override
  String get open_project_screen_no_project => 'কোনো প্রজেক্ট পাওয়া যায়নি।';

  @override
  String get default_project_name => 'প্রজেক্ট';

  @override
  String get default_video_name => 'ভিডিও উৎস';

  @override
  String get default_zone_name => 'ডিটেকশন জোন';

  @override
  String get error_oops => 'উপস, কিছু ভুল হয়েছে';

  @override
  String get error_content => 'একটি অপ্রত্যাশিত ত্রুটি ঘটেছে। আপনি কি একটি ইমেইল রিপোর্ট জমা দিতে চান?';

  @override
  String get error_report => 'আমাদের ইমেইল করুন';

  @override
  String get submit => 'জমা দিন';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get cancel => 'বাতিল';

  @override
  String get yes => 'হ্যাঁ';

  @override
  String get no => 'না';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get back => 'পিছনে';

  @override
  String get zone_screen_zone => 'জোন';

  @override
  String get zone_screen_zone_show_summary => 'স্ক্রিনে সারসংক্ষেপ দেখান';

  @override
  String get video_sources_photos_denied => 'ছবিতে অ্যাক্সেস প্রত্যাখ্যাত';

  @override
  String get video_sources_photos_goto_settings => 'সেটিংসে যান';

  @override
  String get video_sources_camera_denied => 'ক্যামেরায় অ্যাক্সেস প্রত্যাখ্যাত';

  @override
  String get video_sources_photos_denied_msg => 'অনুগ্রহ করে সেটিংসে যান এবং এই অ্যাপটির জন্য ফটো অ্যাক্সেসের অনুমতি দিন।';

  @override
  String get video_sources_camera_denied_msg => 'অনুগ্রহ করে সেটিংসে যান এবং এই অ্যাপটির জন্য ক্যামেরা অ্যাক্সেসের অনুমতি দিন।';
}

/// The translations for Bengali Bangla, as used in India (`bn_IN`).
class LocalizationBnIn extends LocalizationBn {
  LocalizationBnIn(): super('bn_IN');

  @override
  String get product_name => 'কাউন্টার';

  @override
  String get product_desc => 'কম্পিউটার ভিশন এবং এআই ব্যবহার করে মানুষ, যানবাহন, পোষা প্রাণী এবং আরও অনেক কিছু গণনা করুন।';

  @override
  String get product_copyright => 'কপিরাইট © ২০২৫';

  @override
  String get video_sources_webcam => 'ওয়েবক্যাম';

  @override
  String get video_sources_live_stream => 'লাইভ স্ট্রিম URL';

  @override
  String get video_sources_file => 'ফাইল';

  @override
  String get video_sources_camera => 'ক্যামেরা';

  @override
  String get video_sources_camera_not_found_title => 'ক্যামেরা পাওয়া যায়নি';

  @override
  String get video_sources_camera_not_found_message => 'ক্যামেরা ব্যবহার করতে অনুমতি প্রদান করুন';

  @override
  String get video_sources_webcam_not_found_title => 'ওয়েবক্যাম পাওয়া যায়নি';

  @override
  String get video_sources_webcam_not_found_message => 'অ্যাপ্লিকেশনের ক্যামেরা অনুমতি এবং সংযোগ যাচাই করুন';

  @override
  String get wizard_screen_desc => 'গণনা শুরু করতে নীচে একটি নতুন প্রজেক্ট তৈরি করুন।';

  @override
  String get wizard_screen_new_project_from => 'এখান থেকে নতুন প্রজেক্ট';

  @override
  String get wizard_screen_language => 'ভাষা';

  @override
  String get wizard_screen_about => 'সম্পর্কে';

  @override
  String get wizard_screen_open_projects_tip => 'সমস্ত প্রজেক্ট স্বয়ংক্রিয়ভাবে স্থানীয়ভাবে সংরক্ষিত হবে';

  @override
  String get wizard_screen_open_projects => 'বিদ্যমান প্রজেক্ট খুলুন';

  @override
  String get wizard_screen_email_us => 'আমাদের ইমেইল করুন';

  @override
  String get language_screen_language => 'ভাষা';

  @override
  String get project_view_no_videos => 'কোন ভিডিও উৎস উপলব্ধ নেই।';

  @override
  String get about_screen_title => 'সম্পর্কে';

  @override
  String get about_screen_platform => 'প্ল্যাটফর্ম';

  @override
  String get about_screen_app_version => 'অ্যাপ সংস্করণ';

  @override
  String get about_screen_models => 'অবজেক্ট ডিটেকশন মডেল';

  @override
  String get about_screen_benchmark => 'বেঞ্চমার্ক';

  @override
  String get about_screen_opencv_build_info => 'OpenCV বিল্ড তথ্য';

  @override
  String get benchmark_screen_title => 'মডেল বেঞ্চমার্ক';

  @override
  String get benchmark_screen_recommended => 'সুপারিশকৃত মডেল';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'বেঞ্চমার্ক শুরু করুন';

  @override
  String get benchmark_screen_start_failed => 'বেঞ্চমার্ক শুরু করতে ব্যর্থ, ত্রুটি কোড হল';

  @override
  String get benchmark_screen_models => 'অবজেক্ট ডিটেকশন মডেল';

  @override
  String get project_screen_title => 'প্রজেক্ট';

  @override
  String get project_screen_exit_confirm_title => 'প্রজেক্ট থেকে বের হওয়া নিশ্চিত করুন';

  @override
  String get project_screen_exit_confirm_content => 'প্রজেক্ট ছেড়ে যাওয়া গণনা বন্ধ করবে। আপনি কি অবিরত রাখতে চান?';

  @override
  String get project_screen_exit_button => 'প্রস্থান';

  @override
  String get project_screen_add_video_button => 'ভিডিও উৎস যোগ করুন';

  @override
  String get project_screen_from_desc => 'আমরা ২৪ ঘন্টার রেকর্ড রাখি, যাতে আপনি যেকোনো সময়ের অংশ দেখতে পারেন।';

  @override
  String get project_screen_report_settings => 'সেটিংস';

  @override
  String get filter_screen_title => 'ফিল্টার';

  @override
  String get filter_screen_desc => 'নীচের তালিকা থেকে একটি ফিল্টার রেঞ্জ নির্বাচন করুন';

  @override
  String get filter_screen_error_title => 'ফিল্টার';

  @override
  String get filter_screen_error_content => 'শেষ সময় শুরু সময়ের চেয়ে বেশি হতে হবে';

  @override
  String get filter_screen_error_custom => 'কাস্টম';

  @override
  String get filter_screen_error_start => 'শুরু';

  @override
  String get filter_screen_error_end => 'শেষ';

  @override
  String get settings_screen_title => 'সেটিংস';

  @override
  String get settings_screen_desc => 'প্রজেক্টের নাম, সনাক্তকরণ পরামিতি, গণনা পরিষ্কার সেট করুন।';

  @override
  String get settings_screen_project_id => 'প্রজেক্ট আইডি';

  @override
  String get settings_screen_project_name => 'প্রজেক্টের নাম';

  @override
  String get settings_screen_project_name_place_holder => '১২৩ মেইন স্ট্রিট বা রবীন্দ্র সরণি';

  @override
  String get settings_screen_project_error => 'প্রজেক্টের নাম খালি থাকতে পারে না';

  @override
  String get settings_screen_random_count_button => 'এলোমেলো গণনা যোগ করুন';

  @override
  String get settings_screen_reset_count_header => 'এই প্রজেক্টের সমস্ত গণনা রিসেট করুন';

  @override
  String get settings_screen_reset_count_button => 'গণনা রিসেট করুন';

  @override
  String get settings_screen_reset_count_content => 'আপনি কি নিশ্চিত যে আপনি সমস্ত গণনা রিসেট করতে চান?';

  @override
  String get settings_screen_delete_header => 'এই প্রজেক্ট মুছুন';

  @override
  String get settings_screen_delete_content => 'আপনি কি নিশ্চিত যে আপনি এই প্রজেক্ট মুছতে চান?';

  @override
  String get settings_screen_delete_button => 'মুছুন';

  @override
  String get settings_screen_center_point_title => 'টার্গেটে সেন্টার পয়েন্ট';

  @override
  String get settings_screen_center_point_desc => 'সেন্টার পয়েন্ট টার্গেট হিট জোনের মধ্যে আছে কিনা তা নির্ধারণ করতে সাহায্য করে।';

  @override
  String get settings_screen_center_point_button => 'টার্গেটে সেন্টার পয়েন্ট দেখান';

  @override
  String get settings_screen_lost_target_title => 'হারিয়ে যাওয়া টার্গেট';

  @override
  String get settings_screen_lost_target_desc => 'যখন অবজেক্ট ট্র্যাকিং একটি টার্গেট হারায়, এই অপশন এটি দৃশ্যমান করে। ডিফল্টভাবে, হারানো টার্গেট দেখানো হয় না।';

  @override
  String get settings_screen_lost_target_button => 'হারিয়ে যাওয়া টার্গেট দেখান';

  @override
  String get detection_screen_title => 'ডিটেকশন সেটিংস';

  @override
  String get detection_screen_models => 'মডেল';

  @override
  String get detection_screen_confidence => 'কনফিডেন্স';

  @override
  String get detection_screen_confidence_desc => '#0 এর উপরে কনফিডেন্স একটি বৈধ সনাক্তকরণ হিসাবে বিবেচিত হয়';

  @override
  String get detection_screen_low => 'কম';

  @override
  String get detection_screen_high => 'উচ্চ';

  @override
  String get detection_screen_nms => 'নন-ম্যাক্সিমাম সাপ্রেশন';

  @override
  String get detection_screen_nms_desc => '#0 একটি কম NMS থ্রেশহোল্ড (যেমন, ৩০%) আরও আক্রমণাত্মকভাবে ওভারল্যাপিং বাউন্ডিং বক্স সরাবে, যখন একটি উচ্চ NMS থ্রেশহোল্ড (যেমন, ০.৬) আরও ওভারল্যাপ অনুমতি দেবে';

  @override
  String get detection_screen_match => 'ম্যাচ';

  @override
  String get detection_screen_match_desc => '#0 এর উপরে ম্যাচ একই অবজেক্ট হিসাবে বিবেচিত হয়।';

  @override
  String get detection_screen_lost => 'হারিয়েছে';

  @override
  String get detection_screen_lost_desc => '#0 সময়ের জন্য হারিয়ে গেলে ট্র্যাক করা অবজেক্ট সরানো হবে';

  @override
  String get detection_screen_consider_valid => 'এর পরে বৈধ মনে করুন';

  @override
  String get detection_screen_consider_valid_desc => '#0 পরে ট্র্যাক করা অবজেক্ট বৈধ মনে করা হবে';

  @override
  String get detection_screen_reset => 'রিসেট';

  @override
  String get detection_screen_reset_content => 'আপনি কি নিশ্চিত যে আপনি ডিটেকশন সেটিংস রিসেট করতে চান?';

  @override
  String get url_screen_title => 'লাইভ স্ট্রিম URL';

  @override
  String get url_screen_desc => 'লাইভ স্ট্রিম URL লিখুন';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream বা rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'ভিডিও উৎস যোগ করুন';

  @override
  String get add_video_screen_from => 'এখান থেকে ভিডিও উৎস যোগ করুন';

  @override
  String get webcam_screen_add_title => 'ওয়েবক্যাম যোগ করুন';

  @override
  String get webcam_screen_edit_title => 'ওয়েবক্যাম বেছে নিন';

  @override
  String get webcam_manager_webcam => 'ওয়েবক্যাম';

  @override
  String get camera_screen_front_camera => 'সামনের ক্যামেরা';

  @override
  String get camera_screen_back_camera => 'পিছনের ক্যামেরা';

  @override
  String get camera_screen_add_title => 'ক্যামেরা যোগ করুন';

  @override
  String get camera_screen_edit_title => 'ক্যামেরা বেছে নিন';

  @override
  String get camera_screen_zoom_level => 'জুম লেভেল';

  @override
  String get video_screen_name_empty => 'ভিডিওর নাম খালি থাকতে পারে না।';

  @override
  String get video_screen_desc => 'ভিডিও উৎস পরিচালনা করুন, ডিটেকশন জোন যোগ করুন বা পরিবর্তন করুন।';

  @override
  String get video_screen_video_name => 'ভিডিও উৎসের নাম';

  @override
  String get video_screen_edit_placeholder => 'সামনের দরজার ক্যাম বা পার্কিং লট ক্যাম';

  @override
  String get video_screen_change_file => 'ফাইল পরিবর্তন করুন';

  @override
  String get video_screen_add_zone => 'ডিটেকশন জোন যোগ করুন';

  @override
  String get video_screen_zones => 'ডিটেকশন জোন';

  @override
  String get video_screen_zones_desc => 'জোন সামঞ্জস্য করতে ড্র্যাগ এন্ড ড্রপ ব্যবহার করুন';

  @override
  String get video_screen_tools => 'টুলস';

  @override
  String get video_screen_move_bottom => 'বর্তমান জোন নীচে সরান';

  @override
  String get video_screen_add_point => 'বর্তমান জোনে পয়েন্ট যোগ করুন';

  @override
  String get video_screen_remove_point => 'বর্তমান জোন থেকে পয়েন্ট সরান';

  @override
  String get video_screen_playback_speed => 'প্লেব্যাক স্পিড';

  @override
  String get video_screen_playback_current => 'বর্তমান: ';

  @override
  String get video_screen_playback_14x => '১/৪x';

  @override
  String get video_screen_playback_2x => '২x';

  @override
  String get video_screen_delete_header => 'এই ভিডিও উৎস মুছুন';

  @override
  String get video_screen_delete_content => 'আপনি কি নিশ্চিত যে আপনি এই ভিডিও উৎস মুছতে চান?';

  @override
  String get video_screen_delete_button => 'মুছুন';

  @override
  String get video_screen_sources => 'ইমেজ উৎস, ডিটেকশন টার্গেট এবং মডেল প্যারামিটার কনফিগার করুন।';

  @override
  String get video_screen_targets => 'ডিটেকশন টার্গেট';

  @override
  String get video_screen_detection => 'মডেল প্যারামিটার';

  @override
  String get color_screen_title => 'একটি রঙ বেছে নিন';

  @override
  String get zone_screen_desc => 'ডিটেকশন জোন সনাক্ত করার জন্য অবজেক্টের ধরন সেট করতে পারে এবং কোন কাউন্টার প্রদর্শন করবে তা বেছে নিতে পারে, যেমন সনাক্তকৃত, উৎপন্ন, এবং প্রবেশ করেছে।';

  @override
  String get zone_screen_name_placeholder => 'জোনের নাম, যেমন ফুটপাথ বা পার্কিং লট';

  @override
  String get zone_screen_zone_color => 'জোন রঙ';

  @override
  String get zone_screen_color => 'রঙ';

  @override
  String get zone_screen_delete_header => 'এই জোন মুছুন';

  @override
  String get zone_screen_delete_content => 'আপনি কি নিশ্চিত যে আপনি এই জোন মুছতে চান?';

  @override
  String get zone_screen_delete_button => 'মুছুন';

  @override
  String get zone_screen_can_not_delete => 'জোন মুছতে পারবেন না';

  @override
  String get zone_screen_one_zone_required => 'অন্তত একটি জোন প্রয়োজন।';

  @override
  String get zone_screen_zone_name_required => 'জোনের নাম খালি থাকতে পারে না';

  @override
  String get counter_screen_show_on => 'স্ক্রিনে দেখান';

  @override
  String get counter_screen_enabled => 'সক্রিয়';

  @override
  String get counter_screen_reentry_threshold => 'পুনঃপ্রবেশ থ্রেশহোল্ড';

  @override
  String get counter_screen_reentry_desc => 'অবজেক্টকে #0 বার প্রবেশ করতে হবে, প্রতিটি প্রস্থান এবং পুনঃপ্রবেশের মধ্যে #1 সেকেন্ড কুলডাউন সহ, পুনঃপ্রবেশ ট্রিগার করতে';

  @override
  String get counter_screen_reentry_title => 'পুনঃপ্রবেশ গণনা';

  @override
  String get counter_screen_cooldown_threshold => 'কুলডাউন থ্রেশহোল্ড';

  @override
  String get counter_screen_cooldown_desc => 'ডিটেকশন জোন থেকে বেরিয়ে যাওয়ার পরে পুনঃপ্রবেশের জন্য #0 সেকেন্ড কুলডাউন প্রয়োজন';

  @override
  String get counter_screen_cooldown_time => 'কুলডাউন সময়';

  @override
  String get counter_screen_cooldown_in_seconds => 'সেকেন্ডে';

  @override
  String get counter_screen_stagnant_threshold => 'স্থির থ্রেশহোল্ড';

  @override
  String get counter_screen_stagnant_desc => '#0 সেকেন্ডের বেশি সময় স্থির থাকা অবজেক্ট স্থবির বলে বিবেচিত হবে';

  @override
  String get counter_screen_stagnant_consider => 'স্থবির হিসাবে বিবেচনা করুন';

  @override
  String get counter_screen_stagnant_in_seconds => 'সেকেন্ডে';

  @override
  String get counter_screen_stagnant_desc_prefix => 'বর্ণনা প্রিফিক্স';

  @override
  String get counter_screen_stagnant_desc_suffix => 'বর্ণনা সাফিক্স';

  @override
  String get counter_screen_name_error => 'কাউন্টারের নাম খালি থাকতে পারে না';

  @override
  String get counter_screen_enabled_error => 'ত্রুটি';

  @override
  String get counter_screen_enabled_error_content => 'আপনাকে প্রথমে অন্য কাউন্টার সক্রিয় করতে হবে, তারপর আপনি এই কাউন্টার নিষ্ক্রিয় করতে পারবেন';

  @override
  String get objects_screen_title => 'অবজেক্ট';

  @override
  String get objects_screen_desc => 'ব্যক্তি, গাড়ি, বাস ইত্যাদি ডিটেকশন টার্গেট বেছে নিন।';

  @override
  String get open_project_screen_title => 'প্রজেক্ট খুলুন';

  @override
  String get open_project_screen_desc => 'পূর্বে তৈরি করা প্রজেক্ট খুলুন, শুধুমাত্র সর্বাধিক সাম্প্রতিক ২০টি রাখুন।';

  @override
  String get open_project_screen_no_project => 'কোন প্রজেক্ট পাওয়া যায়নি।';

  @override
  String get default_project_name => 'প্রজেক্ট';

  @override
  String get default_video_name => 'ভিডিও উৎস';

  @override
  String get default_zone_name => 'ডিটেকশন জোন';

  @override
  String get error_oops => 'উফ, কিছু ভুল হয়েছে';

  @override
  String get error_content => 'একটি অপ্রত্যাশিত ত্রুটি ঘটেছে। আপনি কি একটি ইমেইল রিপোর্ট জমা দিতে চান?';

  @override
  String get error_report => 'আমাদের ইমেইল করুন';

  @override
  String get submit => 'জমা দিন';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get cancel => 'বাতিল';

  @override
  String get yes => 'হ্যাঁ';

  @override
  String get no => 'না';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get back => 'পিছনে';

  @override
  String get zone_screen_zone => 'জোন';

  @override
  String get zone_screen_zone_show_summary => 'स्क्रीन पर सारांश दिखाएं';

  @override
  String get video_sources_photos_denied => 'ফটোতে অ্যাক্সেস প্রত্যাখ্যাত';

  @override
  String get video_sources_photos_goto_settings => 'সেটিংসে যান';

  @override
  String get video_sources_camera_denied => 'ক্যামেরা অ্যাক্সেস অস্বীকৃত';

  @override
  String get video_sources_photos_denied_msg => 'सेटिंग्स में जाएं और इस ऐप के लिए फोटो एक्सेस अनुमति दें।';

  @override
  String get video_sources_camera_denied_msg => 'सेटिंग्स में जाएं और इस ऐप के लिए कैमरा एक्सेस अनुमति दें।';
}
