import 'dart:convert';

import 'package:counter/app/app.dart' as app;
import 'package:vision/vision.dart' as vision;

import 'database.dart';
import 'meta.dart';
import 'meta/project_meta.dart';

/// The maximum number of projects allowed in the database.
const _maxAllowedProjectCount = 20;

class DataManager {
  final AppDatabase appDatabase = AppDatabase();

  /// the add activity count, used to delete old activities
  int _addActivityCount = 0;

  /// maintain the database, delete old data
  Future<void> maintainDatabase() async {
    // add random to avoid check every time
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    if (random > 30) {
      return;
    }

    // wait for 10 seconds for app to start
    await Future.delayed(const Duration(seconds: 10));

    // keep projects count to 20;
    await appDatabase.enforceProjectLimit(_maxAllowedProjectCount);
  }

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
      await deleteActivitiesOlderThanOneDay();
    }
  }

  /// delete activities in a project
  Future<void> deleteActivitiesInProject(String projectId) async {
    await appDatabase.deleteActivitiesInProject(projectId);
  }

  /// delete activities older than 1 day
  Future<void> deleteActivitiesOlderThanOneDay() async {
    await deleteActivitiesOlderThan(DateTime.now().subtract(const Duration(days: 1)));
  }

  /// delete activities older than 1 day
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
