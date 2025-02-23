import 'dart:convert';

import 'package:counter/app/app.dart' as app;

import 'database.dart';
import 'meta.dart';
import 'meta/project_meta.dart';

class DataManager {
  final AppDatabase appDatabase = AppDatabase();

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
