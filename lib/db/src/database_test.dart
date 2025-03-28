// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';
import 'dart:io';

import 'package:counter/db/src/database.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize bindings

  // Set up the mock for getApplicationSupportDirectory.
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel,
      (MethodCall call) async {
    if (call.method == 'getApplicationSupportDirectory') {
      return Directory.systemTemp.path;
    }
    return null;
  });

  setUp(() async {});

  group('[database.test]', () {
    test('should save, retrieve, and delete a project', () async {
      final db = AppDatabase();

      // Dummy project data.
      const String projectId = 'proj_test1';
      const String projectName = 'Test Project';
      const String jsonString =
          '{"projectId": "proj_test1", "projectName": "Test Project", "dummyField": "dummyValue"}';

      // Save the project.
      await db.setProject(projectId, projectName, jsonString);

      // Retrieve single project using getProject.
      final savedProject = await db.getProjectById(projectId);
      expect(savedProject, isNotNull);

      final decodedJson = jsonDecode(utf8.decode(savedProject!.data));
      expect(decodedJson['projectId'], projectId);
      expect(decodedJson['projectName'], projectName);

      // Retrieve project summaries (without the blob column).
      final summaries = await db.getProjectSummaries();
      expect(summaries, isNotEmpty);
      final summary = summaries.where((row) => row.projectId == projectId).first;
      expect(summary, isNotNull);
      expect(summary.projectName, projectName);

      // Delete the project.
      await db.deleteProject(projectId);

      // Verify deletion via getProject.
      final deletedProject = await db.getProjectById(projectId);
      expect(deletedProject, isNull);

      // Verify deletion via summaries.
      final remainingSummaries = await db.getProjectSummaries();
      final deletedSummary = remainingSummaries.where((row) => row.projectId == projectId);
      expect(deletedSummary, isEmpty);

      await db.close();
    });
  });
}
