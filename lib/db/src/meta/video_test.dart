// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart';

import 'annotation_meta.dart';
import 'camera_meta.dart';
import 'point_meta.dart'; // assume PointMeta takes x and y
import 'video_meta.dart';
import 'webcam_meta.dart';
import 'zone_meta.dart';

void main() {
  setUp(() async {});

  group('[video.test]', () {
    test('should convert to string', () async {
      // Create dependent objects
      final cameraMeta = CameraMeta(
        name: 'Main Camera',
        title: 'Front Cam',
        isFront: true,
      );
      final webcamMeta = WebcamMeta(
        index: 0,
        name: 'Test Webcam',
      );
      final annotation = AnnotationMeta(
        type: TallyType.detected,
        enabled: true,
        title: 'Test Title',
        prefix: 'Mr.',
        suffix: 'Jr.',
      );
      final zone = ZoneMeta(
        zoneId: 1,
        annotations: [annotation],
        classes: [1, 2, 3],
        zoneName: 'Test Zone',
        points: [PointMeta(x: 0, y: 0)],
        pointIndex: 0,
        color: Colors.blue.shade500,
        stagnant: 5,
        reentered: 2,
        crossedZones: 3,
        cooldown: 10,
        ignoreIfCounted: false,
      );
      final videoMeta = VideoMeta(
        videoId: 101,
        mediaType: MediaType.file,
        videoName: 'Test Video',
        path: 'test/path.mp4',
        camera: cameraMeta,
        webcam: webcamMeta,
        zoom: 1.5,
        zones: [zone],
      );

      final json = videoMeta.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['videoId'], 101);
      expect(json['mediaType'], 'file');
      expect(json['videoName'], 'Test Video');
      expect(json['path'], 'test/path.mp4');
      expect(json['zoom'], 1.5);
      // Check nested objects by their JSON conversion
      expect(json['camera'], cameraMeta.toJson());
      expect(json['webcam'], webcamMeta.toJson());
      expect(json['zones'], isA<List<dynamic>>());
      expect((json['zones'] as List).first, zone.toJson());

      final videoMetaFromJson = VideoMeta.fromJson(json);
      expect(videoMetaFromJson, isA<VideoMeta>());
      expect(videoMetaFromJson, videoMeta);
      expect(videoMetaFromJson.toString(), videoMeta.toString());
      expect(videoMetaFromJson.hashCode, videoMeta.hashCode);
      expect(videoMetaFromJson.runtimeType, videoMeta.runtimeType);
    });
    // ...other tests...
  });
  // ...existing code...
}
