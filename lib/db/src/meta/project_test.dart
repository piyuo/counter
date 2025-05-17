// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart';

import 'camera_meta.dart';
import 'filter_meta.dart';
import 'project_meta.dart';
import 'time_of_day_meta.dart';
import 'video_meta.dart';
import 'webcam_meta.dart';

void main() {
  setUp(() async {});

  group('[project.test]', () {
    test('should convert to string', () async {
      // Create dependent objects
      final cameraMeta = CameraMeta(
        name: 'Camera1',
        title: 'Primary',
        isFront: true,
      );
      final webcamMeta = WebcamMeta(
        index: 0,
        name: 'Webcam1',
      );
      final videoMeta = VideoMeta(
        videoId: 101,
        mediaType: SourceType.file, // or suitable MediaType from your definitions
        videoName: 'Test Video',
        path: 'video.mp4',
        camera: cameraMeta,
        webcam: webcamMeta,
        confidence: 0.85,
        nms: 0.5,
        match: 0.9,
        minLostSeconds: 0.5,
        maxLostSeconds: 10,
        valid: 1,
        tracking: 0.75,
        model: Models.onnx_640, // adjust according to your Models enum
        objectClasses: [0, 1, 2], // example class IDs
        zoom: 1.0,
        zones: [],
      );
      final filter = FilterMeta(
        filterType: FilterType.pass1Hour, // adjust if needed based on your FilterType enum
        start: TimeOfDayMeta(hour: 8, minute: 0),
        end: TimeOfDayMeta(hour: 17, minute: 0),
      );

      // Create a ProjectMeta instance
      final project = ProjectMeta(
        projectId: 'proj1',
        projectName: 'Test Project',
        videos: [videoMeta],
        filter: filter,
        isShowCenterRedDotOnTarget: false,
        isShowGhostTarget: false,
      );

      final json = project.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['projectId'], 'proj1');
      expect(json['projectName'], 'Test Project');
      // Check nested objects
      expect(json['videos'], isA<List<dynamic>>());
      expect((json['videos'] as List).first, videoMeta.toJson());
      expect(json['filter'], filter.toJson());
      expect(json['isShowCenterRedDotOnTarget'], false); // assuming Models enum is serialized using its name
      expect(json['isShowGhostTarget'], false); // assuming Models enum is serialized using its name

      final projectFromJson = ProjectMeta.fromJson(json);
      expect(projectFromJson, isA<ProjectMeta>());
      expect(projectFromJson, project);
      expect(projectFromJson.toString(), project.toString());
      expect(projectFromJson.hashCode, project.hashCode);
      expect(projectFromJson.runtimeType, project.runtimeType);
      // Check if the project has the same properties
    });
  });
}
