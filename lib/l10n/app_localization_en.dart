// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get product_name => 'Vision Counter';

  @override
  String get product_desc => 'Using computer vision and ai to count people, vehicles, pets, and more.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_starter_webcam => 'Webcam';

  @override
  String get video_starter_live_stream => 'Live stream URL';

  @override
  String get video_starter_file => 'File';

  @override
  String get video_starter_camera => 'Camera';

  @override
  String get wizard_screen_desc => 'Create a new project below to start counting.';

  @override
  String get wizard_screen_new_project_from => 'New Project from';

  @override
  String get wizard_screen_language => 'Language';

  @override
  String get wizard_screen_about => 'About';

  @override
  String get wizard_screen_open_projects_tip => 'All projects will be saved locally automatically';

  @override
  String get wizard_screen_open_projects => 'Open existing project';

  @override
  String get language_screen_language => 'Language';

  @override
  String get project_view_no_videos => 'No video source available.';

  @override
  String get about_screen_title => 'About';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'App Version';

  @override
  String get about_screen_models => 'Object detection models';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Build Info';

  @override
  String get benchmark_screen_title => 'Models Benchmarks';

  @override
  String get benchmark_screen_recommended => 'Recommended Model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Start Benchmark';

  @override
  String get benchmark_screen_start_failed => 'Failed to start benchmark, the error code is';

  @override
  String get benchmark_screen_models => 'Object detection models';

  @override
  String get project_screen_title => 'Project';

  @override
  String get project_screen_exit_confirm_title => 'Confirm exit the project';

  @override
  String get project_screen_exit_confirm_content => 'Leaving the project will stop Counting. Are you sure you want to continue?';

  @override
  String get project_screen_exit_button => 'Exit';

  @override
  String get project_screen_add_video_button => 'Add video source';

  @override
  String get project_screen_from_desc => 'We keep a rolling 24-hour record, so you can view any time slice you need.';

  @override
  String get project_screen_report_settings => 'Settings';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc => 'Select a filter range from the list below';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content => 'End time must be greater than start time';

  @override
  String get filter_screen_error_custom => 'Custom';

  @override
  String get filter_screen_error_start => 'Start';

  @override
  String get filter_screen_error_end => 'End';

  @override
  String get settings_screen_title => 'Settings';

  @override
  String get settings_screen_desc => 'Set Project name, detection parameters, count clearing.';

  @override
  String get settings_screen_project_id => 'Project Id';

  @override
  String get settings_screen_project_name => 'Project Name';

  @override
  String get settings_screen_project_name_place_holder => '123 Main St. or Park Avenue';

  @override
  String get settings_screen_project_error => 'The project name cannot be empty';

  @override
  String get settings_screen_detection => 'Detection Settings';

  @override
  String get settings_screen_detection_parameters => 'Object Detection Parameters lie confidence, NMS, etc.';

  @override
  String get settings_screen_random_count_button => 'Add random counts';

  @override
  String get settings_screen_reset_count_header => 'Reset all counts in this project';

  @override
  String get settings_screen_reset_count_button => 'Reset counts';

  @override
  String get settings_screen_reset_count_content => 'Are you sure you want to reset all counts?';

  @override
  String get settings_screen_delete_header => 'Delete this project';

  @override
  String get settings_screen_delete_content => 'Are you sure you want to delete this project?';

  @override
  String get settings_screen_delete_button => 'Delete';

  @override
  String get settings_screen_center_point_title => 'Center Point on Target';

  @override
  String get settings_screen_center_point_desc => 'The center point helps determine whether the target is within the hit zone.';

  @override
  String get settings_screen_center_point_button => 'Show Center Point on Target';

  @override
  String get settings_screen_lost_target_title => 'Lost Target';

  @override
  String get settings_screen_lost_target_desc => 'When object tracking loses a target, this option makes it visible. By default, lost targets are not shown.';

  @override
  String get settings_screen_lost_target_button => 'Show Lost Target';

  @override
  String get detection_screen_title => 'Detection Settings';

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
  String get detection_screen_0 => '0';

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
  String get add_video_screen_title => 'Add Video source';

  @override
  String get add_video_screen_from => 'Add video source from';

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
  String get source_screen_desc => 'Manage video sources, add or modify detection zones.';

  @override
  String get source_screen_video_name => 'Video source name';

  @override
  String get source_screen_edit_placeholder => 'Front Door Cam or Parking Lot Cam';

  @override
  String get source_screen_url => 'Current URL';

  @override
  String get source_screen_change_file => 'Change File';

  @override
  String get source_screen_file => 'File';

  @override
  String get source_screen_camera => 'Camera';

  @override
  String get source_screen_webcam => 'Webcam';

  @override
  String get source_screen_add_zone => 'Add detection zone';

  @override
  String get source_screen_zones => 'Detection zones';

  @override
  String get source_screen_zones_desc => 'Use drag and drop to adjust zones';

  @override
  String get source_screen_tools => 'Tools';

  @override
  String get source_screen_move_bottom => 'Move current zone to bottom';

  @override
  String get source_screen_add_point => 'Add point to current zone';

  @override
  String get source_screen_remove_point => 'Remove point from current zone';

  @override
  String get source_screen_playback_speed => 'Playback Speed';

  @override
  String get source_screen_playback_current => 'current: ';

  @override
  String get source_screen_playback_14x => '1/4x';

  @override
  String get source_screen_playback_2x => '2x';

  @override
  String get source_screen_delete_header => 'Delete this video source';

  @override
  String get source_screen_delete_content => 'Are you sure you want to delete this video source?';

  @override
  String get source_screen_delete_button => 'Delete';

  @override
  String get color_screen_title => 'Pick a color';

  @override
  String get zone_screen_desc => 'The detection zone can set the types of objects to detect and choose which counters to display, such as Detected, Spawned, and Entered.';

  @override
  String get zone_screen_name_placeholder => 'The name of the zone, like Sidewalk or Parking Lot';

  @override
  String get zone_screen_zone_color => 'Zone color';

  @override
  String get zone_screen_color => 'Color';

  @override
  String get zone_screen_objects_header => 'Detect objects such as people, vehicles, and dogs.';

  @override
  String get zone_screen_objects => 'Select Objects to Detect';

  @override
  String get zone_screen_delete_header => 'Delete this zone';

  @override
  String get zone_screen_delete_content => 'Are you sure you want to delete this zone?';

  @override
  String get zone_screen_delete_button => 'Delete';

  @override
  String get zone_screen_can_not_delete => 'Cannot delete zone';

  @override
  String get zone_screen_one_zone_required => 'At least one zone is required.';

  @override
  String get zone_screen_zone_name_required => 'The zone name cannot be empty';

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
  String get objects_screen_title => 'Objects';

  @override
  String get objects_screen_desc => 'Choose detection targets like person, car, bus, etc.';

  @override
  String get open_project_screen_title => 'Open Project';

  @override
  String get open_project_screen_desc => 'Open previously created projects, keeping only the most recent 20.';

  @override
  String get open_project_screen_no_project => 'No project found.';

  @override
  String get default_project_name => 'Project';

  @override
  String get default_video_name => 'Video source';

  @override
  String get default_zone_name => 'Detection zone';

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
