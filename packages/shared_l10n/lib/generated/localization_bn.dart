// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class LocalizationBn extends Localization {
  LocalizationBn([String locale = 'bn']) : super(locale);

  @override
  String get about_screen_app_version => 'অ্যাপ ভার্সন';

  @override
  String get about_screen_email_us => 'আমাদের ইমেইল করুন';

  @override
  String get about_screen_platform => 'প্ল্যাটফর্ম';

  @override
  String get appeared => 'প্রথম দেখা গেছে';

  @override
  String get appeared_help =>
      'যেসব মানুষ বা যানবাহনের প্রথম শনাক্ত অবস্থান এই এলাকার ভিতরে ছিল, তাদের সংখ্যা গণনা করে।\\n\\nট্র্যাকিং কোথা থেকে শুরু হয়েছে তা বুঝতে সহায়ক।\\n\\n(মূলত উন্নত ব্যবহারকারীদের জন্য)';

  @override
  String get average_occupancy => 'গড় উপস্থিতি';

  @override
  String get average_occupancy_help =>
      'বর্তমান গণনা সময়সীমায় এই এলাকায় মানুষ বা যানবাহনের গড় সংখ্যা দেখায়।\\n\\nএটি পুরো গণনা সময়জুড়ে এলাকাটি কতটা ব্যস্ত ছিল তা বুঝতে সাহায্য করে।';

  @override
  String get average_stay => 'গড় অবস্থান সময়';

  @override
  String get average_stay_help =>
      '显示人员或车辆在此区域内的平均停留时间。\\n\\n较长的平均停留时间可能表示顾客在该区域停留更久。';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter আপনার ক্যামেরা এবং ডিভাইসে চলা AI ব্যবহার করে মানুষ গণনা করে। প্রথমে নিশ্চিত করা যাক যে আপনার ডিভাইসটি সমর্থিত।';

  @override
  String get camera_test_screen_instruction =>
      'ক্যামেরা মানুষের দিকে তাক করুন। অ্যাপটি শনাক্ত করা ব্যক্তিদের চারপাশে বক্স আঁকবে।';

  @override
  String get camera_test_screen_next => 'পরবর্তী চাপুন।';

  @override
  String get camera_test_screen_start =>
      'শুরু করুন চাপুন। প্রয়োজন হলে ক্যামেরার অনুমতি দিন।';

  @override
  String get camera_test_screen_test_failed => 'পরীক্ষা ব্যর্থ!';

  @override
  String get camera_test_screen_test_passed => 'পরীক্ষা সফল!';

  @override
  String get camera_test_screen_title => 'এআই ক্যামেরা পরীক্ষা';

  @override
  String get camera_test_screen_wait => 'AI মানুষের শনাক্ত করার অপেক্ষায়…';

  @override
  String get cta_screen_custom => 'নিজের সার্ভার ব্যবহার করুন';

  @override
  String get cta_screen_custom_help =>
      'ট্রাফিক ডেটা সরাসরি আপনার নিজস্ব ব্যাকএন্ড বা ডাটাবেসে পাঠান。';

  @override
  String get cta_screen_footer =>
      'অব্যাহত রাখার মাধ্যমে, আপনি পরিষেবার শর্তাবলী, গোপনীয়তা নীতি এবং ডেটা প্রক্রিয়াকরণ চুক্তিতে সম্মত হচ্ছেন।';

  @override
  String get cta_screen_invitation => 'আমন্ত্রণ কোড ব্যবহার করুন';

  @override
  String get cta_screen_invitation_help =>
      'অ্যাডমিনের পাঠানো আমন্ত্রণ ব্যবহার করে বিদ্যমান প্রতিষ্ঠানে যোগ দিন।';

  @override
  String get cta_screen_local => 'শুধু এই ডিভাইসে';

  @override
  String get cta_screen_local_help =>
      'শুধু এই ডিভাইসে ট্রাফিক ডেটা সংরক্ষণ করুন। কোনো তথ্য আপলোড করা হবে না।';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud ব্যবহার করুন';

  @override
  String get cta_screen_piyuo_help =>
      'Piyuo Cloud-এ ট্রাফিক ডেটা সংরক্ষণ করুন এবং ড্যাশবোর্ড ও ব্যবসায়িক বিশ্লেষণ ব্যবহার করুন।';

  @override
  String get cta_screen_premium => 'প্রিমিয়াম';

  @override
  String get cta_screen_title =>
      'Piyuo Counter প্রতি ৫ মিনিটে বেনামী ট্রাফিক পরিসংখ্যান তৈরি করে।\\nআপনি কীভাবে আপনার ডেটা সংরক্ষণ ও ব্যবহার করতে চান তা নির্বাচন করুন।';

  @override
  String get current_occupancy => 'বর্তমান সংখ্যা';

  @override
  String get current_occupancy_help =>
      'এই এলাকায় মানুষ বা যানবাহনের বর্তমান সংখ্যা দেখায়।\\n\\nএই সংখ্যা তাৎক্ষণিকভাবে আপডেট হয় এবং AI সনাক্তকরণ স্ক্রিনে যা দেখছেন তার সাথে মিলছে কিনা তা যাচাই করতে সাহায্য করে। এটি আপলোড করা টেলিমেট্রি ডেটার অংশ নয়।';

  @override
  String get custom_server_screen_bearer_saving_action => 'সংরক্ষণ হচ্ছে...';

  @override
  String get custom_server_screen_server_url_label => 'সার্ভারের URL';

  @override
  String get detection_screen_confidence => 'আত্মবিশ্বাসের সীমা';

  @override
  String get detection_screen_confidence_dialog =>
      'একজন ব্যক্তি বা যানবাহন গণনা করার আগে AI কতটা নিশ্চিত হতে হবে তা নিয়ন্ত্রণ করে।\\nকম মান\\n• বেশি বস্তু শনাক্ত করে\\n• দূরের বা আংশিক লুকানো বস্তুর জন্য ভালো\\n• ভুল শনাক্তকরণ বাড়তে পারে\\nবেশি মান\\n• শুধু উচ্চ-নিশ্চয়তার শনাক্তকরণ গণনা করে\\n• ভুল শনাক্তকরণ কমায়\\n• ছোট বা কঠিন বস্তু বাদ পড়তে পারে\\nঅ্যাপ যদি মানুষ বা যানবাহন মিস করে, তাহলে কম মান ব্যবহার করুন।\\nঅ্যাপ যদি ছায়া, প্রতিফলন বা অন্য ভুল বস্তু গণনা করে, তাহলে বেশি মান ব্যবহার করুন।';

  @override
  String get detection_screen_confidence_help =>
      'বস্তু শনাক্ত করার জন্য প্রয়োজনীয় ন্যূনতম আত্মবিশ্বাস।';

  @override
  String get detection_screen_confidence_max_label => 'صارم';

  @override
  String get detection_screen_confidence_min_label => 'শিথিল';

  @override
  String get detection_screen_disappear => 'সময়সীমা অদৃশ্য হওয়া';

  @override
  String get detection_screen_disappear_dialog =>
      'একটি বস্তু আর শনাক্ত না হওয়ার পর AI কতক্ষণ অপেক্ষা করে তারপর তা \\অদৃশ্য\\ হিসেবে চিহ্নিত করে তা নির্ধারণ করে।\\nছোট মান\\n• বস্তুগুলোকে দ্রুত অদৃশ্য হিসেবে চিহ্নিত করে\\n• দ্রুত গতির চলাচলের জন্য ভালো\\n• সাময়িকভাবে ঢাকা পড়া বস্তুকে ভুলভাবে অদৃশ্য চিহ্নিত করতে পারে\\nবড় মান\\n• বস্তুকে অদৃশ্য চিহ্নিত করার আগে বেশি সময় অপেক্ষা করে\\n• বস্তু সাময়িকভাবে বাধাপ্রাপ্ত বা মিস হলে ভালো\\n• অদৃশ্য হওয়ার ঘটনা দেরিতে ঘটায়';

  @override
  String get detection_screen_disappear_help =>
      'AI আর শনাক্ত করতে না পারার পর কোনো বস্তুকে অদৃশ্য হিসেবে গণ্য করার আগে কতক্ষণ অপেক্ষা করবে।';

  @override
  String get detection_screen_disappear_max_label => 'ধীর';

  @override
  String get detection_screen_disappear_min_label => 'দ্রুত';

  @override
  String get detection_screen_memory_dialog =>
      'একটি বস্তু অদৃশ্য হওয়ার পর AI কতক্ষণ তা মনে রাখে তা নিয়ন্ত্রণ করে।\\nমানুষ বা যানবাহন প্রায়ই অন্য বস্তুর পেছনে ঢাকা পড়লে এই মান বাড়ান।\\nদৃশ্য ছেড়ে যাওয়ার পর বস্তুগুলো ভুলভাবে যুক্ত হলে এই মান কমান।';

  @override
  String get detection_screen_min_presence => 'ন্যূনতম উপস্থিতির সময়';

  @override
  String get detection_screen_min_presence_help =>
      'কোনো বস্তুকে গণনা করার আগে কিছুক্ষণ দৃশ্যমান থাকতে হবে। বেশি মান ক্ষণস্থায়ী ভুল শনাক্তকরণ কমাতে সাহায্য করে।';

  @override
  String get detection_screen_min_presence_max_label => 'আরও নিরাপদ';

  @override
  String get detection_screen_min_presence_min_label => '更快';

  @override
  String get detection_screen_minimum_visible =>
      'বস্তুগুলো গণনা করার আগে এই সময় পর্যন্ত দৃশ্যমান থাকতে হবে।\\nসংক্ষিপ্ত ভুল শনাক্তকরণ উপেক্ষা করতে এই মান বাড়ান।\\nদ্রুত গতিশীল মানুষ বা যানবাহন মিস হলে এই মান কমান।';

  @override
  String get detection_screen_new_track => 'নতুন ট্র্যাকের সীমা';

  @override
  String get detection_screen_new_track_help =>
      'নতুন বস্তুর ট্র্যাকিং শুরু করতে ন্যূনতম আত্মবিশ্বাস। কম মানে একই বস্তুর জন্য একাধিক ট্র্যাক তৈরি হতে পারে।';

  @override
  String get detection_screen_new_track_max_label => 'সতর্ক';

  @override
  String get detection_screen_new_track_min_label => 'সংবেদনশীল';

  @override
  String get detection_screen_reset => 'রিসেট';

  @override
  String get detection_screen_reset_content =>
      'আপনি কি নিশ্চিত যে আপনি ডিটেকশন সেটিংস রিসেট করতে চান?';

  @override
  String get detection_screen_show_track_id => 'ট্র্যাক আইডি দেখান';

  @override
  String get detection_screen_show_track_id_help =>
      'এই বিকল্পটি সক্রিয় করুন প্রতিটি ট্র্যাক করা অবজেক্টের জন্য অনন্য ট্র্যাক আইডি দেখাতে।';

  @override
  String get detection_screen_stay => 'থাকার সময়';

  @override
  String get detection_screen_stay_help =>
      'কোনো বস্তুকে অবস্থানকারী হিসেবে গণনা করার আগে কতক্ষণ এলাকায় থাকতে হবে।';

  @override
  String get detection_screen_stay_max_label => 'বিলম্বিত';

  @override
  String get detection_screen_stay_min_label => 'তাৎক্ষণিক';

  @override
  String get detection_screen_stay_threshold =>
      'একটি বস্তু কখন \\Stay\\ গণনায় অবদান রাখে তা নির্ধারণ করে।\\nছোট মান\\n• সাথে সাথে থাকা গণনা করে\\n• দ্রুত বিশ্লেষণের জন্য ভালো\\nবড় মান\\n• সংক্ষিপ্ত পার হয়ে যাওয়া চলাচল উপেক্ষা করে\\n• দখল পরিমাপের জন্য ভালো';

  @override
  String get detection_screen_subtitle =>
      'AI কীভাবে বস্তু শনাক্ত ও ট্র্যাক করবে তা সামঞ্জস্য করুন';

  @override
  String get detection_screen_title => 'ট্র্যাকিং ও গণনা';

  @override
  String get detection_screen_track_dialog =>
      'একটি নতুন শনাক্ত হওয়া বস্তু কখন নতুন ট্র্যাক হবে তা নিয়ন্ত্রণ করে।\\nকম মান\\n• দ্রুত ট্র্যাকিং শুরু হয়\\n• দ্রুত গতিশীল বস্তুর জন্য ভালো\\n• ডুপ্লিকেট ট্র্যাক তৈরি হতে পারে\\nবেশি মান\\n• নতুন ট্র্যাক তৈরির আগে বেশি প্রমাণ দরকার\\n• ডুপ্লিকেট ট্র্যাক কমায়\\n• নতুন বস্তু ট্র্যাক করতে দেরি হতে পারে';

  @override
  String get detection_screen_track_memory => 'ট্র্যাকিং মেমোরি';

  @override
  String get detection_screen_track_memory_help =>
      'বস্তুটি সাময়িকভাবে হারিয়ে গেলে কতক্ষণ ট্র্যাকিং চালু থাকবে। বেশি সময় দিলে স্বল্প সময়ের আড়াল থেকে পুনরুদ্ধার সহজ হয়।';

  @override
  String get detection_screen_track_memory_max_label => 'লম্বা';

  @override
  String get detection_screen_track_memory_min_label => 'ছোট';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter আপনার ক্যামেরা ব্যবহার করে পথচারী ও যানবাহনকে রিয়েল টাইমে শনাক্ত করে। এই ডিভাইসে ক্যামেরা উপলব্ধ নেই.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'আপনার ফোনে এই অ্যাপটি খুলে দেখুন';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'ক্যামেরাসহ একটি স্মার্টফোন বা ট্যাবলেট';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'প্রস্তাবিত iOS বা Android ডিভাইস';

  @override
  String get device_not_supported_screen_requirements_title => 'আপনার যা দরকার';

  @override
  String get device_not_supported_screen_title => 'ক্যামেরা পাওয়া যায়নি';

  @override
  String get disappeared => 'অদৃশ্য হয়েছে';

  @override
  String get disappeared_help =>
      'যেসব মানুষ বা যানবাহনের সর্বশেষ শনাক্ত অবস্থান এই এলাকার ভিতরে ছিল, তাদের সংখ্যা গণনা করে।\\n\\nনির্ধারিত Disappear Time পর্যন্ত শনাক্ত না হলে ট্র্যাকিং শেষ হয়।\\n\\n(মূলত উন্নত ব্যবহারকারীদের জন্য)';

  @override
  String get dpa => 'ডেটা প্রক্রিয়াকরণ চুক্তি';

  @override
  String get durationDaysShort => '%sদিন';

  @override
  String get durationHoursShort => '%sঘ';

  @override
  String get durationMinutesShort => '%sমি';

  @override
  String get durationSecondsShort => '%sসে';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'প্রবেশ করেছে';

  @override
  String get entered_help =>
      'বর্তমান গণনা সময়সীমায় এই এলাকায় প্রবেশ করা মানুষ বা যানবাহনের সংখ্যা গণনা করে。\\n\\nকোনো ব্যক্তি বা যানবাহন এলাকার বাইরে থেকে ভেতরে প্রবেশ করলে একটি প্রবেশ গণনা করা হয়।';

  @override
  String get exited => 'বের হয়েছে';

  @override
  String get exited_help =>
      'বর্তমান গণনা সময়সীমায় এই এলাকা থেকে বের হয়ে যাওয়া মানুষ বা যানবাহনের সংখ্যা গণনা করে。\\n\\nকোনো ব্যক্তি বা যানবাহন এলাকার ভেতর থেকে বাইরে গেলে একটি প্রস্থান গণনা করা হয়।';

  @override
  String get language_screen_language => 'ভাষা';

  @override
  String get language_screen_subtitle => 'অ্যাপে ব্যবহৃত ভাষা নির্বাচন করুন।';

  @override
  String get local_only_screen_body =>
      'লোকাল ডিভাইস ওনলি মোডে আপনি কোনো ডেটা আপলোড না করেই AI ক্যামেরা ডিটেকশন ও ট্র্যাকিং পরীক্ষা করতে পারবেন। সব ফুট ট্রাফিক পরিসংখ্যান শুধু এই ডিভাইসেই প্রসেস হয়, যা সার্ভারের সাথে সংযোগ করার আগে পরীক্ষা করার জন্য উপযুক্ত।';

  @override
  String get local_only_screen_use_action => 'শুধু এই ডিভাইস ব্যবহার করুন';

  @override
  String get local_screen_text =>
      'Piyuo Counter সম্পূর্ণভাবে এই ডিভাইসেই চলবে।\\nট্রাফিক পরিসংখ্যান শুধু এই ডিভাইসেই সংরক্ষণ হবে এবং আপলোড করা হবে না।\\nপরে Settings থেকে Piyuo Cloud বা নিজের সার্ভারের সাথে সংযোগ করতে পারবেন।';

  @override
  String get maximum_occupancy => 'সর্বোচ্চ উপস্থিতি';

  @override
  String get maximum_occupancy_help =>
      'বর্তমান গণনা সময়সীমায় একই সময়ে এই এলাকায় থাকা সর্বোচ্চ সংখ্যক মানুষ বা যানবাহন দেখায়。\\n\\nএটি সর্বোচ্চ ভিড় বা যানবাহনের চাপের সময় শনাক্ত করতে সহায়তা করে।';

  @override
  String get maximum_stay => 'সর্বোচ্চ অবস্থান সময়';

  @override
  String get maximum_stay_help =>
      'বর্তমান গণনা সময়সীমায় কোনো ব্যক্তি বা যানবাহন এই এলাকায় সবচেয়ে বেশি সময় অবস্থান করেছে কতক্ষণ, তা দেখায়。\\n\\nঅস্বাভাবিক দীর্ঘ অবস্থান বা থামা শনাক্ত করতে সহায়ক।';

  @override
  String get metric_events => 'ইভেন্ট';

  @override
  String get metric_live => 'สด';

  @override
  String get metric_show_less => 'কম দেখান';

  @override
  String get metric_show_more => 'আরও দেখান';

  @override
  String get metric_statistics => 'পরিসংখ্যান';

  @override
  String get metrics_counting_all => 'সব';

  @override
  String get metrics_counting_done => 'সম্পন্ন';

  @override
  String get metrics_counting_in_progress => '进行中';

  @override
  String get metrics_counting_missing => 'অনুপস্থিত';

  @override
  String get metrics_counting_window => 'প্রতি ৫ মিনিটের পরিসংখ্যান';

  @override
  String get onboarding_back_action => 'ফিরে যান';

  @override
  String get onboarding_cta_no_server => 'ডেটা আপলোড করতে চান না?';

  @override
  String get onboarding_cta_title => 'আপনার ডেটা কোথায় যাবে?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter আপনার ক্যামেরা আর ডিভাইসের ভেতরের AI দিয়ে সঙ্গে সঙ্গে মানুষ আর গাড়ি শনাক্ত করে।\\nশনাক্তকরণ ও ট্র্যাকিং প্রযুক্তির মাধ্যমে, গাড়ি আর মানুষের চলাচল স্বয়ংক্রিয়ভাবে গোনা হয় — সবকিছু আপনার ডিভাইসেই।';

  @override
  String get onboarding_intro_text2 =>
      'সব AI প্রসেসিং আপনার ডিভাইসেই স্থানীয়ভাবে হয়। কোনো ভিডিও, ছবি, মুখ, বা পরিচয় আপলোড করা হয় না।\\nশুধু প্রতি ৫ মিনিটে বেনামী সারাংশ শেয়ার করা হয়, যাতে থাকে গণনা, দখলের হার, প্রবেশ, প্রস্থান, আর অবস্থানের সময়ের পরিসংখ্যান।';

  @override
  String get onboarding_intro_text3 =>
      'শুধু অ্যাপটি চালু করুন আর চলতে দিন। Piyuo Counter নিজে থেকেই ক্রমাগত ট্রাফিক ডেটা সংগ্রহ করে জমা রাখে।\\nপ্রতি ৫ মিনিটে ডেটার সারাংশ সংরক্ষিত হয় আর প্রতি ঘণ্টায় Piyuo Cloud বা আপনার নিজের সার্ভারে আপলোড হয়।';

  @override
  String get onboarding_intro_title1 => 'এআই ট্রাফিক গণনা';

  @override
  String get onboarding_intro_title2 => 'গোপনীয়তা সবার আগে';

  @override
  String get onboarding_intro_title3 => '২৪/৭ স্বয়ংক্রিয়ভাবে কাজ করে';

  @override
  String get onboarding_next_action => 'পরবর্তী';

  @override
  String get onboarding_skip_action => 'ভূমিকা এড়িয়ে যান';

  @override
  String get onboarding_start_action => 'শুরু করুন';

  @override
  String get passed_by => 'অতিক্রম করেছে';

  @override
  String get passed_by_help =>
      'বর্তমান গণনা সময়সীমায় এই এলাকার মধ্য দিয়ে অতিক্রম করা মানুষ বা যানবাহনের সংখ্যা গণনা করে।\\n\\nপ্রতিটি ব্যক্তি বা যানবাহন প্রতিবার এলাকা অতিক্রম করার জন্য একবার করে গণনা করা হয়।';

  @override
  String get payloads_screen_area => 'এলাকা';

  @override
  String get payloads_screen_confidence => 'আস্থা';

  @override
  String get payloads_screen_coverage => 'কভারেজ';

  @override
  String get payloads_screen_delivered => 'পৌঁছে গেছে';

  @override
  String get payloads_screen_failed_load => 'সাম্প্রতিক পেলোড লোড করতে ব্যর্থ';

  @override
  String get payloads_screen_frame_processed => 'প্রক্রিয়াকৃত ফ্রেম';

  @override
  String get payloads_screen_hour_not_exists =>
      'এই সময়ের ঘণ্টাটি আর বিদ্যমান নেই।';

  @override
  String get payloads_screen_missing_time => 'হারানো সময়';

  @override
  String get payloads_screen_no_payloads => 'এখনও কোনো পেলোড নেই।';

  @override
  String get payloads_screen_partial => 'উইন্ডো আগেই শেষ হয়েছে (আংশিক)';

  @override
  String get payloads_screen_partially => 'আংশিকভাবে পৌঁছেছে';

  @override
  String get payloads_screen_payload_not_exists =>
      'এই পেলোডটি আর বিদ্যমান নেই।';

  @override
  String get payloads_screen_pending => 'অপেক্ষমাণ';

  @override
  String get payloads_screen_process_fps => 'প্রসেস FPS';

  @override
  String get payloads_screen_resend => 'পুনরায় পাঠান';

  @override
  String get payloads_screen_select_first =>
      'আগে অন্তত একটি তারিখ বা ঘণ্টা নির্বাচন করুন।';

  @override
  String get payloads_screen_subtitle =>
      'তারিখ বা ঘণ্টা নির্বাচন করে পুনরায় পাঠান';

  @override
  String get payloads_screen_title => 'সাম্প্রতিক পেলোড';

  @override
  String get personal_custom_screen_build_server =>
      'নিজের সার্ভার সেটআপে সাহায্য দরকার?\\nআমাদের API ডকুমেন্টেশন এবং সার্ভারের উদাহরণ দেখুন।';

  @override
  String get personal_custom_screen_help_action => 'API ডকুমেন্টেশন খুলুন';

  @override
  String get personal_custom_screen_reset_action => 'আবার শুরু করুন';

  @override
  String get personal_custom_success_screen_help =>
      'নিচের Start বোতামে ট্যাপ করে গণনা শুরু করুন।';

  @override
  String get personal_custom_success_screen_help1 =>
      'ট্রাফিক পরিসংখ্যান প্রতি ঘণ্টায় স্বয়ংক্রিয়ভাবে আপলোড হয়।\\nআপনি Upload Logs স্ক্রিন থেকেও হাতে আপলোড করতে পারেন।';

  @override
  String get personal_custom_success_screen_help2 =>
      'আপনার সার্ভার এখনই অনলাইনে থাকার প্রয়োজন নেই।\\nএখনই গণনা শুরু করুন। পরে আপনার সার্ভার তৈরি ও পরীক্ষা করতে পারবেন। ট্রাফিক পরিসংখ্যান সফলভাবে আপলোড না হওয়া পর্যন্ত এই ডিভাইসেই থাকবে।';

  @override
  String get personal_custom_success_screen_send_to =>
      'ট্রাফিক পরিসংখ্যান পাঠানো হবে';

  @override
  String get personal_custom_success_screen_title => 'সার্ভার প্রস্তুত';

  @override
  String get piyuo_server_screen_cloud_url_label => 'আপনার Piyuo Cloud URL';

  @override
  String get piyuo_server_screen_copy_action => 'URL কপি করুন';

  @override
  String get piyuo_server_screen_copy_success => 'URL কপি করা হয়েছে';

  @override
  String get piyuo_server_screen_saving_action => 'সংরক্ষণ হচ্ছে...';

  @override
  String get piyuo_server_screen_start =>
      'গণনা শুরু করতে নিচের \"Start\" বোতামটি চাপুন।';

  @override
  String get piyuo_server_screen_url_help =>
      'আপনার ব্যক্তিগত Piyuo Cloud ড্যাশবোর্ড এই URL-এ প্রস্তুত।';

  @override
  String get piyuo_server_screen_url_remember =>
      'অন্য ডিভাইস থেকে আপনার ট্রাফিক ড্যাশবোর্ডে প্রবেশ করতে এই URL সংরক্ষণ করুন।';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloud ব্যবহার করুন';

  @override
  String get privacy => 'গোপনীয়তা নীতি';

  @override
  String get product_copyright => 'কপিরাইট © ২০২৬';

  @override
  String get product_desc => 'এআই-চালিত মানুষ ও যানবাহন গণনা।';

  @override
  String get settings_screen_custom_subtitle =>
      'ট্রাফিক ডেটা সরাসরি আপনার ব্যাকএন্ড বা ডাটাবেসে পাঠান।';

  @override
  String get settings_screen_custom_title => 'কাস্টম সার্ভার ব্যবহার করুন';

  @override
  String get settings_screen_data_server_label => 'ডেটা সার্ভার';

  @override
  String get settings_screen_detection_target => 'শনাক্তকরণের লক্ষ্য';

  @override
  String get settings_screen_language_title => 'ভাষা';

  @override
  String get settings_screen_local_subtitle =>
      'এই ডিভাইসেই ট্রাফিক ডেটা সংরক্ষণ করুন। কোনো তথ্য আপলোড হবে না।';

  @override
  String get settings_screen_local_title => 'শুধু এই ডিভাইস';

  @override
  String get settings_screen_misc_label => 'বিবিধ';

  @override
  String get settings_screen_object_detection => 'বস্তু শনাক্তকরণ';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Piyuo Cloud-এ আপনার চলাচলের ডেটা সংরক্ষণ করুন, ড্যাশবোর্ড ও ব্যবসায়িক বিশ্লেষণসহ.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'এটি সব ডেটা মুছে দিয়ে নতুন করে শুরু করবে। এই কাজটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get settings_screen_reset_all_data_title => 'সব ডেটা রিসেট করবেন?';

  @override
  String get settings_screen_subscription_body =>
      'আপনার সাবস্ক্রিপশন ও বিলিং তথ্য পরিচালনা করুন';

  @override
  String get settings_screen_subscription_title => 'সাবস্ক্রিপশন';

  @override
  String get start_screen_about => 'সম্পর্কে';

  @override
  String get start_screen_server_none => 'ডেটা শুধু এই ডিভাইসেই সংরক্ষিত থাকবে';

  @override
  String get start_screen_server_personal => 'ডেটা প্রতি ঘণ্টায় আপলোড করা হয়';

  @override
  String get start_screen_settings => 'সেটিংস';

  @override
  String get start_screen_upload_logs => 'লগ আপলোড করুন';

  @override
  String get start_screen_video_sources => 'ভিডিও উৎস';

  @override
  String get stayed => 'থেকেছে';

  @override
  String get stayed_help =>
      'গণনা করে কতজন মানুষ বা কতটি যানবাহন এই এলাকায় নির্ধারিত ন্যূনতম অবস্থান সময় পর্যন্ত ছিল।\\n\\nডিফল্ট Stay Time হলো ১৫ সেকেন্ড, যা Settings থেকে পরিবর্তন করা যায়।';

  @override
  String get target_pedestrian => 'পথচারী';

  @override
  String get target_pedestrian_help =>
      'পথচারী শনাক্তকরণ মডেল ব্যবহার করে মানুষ গণনা করুন';

  @override
  String get target_screen_subtitle =>
      'কোন শনাক্তকরণ মডেল ব্যবহার করবেন তা নির্বাচন করুন';

  @override
  String get target_vehicle => 'যানবাহন';

  @override
  String get target_vehicle_help =>
      'গাড়ি ও অন্যান্য যানবাহন যানবাহন শনাক্তকরণ মডেল দিয়ে গণনা করুন';

  @override
  String get telemetry_error_connection_refused =>
      'সার্ভারে পৌঁছানো যায়নি। এটি এখন অফলাইন থাকতে পারে।';

  @override
  String get telemetry_error_connection_reset =>
      'সংযোগটি পুনরায় সেট হয়েছে। আপনার ইন্টারনেট সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।';

  @override
  String get telemetry_error_connection_timeout =>
      'সংযোগ সাড়া দিতে অনেক সময় নিয়েছে। আপনার ইন্টারনেট সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'সার্ভারের ঠিকানা খুঁজে পাওয়া যায়নি। আপনার ইন্টারনেট সংযোগ বা সার্ভার URL পরীক্ষা করুন।';

  @override
  String get telemetry_error_http_error_status =>
      'সার্ভার অনুরোধটি প্রত্যাখ্যান করেছে। পরে আবার চেষ্টা করুন।';

  @override
  String get telemetry_error_http_unknown_error =>
      'সার্ভারের সাথে যোগাযোগের সময় একটি অপ্রত্যাশিত ত্রুটি ঘটেছে।';

  @override
  String get telemetry_error_invalid_url =>
      'সার্ভারের ঠিকানাটি অবৈধ। আপনার সেটিংস পরীক্ষা করুন।';

  @override
  String get telemetry_error_network_error =>
      'একটি নেটওয়ার্ক ত্রুটি হয়েছে। আপনার ইন্টারনেট সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।';

  @override
  String get telemetry_error_socket_error =>
      'একটি নেটওয়ার্ক সংযোগ সমস্যা হয়েছে। আপনার ইন্টারনেট সংযোগ পরীক্ষা করুন।';

  @override
  String get telemetry_error_transport_exception =>
      'ডেটা পাঠানোর সময় কিছু ভুল হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get terms => 'পরিষেবার শর্তাবলী';

  @override
  String get upload_screen_attempt_time => 'চেষ্টার সময়:';

  @override
  String get upload_screen_error => 'ত্রুটি:';

  @override
  String get upload_screen_failed => 'ব্যর্থ';

  @override
  String get upload_screen_load_error => 'আপলোড লগ লোড করা যায়নি।';

  @override
  String get upload_screen_log_not_exists => 'আপলোড লগ আর উপলব্ধ নয়।';

  @override
  String get upload_screen_next => 'পরবর্তী আপলোড ...';

  @override
  String get upload_screen_next_upload_prefix => 'পরবর্তী আপলোড ';

  @override
  String get upload_screen_no_data_server =>
      'অনুগ্রহ করে আগে ডেটা সার্ভার সেট করুন।';

  @override
  String get upload_screen_no_logs => 'এখনও কোনো আপলোড লগ নেই।';

  @override
  String get upload_screen_payload_count => 'পেলোড সংখ্যা';

  @override
  String get upload_screen_payload_count_label => 'পেলোড সংখ্যা:';

  @override
  String get upload_screen_payload_size => 'পেলোডের আকার:';

  @override
  String get upload_screen_result => 'ফলাফল:';

  @override
  String get upload_screen_retry => 'পুনরায় চেষ্টার সংখ্যা:';

  @override
  String get upload_screen_size_kb => 'কেবি';

  @override
  String get upload_screen_success => 'সফল';

  @override
  String get upload_screen_today => 'আজ';

  @override
  String get upload_screen_upload_now => 'এখন আপলোড করুন';

  @override
  String get upload_screen_upload_success => 'আপলোড সফল।';

  @override
  String get upload_screen_uploading => 'আপলোড হচ্ছে...';

  @override
  String get upload_screen_yesterday => 'গতকাল';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP URL-এ অবশ্যই হোস্ট নাম থাকতে হবে।';

  @override
  String get url_screen_invalid_url_error =>
      'একটি সমর্থিত স্কিমসহ বৈধ URL লিখুন।';

  @override
  String get url_screen_subtitle => 'লাইভ স্ট্রিম URL লিখুন';

  @override
  String get url_screen_title => 'লাইভ স্ট্রিম URL';

  @override
  String get url_screen_unsupported_scheme_error => 'শুধুমাত্র HTTP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'অনুগ্রহ করে একটি লাইভ স্ট্রিম URL লিখুন।';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream বা rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'পিছনের ক্যামেরা';

  @override
  String get video_sources_camera => 'ক্যামেরা';

  @override
  String get video_sources_file => 'ফাইল';

  @override
  String get video_sources_front_camera => 'সামনের ক্যামেরা';

  @override
  String get video_sources_live_stream => 'লাইভ স্ট্রিম URL';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'ক্যামেরা ব্যবহার করতে অনুমতি প্রদান করুন';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'ক্যামেরা পাওয়া যায়নি';

  @override
  String get video_sources_screen_import_error =>
      'ভিডিও ফাইল ইম্পোর্ট করা যায়নি।';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'অনুগ্রহ করে সেটিংসে যান এবং এই অ্যাপটির জন্য ফটো অ্যাক্সেসের অনুমতি দিন।';

  @override
  String get video_sources_screen_select_camera =>
      'এই ক্যামেরাটি নির্বাচন করতে ট্যাপ করুন';

  @override
  String get video_sources_screen_select_file =>
      'ফাইল নির্বাচন করতে ট্যাপ করুন';

  @override
  String get video_sources_screen_select_live =>
      'লাইভ স্ট্রিম URL সেট করতে ট্যাপ করুন';

  @override
  String get video_sources_webcam => 'ওয়েবক্যাম';
}
