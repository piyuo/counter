// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up the mock for getApplicationSupportDirectory.
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
    MethodCall call,
  ) async {
    if (call.method == 'getApplicationSupportDirectory') {
      return Directory.systemTemp.path;
    }
    return null;
  });

  setUp(() async {});

  group('[data_manager.test]', () {
    test('should save, retrieve, and delete a project', () async {});
  });
}
