// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

import 'time_of_day_meta.dart';

void main() {
  setUp(() async {});

  group('[time_of_day.test]', () {
    test('should convert to string', () async {
      final timeMeta = TimeOfDayMeta(
        hour: 12,
        minute: 30,
      );
      final json = timeMeta.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['hour'], 12);
      expect(json['minute'], 30);

      final timeMetaFromJson = TimeOfDayMeta.fromJson(json);
      expect(timeMetaFromJson, isA<TimeOfDayMeta>());
      expect(timeMetaFromJson, timeMeta);
      expect(timeMetaFromJson.toString(), timeMeta.toString());
      expect(timeMetaFromJson.hashCode, timeMeta.hashCode);
      expect(timeMetaFromJson.runtimeType, timeMeta.runtimeType);
    });
  });
}
