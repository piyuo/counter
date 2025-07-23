// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class LocalizationMy extends Localization {
  LocalizationMy([String locale = 'my']) : super(locale);

  @override
  String get product_name => 'ကောင်တာ';

  @override
  String get product_desc =>
      'ကွန်ပျူတာမျက်စိနှင့် AI ကိုအသုံးပြု၍ လူများ၊ ယာဉ်များ၊ အိမ်မွေးတိရစ္ဆာန်များနှင့် အခြားအရာများကို ရေတွက်ပါ။';

  @override
  String get product_copyright => 'မူပိုင်ခွင့် © 2025';

  @override
  String get video_sources_webcam => 'ဝက်ဘ်ကင်မရာ';

  @override
  String get video_sources_live_stream => 'တိုက်ရိုက်ထုတ်လွှင့်မှု URL';

  @override
  String get video_sources_file => 'ဖိုင်';

  @override
  String get video_sources_camera => 'ကင်မရာ';

  @override
  String get video_sources_camera_not_found_title => 'ကင်မရာမတွေ့ပါ';

  @override
  String get video_sources_camera_not_found_message =>
      'ကင်မရာကိုအသုံးပြုရန် ကင်မရာခွင့်ပြုချက်လိုအပ်သည်';

  @override
  String get video_sources_webcam_not_found_title => 'ဝက်ဘ်ကင်မရာမတွေ့ပါ';

  @override
  String get video_sources_webcam_not_found_message =>
      'অ্যাপ অনুমতি এবং ওয়েবক্যাম সংযোগ যাচাই করুন';

  @override
  String get wizard_screen_desc =>
      'ရေတွက်စတင်ရန် အောက်တွင် စီမံကိန်းအသစ်တစ်ခု ဖန်တီးပါ။';

  @override
  String get wizard_screen_new_project_from => 'အောက်ပါမှ စီမံကိန်းအသစ်';

  @override
  String get wizard_screen_language => 'ဘာသာစကား';

  @override
  String get wizard_screen_about => 'အကြောင်း';

  @override
  String get wizard_screen_open_projects_tip =>
      'စီမံကိန်းအားလုံးကို စက်ထဲတွင် အလိုအလျောက် သိမ်းဆည်းထားမည်';

  @override
  String get wizard_screen_open_projects => 'ရှိပြီးသားစီမံကိန်းကို ဖွင့်ပါ';

  @override
  String get wizard_screen_email_us => 'ကျွန်ုပ်တို့ထံ အီးမေးလ်ပို့ပါ';

  @override
  String get language_screen_language => 'ဘာသာစကား';

  @override
  String get project_view_no_videos => 'ဗီဒီယိုရင်းမြစ်မရှိပါ။';

  @override
  String get about_screen_title => 'အကြောင်း';

  @override
  String get about_screen_platform => 'ပလက်ဖောင်း';

  @override
  String get about_screen_app_version => 'အက်ပ်ဗားရှင်း';

  @override
  String get about_screen_models => 'အရာဝတ္ထုရှာဖွေခြင်းမော်ဒယ်များ';

  @override
  String get about_screen_benchmark => 'စံပြုတိုင်းတာချက်';

  @override
  String get about_screen_opencv_build_info => 'OpenCV ဆောက်လုပ်မှုအချက်အလက်';

  @override
  String get benchmark_screen_title => 'မော်ဒယ်စံပြုတိုင်းတာချက်များ';

  @override
  String get benchmark_screen_recommended => 'အကြံပြုထားသောမော်ဒယ်';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'စံပြုတိုင်းတာချက်စတင်ပါ';

  @override
  String get benchmark_screen_start_failed =>
      'စံပြုတိုင်းတာချက်စတင်ရန် မအောင်မြင်ပါ၊ အမှားကုဒ်မှာ';

  @override
  String get benchmark_screen_models => 'အရာဝတ္ထုရှာဖွေမှုမော်ဒယ်များ';

  @override
  String get project_screen_title => 'စီမံကိန်း';

  @override
  String get project_screen_exit_confirm_title =>
      'စီမံကိန်းမှထွက်ရန် အတည်ပြုပါ';

  @override
  String get project_screen_exit_confirm_content =>
      'စီမံကိန်းမှထွက်ခွာခြင်းသည် ရေတွက်ခြင်းကို ရပ်တန့်မည်ဖြစ်သည်။ ဆက်လက်လုပ်ဆောင်ရန် သေချာပါသလား။';

  @override
  String get project_screen_exit_button => 'ထွက်ရန်';

  @override
  String get project_screen_add_video_button => 'ဗီဒီယိုရင်းမြစ်ထည့်ပါ';

  @override
  String get project_screen_from_desc =>
      'လိုအပ်သောအချိန်ကို ကြည့်ရှုနိုင်ရန် ၂၄ နာရီ မှတ်တမ်းကို ထိန်းသိမ်းထားပါသည်။';

  @override
  String get project_screen_report_settings => 'ဆက်တင်များ';

  @override
  String get filter_screen_title => 'စစ်ထုတ်ရန်';

  @override
  String get filter_screen_desc =>
      'အောက်ပါစာရင်းမှ စစ်ထုတ်မည့်အပိုင်းကို ရွေးချယ်ပါ';

  @override
  String get filter_screen_error_title => 'စစ်ထုတ်ရန်';

  @override
  String get filter_screen_error_content =>
      'အဆုံးအချိန်သည် စတင်ချိန်ထက် ကြီးရမည်';

  @override
  String get filter_screen_error_custom => 'စိတ်ကြိုက်';

  @override
  String get filter_screen_error_start => 'စတင်';

  @override
  String get filter_screen_error_end => 'အဆုံး';

  @override
  String get settings_screen_title => 'ဆက်တင်များ';

  @override
  String get settings_screen_desc =>
      'စီမံကိန်းအမည်၊ ရှာဖွေမှုသတ်မှတ်ချက်များ၊ ရေတွက်မှုရှင်းလင်းခြင်းတို့ကို သတ်မှတ်ပါ။';

  @override
  String get settings_screen_project_id => 'စီမံကိန်း ID';

  @override
  String get settings_screen_project_name => 'စီမံကိန်းအမည်';

  @override
  String get settings_screen_project_name_place_holder =>
      'မင်္ဂလာလမ်း ၁၂၃ သို့မဟုတ် ရွှေတိဂုံဥယျာဉ်';

  @override
  String get settings_screen_project_error => 'စီမံကိန်းအမည် ဗလာမဖြစ်နိုင်ပါ';

  @override
  String get settings_screen_random_count_button => 'ကျပန်းရေတွက်မှုထည့်ပါ';

  @override
  String get settings_screen_reset_count_header =>
      'ဤစီမံကိန်းရှိ ရေတွက်မှုအားလုံးကို ပြန်လည်သတ်မှတ်ပါ';

  @override
  String get settings_screen_reset_count_button =>
      'ရေတွက်မှုများကို ပြန်လည်သတ်မှတ်ပါ';

  @override
  String get settings_screen_reset_count_content =>
      'ရေတွက်မှုအားလုံးကို ပြန်လည်သတ်မှတ်ရန် သေချာပါသလား။';

  @override
  String get settings_screen_delete_header => 'ဤစီမံကိန်းကို ဖျက်ပါ';

  @override
  String get settings_screen_delete_content =>
      'ဤစီမံကိန်းကို ဖျက်ရန် သေချာပါသလား။';

  @override
  String get settings_screen_delete_button => 'ဖျက်ပါ';

  @override
  String get settings_screen_center_point_title => 'ပစ်မှတ်ပေါ်တွင် အလယ်အမှတ်';

  @override
  String get settings_screen_center_point_desc =>
      'အလယ်အမှတ်သည် ပစ်မှတ်သည် ထိမှတ်ဇုန်အတွင်း ရှိမရှိ ဆုံးဖြတ်ရာတွင် အထောက်အကူဖြစ်စေသည်။';

  @override
  String get settings_screen_center_point_button =>
      'ပစ်မှတ်ပေါ်တွင် အလယ်အမှတ်ပြပါ';

  @override
  String get settings_screen_lost_target_title => 'ပျောက်ဆုံးသွားသော ပစ်မှတ်';

  @override
  String get settings_screen_lost_target_desc =>
      'အရာဝတ္ထုခြေရာခံခြင်းသည် ပစ်မှတ်ပျောက်ဆုံးသောအခါ ဤရွေးချယ်မှုက မြင်သာအောင်ပြုလုပ်ပေးသည်။ ပုံမှန်အားဖြင့် ပျောက်ဆုံးသော ပစ်မှတ်များကို မပြပါ။';

  @override
  String get settings_screen_lost_target_button =>
      'ပျောက်ဆုံးသွားသော ပစ်မှတ်ကိုပြပါ';

  @override
  String get detection_screen_title => 'ရှာဖွေခြင်းဆက်တင်များ';

  @override
  String get detection_screen_models => 'မော်ဒယ်များ';

  @override
  String get detection_screen_confidence => 'ယုံကြည်မှု';

  @override
  String get detection_screen_confidence_desc =>
      'ယုံကြည်မှု #0 ထက်ကျော်လွန်လျှင် တရားဝင်ရှာဖွေမှုအဖြစ် သတ်မှတ်သည်';

  @override
  String get detection_screen_low => 'နိမ့်';

  @override
  String get detection_screen_high => 'မြင့်';

  @override
  String get detection_screen_nms => 'မမာဟုမ်-အများဆုံးဖိနှိပ်မှု';

  @override
  String get detection_screen_nms_desc =>
      '#0 NMS သတ်မှတ်ချက် နိမ့်ပါက (ဥပမာ 0.3-0.4) ထပ်နေသော ဘောင်များကို ပိုမိုတင်းကျပ်စွာ ဖယ်ရှားပြီး မှားယွင်းသော အပေါင်းလက္ခဏာများ လျော့နည်းစေသော်လည်း ထပ်နေသော လူများကို လွဲချော်နိုင်ပါသည်။ မြင့်မားသော သတ်မှတ်ချက် (0.7-0.9) သည် ဘောင်များကို ပိုမိုထိန်းသိမ်းထားသောကြောင့် မှားယွင်းသော အပေါင်းလက္ခဏာများ ပိုမိုတိုးပွားလာနိုင်သော်လည်း ထပ်နေသော လူများကို ပိုမိုကောင်းမွန်စွာ ဖော်ထုတ်နိုင်ပါသည်။';

  @override
  String get detection_screen_match => 'တိုက်ဆိုင်မှု';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold သည် အရာဝတ္ထုခြေရာခံခြင်းတွင် မတူညီသော ရှာဖွေမှုဘောင်များအကြား ကိုက်ညီမှုအဆင့်ကို တိုင်းတာသော အဓိကပါရာမီတာဖြစ်သည်။ နိမ့်သောတန်ဖိုးသည် အရာဝတ္ထုဆက်နွယ်မှုကို ပိုမိုလွယ်ကူစေသော်လည်း မှားယွင်းသောဆက်နွယ်မှုများ၏ အန္တရာယ်ကို တိုးစေသည်။ မြင့်သောတန်ဖိုးသည် အရာဝတ္ထုဆက်နွယ်မှုများတွင် ပိုမိုတင်းကျပ်သော်လည်း အမှန်တကယ်ကိုက်ညီမှုအချို့ကို လွတ်သွားနိုင်သည်။';

  @override
  String get detection_screen_lost => 'ပျောက်ဆုံးသွားခြင်း';

  @override
  String get detection_screen_lost_desc =>
      'အရွေ့အလျင်အပေါ် အခြေခံ၍ #0 နှင့် #1 ကြား ပျောက်ဆုံးသွားသော အရာဝတ္ထုများကို ဖယ်ရှားရန် အချိန်ကို ပြောင်းလဲနိုင်စွမ်းရှိစွာ ဆုံးဖြတ်သည်';

  @override
  String get detection_screen_consider_valid => 'ခိုင်မာသည်ဟု သတ်မှတ်ချိန်';

  @override
  String get detection_screen_consider_valid_desc =>
      'ခြေရာခံအရာဝတ္ထုကို #0 နောက်တွင် ခိုင်မာသည်ဟု သတ်မှတ်မည်';

  @override
  String get detection_screen_reset => 'ပြန်လည်သတ်မှတ်ပါ';

  @override
  String get detection_screen_reset_content =>
      'ရှာဖွေခြင်းဆက်တင်များကို ပြန်လည်သတ်မှတ်ရန် သေချာပါသလား။';

  @override
  String get url_screen_title => 'တိုက်ရိုက်ထုတ်လွှင့်မှု URL';

  @override
  String get url_screen_desc => 'တိုက်ရိုက်ထုတ်လွှင့်မှု URL ကို ထည့်သွင်းပါ';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream သို့မဟုတ် rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'ဗီဒီယိုရင်းမြစ်ထည့်ပါ';

  @override
  String get add_video_screen_from => 'အောက်ပါရင်းမြစ်မှ ဗီဒီယိုထည့်ပါ';

  @override
  String get webcam_screen_add_title => 'ဝက်ဘ်ကင်မရာထည့်ပါ';

  @override
  String get webcam_screen_edit_title => 'ဝက်ဘ်ကင်မရာရွေးချယ်ပါ';

  @override
  String get webcam_manager_webcam => 'ဝက်ဘ်ကင်မရာ';

  @override
  String get camera_screen_front_camera => 'ရှေ့ကင်မရာ';

  @override
  String get camera_screen_back_camera => 'နောက်ကင်မရာ';

  @override
  String get camera_screen_add_title => 'ကင်မရာထည့်ပါ';

  @override
  String get camera_screen_edit_title => 'ကင်မရာရွေးချယ်ပါ';

  @override
  String get camera_screen_zoom_level => 'ချဲ့/ချုံ့အဆင့်';

  @override
  String get video_screen_name_empty => 'ဗီဒီယိုအမည် ဗလာမဖြစ်နိုင်ပါ။';

  @override
  String get video_screen_desc =>
      'ဗီဒီယိုရင်းမြစ်များကို စီမံခန့်ခွဲပါ၊ ရှာဖွေမှုဇုန်များကို ထည့်သွင်းခြင်း သို့မဟုတ် ပြုပြင်ခြင်း။';

  @override
  String get video_screen_video_name => 'ဗီဒီယိုရင်းမြစ်အမည်';

  @override
  String get video_screen_edit_placeholder =>
      'ရှေ့တံခါးကင်မရာ သို့မဟုတ် ကားရပ်နားကင်မရာ';

  @override
  String get video_screen_change_file => 'ဖိုင်ပြောင်းပါ';

  @override
  String get video_screen_add_zone => 'ရှာဖွေမှုဇုန်ထည့်ပါ';

  @override
  String get video_screen_zones => 'ရှာဖွေမှုဇုန်များ';

  @override
  String get video_screen_zones_desc =>
      'ဇုန်များကို ချိန်ညှိရန် ဆွဲချ/ချထားခြင်းကို အသုံးပြုပါ';

  @override
  String get video_screen_tools => 'ကိရိယာများ';

  @override
  String get video_screen_move_bottom => 'လက်ရှိဇုန်ကို အောက်ဆုံးသို့ရွှေ့ပါ';

  @override
  String get video_screen_add_point => 'လက်ရှိဇုန်တွင် အမှတ်ထည့်ပါ';

  @override
  String get video_screen_remove_point => 'လက်ရှိဇုန်မှ အမှတ်ကိုဖယ်ရှားပါ';

  @override
  String get video_screen_playback_speed => 'ဖွင့်ခြင်းအမြန်နှုန်း';

  @override
  String get video_screen_playback_current => 'လက်ရှိ: ';

  @override
  String get video_screen_playback_14x => '1/4 ဆ';

  @override
  String get video_screen_playback_2x => '2 ဆ';

  @override
  String get video_screen_delete_header => 'ဤဗီဒီယိုရင်းမြစ်ကို ဖျက်ပါ';

  @override
  String get video_screen_delete_content =>
      'ဤဗီဒီယိုရင်းမြစ်ကို ဖျက်ရန် သေချာပါသလား။';

  @override
  String get video_screen_delete_button => 'ဖျက်ပါ';

  @override
  String get video_screen_sources =>
      'ပုံရင်းမြစ်၊ ရှာဖွေမှုပစ်မှတ်နှင့် မော်ဒယ်သတ်မှတ်ချက်များကို စီစဉ်ပါ။';

  @override
  String get video_screen_targets => 'ရှာဖွေမှုပစ်မှတ်များ';

  @override
  String get video_screen_detection => 'မော်ဒယ်သတ်မှတ်ချက်များ';

  @override
  String get color_screen_title => 'အရောင်ရွေးချယ်ပါ';

  @override
  String get zone_screen_desc =>
      'ရှာဖွေမှုဇုန်သည် ရှာဖွေရန် အရာဝတ္ထုအမျိုးအစားများကို သတ်မှတ်နိုင်ပြီး ရှာတွေ့ပြီး၊ ပေါ်လာပြီး၊ ဝင်လာပြီးကဲ့သို့ မည်သည့်ကောင်တာများကို ပြရမည်ကို ရွေးချယ်နိုင်သည်။';

  @override
  String get zone_screen_name_placeholder =>
      'လမ်းဘေး သို့မဟုတ် ကားရပ်နားရန်နေရာကဲ့သို့ ဇုန်၏အမည်';

  @override
  String get zone_screen_zone_color => 'ဇုန်အရောင်';

  @override
  String get zone_screen_color => 'အရောင်';

  @override
  String get zone_screen_delete_header => 'ဤဇုန်ကို ဖျက်ပါ';

  @override
  String get zone_screen_delete_content => 'ဤဇုန်ကို ဖျက်ရန် သေချာပါသလား။';

  @override
  String get zone_screen_delete_button => 'ဖျက်ပါ';

  @override
  String get zone_screen_can_not_delete => 'ဇုန်ကို ဖျက်၍မရပါ';

  @override
  String get zone_screen_one_zone_required =>
      'အနည်းဆုံး ဇုန်တစ်ခု လိုအပ်ပါသည်။';

  @override
  String get zone_screen_zone_name_required => 'ဇုန်အမည် ဗလာမဖြစ်နိုင်ပါ';

  @override
  String get counter_screen_show_on => 'မျက်နှာပြင်ပေါ်တွင်ပြပါ';

  @override
  String get counter_screen_enabled => 'ဖွင့်ထားသည်';

  @override
  String get counter_screen_reentry_threshold =>
      'ပြန်လည်ဝင်ရောက်မှုသတ်မှတ်ချက်';

  @override
  String get counter_screen_reentry_desc =>
      'အရာဝတ္ထုများသည် #0 ကြိမ် ဝင်ရမည်၊ ထွက်သွားပြီး ပြန်ဝင်ရောက်ခြင်းအကြား #1 စက္ကန့် အအေးခံချိန်ဖြင့် ပြန်လည်ဝင်ရောက်မှုကို စတင်နိုင်သည်';

  @override
  String get counter_screen_reentry_title => 'ပြန်လည်ဝင်ရောက်မှုရေတွက်ခြင်း';

  @override
  String get counter_screen_cooldown_threshold => 'အအေးခံချိန်သတ်မှတ်ချက်';

  @override
  String get counter_screen_cooldown_desc =>
      'ပြန်လည်ဝင်ရောက်ရန် ရှာဖွေမှုဇုန်မှ ထွက်ခွာပြီးနောက် #0 စက္ကန့် အအေးခံချိန် လိုအပ်သည်';

  @override
  String get counter_screen_cooldown_time => 'အအေးခံချိန်';

  @override
  String get counter_screen_cooldown_in_seconds => 'စက္ကန့်ဖြင့်';

  @override
  String get counter_screen_stagnant_threshold => 'ရပ်တန့်နေမှုသတ်မှတ်ချက်';

  @override
  String get counter_screen_stagnant_desc =>
      '#0 စက္ကန့်ထက်ပိုပြီး မလှုပ်ရှားဘဲနေသော အရာဝတ္ထုများကို ရပ်တန့်နေသည်ဟု သတ်မှတ်မည်';

  @override
  String get counter_screen_stagnant_consider => 'ရပ်တန့်နေသည်ဟု သတ်မှတ်ရန်';

  @override
  String get counter_screen_stagnant_in_seconds => 'စက္ကန့်ဖြင့်';

  @override
  String get counter_screen_stagnant_desc_prefix => 'ဖော်ပြချက်ရှေ့ဆက်';

  @override
  String get counter_screen_stagnant_desc_suffix => 'ဖော်ပြချက်နောက်ဆက်';

  @override
  String get counter_screen_name_error => 'ကောင်တာအမည် ဗလာမဖြစ်နိုင်ပါ';

  @override
  String get counter_screen_enabled_error => 'အမှား';

  @override
  String get counter_screen_enabled_error_content =>
      'ဤကောင်တာကို ပိတ်ရန်အတွက် အခြားကောင်တာကို အရင်ဖွင့်ရန် လိုအပ်ပါသည်';

  @override
  String get objects_screen_title => 'အရာဝတ္ထုများ';

  @override
  String get objects_screen_desc =>
      'လူ၊ ကား၊ ဘတ်စ်ကား စသည်ဖြင့် ရှာဖွေမှုပစ်မှတ်များကို ရွေးချယ်ပါ။';

  @override
  String get open_project_screen_title => 'စီမံကိန်းဖွင့်ပါ';

  @override
  String get open_project_screen_desc =>
      'ယခင်ဖန်တီးခဲ့သော စီမံကိန်းများကို ဖွင့်ပါ၊ နောက်ဆုံး ၂၀ ခုကိုသာ သိမ်းထားပါသည်။';

  @override
  String get open_project_screen_no_project => 'စီမံကိန်းမတွေ့ရှိပါ။';

  @override
  String get default_project_name => 'စီမံကိန်း';

  @override
  String get default_video_name => 'ဗီဒီယိုရင်းမြစ်';

  @override
  String get default_zone_name => 'ရှာဖွေမှုဇုန်';

  @override
  String get error_oops => 'အိုး၊ တစ်ခုခုမှားယွင်းသွားပါပြီ';

  @override
  String get error_content =>
      'မမျှော်လင့်ထားသောအမှားတစ်ခု ဖြစ်ပွားခဲ့သည်။ အီးမေးလ်အစီရင်ခံစာတင်သွင်းလိုပါသလား။';

  @override
  String get error_report => 'ကျွန်ုပ်တို့ထံ အီးမေးလ်ပို့ပါ';

  @override
  String get submit => 'တင်သွင်းပါ';

  @override
  String get ok => 'အိုကေ';

  @override
  String get cancel => 'ပယ်ဖျက်ပါ';

  @override
  String get yes => 'ဟုတ်ကဲ့';

  @override
  String get no => 'မဟုတ်ပါ';

  @override
  String get close => 'ပိတ်ပါ';

  @override
  String get back => 'နောက်သို့';

  @override
  String get zone_screen_zone => 'ဇုန်';

  @override
  String get zone_screen_zone_show_summary =>
      'မျက်နှာပြင်တွင် အကျဉ်းချုပ် ပြရန်';

  @override
  String get video_sources_photos_denied =>
      'ဓာတ်ပုံများသို့ ဝင်ရောက်ခွင့် ငြင်းပယ်ခံရ';

  @override
  String get video_sources_photos_goto_settings => 'ဆက်တင်သို့သွားပါ';

  @override
  String get video_sources_camera_denied =>
      'ကင်မရာသို့ ဝင်ရောက်ခွင့် ငြင်းပယ်ခံရ';

  @override
  String get video_sources_photos_denied_msg =>
      'ဆက်တင်သို့သွားပြီး ဤအက်ပ်အတွက် ဓာတ်ပုံဝင်ရောက်ခွင့် ခွင့်ပြုပါ။';

  @override
  String get video_sources_camera_denied_msg =>
      'ဆက်တင်သို့သွားပြီး ဤအက်ပ်အတွက် ကင်မရာဝင်ရောက်ခွင့် ခွင့်ပြုပါ။';
}
