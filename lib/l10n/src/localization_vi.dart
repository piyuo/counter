// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class LocalizationVi extends Localization {
  LocalizationVi([String locale = 'vi']) : super(locale);

  @override
  String get about_screen_app_version => 'Phiên bản ứng dụng';

  @override
  String get about_screen_benchmark => 'Đánh giá hiệu suất';

  @override
  String get about_screen_models => 'Mô hình phát hiện đối tượng';

  @override
  String get about_screen_opencv_build_info => 'Thông tin xây dựng OpenCV';

  @override
  String get about_screen_platform => 'Nền tảng';

  @override
  String get about_screen_title => 'Giới thiệu';

  @override
  String get add_video_screen_from => 'Thêm nguồn video từ';

  @override
  String get add_video_screen_title => 'Thêm nguồn video';

  @override
  String get back => 'Quay lại';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Mô hình phát hiện đối tượng';

  @override
  String get benchmark_screen_recommended => 'Mô hình được đề xuất';

  @override
  String get benchmark_screen_start_button => 'Bắt đầu đánh giá';

  @override
  String get benchmark_screen_start_failed =>
      'Không thể bắt đầu đánh giá, mã lỗi là';

  @override
  String get benchmark_screen_title => 'Đánh giá hiệu suất mô hình';

  @override
  String get camera_screen_add_title => 'Thêm Camera';

  @override
  String get camera_screen_back_camera => 'Camera sau';

  @override
  String get camera_screen_edit_title => 'Chọn Camera';

  @override
  String get camera_screen_front_camera => 'Camera trước';

  @override
  String get camera_screen_zoom_level => 'Mức độ thu phóng';

  @override
  String get cancel => 'Hủy';

  @override
  String get close => 'Đóng';

  @override
  String get color_screen_title => 'Chọn màu';

  @override
  String get counter_screen_cooldown_desc =>
      'Vào lại yêu cầu thời gian chờ #0 giây sau khi rời khỏi vùng phát hiện';

  @override
  String get counter_screen_cooldown_in_seconds => 'tính bằng giây';

  @override
  String get counter_screen_cooldown_threshold => 'Ngưỡng thời gian chờ';

  @override
  String get counter_screen_cooldown_time => 'Thời gian chờ';

  @override
  String get counter_screen_enabled => 'Đã bật';

  @override
  String get counter_screen_enabled_error => 'Lỗi';

  @override
  String get counter_screen_enabled_error_content =>
      'Bạn cần bật bộ đếm khác trước, sau đó mới có thể tắt bộ đếm này';

  @override
  String get counter_screen_name_error => 'Tên bộ đếm không được để trống';

  @override
  String get counter_screen_reentry_desc =>
      'Đối tượng phải vào #0 lần, với thời gian chờ #1 giây giữa mỗi lần ra và vào lại, để kích hoạt việc vào lại';

  @override
  String get counter_screen_reentry_threshold => 'Ngưỡng vào lại';

  @override
  String get counter_screen_reentry_title => 'Đếm vào lại';

  @override
  String get counter_screen_show_on => 'Hiển thị trên màn hình';

  @override
  String get counter_screen_stagnant_consider => 'Coi là đứng yên';

  @override
  String get counter_screen_stagnant_desc =>
      'Đối tượng đứng yên trong hơn #0 giây sẽ được coi là đứng yên';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Tiền tố mô tả';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Hậu tố mô tả';

  @override
  String get counter_screen_stagnant_in_seconds => 'tính bằng giây';

  @override
  String get counter_screen_stagnant_threshold => 'Ngưỡng đứng yên';

  @override
  String get default_project_name => 'Dự án';

  @override
  String get default_video_name => 'Nguồn video';

  @override
  String get default_zone_name => 'Vùng phát hiện';

  @override
  String get detection_screen_confidence => 'Độ tin cậy';

  @override
  String get detection_screen_confidence_desc =>
      'độ tin cậy trên #0 được coi là phát hiện hợp lệ';

  @override
  String get detection_screen_consider_valid => 'Coi là hợp lệ sau';

  @override
  String get detection_screen_consider_valid_desc =>
      'Đối tượng theo dõi sẽ được coi là hợp lệ sau #0';

  @override
  String get detection_screen_high => 'Cao';

  @override
  String get detection_screen_lost => 'Mất';

  @override
  String get detection_screen_lost_desc =>
      'Xác định động thời gian xóa vật thể bị mất giữa #0 và #1 dựa trên tốc độ di chuyển';

  @override
  String get detection_screen_low => 'Thấp';

  @override
  String get detection_screen_match => 'Khớp';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold là tham số quan trọng trong theo dõi đối tượng đo lường mức độ khớp giữa các khung phát hiện khác nhau. Giá trị thấp hơn giúp liên kết đối tượng dễ dàng hơn nhưng tăng nguy cơ liên kết sai. Giá trị cao hơn nghiêm ngặt hơn đối với liên kết đối tượng nhưng có thể bỏ lỡ một số khớp thực.';

  @override
  String get detection_screen_models => 'Mô hình';

  @override
  String get detection_screen_nms => 'Triệt tiêu không cực đại';

  @override
  String get detection_screen_nms_desc =>
      '#0 Ngưỡng NMS thấp hơn (ví dụ: 0.3-0.4) loại bỏ các khung chồng chéo nghiêm ngặt hơn và giảm kết quả dương tính giả nhưng có thể bỏ sót người chồng chéo. Ngưỡng cao hơn (0.7-0.9) giữ nhiều khung hơn có thể tăng kết quả dương tính giả nhưng phát hiện người chồng chéo tốt hơn.';

  @override
  String get detection_screen_reset => 'Đặt lại';

  @override
  String get detection_screen_reset_content =>
      'Bạn có chắc chắn muốn đặt lại cài đặt phát hiện không?';

  @override
  String get detection_screen_title => 'Cài đặt phát hiện';

  @override
  String get error_content =>
      'Đã xảy ra lỗi không mong muốn. Bạn có muốn gửi báo cáo qua email không?';

  @override
  String get error_oops => 'Rất tiếc, đã xảy ra sự cố';

  @override
  String get error_report => 'Gửi email cho chúng tôi';

  @override
  String get filter_screen_desc => 'Chọn phạm vi lọc từ danh sách bên dưới';

  @override
  String get filter_screen_error_content =>
      'Thời gian kết thúc phải lớn hơn thời gian bắt đầu';

  @override
  String get filter_screen_error_custom => 'Tùy chỉnh';

  @override
  String get filter_screen_error_end => 'Kết thúc';

  @override
  String get filter_screen_error_start => 'Bắt đầu';

  @override
  String get filter_screen_error_title => 'Bộ lọc';

  @override
  String get filter_screen_title => 'Bộ lọc';

  @override
  String get language_screen_language => 'Ngôn ngữ';

  @override
  String get no => 'Không';

  @override
  String get objects_screen_desc =>
      'Chọn đối tượng phát hiện như người, xe hơi, xe buýt, v.v.';

  @override
  String get objects_screen_title => 'Đối tượng';

  @override
  String get ok => 'OK';

  @override
  String get open_project_screen_desc =>
      'Mở dự án đã tạo trước đó, chỉ giữ 20 dự án gần nhất.';

  @override
  String get open_project_screen_no_project => 'Không tìm thấy dự án nào.';

  @override
  String get open_project_screen_title => 'Mở dự án';

  @override
  String get product_copyright => 'Bản quyền © 2025';

  @override
  String get product_desc =>
      'Sử dụng thị giác máy tính và trí tuệ nhân tạo để đếm người, phương tiện, thú cưng và nhiều đối tượng khác.';

  @override
  String get product_name => 'Bộ Đếm';

  @override
  String get project_screen_add_video_button => 'Thêm nguồn video';

  @override
  String get project_screen_exit_button => 'Thoát';

  @override
  String get project_screen_exit_confirm_content =>
      'Rời khỏi dự án sẽ dừng việc đếm. Bạn có chắc chắn muốn tiếp tục không?';

  @override
  String get project_screen_exit_confirm_title => 'Xác nhận thoát dự án';

  @override
  String get project_screen_from_desc =>
      'Chúng tôi lưu trữ bản ghi 24 giờ liên tục, để bạn có thể xem bất kỳ khoảng thời gian nào cần thiết.';

  @override
  String get project_screen_report_settings => 'Cài đặt';

  @override
  String get project_screen_title => 'Dự án';

  @override
  String get project_view_no_videos => 'Không có nguồn video.';

  @override
  String get settings_screen_center_point_button =>
      'Hiển thị điểm trung tâm trên đối tượng';

  @override
  String get settings_screen_center_point_desc =>
      'Điểm trung tâm giúp xác định xem đối tượng có nằm trong vùng phát hiện hay không.';

  @override
  String get settings_screen_center_point_title =>
      'Điểm trung tâm trên đối tượng';

  @override
  String get settings_screen_delete_button => 'Xóa';

  @override
  String get settings_screen_delete_content =>
      'Bạn có chắc chắn muốn xóa dự án này không?';

  @override
  String get settings_screen_delete_header => 'Xóa dự án này';

  @override
  String get settings_screen_desc =>
      'Đặt tên dự án, thông số phát hiện, xóa số lượng.';

  @override
  String get settings_screen_lost_target_button => 'Hiển thị đối tượng bị mất';

  @override
  String get settings_screen_lost_target_desc =>
      'Khi theo dõi đối tượng bị mất, tùy chọn này giúp hiển thị chúng. Mặc định, đối tượng bị mất sẽ không được hiển thị.';

  @override
  String get settings_screen_lost_target_title => 'Đối tượng bị mất';

  @override
  String get settings_screen_project_error => 'Tên dự án không được để trống';

  @override
  String get settings_screen_project_id => 'ID dự án';

  @override
  String get settings_screen_project_name => 'Tên dự án';

  @override
  String get settings_screen_project_name_place_holder =>
      '123 Đường Lê Lợi hoặc Công viên Thống Nhất';

  @override
  String get settings_screen_random_count_button => 'Thêm số lượng ngẫu nhiên';

  @override
  String get settings_screen_reset_count_button => 'Đặt lại số lượng';

  @override
  String get settings_screen_reset_count_content =>
      'Bạn có chắc chắn muốn đặt lại tất cả số lượng không?';

  @override
  String get settings_screen_reset_count_header =>
      'Đặt lại tất cả số lượng trong dự án này';

  @override
  String get settings_screen_title => 'Cài đặt';

  @override
  String get submit => 'Gửi';

  @override
  String get url_screen_desc => 'Vui lòng nhập URL phát trực tiếp';

  @override
  String get url_screen_title => 'URL phát trực tiếp';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream hoặc rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'Thêm điểm vào vùng hiện tại';

  @override
  String get video_screen_add_zone => 'Thêm vùng phát hiện';

  @override
  String get video_screen_change_file => 'Đổi tệp';

  @override
  String get video_screen_delete_button => 'Xóa';

  @override
  String get video_screen_delete_content =>
      'Bạn có chắc chắn muốn xóa nguồn video này không?';

  @override
  String get video_screen_delete_header => 'Xóa nguồn video này';

  @override
  String get video_screen_desc =>
      'Quản lý nguồn video, thêm hoặc sửa đổi vùng phát hiện.';

  @override
  String get video_screen_detection => 'Thông số mô hình';

  @override
  String get video_screen_edit_placeholder =>
      'Camera cửa trước hoặc Camera bãi đỗ xe';

  @override
  String get video_screen_move_bottom =>
      'Di chuyển vùng hiện tại xuống dưới cùng';

  @override
  String get video_screen_name_empty => 'Tên nguồn video không được để trống.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'hiện tại: ';

  @override
  String get video_screen_playback_speed => 'Tốc độ phát';

  @override
  String get video_screen_remove_point => 'Xóa điểm khỏi vùng hiện tại';

  @override
  String get video_screen_sources =>
      'Cấu hình nguồn hình ảnh, đối tượng phát hiện và thông số mô hình.';

  @override
  String get video_screen_targets => 'Đối tượng phát hiện';

  @override
  String get video_screen_tools => 'Công cụ';

  @override
  String get video_screen_video_name => 'Tên nguồn video';

  @override
  String get video_screen_zones => 'Vùng phát hiện';

  @override
  String get video_screen_zones_desc => 'Sử dụng kéo và thả để điều chỉnh vùng';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_camera_denied => 'Quyền truy cập camera bị từ chối';

  @override
  String get video_sources_camera_denied_msg =>
      'Vui lòng đi tới cài đặt và cho phép quyền truy cập camera cho ứng dụng này.';

  @override
  String get video_sources_camera_not_found_message =>
      'Cần cấp quyền camera để sử dụng tính năng này';

  @override
  String get video_sources_camera_not_found_title => 'Không tìm thấy camera';

  @override
  String get video_sources_file => 'Tệp';

  @override
  String get video_sources_live_stream => 'URL phát trực tiếp';

  @override
  String get video_sources_photos_denied => 'Quyền truy cập ảnh bị từ chối';

  @override
  String get video_sources_photos_denied_msg =>
      'Vui lòng đi tới cài đặt và cho phép quyền truy cập ảnh cho ứng dụng này.';

  @override
  String get video_sources_photos_goto_settings => 'Đi tới cài đặt';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_webcam_not_found_message =>
      'Vui lòng kiểm tra quyền truy cập ứng dụng và kết nối webcam';

  @override
  String get video_sources_webcam_not_found_title => 'Không tìm thấy webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get webcam_screen_add_title => 'Thêm Webcam';

  @override
  String get webcam_screen_edit_title => 'Chọn Webcam';

  @override
  String get wizard_screen_about => 'Giới thiệu';

  @override
  String get wizard_screen_desc => 'Tạo dự án mới bên dưới để bắt đầu đếm.';

  @override
  String get wizard_screen_email_us => 'Gửi email cho chúng tôi';

  @override
  String get wizard_screen_language => 'Ngôn ngữ';

  @override
  String get wizard_screen_new_project_from => 'Dự án mới từ';

  @override
  String get wizard_screen_open_projects => 'Mở dự án hiện có';

  @override
  String get wizard_screen_open_projects_tip =>
      'Tất cả dự án sẽ được tự động lưu trữ cục bộ';

  @override
  String get yes => 'Có';

  @override
  String get zone_screen_can_not_delete => 'Không thể xóa vùng';

  @override
  String get zone_screen_color => 'Màu';

  @override
  String get zone_screen_delete_button => 'Xóa';

  @override
  String get zone_screen_delete_content =>
      'Bạn có chắc chắn muốn xóa vùng này không?';

  @override
  String get zone_screen_delete_header => 'Xóa vùng này';

  @override
  String get zone_screen_desc =>
      'Vùng phát hiện có thể đặt các loại đối tượng cần phát hiện và chọn bộ đếm hiển thị, như Đã phát hiện, Đã xuất hiện và Đã đi vào.';

  @override
  String get zone_screen_name_placeholder =>
      'Tên của vùng, như Vỉa hè hoặc Bãi đỗ xe';

  @override
  String get zone_screen_one_zone_required => 'Cần ít nhất một vùng.';

  @override
  String get zone_screen_zone => 'Vùng';

  @override
  String get zone_screen_zone_color => 'Màu vùng';

  @override
  String get zone_screen_zone_name_required => 'Tên vùng không được để trống';

  @override
  String get zone_screen_zone_show_summary => 'Hiển thị tóm tắt trên màn hình';
}
