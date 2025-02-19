import 'dart:convert';
import 'package:uuid/uuid.dart';

/// uuid create UUID in string format, it use time base v1 UUID to avoid collision on old data
/// ```dart
/// final id = uuid();
/// ```
String uuid() {
  var bytes = List<int>.filled(16, 0, growable: false);
  const Uuid().v1buffer(bytes);
  String text = base64Url.encode(bytes);
  return text.substring(0, text.length - 2);
}
