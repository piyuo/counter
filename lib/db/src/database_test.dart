// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';
import 'dart:io';

import 'package:counter/db/src/database.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize bindings

  // Replace deprecated setMockMethodCallHandler with:
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel,
      (MethodCall call) async {
    if (call.method == 'getApplicationDocumentsDirectory') {
      return Directory.systemTemp.path;
    }
    return null;
  });

  setUp(() async {});

  group('[database.test]', () {
    test('should save, retrieve, and delete a project', () async {
      final db = AppDatabase();

      // Create dummy project id and JSON string.
      const String projectId = 'proj_test1';
      const String projectName = 'Test Project';
      const String jsonString =
          '{"projectId": "proj_test1", "projectName": "Test Project", "dummyField": "dummyValue"}';

      // Save the project.
      await db.saveProject(projectId, projectName, jsonString);

      // Retrieve all project rows.
      final rows = await db.getAllProjects();
      expect(rows, isNotEmpty);

      // Locate saved row.
      final savedRow = rows.where((row) => row.projectId == projectId).first;
      expect(savedRow, isNotNull);

      // Decode stored data.
      final decodedJson = jsonDecode(utf8.decode(savedRow.data));
      expect(decodedJson['projectId'], projectId);
      expect(decodedJson['projectName'], 'Test Project');

      // Delete the project.
      await db.deleteProject(projectId);

      // Verify deletion.
      final remainingRows = await db.getAllProjects();
      final deleted = remainingRows.where((row) => row.projectId == projectId);
      expect(deleted, isEmpty);

      await db.close();
    });
  });
}
