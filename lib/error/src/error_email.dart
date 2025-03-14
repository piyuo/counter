import 'dart:convert';
import 'dart:core';

import 'package:counter/log/log.dart' as log;

import 'net.dart';

class ErrorEmail {
  final String _subject = 'Report an error';

  final String _body = '''


Debug Information
------------------------------------------------
''';

  String get encodedLogs {
    String logs = log.printLogs();
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(logs);
  }

  void launchMailTo() async {
    openMailTo(
      'service@piyuo.com',
      _subject,
      _body.replaceAll('\n', '%0D%0A') + encodedLogs,
    );
  }
}
