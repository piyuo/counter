// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

import 'point_meta.dart';

void main() {
  setUp(() async {});

  group('[point.test]', () {
    test('should convert to string', () async {
      final point = PointMeta(x: 10.5, y: 20.5);
      final json = point.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['x'], 10.5);
      expect(json['y'], 20.5);

      final pointFromJson = PointMeta.fromJson(json);
      expect(pointFromJson, isA<PointMeta>());
      expect(pointFromJson, point);
      expect(pointFromJson.toString(), point.toString());
      expect(pointFromJson.hashCode, point.hashCode);
      expect(pointFromJson.runtimeType, point.runtimeType);
    });
  });
}
