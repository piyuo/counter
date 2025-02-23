// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get video_starter_webcam => 'Webcam';

  @override
  String get video_starter_camera => 'Camera';

  @override
  String get video_starter_live_stream => 'Live stream URL';

  @override
  String get video_starter_file => 'File';

  @override
  String get welcome_screen_title => 'piyuo.com';

  @override
  String get welcome_screen_people_counting => 'People Counting';

  @override
  String get welcome_screen_new_project_from => 'New Project from';

  @override
  String get welcome_screen_language => 'Language';

  @override
  String get welcome_screen_about => 'About';

  @override
  String get welcome_screen_open_projects_tip => 'All project will save to local automatically';

  @override
  String get welcome_screen_open_projects => 'Open existing project';

  @override
  String get language_screen_language => 'Language';

  @override
  String get about_screen_about => 'About';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'App Version';

  @override
  String get about_screen_models => 'Models';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build Info';

  @override
  String get benchmark_screen_title => 'Benchmarks';

  @override
  String get benchmark_screen_recommended => 'Recommended';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start Benchmark';

  @override
  String get benchmark_screen_start_failed => 'Failed to start benchmark, the error code is';

  @override
  String get home_screen_title => 'Project';

  @override
  String get home_screen_exit_confirm_title => 'Confirm exit the project';

  @override
  String get home_screen_exit_confirm_content => 'Leaving the project will stop Counting. Are you sure you want to continue?';

  @override
  String get home_screen_exit_button => 'Exit';

  @override
  String get home_screen_add_video_button => 'Add video';

  @override
  String get home_screen_report_from => 'Report from';

  @override
  String get home_screen_report_settings => 'Settings';

  @override
  String get filter_screen_title => 'Settings';

  @override
  String get filter_screen_select_range => 'Select report range from the list below';

  @override
  String get filter_screen_error_title => 'Settings';

  @override
  String get filter_screen_error_content => 'Settings';

  @override
  String get filter_screen_error_custom => 'Custom';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'End';

  @override
  String get settings_screen_title => 'Settings';

  @override
  String get settings_screen_project_name => 'Project Name';

  @override
  String get settings_screen_project_name_place_holder => '123 Main St. or Park Avenue';

  @override
  String get settings_screen_project_error => 'The project name cannot be empty';

  @override
  String get settings_screen_detection => 'Detection';

  @override
  String get settings_screen_delete_header => 'Delete this project';

  @override
  String get settings_screen_delete_content => 'Are you sure you want to delete this project?';

  @override
  String get settings_screen_delete_button => 'Delete';

  @override
  String get detection_screen_title => 'Detection';

  @override
  String get detection_screen_models => 'Models';

  @override
  String get detection_screen_confidence => 'Confidence';

  @override
  String get detection_screen_confidence_desc => 'confidence over #0 considered as a valid detection';

  @override
  String get detection_screen_low => 'Low';

  @override
  String get detection_screen_high => 'High';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 A lower NMS threshold (e.g., 30%) will more aggressively remove overlapping bounding boxes, while a higher NMS threshold (e.g., 0.6) will allow more overlap';

  @override
  String get detection_screen_match => 'Match';

  @override
  String get detection_screen_match_desc => 'Match over #0 is considered to be the same object.';

  @override
  String get detection_screen_lost => 'Lost';

  @override
  String get detection_screen_lost_desc => 'Track object will be removed if it is lost for #0 seconds';

  @override
  String get detection_screen_1 => '1';

  @override
  String get detection_screen_30 => '30 seconds';

  @override
  String get detection_screen_consider_valid => 'Consider valid after';

  @override
  String get detection_screen_consider_valid_desc => 'Track object will be consider valid after #0 seconds';

  @override
  String get detection_screen_reset => 'Reset';

  @override
  String get detection_screen_reset_content => 'Are you sure you want to reset the detection settings?';

  @override
  String get url_screen_title => 'Live stream URL';

  @override
  String get url_screen_desc => 'Please enter the live stream URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Add Video';

  @override
  String get add_video_screen_from => 'Add video from';

  @override
  String get webcam_screen_add_title => 'Add Webcam';

  @override
  String get webcam_screen_edit_title => 'Choose Webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Back Camera';

  @override
  String get camera_screen_back_camera => 'Front Camera';

  @override
  String get camera_screen_add_title => 'Add Camera';

  @override
  String get camera_screen_edit_title => 'Choose Camera';

  @override
  String get camera_screen_zoom_level => 'Zoom Level';

  @override
  String get video_source_screen_video_name => 'Video Name';

  @override
  String get video_source_screen_edit_placeholder => 'Front Door Cam or Parking Lot Cam';

  @override
  String get video_source_screen_url => 'Current URL';

  @override
  String get video_source_screen_opened_file => 'Currently opened file';

  @override
  String get video_source_screen_camera => 'Camera';

  @override
  String get video_source_screen_webcam => 'Webcam';

  @override
  String get video_source_screen_zones => 'Zones';

  @override
  String get video_source_screen_zones_desc => 'Use drag and drop to adjust zones';

  @override
  String get video_source_screen_tools => 'Tools';

  @override
  String get video_source_screen_move_bottom => 'Move current zone to bottom';

  @override
  String get video_source_screen_add_point => 'Add point to current zone';

  @override
  String get video_source_screen_remove_point => 'Remove point from current zone';

  @override
  String get video_source_screen_playback_speed => 'Playback Speed';

  @override
  String get video_source_screen_playback_current => 'current: ';

  @override
  String get video_source_screen_playback_14x => '1/4x';

  @override
  String get video_source_screen_playback_2x => '2x';

  @override
  String get video_source_screen_Remove => 'Remove';

  @override
  String get color_screen_title => 'Pick a color';

  @override
  String get zone_screen_desc => 'The zone can set the types of objects to detect and choose which counters to display, such as Detected, Spawned, and Entered.';

  @override
  String get zone_screen_name_placeholder => 'The name of the zone, like Sidewalk or Parking Lot';

  @override
  String get zone_screen_zone_color => 'Zone color';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_detect_desc => 'Detects objects such as people, vehicles, dogs.';

  @override
  String get zone_screen_detection => 'Detection';

  @override
  String get zone_screen_remove => 'Remove';

  @override
  String get zone_screen_remove_desc => 'Remove this zone';

  @override
  String get zone_screen_remove_title => 'Cannot remove zone';

  @override
  String get zone_screen_remove_content => 'At least one zone is required.';

  @override
  String get zone_screen_remove_error => 'The zone name cannot be empty';

  @override
  String get counter_screen_show_on => 'Show on screen';

  @override
  String get counter_screen_enabled => 'Enabled';

  @override
  String get counter_screen_reentry_threshold => 'Re-entry Threshold';

  @override
  String get counter_screen_reentry_desc => 'Objects must enter #0 times, with a #1 second cooldown between each exit and re-entry, to trigger re-entry';

  @override
  String get counter_screen_reentry_title => 'Re-entry count';

  @override
  String get counter_screen_cooldown_threshold => 'Cooldown Threshold';

  @override
  String get counter_screen_cooldown_desc => 'Re-entry requires a #0 second cooldown after exiting the detection zone';

  @override
  String get counter_screen_cooldown_time => 'Cooldown Time';

  @override
  String get counter_screen_cooldown_in_seconds => 'in seconds';

  @override
  String get counter_screen_stagnant_threshold => 'Stagnant Threshold';

  @override
  String get counter_screen_stagnant_desc => 'Objects remaining stationary for more than #0 seconds will be considered stagnant';

  @override
  String get counter_screen_stagnant_consider => 'Consider as stagnant';

  @override
  String get counter_screen_stagnant_in_seconds => 'in seconds';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Description Prefix';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Description Suffix';

  @override
  String get counter_screen_name_error => 'The counter name cannot be empty';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content => 'You need to enable other counter first, then you can disable this counter';

  @override
  String get object_class_screen_title => 'Detected Objects';

  @override
  String get open_project_screen_title => 'Open Project';

  @override
  String get open_project_screen_desc => 'Select a project to open';

  @override
  String get open_project_screen_no_project => 'No project found.';

  @override
  String get submit => 'Submit';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';
}
