// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart';

import 'annotation_meta.dart';

void main() {
  setUp(() async {});

  group('[annotation.test]', () {
    test('should convert to string', () async {
      final annotation = AnnotationMeta(
        type: TallyType.detected,
        enabled: true,
        title: 'Test Title',
        prefix: 'Mr.',
        suffix: 'Jr.',
      );
      final json = annotation.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['type'], TallyType.detected.name);
      expect(json['enabled'], true);
      expect(json['title'], 'Test Title');
      expect(json['prefix'], 'Mr.');
      expect(json['suffix'], 'Jr.');
      expect(json, {
        'type': TallyType.detected.name,
        'enabled': true,
        'title': 'Test Title',
        'prefix': 'Mr.',
        'suffix': 'Jr.',
      });
      final annotationFromJson = AnnotationMeta.fromJson(json);
      expect(annotationFromJson, isA<AnnotationMeta>());
      expect(annotationFromJson.type, TallyType.detected);
      expect(annotationFromJson.enabled, true);
      expect(annotationFromJson.title, 'Test Title');
      expect(annotationFromJson.prefix, 'Mr.');
      expect(annotationFromJson.suffix, 'Jr.');
      expect(annotationFromJson.toJson(), {
        'type': TallyType.detected.name,
        'enabled': true,
        'title': 'Test Title',
        'prefix': 'Mr.',
        'suffix': 'Jr.',
      });
      expect(annotationFromJson, annotation);
      expect(annotationFromJson.toString(),
          'Annotation(type: TallyType.detected, enabled: true, title: Test Title, prefix: Mr., suffix: Jr.)');
      expect(annotation.toString(),
          'Annotation(type: TallyType.detected, enabled: true, title: Test Title, prefix: Mr., suffix: Jr.)');
      expect(annotationFromJson.hashCode, annotation.hashCode);
      expect(annotationFromJson.runtimeType, annotation.runtimeType);
    });
  });
}
