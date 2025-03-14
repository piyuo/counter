import 'package:flutter_test/flutter_test.dart';
import 'log.dart';

void main() {
  group('[log]', () {
    test('should log', () async {
      // ignore: invalid_use_of_visible_for_testing_member
      log('hi');
    });

    test('should error', () async {
      // ignore: invalid_use_of_visible_for_testing_member
      try {
        throw Exception('my error');
      } catch (e, s) {
        error(e, s);
      }
    });

    test('should beautify stack trace', () async {
      try {
        throw Exception('hi');
      } catch (e, s) {
        String text = beautyStack(s);
        expect(text.length, greaterThan(0));
      }
    });

    test('should beautify stack line', () async {
      var l = '#0      main.<anonymous closure>.<anonymous closure> (file://libcli/test/log/log_test.dart:34:9)';
      // ignore: invalid_use_of_visible_for_testing_member
      expect(beautyLine(l), 'at main.. (file://libcli/test/log/log_test.dart:34:9)');

      l = 'package:libcli/command.dart 46:15 post.<fn>';
      // ignore: invalid_use_of_visible_for_testing_member
      expect(beautyLine(l), 'at package:libcli/command.dart (46:15_post.<fn>)');
    });

    test('should turn object into string', () async {
      String str = toString(MockObject);
      expect(str, isNotEmpty);
    });

    test('should get last message', () async {
      try {
        throw Exception('hi');
      } catch (e, s) {
        error(e, s);
        expect(lastException, isNotNull);
        expect(lastStackTrace, isNotEmpty);
        expect(lastExceptionMessage, 'hi');
      }
    });
  });
}

class MockObject {
  int value = 0;
  Map toJson() {
    return {'value': value};
  }
}
