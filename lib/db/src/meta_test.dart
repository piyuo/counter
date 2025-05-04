// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart' as vision;

import 'meta.dart';

void main() {
  setUp(() async {});

  group('[meta.test]', () {
    test('should convert project to meta and back', () async {
      // Create a dummy zone using vision.VideoZone
      final zone = vision.VideoZone(
        zoneId: 1,
        name: 'Zone 1',
        tallyAnnotations: [],
        points: [Offset(10, 10)],
        selectedPointIndex: 0,
        color: Colors.blue,
        stagnantThreshold: 5,
        reenteredThreshold: 2,
        crossedZonesThreshold: 3,
        cooldownThreshold: 10,
        ignoreIfCounted: false,
      );

      // Create a dummy video using app.Video
      final video = app.Video(
        videoId: 1,
        mediaType: vision.MediaType.file,
        videoName: 'Video 1',
        path: 'video1.mp4',
        camera: app.CameraDefine(name: 'Cam 1', title: 'Primary Cam', isFrontCamera: true),
        webcam: app.WebcamDefine(index: 0, name: 'Webcam 1'),
        confidenceThreshold: 0.35,
        nmsThreshold: 0.65,
        matchThreshold: 0.55,
        minLostSeconds: 0.5,
        maxLostSeconds: 1,
        validThreshold: 2,
        trackingThreshold: 0.7,
        objectClasses: [0],
        model: vision.Models.onnx_640, // adjust as needed
        zoom: 1.0,
        zones: [zone],
      );

      // Create a dummy project using app.Project
      final project = app.Project(
        projectId: 'proj1',
        projectName: 'Test Project',
        videos: [video],
        filter: vision.Filter(
          vision.FilterType.pass1Hour,
          start: const TimeOfDay(hour: 8, minute: 0),
          end: const TimeOfDay(hour: 17, minute: 0),
        ),
      );

      // Convert project to meta and back to project.
      final meta = projectToMeta(project);
      final projectFromMeta = metaToProject(meta);

      final videoFromMeta = projectFromMeta.videos[0];
      // Validate key properties.
      expect(projectFromMeta.projectId, project.projectId);
      expect(projectFromMeta.projectName, project.projectName);
      expect(projectFromMeta.filter.filterType, project.filter.filterType);
      expect(projectFromMeta.filter.start.hour, project.filter.start.hour);
      expect(projectFromMeta.filter.end.minute, project.filter.end.minute);
      expect(videoFromMeta.confidenceThreshold, video.confidenceThreshold);
      expect(videoFromMeta.nmsThreshold, video.nmsThreshold);
      expect(videoFromMeta.matchThreshold, video.matchThreshold);
      expect(videoFromMeta.minLostSeconds, video.minLostSeconds);
      expect(videoFromMeta.maxLostSeconds, video.maxLostSeconds);
      expect(videoFromMeta.validThreshold, video.validThreshold);
      expect(videoFromMeta.trackingThreshold, video.trackingThreshold);
      expect(videoFromMeta.model, video.model);
      expect(videoFromMeta.objectClasses, video.objectClasses);

      // Validate video and zone details.
      expect(projectFromMeta.videos.length, project.videos.length);
      expect(projectFromMeta.firstVideo.videoId, project.firstVideo.videoId);
      expect(projectFromMeta.firstVideo.zones.length, project.firstVideo.zones.length);

      // Optionally, compare string representations.
      expect(projectFromMeta.toString(), project.toString());
    });
  });
}
