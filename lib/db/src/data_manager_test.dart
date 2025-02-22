// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:counter/app/app.dart' as app;
import 'package:counter/db/src/data_manager.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:vision/vision.dart' as vision;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up the mock for getApplicationDocumentsDirectory.
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel,
      (MethodCall call) async {
    if (call.method == 'getApplicationDocumentsDirectory') {
      return Directory.systemTemp.path;
    }
    return null;
  });

  setUp(() async {});

  group('[data_manager.test]', () {
    test('should save, retrieve, and delete a project', () async {
      final dataManager = DataManager();

      // Create a dummy project.
      final dummyProject = app.Project(
        projectName: 'DataManager Test Project',
        model: vision.Models.onnx_640,
        videos: [], // empty videos list
      );
      // Force a known projectId.
      dummyProject.projectId = 'dm_test_1';

      // Save the project.
      await dataManager.setProject(dummyProject);

      // Retrieve the project.
      final retrievedProject = await dataManager.getProject('dm_test_1');
      expect(retrievedProject, isNotNull);
      expect(retrievedProject!.projectId, dummyProject.projectId);
      expect(retrievedProject.projectName, dummyProject.projectName);

      // Retrieve project summaries.
      final summaries = await dataManager.getAllProjectRows();
      final summary = summaries.where((row) => row.projectId == 'dm_test_1').first;
      expect(summary, isNotNull);
      expect(summary.projectName, dummyProject.projectName);

      // Delete the project.
      await dataManager.deleteProject('dm_test_1');

      // Verify deletion.
      final deletedProject = await dataManager.getProject('dm_test_1');
      expect(deletedProject, isNull);

      final remainingSummaries = await dataManager.getAllProjectRows();
      final deletedSummary = remainingSummaries.where((row) => row.projectId == 'dm_test_1');
      expect(deletedSummary, isEmpty);

      // Clean up the database.
      await dataManager.appDatabase.close();
    });
  });
}
