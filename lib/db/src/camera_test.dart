// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

import 'camera_meta.dart'; // assuming camera_meta.dart exists in the same directory

void main() {
  setUp(() async {});

  group('[camera.test]', () {
    test('should convert to string', () async {
      final cameraMeta = CameraMeta(
        name: 'Main Camera',
        title: 'Front Cam',
        isFront: true,
      );
      final json = cameraMeta.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['name'], 'Main Camera');
      expect(json['title'], 'Front Cam');
      expect(json['isFront'], true);

      final cameraMetaFromJson = CameraMeta.fromJson(json);
      expect(cameraMetaFromJson, isA<CameraMeta>());
      expect(cameraMetaFromJson, cameraMeta);
      expect(cameraMetaFromJson.toString(), cameraMeta.toString());
      expect(cameraMetaFromJson.hashCode, cameraMeta.hashCode);
      expect(cameraMetaFromJson.runtimeType, cameraMeta.runtimeType);
    });
  });
}
