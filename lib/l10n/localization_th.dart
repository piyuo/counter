// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class LocalizationTh extends Localization {
  LocalizationTh([String locale = 'th']) : super(locale);

  @override
  String get product_name => 'เครื่องนับ';

  @override
  String get product_desc => 'ใช้คอมพิวเตอร์วิชั่นและเอไอเพื่อนับคน ยานพาหนะ สัตว์เลี้ยง และอื่นๆ';

  @override
  String get product_copyright => 'ลิขสิทธิ์ © 2025';

  @override
  String get video_sources_webcam => 'เว็บแคม';

  @override
  String get video_sources_live_stream => 'URL สตรีมสด';

  @override
  String get video_sources_file => 'ไฟล์';

  @override
  String get video_sources_camera => 'กล้อง';

  @override
  String get video_sources_camera_not_found_title => 'ไม่พบกล้อง';

  @override
  String get video_sources_camera_not_found_message => 'ต้องอนุญาตการเข้าถึงกล้องเพื่อใช้งาน';

  @override
  String get video_sources_webcam_not_found_title => 'ไม่พบเว็บแคม';

  @override
  String get video_sources_webcam_not_found_message => 'กรุณาตรวจสอบว่ามีเว็บแคมเชื่อมต่ออยู่หรือไม่';

  @override
  String get wizard_screen_desc => 'สร้างโปรเจกต์ใหม่ด้านล่างเพื่อเริ่มการนับ';

  @override
  String get wizard_screen_new_project_from => 'สร้างโปรเจกต์ใหม่จาก';

  @override
  String get wizard_screen_language => 'ภาษา';

  @override
  String get wizard_screen_about => 'เกี่ยวกับ';

  @override
  String get wizard_screen_open_projects_tip => 'โปรเจกต์ทั้งหมดจะถูกบันทึกในเครื่องโดยอัตโนมัติ';

  @override
  String get wizard_screen_open_projects => 'เปิดโปรเจกต์ที่มีอยู่';

  @override
  String get wizard_screen_email_us => 'อีเมลถึงเรา';

  @override
  String get language_screen_language => 'ภาษา';

  @override
  String get project_view_no_videos => 'ไม่มีแหล่งวิดีโอ';

  @override
  String get about_screen_title => 'เกี่ยวกับ';

  @override
  String get about_screen_platform => 'แพลตฟอร์ม';

  @override
  String get about_screen_app_version => 'เวอร์ชันแอป';

  @override
  String get about_screen_models => 'โมเดลตรวจจับวัตถุ';

  @override
  String get about_screen_benchmark => 'เกณฑ์การทดสอบ';

  @override
  String get about_screen_opencv_build_info => 'ข้อมูลการสร้าง OpenCV';

  @override
  String get benchmark_screen_title => 'เกณฑ์การทดสอบโมเดล';

  @override
  String get benchmark_screen_recommended => 'โมเดลที่แนะนำ';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'เริ่มการทดสอบ';

  @override
  String get benchmark_screen_start_failed => 'เริ่มการทดสอบล้มเหลว รหัสข้อผิดพลาดคือ';

  @override
  String get benchmark_screen_models => 'โมเดลตรวจจับวัตถุ';

  @override
  String get project_screen_title => 'โปรเจกต์';

  @override
  String get project_screen_exit_confirm_title => 'ยืนยันการออกจากโปรเจกต์';

  @override
  String get project_screen_exit_confirm_content => 'การออกจากโปรเจกต์จะหยุดการนับ คุณแน่ใจหรือไม่ว่าต้องการดำเนินการต่อ?';

  @override
  String get project_screen_exit_button => 'ออก';

  @override
  String get project_screen_add_video_button => 'เพิ่มแหล่งวิดีโอ';

  @override
  String get project_screen_from_desc => 'เราเก็บบันทึกต่อเนื่อง 24 ชั่วโมง คุณจึงสามารถดูช่วงเวลาใดก็ได้ตามที่ต้องการ';

  @override
  String get project_screen_report_settings => 'การตั้งค่า';

  @override
  String get filter_screen_title => 'ตัวกรอง';

  @override
  String get filter_screen_desc => 'เลือกช่วงตัวกรองจากรายการด้านล่าง';

  @override
  String get filter_screen_error_title => 'ตัวกรอง';

  @override
  String get filter_screen_error_content => 'เวลาสิ้นสุดต้องมากกว่าเวลาเริ่มต้น';

  @override
  String get filter_screen_error_custom => 'กำหนดเอง';

  @override
  String get filter_screen_error_start => 'เริ่มต้น';

  @override
  String get filter_screen_error_end => 'สิ้นสุด';

  @override
  String get settings_screen_title => 'การตั้งค่า';

  @override
  String get settings_screen_desc => 'ตั้งค่าชื่อโปรเจกต์ พารามิเตอร์การตรวจจับ การล้างข้อมูลการนับ';

  @override
  String get settings_screen_project_id => 'รหัสโปรเจกต์';

  @override
  String get settings_screen_project_name => 'ชื่อโปรเจกต์';

  @override
  String get settings_screen_project_name_place_holder => '123 ถ.สุขุมวิท หรือ สวนลุมพินี';

  @override
  String get settings_screen_project_error => 'ชื่อโปรเจกต์ต้องไม่ว่างเปล่า';

  @override
  String get settings_screen_random_count_button => 'เพิ่มการนับแบบสุ่ม';

  @override
  String get settings_screen_reset_count_header => 'รีเซ็ตการนับทั้งหมดในโปรเจกต์นี้';

  @override
  String get settings_screen_reset_count_button => 'รีเซ็ตการนับ';

  @override
  String get settings_screen_reset_count_content => 'คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตการนับทั้งหมด?';

  @override
  String get settings_screen_delete_header => 'ลบโปรเจกต์นี้';

  @override
  String get settings_screen_delete_content => 'คุณแน่ใจหรือไม่ว่าต้องการลบโปรเจกต์นี้?';

  @override
  String get settings_screen_delete_button => 'ลบ';

  @override
  String get settings_screen_center_point_title => 'จุดศูนย์กลางบนเป้าหมาย';

  @override
  String get settings_screen_center_point_desc => 'จุดศูนย์กลางช่วยระบุว่าเป้าหมายอยู่ในโซนหรือไม่';

  @override
  String get settings_screen_center_point_button => 'แสดงจุดศูนย์กลางบนเป้าหมาย';

  @override
  String get settings_screen_lost_target_title => 'เป้าหมายที่หายไป';

  @override
  String get settings_screen_lost_target_desc => 'เมื่อการติดตามวัตถุเสียเป้าหมาย ตัวเลือกนี้จะทำให้มองเห็นได้ โดยค่าเริ่มต้น เป้าหมายที่หายไปจะไม่แสดง';

  @override
  String get settings_screen_lost_target_button => 'แสดงเป้าหมายที่หายไป';

  @override
  String get detection_screen_title => 'การตั้งค่าการตรวจจับ';

  @override
  String get detection_screen_models => 'โมเดล';

  @override
  String get detection_screen_confidence => 'ความเชื่อมั่น';

  @override
  String get detection_screen_confidence_desc => 'ความเชื่อมั่นมากกว่า #0 จะถือว่าเป็นการตรวจจับที่ถูกต้อง';

  @override
  String get detection_screen_low => 'ต่ำ';

  @override
  String get detection_screen_high => 'สูง';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 ค่า NMS ที่ต่ำกว่า (เช่น 30%) จะลบกรอบที่ซ้อนทับกันอย่างเข้มงวด ในขณะที่ค่า NMS ที่สูงกว่า (เช่น 0.6) จะอนุญาตให้มีการซ้อนทับมากขึ้น';

  @override
  String get detection_screen_match => 'การจับคู่';

  @override
  String get detection_screen_match_desc => 'การจับคู่มากกว่า #0 จะถือว่าเป็นวัตถุเดียวกัน';

  @override
  String get detection_screen_lost => 'การสูญหาย';

  @override
  String get detection_screen_lost_desc => 'การติดตามวัตถุจะถูกลบหากสูญหายเป็นเวลา #0';

  @override
  String get detection_screen_consider_valid => 'พิจารณาว่าถูกต้องหลังจาก';

  @override
  String get detection_screen_consider_valid_desc => 'การติดตามวัตถุจะถือว่าถูกต้องหลังจาก #0';

  @override
  String get detection_screen_reset => 'รีเซ็ต';

  @override
  String get detection_screen_reset_content => 'คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตการตั้งค่าการตรวจจับ?';

  @override
  String get url_screen_title => 'URL สตรีมสด';

  @override
  String get url_screen_desc => 'กรุณาใส่ URL สตรีมสด';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream หรือ rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'เพิ่มแหล่งวิดีโอ';

  @override
  String get add_video_screen_from => 'เพิ่มแหล่งวิดีโอจาก';

  @override
  String get webcam_screen_add_title => 'เพิ่มเว็บแคม';

  @override
  String get webcam_screen_edit_title => 'เลือกเว็บแคม';

  @override
  String get webcam_manager_webcam => 'เว็บแคม';

  @override
  String get camera_screen_front_camera => 'กล้องหน้า';

  @override
  String get camera_screen_back_camera => 'กล้องหลัง';

  @override
  String get camera_screen_add_title => 'เพิ่มกล้อง';

  @override
  String get camera_screen_edit_title => 'เลือกกล้อง';

  @override
  String get camera_screen_zoom_level => 'ระดับการซูม';

  @override
  String get video_screen_name_empty => 'ชื่อวิดีโอต้องไม่ว่างเปล่า';

  @override
  String get video_screen_desc => 'จัดการแหล่งวิดีโอ เพิ่มหรือแก้ไขโซนการตรวจจับ';

  @override
  String get video_screen_video_name => 'ชื่อแหล่งวิดีโอ';

  @override
  String get video_screen_edit_placeholder => 'กล้องหน้าประตูหรือกล้องลานจอดรถ';

  @override
  String get video_screen_change_file => 'เปลี่ยนไฟล์';

  @override
  String get video_screen_add_zone => 'เพิ่มโซนการตรวจจับ';

  @override
  String get video_screen_zones => 'โซนการตรวจจับ';

  @override
  String get video_screen_zones_desc => 'ใช้การลากและวางเพื่อปรับโซน';

  @override
  String get video_screen_tools => 'เครื่องมือ';

  @override
  String get video_screen_move_bottom => 'ย้ายโซนปัจจุบันไปด้านล่าง';

  @override
  String get video_screen_add_point => 'เพิ่มจุดไปยังโซนปัจจุบัน';

  @override
  String get video_screen_remove_point => 'ลบจุดออกจากโซนปัจจุบัน';

  @override
  String get video_screen_playback_speed => 'ความเร็วการเล่น';

  @override
  String get video_screen_playback_current => 'ปัจจุบัน: ';

  @override
  String get video_screen_playback_14x => '1/4 เท่า';

  @override
  String get video_screen_playback_2x => '2 เท่า';

  @override
  String get video_screen_delete_header => 'ลบแหล่งวิดีโอนี้';

  @override
  String get video_screen_delete_content => 'คุณแน่ใจหรือไม่ว่าต้องการลบแหล่งวิดีโอนี้?';

  @override
  String get video_screen_delete_button => 'ลบ';

  @override
  String get video_screen_sources => 'กำหนดค่าแหล่งภาพ เป้าหมายการตรวจจับ และพารามิเตอร์โมเดล';

  @override
  String get video_screen_targets => 'เป้าหมายการตรวจจับ';

  @override
  String get video_screen_detection => 'พารามิเตอร์โมเดล';

  @override
  String get color_screen_title => 'เลือกสี';

  @override
  String get zone_screen_desc => 'โซนการตรวจจับสามารถกำหนดประเภทของวัตถุที่จะตรวจจับและเลือกตัวนับที่จะแสดง เช่น ตรวจพบ เกิดขึ้น และเข้ามา';

  @override
  String get zone_screen_name_placeholder => 'ชื่อของโซน เช่น ทางเท้าหรือลานจอดรถ';

  @override
  String get zone_screen_zone_color => 'สีโซน';

  @override
  String get zone_screen_color => 'สี';

  @override
  String get zone_screen_delete_header => 'ลบโซนนี้';

  @override
  String get zone_screen_delete_content => 'คุณแน่ใจหรือไม่ว่าต้องการลบโซนนี้?';

  @override
  String get zone_screen_delete_button => 'ลบ';

  @override
  String get zone_screen_can_not_delete => 'ไม่สามารถลบโซน';

  @override
  String get zone_screen_one_zone_required => 'ต้องมีอย่างน้อยหนึ่งโซน';

  @override
  String get zone_screen_zone_name_required => 'ชื่อโซนต้องไม่ว่างเปล่า';

  @override
  String get counter_screen_show_on => 'แสดงบนหน้าจอ';

  @override
  String get counter_screen_enabled => 'เปิดใช้งาน';

  @override
  String get counter_screen_reentry_threshold => 'เกณฑ์การเข้าซ้ำ';

  @override
  String get counter_screen_reentry_desc => 'วัตถุต้องเข้ามา #0 ครั้ง โดยมีเวลาคูลดาวน์ #1 วินาทีระหว่างการออกและเข้าซ้ำแต่ละครั้ง เพื่อทริกเกอร์การเข้าซ้ำ';

  @override
  String get counter_screen_reentry_title => 'จำนวนการเข้าซ้ำ';

  @override
  String get counter_screen_cooldown_threshold => 'เกณฑ์คูลดาวน์';

  @override
  String get counter_screen_cooldown_desc => 'การเข้าซ้ำต้องมีเวลาคูลดาวน์ #0 วินาทีหลังจากออกจากโซนการตรวจจับ';

  @override
  String get counter_screen_cooldown_time => 'เวลาคูลดาวน์';

  @override
  String get counter_screen_cooldown_in_seconds => 'ในหน่วยวินาที';

  @override
  String get counter_screen_stagnant_threshold => 'เกณฑ์การหยุดนิ่ง';

  @override
  String get counter_screen_stagnant_desc => 'วัตถุที่อยู่นิ่งนานกว่า #0 วินาทีจะถือว่าหยุดนิ่ง';

  @override
  String get counter_screen_stagnant_consider => 'พิจารณาว่าหยุดนิ่ง';

  @override
  String get counter_screen_stagnant_in_seconds => 'ในหน่วยวินาที';

  @override
  String get counter_screen_stagnant_desc_prefix => 'คำอธิบายนำหน้า';

  @override
  String get counter_screen_stagnant_desc_suffix => 'คำอธิบายต่อท้าย';

  @override
  String get counter_screen_name_error => 'ชื่อตัวนับต้องไม่ว่างเปล่า';

  @override
  String get counter_screen_enabled_error => 'ข้อผิดพลาด';

  @override
  String get counter_screen_enabled_error_content => 'คุณต้องเปิดใช้งานตัวนับอื่นก่อน จึงจะสามารถปิดใช้งานตัวนับนี้ได้';

  @override
  String get objects_screen_title => 'วัตถุ';

  @override
  String get objects_screen_desc => 'เลือกเป้าหมายการตรวจจับ เช่น คน รถยนต์ รถบัส ฯลฯ';

  @override
  String get open_project_screen_title => 'เปิดโปรเจกต์';

  @override
  String get open_project_screen_desc => 'เปิดโปรเจกต์ที่สร้างไว้ก่อนหน้า เก็บไว้เพียง 20 รายการล่าสุด';

  @override
  String get open_project_screen_no_project => 'ไม่พบโปรเจกต์';

  @override
  String get default_project_name => 'โปรเจกต์';

  @override
  String get default_video_name => 'แหล่งวิดีโอ';

  @override
  String get default_zone_name => 'โซนการตรวจจับ';

  @override
  String get error_oops => 'อุ๊ปส์ เกิดข้อผิดพลาด';

  @override
  String get error_content => 'เกิดข้อผิดพลาดที่ไม่คาดคิด คุณต้องการส่งรายงานทางอีเมลหรือไม่?';

  @override
  String get error_report => 'อีเมลถึงเรา';

  @override
  String get submit => 'ส่ง';

  @override
  String get ok => 'ตกลง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get yes => 'ใช่';

  @override
  String get no => 'ไม่';

  @override
  String get close => 'ปิด';

  @override
  String get back => 'กลับ';

  @override
  String get zone_screen_zone => 'โซน';

  @override
  String get zone_screen_zone_show_summary => 'แสดงสรุปบนหน้าจอ';

  @override
  String get video_sources_photos_denied => 'ไม่อนุญาตให้เข้าถึงรูปภาพ';
}
