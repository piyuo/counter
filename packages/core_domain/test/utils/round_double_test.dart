// TOC
// 1. RoundedDouble conversion

import 'package:core_domain/utils/round_double.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = RoundedDouble();

  group('RoundedDouble', () {
    test('rounds serialized values to two decimal places', () {
      expect(converter.toJson(0.926), 0.93);
      expect(converter.toJson(2.124), 2.12);
    });

    test('serializes whole rounded values as integers', () {
      final roundedWhole = converter.toJson(1.004);

      expect(roundedWhole, 1);
      expect(roundedWhole, isA<int>());
      expect(converter.toJson(1.25), isA<double>());
    });

    test('reads integers and fractional numbers as doubles without rounding', () {
      expect(converter.fromJson(42), 42.0);
      expect(converter.fromJson(0.123456789), 0.123456789);
    });

    test('serializes non-finite values as zero', () {
      expect(converter.toJson(double.nan), 0);
      expect(converter.toJson(double.infinity), 0);
      expect(converter.toJson(double.negativeInfinity), 0);
    });
  });
}
