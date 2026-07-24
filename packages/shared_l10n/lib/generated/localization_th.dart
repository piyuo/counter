// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class LocalizationTh extends Localization {
  LocalizationTh([String locale = 'th']) : super(locale);

  @override
  String get about_screen_app_version => 'เวอร์ชันแอป';

  @override
  String get about_screen_email_us => 'อีเมลถึงเรา';

  @override
  String get about_screen_platform => 'แพลตฟอร์ม';

  @override
  String get appeared => 'ปรากฏ';

  @override
  String get appeared_help =>
      'นับจำนวนคนหรือยานพาหนะที่ตรวจพบตำแหน่งแรกอยู่ภายในพื้นที่นี้\\n\\nช่วยให้เข้าใจว่าการติดตามเริ่มต้นจากจุดใด\\n\\n(เหมาะสำหรับผู้ใช้ขั้นสูง)';

  @override
  String get average_occupancy => 'จำนวนเฉลี่ย';

  @override
  String get average_occupancy_help =>
      'แสดงจำนวนเฉลี่ยของคนหรือยานพาหนะในพื้นที่นี้ตลอดช่วงหน้าต่างการนับปัจจุบัน\\n\\nช่วยให้ทราบว่าพื้นที่นี้มีความหนาแน่นเพียงใดตลอดช่วงเวลาการนับ';

  @override
  String get average_stay => 'เวลาพักเฉลี่ย';

  @override
  String get average_stay_help =>
      'แสดงระยะเวลาเฉลี่ยที่คนหรือยานพาหนะอยู่ในพื้นที่นี้\\n\\nเวลาพักเฉลี่ยที่นานขึ้นอาจหมายถึงลูกค้าใช้เวลาอยู่ในพื้นที่นี้มากขึ้น';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter ใช้กล้องและ AI บนอุปกรณ์เพื่อนับจำนวนคน ก่อนอื่นมาตรวจสอบว่าอุปกรณ์ของคุณรองรับหรือไม่';

  @override
  String get camera_test_screen_instruction =>
      'หันกล้องไปที่ผู้คน แอปจะแสดงกรอบรอบผู้ที่ตรวจพบ';

  @override
  String get camera_test_screen_next => 'แตะ ถัดไป เพื่อดำเนินการต่อ';

  @override
  String get camera_test_screen_start =>
      'แตะ เริ่ม หากระบบถาม ให้อนุญาตการเข้าถึงกล้อง';

  @override
  String get camera_test_screen_test_failed => 'ทดสอบไม่ผ่าน!';

  @override
  String get camera_test_screen_test_passed => 'ทดสอบผ่าน!';

  @override
  String get camera_test_screen_title => 'ทดสอบกล้อง AI';

  @override
  String get camera_test_screen_wait => 'กำลังรอ AI ตรวจจับผู้คน…';

  @override
  String get cta_screen_custom => 'ใช้เซิร์ฟเวอร์ของคุณเอง';

  @override
  String get cta_screen_custom_help =>
      'ส่งข้อมูลการสัญจรไปยังระบบหลังบ้านหรือฐานข้อมูลของคุณโดยตรง.';

  @override
  String get cta_screen_footer =>
      'เมื่อดำเนินการต่อ คุณยอมรับข้อกำหนดการใช้งาน นโยบายความเป็นส่วนตัว และข้อตกลงการประมวลผลข้อมูล';

  @override
  String get cta_screen_invitation => 'ใช้รหัสคำเชิญ';

  @override
  String get cta_screen_invitation_help =>
      'เข้าร่วมองค์กรที่มีอยู่โดยใช้คำเชิญจากผู้ดูแลระบบ';

  @override
  String get cta_screen_local => 'เฉพาะอุปกรณ์นี้';

  @override
  String get cta_screen_local_help =>
      'จัดเก็บข้อมูลการสัญจรไว้เฉพาะบนอุปกรณ์นี้เท่านั้น ไม่มีการอัปโหลดข้อมูล';

  @override
  String get cta_screen_piyuo => 'ใช้ Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'จัดเก็บข้อมูลการสัญจรใน Piyuo Cloud พร้อมแดชบอร์ดและข้อมูลเชิงธุรกิจ.';

  @override
  String get cta_screen_premium => 'พรีเมียม';

  @override
  String get cta_screen_title =>
      'Piyuo Counter สร้างสถิติการสัญจรแบบไม่ระบุตัวตนทุก 5 นาที\\nเลือกวิธีจัดเก็บและเข้าถึงข้อมูลของคุณ';

  @override
  String get current_occupancy => 'จำนวนปัจจุบัน';

  @override
  String get current_occupancy_help =>
      'แสดงจำนวนปัจจุบันของคนหรือยานพาหนะในพื้นที่นี้\\n\\nตัวเลขนี้อัปเดตแบบเรียลไทม์ และช่วยตรวจสอบว่าการตรวจจับด้วย AI ตรงกับสิ่งที่เห็นบนหน้าจอหรือไม่ ข้อมูลนี้จะไม่ถูกรวมในข้อมูล Telemetry ที่อัปโหลด';

  @override
  String get custom_server_screen_bearer_saving_action => 'กำลังบันทึก...';

  @override
  String get custom_server_screen_server_url_label => 'URL เซิร์ฟเวอร์';

  @override
  String get detection_screen_confidence => 'เกณฑ์ความมั่นใจ';

  @override
  String get detection_screen_confidence_dialog =>
      'กำหนดว่า AI ต้องมั่นใจแค่ไหนก่อนนับคนหรือยานพาหนะ\\nค่าต่ำ\\n• ตรวจจับวัตถุได้มากขึ้น\\n• เหมาะกับวัตถุที่อยู่ไกลหรือถูกบดบังบางส่วน\\n• อาจเพิ่มการตรวจจับผิดพลาด\\nค่าสูง\\n• นับเฉพาะการตรวจจับที่มั่นใจสูง\\n• ลดการตรวจจับผิดพลาด\\n• อาจพลาดวัตถุขนาดเล็กหรือตรวจจับยาก\\nใช้ค่าต่ำลงหากแอปพลาดคนหรือยานพาหนะ\\nใช้ค่าสูงขึ้นหากแอปนับเงา แสงสะท้อน หรือวัตถุผิดพลาดอื่นๆ';

  @override
  String get detection_screen_confidence_help =>
      'ค่าความมั่นใจขั้นต่ำที่ต้องใช้ในการตรวจจับวัตถุ';

  @override
  String get detection_screen_confidence_max_label => 'เข้มงวด';

  @override
  String get detection_screen_confidence_min_label => 'ผ่อนปรน';

  @override
  String get detection_screen_disappear => 'หมดเวลาการหายไป';

  @override
  String get detection_screen_disappear_dialog =>
      'กำหนดว่า AI จะรอนานแค่ไหนก่อนที่จะทำเครื่องหมายวัตถุว่าหายไป หลังจากที่ไม่ถูกตรวจพบอีกต่อไป\\nค่าสั้น\\n• ทำเครื่องหมายวัตถุว่าหายไปเร็วขึ้น\\n• เหมาะกับการจราจรที่เคลื่อนที่เร็ว\\n• อาจทำเครื่องหมายวัตถุที่ถูกบดบังชั่วคราวว่าหายไปผิดพลาด\\nค่ายาว\\n• รอนานขึ้นก่อนทำเครื่องหมายวัตถุว่าหายไป\\n• เหมาะเมื่อวัตถุถูกบดบังหรือพลาดไปชั่วครู่\\n• ทำให้เหตุการณ์การหายไปล่าช้า';

  @override
  String get detection_screen_disappear_help =>
      'AI จะรอนานเท่าใดก่อนกำหนดว่าวัตถุหายไป หลังจากตรวจจับไม่ได้แล้ว';

  @override
  String get detection_screen_disappear_max_label => 'ช้า';

  @override
  String get detection_screen_disappear_min_label => 'เร็ว';

  @override
  String get detection_screen_memory_dialog =>
      'กำหนดว่า AI จะจดจำวัตถุนานแค่ไหนหลังจากที่มันหายไป\\nเพิ่มค่านี้หากคนหรือยานพาหนะมักถูกบดบังด้วยวัตถุอื่น\\nลดค่านี้หากวัตถุถูกเชื่อมโยงผิดพลาดหลังจากออกจากฉาก';

  @override
  String get detection_screen_min_presence => 'เวลาปรากฏขั้นต่ำ';

  @override
  String get detection_screen_min_presence_help =>
      'วัตถุต้องมองเห็นได้ช่วงหนึ่งก่อนจึงจะนับ ค่าที่มากขึ้นช่วยลดการตรวจจับผิดช่วงสั้น ๆ';

  @override
  String get detection_screen_min_presence_max_label => 'ปลอดภัยกว่า';

  @override
  String get detection_screen_min_presence_min_label => 'เร็วกว่า';

  @override
  String get detection_screen_minimum_visible =>
      'วัตถุต้องมองเห็นได้นานเท่านี้ก่อนที่จะถูกนับ\\nเพิ่มค่านี้เพื่อละเว้นการตรวจจับผิดพลาดที่เกิดขึ้นสั้นๆ\\nลดค่านี้หากคนหรือยานพาหนะที่เคลื่อนที่เร็วถูกพลาดไป';

  @override
  String get detection_screen_new_track => 'เกณฑ์เริ่มการติดตาม';

  @override
  String get detection_screen_new_track_help =>
      'ค่าความมั่นใจขั้นต่ำในการเริ่มติดตามวัตถุใหม่ ค่าที่ต่ำอาจทำให้เกิดการติดตามซ้ำ';

  @override
  String get detection_screen_new_track_max_label => 'ระมัดระวัง';

  @override
  String get detection_screen_new_track_min_label => 'เชิงรุก';

  @override
  String get detection_screen_reset => 'รีเซ็ต';

  @override
  String get detection_screen_reset_content =>
      'คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตการตั้งค่าการตรวจจับ?';

  @override
  String get detection_screen_show_track_id => 'แสดง Track ID';

  @override
  String get detection_screen_show_track_id_help =>
      'เปิดใช้งานตัวเลือกนี้เพื่อแสดง Track ID ที่ไม่ซ้ำกันสำหรับแต่ละวัตถุที่ติดตาม';

  @override
  String get detection_screen_stay => 'เวลาพักอยู่';

  @override
  String get detection_screen_stay_help =>
      'วัตถุต้องอยู่ในพื้นที่นานเท่าใดก่อนที่จะนับเป็นการหยุดอยู่';

  @override
  String get detection_screen_stay_max_label => 'หน่วงเวลา';

  @override
  String get detection_screen_stay_min_label => 'ทันที';

  @override
  String get detection_screen_stay_threshold =>
      'กำหนดว่าเมื่อใดวัตถุจะถูกนับรวมในจำนวนการอยู่ประจำ\\nค่าสั้น\\n• นับการอยู่ประจำทันที\\n• เหมาะกับการวิเคราะห์อย่างรวดเร็ว\\nค่ายาว\\n• ละเว้นการผ่านช่วงสั้นๆ\\n• เหมาะกับการวัดอัตราการใช้พื้นที่';

  @override
  String get detection_screen_subtitle =>
      'ปรับวิธีที่ AI ตรวจจับและติดตามวัตถุ';

  @override
  String get detection_screen_title => 'การติดตามและนับ';

  @override
  String get detection_screen_track_dialog =>
      'กำหนดว่าเมื่อใดวัตถุที่เพิ่งตรวจพบจะกลายเป็นเส้นทางติดตามใหม่\\nค่าต่ำ\\n• เริ่มติดตามเร็วขึ้น\\n• เหมาะกับวัตถุที่เคลื่อนที่เร็ว\\n• อาจสร้างเส้นทางติดตามซ้ำซ้อน\\nค่าสูง\\n• ต้องการหลักฐานที่ชัดเจนกว่าก่อนสร้างเส้นทางใหม่\\n• ลดเส้นทางติดตามซ้ำซ้อน\\n• อาจทำให้การติดตามวัตถุใหม่ล่าช้า';

  @override
  String get detection_screen_track_memory => 'หน่วยความจำการติดตาม';

  @override
  String get detection_screen_track_memory_help =>
      'กำหนดระยะเวลาที่จะติดตามวัตถุต่อหลังจากหายไปชั่วคราว ค่าที่มากขึ้นช่วยให้กลับมาติดตามได้หลังถูกบังช่วงสั้น ๆ';

  @override
  String get detection_screen_track_memory_max_label => 'ยาว';

  @override
  String get detection_screen_track_memory_min_label => 'สั้น';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter ใช้กล้องเพื่อตรวจจับคนเดินเท้าและยานพาหนะแบบเรียลไทม์ อุปกรณ์นี้ไม่มีกล้องให้ใช้งาน.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'ลองเปิดแอปนี้บนโทรศัพท์ของคุณ';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'สมาร์ทโฟนหรือแท็บเล็ตที่มีกล้อง';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'แนะนำให้ใช้อุปกรณ์ iOS หรือ Android';

  @override
  String get device_not_supported_screen_requirements_title =>
      'สิ่งที่คุณต้องมี';

  @override
  String get device_not_supported_screen_title => 'ไม่พบกล้อง';

  @override
  String get disappeared => 'หายไป';

  @override
  String get disappeared_help =>
      'นับจำนวนคนหรือยานพาหนะที่ตรวจพบตำแหน่งสุดท้ายอยู่ภายในพื้นที่นี้\\n\\nการติดตามจะสิ้นสุดเมื่อพ้นเวลาการหายไปที่กำหนด หากไม่ตรวจพบคนหรือยานพาหนะอีกต่อไป\\n\\n(เหมาะสำหรับผู้ใช้ขั้นสูง)';

  @override
  String get dpa => 'ข้อตกลงการประมวลผลข้อมูล';

  @override
  String get durationDaysShort => '%sวัน';

  @override
  String get durationHoursShort => '%sชม.';

  @override
  String get durationMinutesShort => '%sนาที';

  @override
  String get durationSecondsShort => '%sวิ';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'เข้า';

  @override
  String get entered_help =>
      'นับจำนวนคนหรือยานพาหนะที่เข้าสู่พื้นที่นี้ในช่วงหน้าต่างการนับปัจจุบัน\\n\\nจะนับ 1 ครั้งเมื่อคนหรือยานพาหนะเคลื่อนที่จากนอกพื้นที่เข้าสู่ภายในพื้นที่';

  @override
  String get exited => 'ออก';

  @override
  String get exited_help =>
      'นับจำนวนคนหรือยานพาหนะที่ออกจากพื้นที่นี้ในช่วงหน้าต่างการนับปัจจุบัน\\n\\nจะนับ 1 ครั้งเมื่อคนหรือยานพาหนะเคลื่อนที่จากภายในพื้นที่ออกไปภายนอก';

  @override
  String get language_screen_language => 'ภาษา';

  @override
  String get language_screen_subtitle => 'เลือกภาษาที่ใช้ในแอป';

  @override
  String get local_only_screen_body =>
      'โหมด \'อุปกรณ์ภายในเครื่องเท่านั้น\' ให้คุณทดลองใช้การตรวจจับและติดตามด้วยกล้อง AI โดยไม่ต้องอัปโหลดข้อมูลใดๆ สถิติการสัญจรทั้งหมดจะถูกประมวลผลบนอุปกรณ์นี้เท่านั้น เหมาะสำหรับทดสอบก่อนเชื่อมต่อกับเซิร์ฟเวอร์';

  @override
  String get local_only_screen_use_action => 'ใช้อุปกรณ์นี้เท่านั้น';

  @override
  String get local_screen_text =>
      'Piyuo Counter จะทำงานทั้งหมดบนอุปกรณ์นี้\\nสถิติการสัญจรจะถูกเก็บไว้บนอุปกรณ์นี้เท่านั้น และจะไม่อัปโหลด\\nคุณสามารถเชื่อมต่อกับ Piyuo Cloud หรือเซิร์ฟเวอร์ของคุณเองได้ภายหลังใน Settings';

  @override
  String get maximum_occupancy => 'จำนวนสูงสุด';

  @override
  String get maximum_occupancy_help =>
      'แสดงจำนวนคนหรือยานพาหนะสูงสุดที่อยู่ในพื้นที่นี้พร้อมกันในช่วงหน้าต่างการนับปัจจุบัน\\n\\nช่วยระบุช่วงเวลาที่มีผู้คนหรือการจราจรหนาแน่นที่สุด';

  @override
  String get maximum_stay => 'เวลาพักสูงสุด';

  @override
  String get maximum_stay_help =>
      'แสดงระยะเวลานานที่สุดที่คนหรือยานพาหนะอยู่ในพื้นที่นี้ในช่วงหน้าต่างการนับปัจจุบัน\\n\\nช่วยระบุการหยุดหรือการอยู่ในพื้นที่ที่นานผิดปกติ';

  @override
  String get metric_events => 'เหตุการณ์';

  @override
  String get metric_live => 'สด';

  @override
  String get metric_show_less => 'แสดงน้อยลง';

  @override
  String get metric_show_more => 'แสดงเพิ่มเติม';

  @override
  String get metric_statistics => 'สถิติ';

  @override
  String get metrics_counting_all => 'ทั้งหมด';

  @override
  String get metrics_counting_done => 'เสร็จสิ้น';

  @override
  String get metrics_counting_in_progress => 'กำลังดำเนินการ';

  @override
  String get metrics_counting_missing => 'ขาดหายไป';

  @override
  String get metrics_counting_window => 'สถิติสำหรับทุกช่วงเวลา 5 นาที';

  @override
  String get onboarding_back_action => 'ย้อนกลับ';

  @override
  String get onboarding_cta_no_server => 'ไม่ต้องการอัปโหลดข้อมูลใช่ไหม?';

  @override
  String get onboarding_cta_title => 'ต้องการส่งข้อมูลไปที่ไหน?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter ใช้กล้องในเครื่องของคุณและ AI ในตัวเพื่อจดจำคนและยานพาหนะได้ทันที\\nด้วยเทคโนโลยีตรวจจับและติดตาม แอปจะนับปริมาณคนเดินเท้าและยานพาหนะโดยอัตโนมัติ — ทุกอย่างประมวลผลอยู่ในเครื่องของคุณเอง';

  @override
  String get onboarding_intro_text2 =>
      'การประมวลผล AI ทั้งหมดเกิดขึ้นในเครื่องของคุณเท่านั้น ไม่มีการอัปโหลดวิดีโอ ภาพ ใบหน้า หรือข้อมูลระบุตัวตนใดๆ\\nมีการแชร์เฉพาะสรุปข้อมูลแบบไม่ระบุตัวตนทุก 5 นาที ซึ่งรวมถึงสถิติจำนวนนับ อัตราการใช้พื้นที่ การเข้า การออก และระยะเวลาที่อยู่';

  @override
  String get onboarding_intro_text3 =>
      'แค่เปิดแอปแล้วปล่อยให้ทำงาน Piyuo Counter จะเก็บรวบรวมและบันทึกข้อมูลการจราจรโดยอัตโนมัติอย่างต่อเนื่อง\\nข้อมูลสรุปจะถูกบันทึกทุก 5 นาที และอัปโหลดทุกชั่วโมงไปยัง Piyuo Cloud หรือเซิร์ฟเวอร์ของคุณเอง';

  @override
  String get onboarding_intro_title1 => 'การนับการสัญจรด้วย AI';

  @override
  String get onboarding_intro_title2 =>
      'ออกแบบโดยคำนึงถึงความเป็นส่วนตัวเป็นหลัก';

  @override
  String get onboarding_intro_title3 => 'ทำงานอัตโนมัติ 24 ชั่วโมงทุกวัน';

  @override
  String get onboarding_next_action => 'ถัดไป';

  @override
  String get onboarding_skip_action => 'ข้ามบทแนะนำ';

  @override
  String get onboarding_start_action => 'เริ่มต้น';

  @override
  String get passed_by => 'ผ่าน';

  @override
  String get passed_by_help =>
      'นับจำนวนคนหรือยานพาหนะที่ผ่านพื้นที่นี้ในช่วงหน้าต่างการนับปัจจุบัน\\n\\nแต่ละคนหรือยานพาหนะจะถูกนับเพียงหนึ่งครั้งต่อการผ่านพื้นที่หนึ่งครั้ง';

  @override
  String get payloads_screen_area => 'พื้นที่';

  @override
  String get payloads_screen_confidence => 'ความมั่นใจ';

  @override
  String get payloads_screen_coverage => 'ความครอบคลุม';

  @override
  String get payloads_screen_delivered => 'ส่งแล้ว';

  @override
  String get payloads_screen_failed_load => 'โหลดเพย์โหลดล่าสุดไม่สำเร็จ';

  @override
  String get payloads_screen_frame_processed => 'เฟรมที่ประมวลผลแล้ว';

  @override
  String get payloads_screen_hour_not_exists => 'ชั่วโมงนี้ไม่มีอยู่แล้ว';

  @override
  String get payloads_screen_missing_time => 'เวลาที่ขาดหายไป';

  @override
  String get payloads_screen_no_payloads => 'ยังไม่มีเพย์โหลด';

  @override
  String get payloads_screen_partial => 'ช่วงเวลาสิ้นสุดก่อนกำหนด (บางส่วน)';

  @override
  String get payloads_screen_partially => 'ส่งสำเร็จบางส่วน';

  @override
  String get payloads_screen_payload_not_exists => 'เพย์โหลดนี้ไม่มีอยู่แล้ว';

  @override
  String get payloads_screen_pending => 'รอการส่ง';

  @override
  String get payloads_screen_process_fps => 'FPS การประมวลผล';

  @override
  String get payloads_screen_resend => 'ส่งอีกครั้ง';

  @override
  String get payloads_screen_select_first =>
      'กรุณาเลือกวันที่หรือชั่วโมงอย่างน้อยหนึ่งรายการก่อน';

  @override
  String get payloads_screen_subtitle =>
      'เลือกตามวันที่หรือชั่วโมงเพื่อส่งอีกครั้ง';

  @override
  String get payloads_screen_title => 'เพย์โหลดล่าสุด';

  @override
  String get personal_custom_screen_build_server =>
      'ต้องการความช่วยเหลือในการตั้งค่าเซิร์ฟเวอร์ของคุณ?\\nดูเอกสาร API และตัวอย่างเซิร์ฟเวอร์ของเรา';

  @override
  String get personal_custom_screen_help_action => 'เปิดเอกสาร API';

  @override
  String get personal_custom_screen_reset_action => 'เริ่มใหม่';

  @override
  String get personal_custom_success_screen_help =>
      'แตะ Start ด้านล่างเพื่อเริ่มนับ';

  @override
  String get personal_custom_success_screen_help1 =>
      'สถิติการสัญจรจะอัปโหลดอัตโนมัติทุกชั่วโมง\\nหรืออัปโหลดเองได้จากหน้าบันทึกการอัปโหลด';

  @override
  String get personal_custom_success_screen_help2 =>
      'เซิร์ฟเวอร์ของคุณยังไม่จำเป็นต้องออนไลน์\\nเริ่มนับได้เลยตอนนี้ แล้วค่อยตั้งค่าและทดสอบเซิร์ฟเวอร์ภายหลัง ข้อมูลสถิติการสัญจรจะถูกเก็บไว้ในอุปกรณ์นี้จนกว่าจะอัปโหลดสำเร็จ';

  @override
  String get personal_custom_success_screen_send_to =>
      'สถิติการเข้าชมจะถูกส่งไปที่';

  @override
  String get personal_custom_success_screen_title =>
      'เซิร์ฟเวอร์ของคุณพร้อมแล้ว';

  @override
  String get piyuo_server_screen_cloud_url_label =>
      'URL ของ Piyuo Cloud ของคุณ';

  @override
  String get piyuo_server_screen_copy_action => 'คัดลอก URL';

  @override
  String get piyuo_server_screen_copy_success => 'คัดลอก URL แล้ว';

  @override
  String get piyuo_server_screen_saving_action => 'กำลังบันทึก...';

  @override
  String get piyuo_server_screen_start =>
      'กด \"Start\" ด้านล่างเพื่อเริ่มการนับ';

  @override
  String get piyuo_server_screen_url_help =>
      'แดชบอร์ด Piyuo Cloud ส่วนตัวของคุณพร้อมใช้งานที่ URL นี้';

  @override
  String get piyuo_server_screen_url_remember =>
      'บันทึก URL นี้เพื่อเข้าถึงแดชบอร์ดสถิติผู้ใช้งานจากอุปกรณ์เครื่องอื่น';

  @override
  String get piyuo_server_screen_use_action => 'ใช้ Piyuo Cloud';

  @override
  String get privacy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get product_copyright => 'ลิขสิทธิ์ © 2026';

  @override
  String get product_desc => 'การนับคนและยานพาหนะด้วย AI.';

  @override
  String get settings_screen_custom_subtitle =>
      'ส่งข้อมูลการสัญจรไปยังแบ็กเอนด์หรือฐานข้อมูลของคุณโดยตรง';

  @override
  String get settings_screen_custom_title => 'ใช้เซิร์ฟเวอร์กำหนดเอง';

  @override
  String get settings_screen_data_server_label => 'เซิร์ฟเวอร์ข้อมูล';

  @override
  String get settings_screen_detection_target => 'เป้าหมายการตรวจจับ';

  @override
  String get settings_screen_language_title => 'ภาษา';

  @override
  String get settings_screen_local_subtitle =>
      'จัดเก็บข้อมูลการสัญจรไว้ในอุปกรณ์นี้เท่านั้น จะไม่มีการอัปโหลดข้อมูล';

  @override
  String get settings_screen_local_title => 'เฉพาะอุปกรณ์นี้';

  @override
  String get settings_screen_misc_label => 'อื่นๆ';

  @override
  String get settings_screen_object_detection => 'การตรวจจับวัตถุ';

  @override
  String get settings_screen_piyuo_subtitle =>
      'จัดเก็บข้อมูลการสัญจรใน Piyuo Cloud พร้อมแดชบอร์ดและข้อมูลเชิงลึกทางธุรกิจ';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'การดำเนินการนี้จะลบข้อมูลทั้งหมดและเริ่มใหม่ การดำเนินการนี้ไม่สามารถย้อนกลับได้';

  @override
  String get settings_screen_reset_all_data_title => 'รีเซ็ตข้อมูลทั้งหมด?';

  @override
  String get settings_screen_subscription_body =>
      'จัดการการสมัครสมาชิกและข้อมูลการเรียกเก็บเงินของคุณ';

  @override
  String get settings_screen_subscription_title => 'การสมัครสมาชิก';

  @override
  String get start_screen_about => 'เกี่ยวกับ';

  @override
  String get start_screen_server_none =>
      'ข้อมูลจะถูกเก็บไว้ในอุปกรณ์นี้เท่านั้น';

  @override
  String get start_screen_server_personal => 'อัปโหลดข้อมูลทุกชั่วโมงไปยัง';

  @override
  String get start_screen_settings => 'การตั้งค่า';

  @override
  String get start_screen_upload_logs => 'อัปโหลดบันทึก';

  @override
  String get start_screen_video_sources => 'แหล่งวิดีโอ';

  @override
  String get stayed => 'อยู่ต่อ';

  @override
  String get stayed_help =>
      'นับจำนวนคนหรือยานพาหนะที่อยู่ในพื้นที่นี้อย่างน้อยตามเวลาพักที่กำหนด\\n\\nค่าเริ่มต้นของเวลาพักคือ 15 วินาที และสามารถเปลี่ยนได้ใน Settings';

  @override
  String get target_pedestrian => 'คนเดินเท้า';

  @override
  String get target_pedestrian_help => 'นับคนด้วยโมเดลตรวจจับคนเดินเท้า';

  @override
  String get target_screen_subtitle => 'เลือกรุ่นการตรวจจับที่จะใช้';

  @override
  String get target_vehicle => 'ยานพาหนะ';

  @override
  String get target_vehicle_help =>
      'นับรถยนต์และยานพาหนะอื่นด้วยโมเดลตรวจจับยานพาหนะ';

  @override
  String get telemetry_error_connection_refused =>
      'ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้ อาจกำลังออฟไลน์อยู่ในขณะนี้';

  @override
  String get telemetry_error_connection_reset =>
      'การเชื่อมต่อถูกรีเซ็ต โปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ตแล้วลองอีกครั้ง';

  @override
  String get telemetry_error_connection_timeout =>
      'การเชื่อมต่อใช้เวลาตอบสนองนานเกินไป โปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ตแล้วลองอีกครั้ง';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'ไม่พบที่อยู่เซิร์ฟเวอร์ โปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ตหรือ URL ของเซิร์ฟเวอร์';

  @override
  String get telemetry_error_http_error_status =>
      'เซิร์ฟเวอร์ปฏิเสธคำขอ โปรดลองอีกครั้งภายหลัง';

  @override
  String get telemetry_error_http_unknown_error =>
      'เกิดข้อผิดพลาดที่ไม่คาดคิดขณะสื่อสารกับเซิร์ฟเวอร์';

  @override
  String get telemetry_error_invalid_url =>
      'ที่อยู่เซิร์ฟเวอร์ไม่ถูกต้อง โปรดตรวจสอบการตั้งค่าของคุณ';

  @override
  String get telemetry_error_network_error =>
      'เกิดข้อผิดพลาดเครือข่าย โปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ตแล้วลองอีกครั้ง';

  @override
  String get telemetry_error_socket_error =>
      'เกิดปัญหาการเชื่อมต่อเครือข่าย โปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get telemetry_error_transport_exception =>
      'เกิดข้อผิดพลาดขณะส่งข้อมูล โปรดลองอีกครั้ง';

  @override
  String get terms => 'ข้อกำหนดการให้บริการ';

  @override
  String get upload_screen_attempt_time => 'เวลาที่พยายาม:';

  @override
  String get upload_screen_error => 'ข้อผิดพลาด:';

  @override
  String get upload_screen_failed => 'ล้มเหลว';

  @override
  String get upload_screen_load_error => 'ไม่สามารถโหลดบันทึกการอัปโหลดได้';

  @override
  String get upload_screen_log_not_exists => 'บันทึกการอัปโหลดไม่มีแล้ว';

  @override
  String get upload_screen_next => 'อัปโหลดครั้งถัดไป ...';

  @override
  String get upload_screen_next_upload_prefix => 'อัปโหลดครั้งถัดไป ';

  @override
  String get upload_screen_no_data_server =>
      'กรุณาตั้งค่าเซิร์ฟเวอร์ข้อมูลก่อน';

  @override
  String get upload_screen_no_logs => 'ยังไม่มีบันทึกการอัปโหลด';

  @override
  String get upload_screen_payload_count => 'จำนวนเพย์โหลด';

  @override
  String get upload_screen_payload_count_label => 'จำนวนเพย์โหลด:';

  @override
  String get upload_screen_payload_size => 'ขนาดเพย์โหลด:';

  @override
  String get upload_screen_result => 'ผลลัพธ์:';

  @override
  String get upload_screen_retry => 'จำนวนครั้งที่ลองใหม่:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'สำเร็จ';

  @override
  String get upload_screen_today => 'วันนี้';

  @override
  String get upload_screen_upload_now => 'อัปโหลดตอนนี้';

  @override
  String get upload_screen_upload_success => 'อัปโหลดสำเร็จ';

  @override
  String get upload_screen_uploading => 'กำลังอัปโหลด...';

  @override
  String get upload_screen_yesterday => 'เมื่อวาน';

  @override
  String get url_screen_invalid_rtsp_error => 'RTSP URL ต้องมีชื่อโฮสต์';

  @override
  String get url_screen_invalid_url_error =>
      'กรุณาใส่ URL ที่ถูกต้องและใช้รูปแบบที่รองรับ';

  @override
  String get url_screen_subtitle => 'กรุณาใส่ URL สตรีมสด';

  @override
  String get url_screen_title => 'URL สตรีมสด';

  @override
  String get url_screen_unsupported_scheme_error => ' RTSP ו-RTSPS.';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'กรุณาใส่ URL ไลฟ์สตรีม';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream หรือ rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'กล้องหลัง';

  @override
  String get video_sources_camera => 'กล้อง';

  @override
  String get video_sources_file => 'ไฟล์';

  @override
  String get video_sources_front_camera => 'กล้องหน้า';

  @override
  String get video_sources_live_stream => 'URL สตรีมสด';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'ต้องอนุญาตการเข้าถึงกล้องเพื่อใช้งาน';

  @override
  String get video_sources_screen_camera_not_found_title => 'ไม่พบกล้อง';

  @override
  String get video_sources_screen_import_error => 'นำเข้าไฟล์วิดีโอไม่สำเร็จ';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'โปรดไปที่การตั้งค่าและอนุญาตให้แอปนี้เข้าถึงรูปภาพ';

  @override
  String get video_sources_screen_select_camera => 'แตะเพื่อเลือกกล้องนี้';

  @override
  String get video_sources_screen_select_file => 'แตะเพื่อเลือกไฟล์';

  @override
  String get video_sources_screen_select_live =>
      'แตะเพื่อตั้งค่า URL ไลฟ์สตรีม';

  @override
  String get video_sources_webcam => 'เว็บแคม';
}
