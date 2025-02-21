// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart';

import 'filter_meta.dart';
import 'time_of_day_meta.dart';

void main() {
  setUp(() async {});

  group('[filter.test]', () {
    test('should convert to string', () async {
      // Use an appropriate FilterType, e.g., FilterType.range
      final filter = FilterMeta(
        type: FilterType.pass1Hour, // adjust according to your FilterType definition
        start: TimeOfDayMeta(hour: 8, minute: 0),
        end: TimeOfDayMeta(hour: 17, minute: 0),
      );
      final json = filter.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['type'], 'pass1Hour');
      expect(json['start'], filter.start.toJson());
      expect(json['end'], filter.end.toJson());

      final filterFromJson = FilterMeta.fromJson(json);
      expect(filterFromJson, isA<FilterMeta>());
      expect(filterFromJson, filter);
      expect(filterFromJson.toString(), filter.toString());
      expect(filterFromJson.hashCode, filter.hashCode);
      expect(filterFromJson.runtimeType, filter.runtimeType);
    });
    // ...other tests...
  });
}
