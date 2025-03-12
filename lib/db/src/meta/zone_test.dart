// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart';

import 'annotation_meta.dart';
import 'point_meta.dart';
import 'zone_meta.dart';

void main() {
  setUp(() async {});

  group('[zone.test]', () {
    test('should convert to string', () async {
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
      final json = zone.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['zoneId'], 1);
      expect(json['annotations'], isA<List<dynamic>>());
      expect((json['annotations'] as List).first, annotation.toJson());
      expect(json['zoneName'], 'Test Zone');
      expect(json['points'], isA<List<dynamic>>());
      expect((json['points'] as List).first, {'x': 0, 'y': 0});
      expect(json['pointIndex'], 0);
      // Assuming ColorConverter converts Colors.blue to its hex string.
      expect(json['color'], Colors.blue.toARGB32());
      expect(json['stagnant'], 5);
      expect(json['reentered'], 2);
      expect(json['crossedZones'], 3);
      expect(json['cooldown'], 10);
      expect(json['ignoreIfCounted'], false);

      final zoneFromJson = ZoneMeta.fromJson(json);
      expect(zoneFromJson, isA<ZoneMeta>());
      expect(zoneFromJson, zone);
      expect(zoneFromJson.toString(), zone.toString());
      expect(zoneFromJson.hashCode, zone.hashCode);
      expect(zoneFromJson.runtimeType, zone.runtimeType);
    });
  });
}
