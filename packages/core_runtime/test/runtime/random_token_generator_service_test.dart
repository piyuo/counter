import 'package:core_runtime/core_runtime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RandomTokenGeneratorService.generate', () {
    final service = RandomTokenGeneratorService();

    test('returns 12 characters by default', () {
      final token = service.generate();
      expect(token, hasLength(12));
    });

    test('returns requested length', () {
      final shortToken = service.generate(length: 6);
      final mediumToken = service.generate(length: 16);

      expect(shortToken, hasLength(6));
      expect(mediumToken, hasLength(16));
    });

    test('uses only URL-safe characters from configured alphabet', () {
      final token = service.generate(length: 12);

      expect(token, matches(RegExp(r'^[2-9a-hj-km-np-z]+$')));
      expect(token, isNot(contains('0')));
      expect(token, isNot(contains('1')));
      expect(token, isNot(contains('i')));
      expect(token, isNot(contains('l')));
      expect(token, isNot(contains('o')));
    });
  });
}
