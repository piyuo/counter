import 'dart:convert';

import 'package:counter/app/app.dart' as app;
import 'package:vision/vision.dart' as vision;

import 'database.dart';
import 'meta.dart';
import 'meta/project_meta.dart';

class DataManager {
  final AppDatabase appDatabase = AppDatabase();

  /// the add activity count, used to delete old activities
  int _addActivityCount = 0;

  /// get recent activities for a project that in the last 24 hours
  Future<List<Activity>> getRecentProjectActivities(String projectId) async {
    final cutOffTime = DateTime.now().subtract(const Duration(days: 1));
    return await appDatabase.getProjectActivities(projectId, cutOffTime);
  }

  /// Add activity to database.
  Future<void> addActivity(String projectId, int videoId, int zoneId, int classId, vision.Activity activity) async {
    await appDatabase.addActivity(projectId, videoId, zoneId, classId, activity);
    _addActivityCount++;
    // if new activities are added more than 120 times (2 hours)
    if (_addActivityCount > 120) {
      _addActivityCount = 0;

      /// delete activities older than 1 day
      await deleteActivitiesOlderThan(DateTime.now().subtract(const Duration(days: 1)));
    }
  }

  Future<void> deleteActivitiesOlderThan(DateTime date) async {
    await appDatabase.deleteActivitiesOlderThan(date);
  }

  /// Save project to database, replacing existing project if it exists.
  Future<void> setProject(app.Project project) async {
    final projectMeta = projectToMeta(project);
    final jsonMap = projectMeta.toJson();
    final jsonString = jsonEncode(jsonMap);

    await appDatabase.setProject(project.projectId, project.projectName, jsonString);
  }

  /// get project summaries without the data blob.
  Future<List<app.ProjectSummary>> getProjectSummaries() async {
    return await appDatabase.getProjectSummaries();
  }

  // Returns a stream of project summaries that updates whenever the projects table changes.
  Stream<List<app.ProjectSummary>> watchProjectSummaries() {
    return appDatabase.watchProjectSummaries();
  }

  /// Get project by its ID.
  Future<app.Project?> getProjectById(String projectId) async {
    final project = await appDatabase.getProjectById(projectId);
    if (project == null) {
      return null;
    }
    final decodedJson = jsonDecode(utf8.decode(project.data));
    final projectMeta = ProjectMeta.fromJson(decodedJson);
    return metaToProject(projectMeta);
  }

  /// Delete project from database.
  Future<void> deleteProject(String projectId) async {
    await appDatabase.deleteProject(projectId);
  }
}
