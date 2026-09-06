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
  String get about_screen_email_us => 'Gửi email cho chúng tôi';

  @override
  String get about_screen_platform => 'Nền tảng';

  @override
  String get appeared => 'Xuất hiện';

  @override
  String get appeared_help =>
      'Đếm số người hoặc phương tiện có vị trí được phát hiện đầu tiên nằm trong khu vực này.\\n\\nGiúp hiểu nơi việc theo dõi bắt đầu.\\n\\n(Chủ yếu dành cho người dùng nâng cao)';

  @override
  String get average_occupancy => 'Số lượng trung bình';

  @override
  String get average_occupancy_help =>
      'Hiển thị số người hoặc phương tiện trung bình trong khu vực này trong cửa sổ đếm hiện tại.\\n\\nGiúp đánh giá khu vực này bận rộn như thế nào trong suốt thời gian đếm.';

  @override
  String get average_stay => 'Thời gian lưu trung bình';

  @override
  String get average_stay_help =>
      'Hiển thị thời gian trung bình mà người hoặc phương tiện ở trong khu vực này.\\n\\nThời gian lưu trung bình dài hơn có thể cho thấy khách dành nhiều thời gian hơn trong khu vực này.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter sử dụng camera và AI trên thiết bị để đếm người. Trước tiên, hãy đảm bảo thiết bị của bạn tương thích.';

  @override
  String get camera_test_screen_instruction =>
      'Hướng camera vào người. Ứng dụng sẽ vẽ khung quanh những người được phát hiện.';

  @override
  String get camera_test_screen_next => 'Nhấn Tiếp theo để tiếp tục.';

  @override
  String get camera_test_screen_start =>
      'Nhấn Bắt đầu. Nếu được yêu cầu, hãy cho phép truy cập camera.';

  @override
  String get camera_test_screen_test_failed => 'Kiểm tra thất bại!';

  @override
  String get camera_test_screen_test_passed => 'Kiểm tra thành công!';

  @override
  String get camera_test_screen_title => 'Kiểm tra camera AI';

  @override
  String get camera_test_screen_wait => 'Đang chờ AI phát hiện người…';

  @override
  String get cta_screen_custom => 'Dùng máy chủ của bạn';

  @override
  String get cta_screen_custom_help =>
      'Gửi dữ liệu lưu lượng trực tiếp đến backend hoặc cơ sở dữ liệu của bạn.';

  @override
  String get cta_screen_footer =>
      'Bằng cách tiếp tục, bạn đồng ý với Điều khoản dịch vụ, Chính sách quyền riêng tư và Thỏa thuận xử lý dữ liệu.';

  @override
  String get cta_screen_invitation => 'Sử dụng mã mời';

  @override
  String get cta_screen_invitation_help =>
      'Tham gia một tổ chức hiện có bằng lời mời từ quản trị viên.';

  @override
  String get cta_screen_local => 'Chỉ trên thiết bị này';

  @override
  String get cta_screen_local_help =>
      'Chỉ lưu dữ liệu lưu lượng trên thiết bị này. Không có dữ liệu nào được tải lên.';

  @override
  String get cta_screen_piyuo => 'Dùng Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Lưu dữ liệu lưu lượng trên Piyuo Cloud với bảng điều khiển và phân tích kinh doanh。';

  @override
  String get cta_screen_premium => 'Cao cấp';

  @override
  String get cta_screen_title =>
      'Piyuo Counter tạo thống kê lưu lượng ẩn danh mỗi 5 phút.\\nChọn cách bạn muốn lưu trữ và truy cập dữ liệu của mình.';

  @override
  String get current_occupancy => 'Số lượng hiện tại';

  @override
  String get current_occupancy_help =>
      'Hiển thị số lượng hiện tại của người hoặc phương tiện trong khu vực này.\\n\\nCon số này được cập nhật theo thời gian thực và giúp kiểm tra xem AI có phát hiện đúng với những gì bạn nhìn thấy trên màn hình hay không. Giá trị này không được đưa vào dữ liệu telemetry tải lên.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Đang lưu...';

  @override
  String get custom_server_screen_server_url_label => 'URL máy chủ';

  @override
  String get detection_screen_confidence => 'Ngưỡng độ tin cậy';

  @override
  String get detection_screen_confidence_dialog =>
      'Kiểm soát mức độ chắc chắn mà AI cần có trước khi đếm một người hoặc phương tiện.\\nGiá trị thấp hơn\\n• Phát hiện nhiều đối tượng hơn\\n• Tốt hơn cho đối tượng ở xa hoặc bị che khuất một phần\\n• Có thể tăng phát hiện sai\\nGiá trị cao hơn\\n• Chỉ đếm các phát hiện có độ tin cậy cao\\n• Giảm phát hiện sai\\n• Có thể bỏ sót đối tượng nhỏ hoặc khó\\nSử dụng giá trị thấp hơn nếu ứng dụng bỏ sót người hoặc phương tiện.\\nSử dụng giá trị cao hơn nếu ứng dụng đếm bóng, phản chiếu hoặc các đối tượng sai khác.';

  @override
  String get detection_screen_confidence_help =>
      'Độ tin cậy tối thiểu cần có để phát hiện một đối tượng.';

  @override
  String get detection_screen_confidence_max_label => 'Nghiêm ngặt';

  @override
  String get detection_screen_confidence_min_label => 'Nới lỏng';

  @override
  String get detection_screen_disappear => 'Thời gian chờ biến mất';

  @override
  String get detection_screen_disappear_dialog =>
      'Xác định thời gian AI chờ trước khi đánh dấu một đối tượng là biến mất sau khi không còn được phát hiện.\\nGiá trị ngắn hơn\\n• Đánh dấu đối tượng biến mất nhanh hơn\\n• Tốt hơn cho giao thông di chuyển nhanh\\n• Có thể đánh dấu nhầm đối tượng bị che khuất tạm thời là biến mất\\nGiá trị dài hơn\\n• Chờ lâu hơn trước khi đánh dấu đối tượng biến mất\\n• Tốt hơn khi đối tượng bị chặn hoặc bỏ sót trong thời gian ngắn\\n• Trì hoãn các sự kiện biến mất';

  @override
  String get detection_screen_disappear_help =>
      'AI sẽ chờ bao lâu trước khi đánh dấu một đối tượng là đã biến mất sau khi không còn phát hiện được nữa.';

  @override
  String get detection_screen_disappear_max_label => 'Chậm';

  @override
  String get detection_screen_disappear_min_label => 'Nhanh';

  @override
  String get detection_screen_memory_dialog =>
      'Kiểm soát thời gian AI ghi nhớ một đối tượng sau khi nó biến mất.\\nTăng giá trị này nếu người hoặc phương tiện thường xuyên bị che khuất bởi các đối tượng khác.\\nGiảm giá trị này nếu các đối tượng bị liên kết sai sau khi rời khỏi khung hình.';

  @override
  String get detection_screen_min_presence => 'Thời gian hiện diện tối thiểu';

  @override
  String get detection_screen_min_presence_help =>
      'Đối tượng phải hiển thị đủ lâu trước khi được tính. Giá trị lớn hơn giúp giảm các phát hiện sai trong thời gian ngắn.';

  @override
  String get detection_screen_min_presence_max_label => 'An toàn hơn';

  @override
  String get detection_screen_min_presence_min_label => 'Nhanh hơn';

  @override
  String get detection_screen_minimum_visible =>
      'Đối tượng phải hiển thị trong khoảng thời gian này trước khi được đếm.\\nTăng giá trị này để bỏ qua các phát hiện sai ngắn hạn.\\nGiảm giá trị này nếu người hoặc phương tiện di chuyển nhanh bị bỏ sót.';

  @override
  String get detection_screen_new_track => 'Ngưỡng theo dõi mới';

  @override
  String get detection_screen_new_track_help =>
      'Độ tin cậy tối thiểu để bắt đầu theo dõi đối tượng mới. Giá trị thấp có thể tạo các lần theo dõi trùng lặp.';

  @override
  String get detection_screen_new_track_max_label => 'Thận trọng';

  @override
  String get detection_screen_new_track_min_label => 'Nhạy';

  @override
  String get detection_screen_reset => 'Đặt lại';

  @override
  String get detection_screen_reset_content =>
      'Bạn có chắc chắn muốn đặt lại cài đặt phát hiện không?';

  @override
  String get detection_screen_show_track_id => 'Hiển thị ID theo dõi';

  @override
  String get detection_screen_show_track_id_help =>
      'Bật tùy chọn này để hiển thị ID theo dõi duy nhất cho từng đối tượng được theo dõi.';

  @override
  String get detection_screen_stay => 'Thời gian lưu lại';

  @override
  String get detection_screen_stay_help =>
      'Đối tượng phải ở trong khu vực bao lâu trước khi được tính là lưu lại.';

  @override
  String get detection_screen_stay_max_label => 'Trì hoãn';

  @override
  String get detection_screen_stay_min_label => 'Ngay lập tức';

  @override
  String get detection_screen_stay_threshold =>
      'Xác định khi nào một đối tượng đóng góp vào số lượng Lưu lại.\\nGiá trị ngắn hơn\\n• Đếm lưu lại ngay lập tức\\n• Tốt hơn cho phân tích nhanh\\nGiá trị dài hơn\\n• Bỏ qua lưu lượng đi ngang qua ngắn\\n• Tốt hơn cho đo lường mức độ chiếm dụng';

  @override
  String get detection_screen_subtitle =>
      'Điều chỉnh cách AI phát hiện và theo dõi đối tượng.';

  @override
  String get detection_screen_title => 'Theo dõi & Đếm';

  @override
  String get detection_screen_track_dialog =>
      'Kiểm soát khi nào một đối tượng mới phát hiện trở thành một track mới.\\nGiá trị thấp hơn\\n• Bắt đầu theo dõi sớm hơn\\n• Tốt hơn cho các đối tượng di chuyển nhanh\\n• Có thể tạo ra track trùng lặp\\nGiá trị cao hơn\\n• Cần bằng chứng mạnh hơn trước khi tạo track mới\\n• Giảm track trùng lặp\\n• Có thể làm chậm việc theo dõi đối tượng mới';

  @override
  String get detection_screen_track_memory => 'Bộ nhớ theo dõi';

  @override
  String get detection_screen_track_memory_help =>
      'Tiếp tục theo dõi đối tượng trong bao lâu sau khi tạm thời mất dấu. Giá trị lớn hơn giúp khôi phục theo dõi sau khi bị che khuất ngắn.';

  @override
  String get detection_screen_track_memory_max_label => 'Dài';

  @override
  String get detection_screen_track_memory_min_label => 'Ngắn';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter sử dụng camera để phát hiện người đi bộ và phương tiện theo thời gian thực. Thiết bị này không có camera khả dụng.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Hãy mở ứng dụng này trên điện thoại của bạn';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Điện thoại hoặc máy tính bảng có camera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Khuyến nghị thiết bị iOS hoặc Android';

  @override
  String get device_not_supported_screen_requirements_title => 'Bạn cần gì';

  @override
  String get device_not_supported_screen_title => 'Không tìm thấy camera';

  @override
  String get disappeared => 'Biến mất';

  @override
  String get disappeared_help =>
      'Đếm số người hoặc phương tiện có vị trí được phát hiện cuối cùng nằm trong khu vực này.\\n\\nViệc theo dõi kết thúc sau Thời gian biến mất đã cấu hình nếu người hoặc phương tiện không còn được phát hiện.\\n\\n(Chủ yếu dành cho người dùng nâng cao)';

  @override
  String get dpa => 'Thỏa thuận xử lý dữ liệu';

  @override
  String get durationDaysShort => '%sn';

  @override
  String get durationHoursShort => '%sg';

  @override
  String get durationMinutesShort => '%sp';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Đi vào';

  @override
  String get entered_help =>
      'Đếm số người hoặc phương tiện đi vào khu vực này trong cửa sổ đếm hiện tại.\\n\\nMột lượt vào được tính khi người hoặc phương tiện di chuyển từ ngoài khu vực vào bên trong.';

  @override
  String get exited => 'Đi ra';

  @override
  String get exited_help =>
      'Đếm số người hoặc phương tiện rời khỏi khu vực này trong cửa sổ đếm hiện tại.\\n\\nMột lượt ra được tính khi người hoặc phương tiện di chuyển từ trong khu vực ra bên ngoài.';

  @override
  String get language_screen_language => 'Ngôn ngữ';

  @override
  String get language_screen_subtitle =>
      'Chọn ngôn ngữ sử dụng trong ứng dụng.';

  @override
  String get local_only_screen_body =>
      'Chế độ \'Chỉ thiết bị cục bộ\' cho phép bạn dùng thử tính năng nhận diện và theo dõi bằng camera AI mà không cần tải lên bất kỳ dữ liệu nào. Mọi số liệu thống kê lượt qua lại đều chỉ được xử lý trên thiết bị này, rất phù hợp để dùng thử trước khi kết nối với máy chủ.';

  @override
  String get local_only_screen_use_action => 'Chỉ dùng thiết bị này';

  @override
  String get local_screen_text =>
      'Piyuo Counter sẽ chạy hoàn toàn trên thiết bị này.\\nThống kê lưu lượng sẽ chỉ được lưu trên thiết bị này và không được tải lên.\\nBạn có thể kết nối với Piyuo Cloud hoặc máy chủ của mình sau trong Cài đặt.';

  @override
  String get maximum_occupancy => 'Số lượng tối đa';

  @override
  String get maximum_occupancy_help =>
      'Hiển thị số người hoặc phương tiện nhiều nhất có mặt cùng lúc trong khu vực này trong cửa sổ đếm hiện tại.\\n\\nHữu ích để xác định thời điểm đông người hoặc lưu lượng giao thông cao nhất.';

  @override
  String get maximum_stay => 'Thời gian lưu tối đa';

  @override
  String get maximum_stay_help =>
      'Hiển thị thời gian dài nhất mà một người hoặc phương tiện ở trong khu vực này trong cửa sổ đếm hiện tại.\\n\\nHữu ích để xác định các lần dừng hoặc lưu lại lâu bất thường.';

  @override
  String get metric_events => 'Sự kiện';

  @override
  String get metric_live => 'Trực tiếp';

  @override
  String get metric_show_less => 'Hiển thị ít hơn';

  @override
  String get metric_show_more => 'Hiển thị thêm';

  @override
  String get metric_statistics => 'Thống kê';

  @override
  String get metrics_counting_all => 'Tất cả';

  @override
  String get metrics_counting_done => 'Hoàn thành';

  @override
  String get metrics_counting_in_progress => 'Đang thực hiện';

  @override
  String get metrics_counting_missing => 'Thiếu';

  @override
  String get metrics_counting_window => 'Thống kê cho mỗi khoảng 5 phút';

  @override
  String get onboarding_back_action => 'Quay lại';

  @override
  String get onboarding_cta_no_server => 'Không muốn tải dữ liệu lên?';

  @override
  String get onboarding_cta_title => 'Dữ liệu của bạn sẽ được gửi đến đâu?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter dùng camera thiết bị và AI tích hợp để nhận diện người và xe cộ ngay lập tức.\\nNhờ công nghệ nhận diện và theo dõi, ứng dụng tự động đếm lưu lượng người đi bộ và phương tiện — tất cả xử lý ngay trên thiết bị của bạn.';

  @override
  String get onboarding_intro_text2 =>
      'Toàn bộ xử lý AI diễn ra ngay trên thiết bị của bạn. Không có video, hình ảnh, khuôn mặt hay danh tính nào được tải lên.\\nChỉ có bản tóm tắt ẩn danh mỗi 5 phút được chia sẻ, bao gồm thống kê số lượng, mức độ chiếm dụng, lượt vào, lượt ra và thời gian lưu lại.';

  @override
  String get onboarding_intro_text3 =>
      'Chỉ cần mở ứng dụng và để nó chạy. Piyuo Counter sẽ tự động liên tục thu thập và lưu trữ dữ liệu giao thông.\\nBản tóm tắt dữ liệu được lưu mỗi 5 phút và tải lên Piyuo Cloud hoặc máy chủ riêng của bạn mỗi giờ.';

  @override
  String get onboarding_intro_title1 => 'Đếm lưu lượng bằng AI';

  @override
  String get onboarding_intro_title2 => 'Ưu tiên quyền riêng tư';

  @override
  String get onboarding_intro_title3 => 'Tự động hoạt động 24/7';

  @override
  String get onboarding_next_action => 'Tiếp theo';

  @override
  String get onboarding_skip_action => 'Bỏ qua giới thiệu';

  @override
  String get onboarding_start_action => 'Bắt đầu';

  @override
  String get passed_by => 'Đã đi qua';

  @override
  String get passed_by_help =>
      'Đếm số người hoặc phương tiện đi qua khu vực này trong cửa sổ đếm hiện tại.\\n\\nMỗi người hoặc phương tiện chỉ được tính một lần cho mỗi lần đi qua khu vực.';

  @override
  String get payloads_screen_area => 'Khu vực';

  @override
  String get payloads_screen_confidence => 'Độ tin cậy';

  @override
  String get payloads_screen_coverage => 'Độ bao phủ';

  @override
  String get payloads_screen_delivered => 'Đã gửi';

  @override
  String get payloads_screen_failed_load => 'Không thể tải dữ liệu gần đây';

  @override
  String get payloads_screen_frame_processed => 'Khung hình đã xử lý';

  @override
  String get payloads_screen_hour_not_exists =>
      'Khung giờ này không còn tồn tại.';

  @override
  String get payloads_screen_missing_time => 'Thời gian bị thiếu';

  @override
  String get payloads_screen_no_payloads => 'Chưa có dữ liệu.';

  @override
  String get payloads_screen_partial =>
      'Khoảng thời gian kết thúc sớm (một phần)';

  @override
  String get payloads_screen_partially => 'Gửi thành công một phần';

  @override
  String get payloads_screen_payload_not_exists =>
      'Payload này không còn tồn tại.';

  @override
  String get payloads_screen_pending => 'Đang chờ gửi';

  @override
  String get payloads_screen_process_fps => 'FPS xử lý';

  @override
  String get payloads_screen_resend => 'Gửi lại';

  @override
  String get payloads_screen_select_first =>
      'Hãy chọn ít nhất một ngày hoặc giờ trước.';

  @override
  String get payloads_screen_subtitle => 'Chọn theo ngày hoặc giờ để gửi lại';

  @override
  String get payloads_screen_title => 'Tải dữ liệu gần đây';

  @override
  String get personal_custom_screen_build_server =>
      'Cần trợ giúp thiết lập máy chủ của riêng bạn?\\nXem tài liệu API và ví dụ máy chủ của chúng tôi.';

  @override
  String get personal_custom_screen_help_action => 'Mở tài liệu API';

  @override
  String get personal_custom_screen_reset_action => 'Bắt đầu lại';

  @override
  String get personal_custom_success_screen_help =>
      'Nhấn Start bên dưới để bắt đầu đếm.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Thống kê lưu lượng được tải lên tự động mỗi giờ.\\nBạn cũng có thể tải lên thủ công từ màn hình Nhật ký tải lên.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Máy chủ của bạn chưa cần phải trực tuyến.\\nHãy bắt đầu đếm ngay bây giờ. Bạn có thể hoàn thiện và kiểm thử máy chủ sau. Thống kê lưu lượng sẽ được lưu trên thiết bị này cho đến khi tải lên thành công.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Số liệu thống kê lưu lượng sẽ được gửi đến';

  @override
  String get personal_custom_success_screen_title =>
      'Máy chủ của bạn đã sẵn sàng';

  @override
  String get piyuo_server_screen_cloud_url_label => 'URL Piyuo Cloud của bạn';

  @override
  String get piyuo_server_screen_copy_action => 'Sao chép URL';

  @override
  String get piyuo_server_screen_copy_success => 'Đã sao chép URL';

  @override
  String get piyuo_server_screen_saving_action => 'Đang lưu...';

  @override
  String get piyuo_server_screen_start =>
      'Nhấn \"Start\" bên dưới để bắt đầu đếm.';

  @override
  String get piyuo_server_screen_url_help =>
      'Bảng điều khiển Piyuo Cloud cá nhân của bạn đã sẵn sàng tại URL này。';

  @override
  String get piyuo_server_screen_url_remember =>
      'Lưu URL này để truy cập bảng điều khiển lưu lượng của bạn từ thiết bị khác.';

  @override
  String get piyuo_server_screen_use_action => 'Dùng Piyuo Cloud';

  @override
  String get privacy => 'Chính sách quyền riêng tư';

  @override
  String get product_copyright => 'Bản quyền © 2026';

  @override
  String get product_desc => 'Đếm người và phương tiện bằng AI.';

  @override
  String get settings_screen_custom_subtitle =>
      'Gửi dữ liệu lưu lượng trực tiếp đến máy chủ hoặc cơ sở dữ liệu của bạn.';

  @override
  String get settings_screen_custom_title => 'Dùng máy chủ tùy chỉnh';

  @override
  String get settings_screen_data_server_label => 'Máy chủ dữ liệu';

  @override
  String get settings_screen_detection_target => 'Mục tiêu phát hiện';

  @override
  String get settings_screen_language_title => 'Ngôn ngữ';

  @override
  String get settings_screen_local_subtitle =>
      'Lưu dữ liệu lưu lượng chỉ trên thiết bị này. Không có dữ liệu nào được tải lên.';

  @override
  String get settings_screen_local_title => 'Chỉ thiết bị này';

  @override
  String get settings_screen_misc_label => 'Khác';

  @override
  String get settings_screen_object_detection => 'Phát hiện đối tượng';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Lưu dữ liệu lưu lượng trên Piyuo Cloud với bảng điều khiển và thông tin chi tiết cho doanh nghiệp.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Thao tác này sẽ xóa toàn bộ dữ liệu và bắt đầu lại từ đầu. Không thể hoàn tác thao tác này.';

  @override
  String get settings_screen_reset_all_data_title => 'Đặt lại toàn bộ dữ liệu?';

  @override
  String get settings_screen_subscription_body =>
      'Quản lý gói đăng ký và thông tin thanh toán';

  @override
  String get settings_screen_subscription_title => 'Gói đăng ký';

  @override
  String get start_screen_about => 'Giới thiệu';

  @override
  String get start_screen_server_none =>
      'Dữ liệu chỉ được lưu trên thiết bị này';

  @override
  String get start_screen_server_personal => 'Dữ liệu được tải lên mỗi giờ tới';

  @override
  String get start_screen_settings => 'Cài đặt';

  @override
  String get start_screen_upload_logs => 'Tải nhật ký lên';

  @override
  String get start_screen_video_sources => 'Nguồn video';

  @override
  String get stayed => 'Ở lại';

  @override
  String get stayed_help =>
      'Đếm số người hoặc phương tiện ở trong khu vực này ít nhất bằng Thời gian lưu được thiết lập.\\n\\nThời gian lưu mặc định là 15 giây và có thể thay đổi trong Cài đặt.';

  @override
  String get target_pedestrian => 'Người đi bộ';

  @override
  String get target_pedestrian_help =>
      'Đếm người bằng mô hình phát hiện người đi bộ';

  @override
  String get target_screen_subtitle => 'Chọn mô hình phát hiện sẽ sử dụng';

  @override
  String get target_vehicle => 'Phương tiện';

  @override
  String get target_vehicle_help =>
      'Đếm ô tô và các phương tiện khác bằng mô hình phát hiện phương tiện';

  @override
  String get telemetry_error_connection_refused =>
      'Không thể kết nối đến máy chủ. Máy chủ có thể đang ngoại tuyến.';

  @override
  String get telemetry_error_connection_reset =>
      'Kết nối đã bị đặt lại. Vui lòng kiểm tra kết nối internet và thử lại.';

  @override
  String get telemetry_error_connection_timeout =>
      'Kết nối phản hồi quá lâu. Vui lòng kiểm tra kết nối internet và thử lại.';

  @override
  String get telemetry_error_database_error =>
      'Ghi vào cơ sở dữ liệu không thành công.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Không tìm thấy địa chỉ máy chủ. Vui lòng kiểm tra kết nối internet hoặc URL máy chủ.';

  @override
  String get telemetry_error_http_error_status =>
      'Máy chủ đã từ chối yêu cầu. Vui lòng thử lại sau.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Đã xảy ra lỗi không mong muốn khi giao tiếp với máy chủ.';

  @override
  String get telemetry_error_invalid_url =>
      'Địa chỉ máy chủ không hợp lệ. Vui lòng kiểm tra cài đặt của bạn.';

  @override
  String get telemetry_error_network_error =>
      'Đã xảy ra lỗi mạng. Vui lòng kiểm tra kết nối internet và thử lại.';

  @override
  String get telemetry_error_socket_error =>
      'Đã xảy ra sự cố kết nối mạng. Vui lòng kiểm tra kết nối internet.';

  @override
  String get telemetry_error_transport_exception =>
      'Đã xảy ra sự cố khi gửi dữ liệu. Vui lòng thử lại.';

  @override
  String get telemetry_error_unknown_error => 'Đã xảy ra lỗi không mong muốn.';

  @override
  String get terms => 'Điều khoản dịch vụ';

  @override
  String get upload_screen_attempt_time => 'Thời gian thử:';

  @override
  String get upload_screen_error => 'Lỗi:';

  @override
  String get upload_screen_failed => 'Thất bại';

  @override
  String get upload_screen_load_error => 'Không thể tải nhật ký tải lên.';

  @override
  String get upload_screen_log_not_exists =>
      'Nhật ký tải lên không còn khả dụng.';

  @override
  String get upload_screen_next => 'Lần tải lên tiếp theo ...';

  @override
  String get upload_screen_next_upload_prefix => 'Lần tải lên tiếp theo ';

  @override
  String get upload_screen_no_data_server =>
      'Vui lòng thiết lập Máy chủ Dữ liệu trước.';

  @override
  String get upload_screen_no_logs => 'Chưa có nhật ký tải lên.';

  @override
  String get upload_screen_payload_count => 'Số lượng dữ liệu';

  @override
  String get upload_screen_payload_count_label => 'Số lượng dữ liệu:';

  @override
  String get upload_screen_payload_size => 'Kích thước dữ liệu:';

  @override
  String get upload_screen_result => 'Kết quả:';

  @override
  String get upload_screen_retry => 'Số lần thử lại:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Thành công';

  @override
  String get upload_screen_today => 'Hôm nay';

  @override
  String get upload_screen_upload_now => 'Tải lên ngay';

  @override
  String get upload_screen_upload_success => 'Tải lên thành công.';

  @override
  String get upload_screen_uploading => 'Đang tải lên...';

  @override
  String get upload_screen_yesterday => 'Hôm qua';

  @override
  String get url_screen_invalid_rtsp_error => 'URL RTSP phải có tên máy chủ.';

  @override
  String get url_screen_invalid_url_error =>
      'Nhập URL hợp lệ với giao thức được hỗ trợ.';

  @override
  String get url_screen_subtitle => 'Vui lòng nhập URL phát trực tiếp';

  @override
  String get url_screen_title => 'URL phát trực tiếp';

  @override
  String get url_screen_unsupported_scheme_error =>
      ' RTSP और RTSPS URL समर्थित हैं।';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Vui lòng nhập URL phát trực tiếp.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream hoặc rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Camera sau';

  @override
  String get video_sources_camera => 'Camera';

  @override
  String get video_sources_file => 'Tệp';

  @override
  String get video_sources_front_camera => 'Camera trước';

  @override
  String get video_sources_live_stream => 'URL phát trực tiếp';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Cần cấp quyền camera để sử dụng tính năng này';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Không tìm thấy camera';

  @override
  String get video_sources_screen_import_error => 'Không thể nhập tệp video.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Vui lòng đi tới cài đặt và cho phép quyền truy cập ảnh cho ứng dụng này.';

  @override
  String get video_sources_screen_select_camera => 'Chạm để chọn camera này';

  @override
  String get video_sources_screen_select_file => 'Chạm để chọn tệp';

  @override
  String get video_sources_screen_select_live =>
      'Chạm để đặt URL phát trực tiếp';

  @override
  String get video_sources_webcam => 'Webcam';
}
