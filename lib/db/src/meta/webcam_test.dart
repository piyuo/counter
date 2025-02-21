// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

import 'webcam_meta.dart'; // assuming camera_meta.dart exists in the same directory

void main() {
  setUp(() async {});

  group('[webcam.test]', () {
    test('should convert to string', () async {
      final webcamMeta = WebcamMeta(
        index: 0,
        name: 'Test Webcam',
      );
      final json = webcamMeta.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['index'], 0);
      expect(json['name'], 'Test Webcam');

      final webcamMetaFromJson = WebcamMeta.fromJson(json);
      expect(webcamMetaFromJson, isA<WebcamMeta>());
      expect(webcamMetaFromJson, webcamMeta);
      expect(webcamMetaFromJson.toString(), webcamMeta.toString());
      expect(webcamMetaFromJson.hashCode, webcamMeta.hashCode);
      expect(webcamMetaFromJson.runtimeType, webcamMeta.runtimeType);
    });
  });
}
