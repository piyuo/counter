import 'dart:convert';

import 'package:counter/app/app.dart' as app;

import 'database.dart';
import 'meta.dart';
import 'meta/project_meta.dart';
import 'projects.dart';

class DataManager {
  final AppDatabase appDatabase = AppDatabase();

  /// Save project to database, replacing existing project if it exists.
  Future<void> setProject(app.Project project) async {
    final projectMeta = projectToMeta(project);
    final jsonMap = projectMeta.toJson();
    final jsonString = jsonEncode(jsonMap);

    await appDatabase.setProject(project.projectId, project.projectName, jsonString);
  }

  /// Retrieve all projects from the database.
  Future<List<ProjectRow>> getAllProjectRows() async {
    return await appDatabase.getAllProjectRows();
  }

  Future<app.Project?> getProject(String projectId) async {
    final project = await appDatabase.getProject(projectId);
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
