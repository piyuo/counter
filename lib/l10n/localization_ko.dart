// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class LocalizationKo extends Localization {
  LocalizationKo([String locale = 'ko']) : super(locale);

  @override
  String get product_name => '카운터';

  @override
  String get product_desc => '컴퓨터 비전과 AI를 사용하여 사람, 차량, 반려동물 등을 카운팅합니다.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => '웹캠';

  @override
  String get video_sources_live_stream => '라이브 스트림 URL';

  @override
  String get video_sources_file => '파일';

  @override
  String get video_sources_camera => '카메라';

  @override
  String get video_sources_camera_not_found_title => '카메라를 찾을 수 없음';

  @override
  String get video_sources_camera_not_found_message => '카메라를 사용하려면 카메라 권한이 필요합니다';

  @override
  String get video_sources_webcam_not_found_title => '웹캠을 찾을 수 없음';

  @override
  String get video_sources_webcam_not_found_message => '웹캠이 연결되어 있는지 확인해 주세요';

  @override
  String get wizard_screen_desc => '아래에서 새 프로젝트를 만들어 카운팅을 시작하세요.';

  @override
  String get wizard_screen_new_project_from => '다음에서 새 프로젝트 만들기';

  @override
  String get wizard_screen_language => '언어';

  @override
  String get wizard_screen_about => '정보';

  @override
  String get wizard_screen_open_projects_tip => '모든 프로젝트는 자동으로 로컬에 저장됩니다';

  @override
  String get wizard_screen_open_projects => '기존 프로젝트 열기';

  @override
  String get wizard_screen_email_us => '이메일 문의';

  @override
  String get language_screen_language => '언어';

  @override
  String get project_view_no_videos => '사용 가능한 비디오 소스가 없습니다.';

  @override
  String get about_screen_title => '정보';

  @override
  String get about_screen_platform => '플랫폼';

  @override
  String get about_screen_app_version => '앱 버전';

  @override
  String get about_screen_models => '객체 감지 모델';

  @override
  String get about_screen_benchmark => '벤치마크';

  @override
  String get about_screen_opencv_build_info => 'OpenCV 빌드 정보';

  @override
  String get benchmark_screen_title => '모델 벤치마크';

  @override
  String get benchmark_screen_recommended => '추천 모델';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => '벤치마크 시작';

  @override
  String get benchmark_screen_start_failed => '벤치마크 시작 실패, 오류 코드:';

  @override
  String get benchmark_screen_models => '객체 감지 모델';

  @override
  String get project_screen_title => '프로젝트';

  @override
  String get project_screen_exit_confirm_title => '프로젝트 종료 확인';

  @override
  String get project_screen_exit_confirm_content => '프로젝트를 나가면 카운팅이 중지됩니다. 계속하시겠습니까?';

  @override
  String get project_screen_exit_button => '종료';

  @override
  String get project_screen_add_video_button => '비디오 소스 추가';

  @override
  String get project_screen_from_desc => '24시간 연속 기록을 유지하므로 필요한 시간대를 확인할 수 있습니다.';

  @override
  String get project_screen_report_settings => '설정';

  @override
  String get filter_screen_title => '필터';

  @override
  String get filter_screen_desc => '아래 목록에서 필터 범위를 선택하세요';

  @override
  String get filter_screen_error_title => '필터';

  @override
  String get filter_screen_error_content => '종료 시간은 시작 시간보다 커야 합니다';

  @override
  String get filter_screen_error_custom => '사용자 정의';

  @override
  String get filter_screen_error_start => '시작';

  @override
  String get filter_screen_error_end => '종료';

  @override
  String get settings_screen_title => '설정';

  @override
  String get settings_screen_desc => '프로젝트 이름, 감지 매개변수, 카운트 초기화 설정.';

  @override
  String get settings_screen_project_id => '프로젝트 ID';

  @override
  String get settings_screen_project_name => '프로젝트 이름';

  @override
  String get settings_screen_project_name_place_holder => '123번지 또는 중앙공원';

  @override
  String get settings_screen_project_error => '프로젝트 이름은 비워둘 수 없습니다';

  @override
  String get settings_screen_random_count_button => '임의 카운트 추가';

  @override
  String get settings_screen_reset_count_header => '이 프로젝트의 모든 카운트 초기화';

  @override
  String get settings_screen_reset_count_button => '카운트 초기화';

  @override
  String get settings_screen_reset_count_content => '모든 카운트를 초기화하시겠습니까?';

  @override
  String get settings_screen_delete_header => '이 프로젝트 삭제';

  @override
  String get settings_screen_delete_content => '이 프로젝트를 삭제하시겠습니까?';

  @override
  String get settings_screen_delete_button => '삭제';

  @override
  String get settings_screen_center_point_title => '대상 중심점';

  @override
  String get settings_screen_center_point_desc => '중심점은 대상이 적중 영역 내에 있는지 판단하는 데 도움이 됩니다.';

  @override
  String get settings_screen_center_point_button => '대상에 중심점 표시';

  @override
  String get settings_screen_lost_target_title => '손실된 대상';

  @override
  String get settings_screen_lost_target_desc => '객체 추적이 대상을 놓쳤을 때 이 옵션을 사용하면 표시됩니다. 기본적으로 손실된 대상은 표시되지 않습니다.';

  @override
  String get settings_screen_lost_target_button => '손실된 대상 표시';

  @override
  String get detection_screen_title => '감지 설정';

  @override
  String get detection_screen_models => '모델';

  @override
  String get detection_screen_confidence => '신뢰도';

  @override
  String get detection_screen_confidence_desc => '#0 이상의 신뢰도는 유효한 감지로 간주됩니다';

  @override
  String get detection_screen_low => '낮음';

  @override
  String get detection_screen_high => '높음';

  @override
  String get detection_screen_nms => '비최대 억제';

  @override
  String get detection_screen_nms_desc => '#0 낮은 NMS 임계값(예: 30%)은 겹치는 경계 상자를 더 적극적으로 제거하고, 높은 NMS 임계값(예: 0.6)은 더 많은 겹침을 허용합니다';

  @override
  String get detection_screen_match => '일치';

  @override
  String get detection_screen_match_desc => '#0 이상 일치하면 동일한 객체로 간주됩니다.';

  @override
  String get detection_screen_lost => '손실';

  @override
  String get detection_screen_lost_desc => '객체가 #0 동안 손실되면 추적 객체가 제거됩니다';

  @override
  String get detection_screen_consider_valid => '유효 간주 시간';

  @override
  String get detection_screen_consider_valid_desc => '추적 객체는 #0 후에 유효한 것으로 간주됩니다';

  @override
  String get detection_screen_reset => '초기화';

  @override
  String get detection_screen_reset_content => '감지 설정을 초기화하시겠습니까?';

  @override
  String get url_screen_title => '라이브 스트림 URL';

  @override
  String get url_screen_desc => '라이브 스트림 URL을 입력하세요';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream 또는 rtsp://example.com/stream';

  @override
  String get add_video_screen_title => '비디오 소스 추가';

  @override
  String get add_video_screen_from => '다음에서 비디오 소스 추가';

  @override
  String get webcam_screen_add_title => '웹캠 추가';

  @override
  String get webcam_screen_edit_title => '웹캠 선택';

  @override
  String get webcam_manager_webcam => '웹캠';

  @override
  String get camera_screen_front_camera => '전면 카메라';

  @override
  String get camera_screen_back_camera => '후면 카메라';

  @override
  String get camera_screen_add_title => '카메라 추가';

  @override
  String get camera_screen_edit_title => '카메라 선택';

  @override
  String get camera_screen_zoom_level => '줌 레벨';

  @override
  String get video_screen_name_empty => '비디오 이름은 비워둘 수 없습니다.';

  @override
  String get video_screen_desc => '비디오 소스 관리, 감지 영역 추가 또는 수정.';

  @override
  String get video_screen_video_name => '비디오 소스 이름';

  @override
  String get video_screen_edit_placeholder => '현관문 카메라 또는 주차장 카메라';

  @override
  String get video_screen_change_file => '파일 변경';

  @override
  String get video_screen_add_zone => '감지 영역 추가';

  @override
  String get video_screen_zones => '감지 영역';

  @override
  String get video_screen_zones_desc => '드래그 앤 드롭으로 영역 조정';

  @override
  String get video_screen_tools => '도구';

  @override
  String get video_screen_move_bottom => '현재 영역을 맨 아래로 이동';

  @override
  String get video_screen_add_point => '현재 영역에 점 추가';

  @override
  String get video_screen_remove_point => '현재 영역에서 점 제거';

  @override
  String get video_screen_playback_speed => '재생 속도';

  @override
  String get video_screen_playback_current => '현재: ';

  @override
  String get video_screen_playback_14x => '1/4배속';

  @override
  String get video_screen_playback_2x => '2배속';

  @override
  String get video_screen_delete_header => '이 비디오 소스 삭제';

  @override
  String get video_screen_delete_content => '이 비디오 소스를 삭제하시겠습니까?';

  @override
  String get video_screen_delete_button => '삭제';

  @override
  String get video_screen_sources => '이미지 소스, 감지 대상 및 모델 매개변수 구성.';

  @override
  String get video_screen_targets => '감지 대상';

  @override
  String get video_screen_detection => '모델 매개변수';

  @override
  String get color_screen_title => '색상 선택';

  @override
  String get zone_screen_desc => '감지 영역에서는 감지할 객체 유형을 설정하고 감지됨, 생성됨, 진입함과 같은 표시할 카운터를 선택할 수 있습니다.';

  @override
  String get zone_screen_name_placeholder => '보도 또는 주차장과 같은 영역 이름';

  @override
  String get zone_screen_zone_color => '영역 색상';

  @override
  String get zone_screen_color => '색상';

  @override
  String get zone_screen_delete_header => '이 영역 삭제';

  @override
  String get zone_screen_delete_content => '이 영역을 삭제하시겠습니까?';

  @override
  String get zone_screen_delete_button => '삭제';

  @override
  String get zone_screen_can_not_delete => '영역을 삭제할 수 없음';

  @override
  String get zone_screen_one_zone_required => '최소 하나의 영역이 필요합니다.';

  @override
  String get zone_screen_zone_name_required => '영역 이름은 비워둘 수 없습니다';

  @override
  String get counter_screen_show_on => '화면에 표시';

  @override
  String get counter_screen_enabled => '활성화됨';

  @override
  String get counter_screen_reentry_threshold => '재진입 임계값';

  @override
  String get counter_screen_reentry_desc => '객체는 #0 번 진입해야 하며, 각 퇴장과 재진입 사이에 #1 초의 쿨다운 시간이 있어야 재진입이 트리거됩니다';

  @override
  String get counter_screen_reentry_title => '재진입 카운트';

  @override
  String get counter_screen_cooldown_threshold => '쿨다운 임계값';

  @override
  String get counter_screen_cooldown_desc => '재진입하려면 감지 영역에서 나간 후 #0 초의 쿨다운이 필요합니다';

  @override
  String get counter_screen_cooldown_time => '쿨다운 시간';

  @override
  String get counter_screen_cooldown_in_seconds => '초 단위';

  @override
  String get counter_screen_stagnant_threshold => '정체 임계값';

  @override
  String get counter_screen_stagnant_desc => '#0 초 이상 정지 상태를 유지하는 객체는 정체된 것으로 간주됩니다';

  @override
  String get counter_screen_stagnant_consider => '정체된 것으로 간주';

  @override
  String get counter_screen_stagnant_in_seconds => '초 단위';

  @override
  String get counter_screen_stagnant_desc_prefix => '설명 접두사';

  @override
  String get counter_screen_stagnant_desc_suffix => '설명 접미사';

  @override
  String get counter_screen_name_error => '카운터 이름은 비워둘 수 없습니다';

  @override
  String get counter_screen_enabled_error => '오류';

  @override
  String get counter_screen_enabled_error_content => '다른 카운터를 먼저 활성화한 다음 이 카운터를 비활성화할 수 있습니다';

  @override
  String get objects_screen_title => '객체';

  @override
  String get objects_screen_desc => '사람, 자동차, 버스 등과 같은 감지 대상을 선택하세요.';

  @override
  String get open_project_screen_title => '프로젝트 열기';

  @override
  String get open_project_screen_desc => '이전에 생성된 프로젝트를 열고 최근 20개만 유지합니다.';

  @override
  String get open_project_screen_no_project => '프로젝트를 찾을 수 없습니다.';

  @override
  String get default_project_name => '프로젝트';

  @override
  String get default_video_name => '비디오 소스';

  @override
  String get default_zone_name => '감지 영역';

  @override
  String get error_oops => '죄송합니다, 문제가 발생했습니다';

  @override
  String get error_content => '예기치 않은 오류가 발생했습니다. 이메일 보고서를 제출하시겠습니까?';

  @override
  String get error_report => '이메일 문의';

  @override
  String get submit => '제출';

  @override
  String get ok => '확인';

  @override
  String get cancel => '취소';

  @override
  String get yes => '예';

  @override
  String get no => '아니오';

  @override
  String get close => '닫기';

  @override
  String get back => '뒤로';

  @override
  String get settings_screen_detection_button => 'MISSING';
}
