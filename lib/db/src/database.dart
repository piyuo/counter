import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'projects.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Projects])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      String dbPath = path.join(dbFolder.path, 'db.sqlite');
      //print('Opening database at $dbPath');
      final file = File(dbPath);
      return NativeDatabase.createInBackground(file);
    });
  }

  /// add project to database
  Future<void> setProject(String id, String name, String data) async {
    Uint8List bytes = Uint8List.fromList(utf8.encode(data));
    await transaction(() async {
      final existingProject = await (select(projects)..where((p) => p.projectId.equals(id))).getSingleOrNull();
      if (existingProject != null) {
        return (update(projects)..where((p) => p.projectId.equals(id))).write(ProjectsCompanion(
          data: Value(bytes),
          updatedAt: Value(DateTime.now()),
        ));
      } else {
        return into(projects).insert(ProjectsCompanion(
          projectId: Value(id),
          projectName: Value(name),
          data: Value(bytes),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ));
      }
    });
  }

  /// get project by it's id
  Future<Project?> getProject(String projectId) async {
    final query = select(projects)..where((p) => p.projectId.equals(projectId));
    final rows = await query.get();
    return rows.isNotEmpty ? rows.first : null;
  }

  /// delete project from database
  Future<void> deleteProject(String projectId) async {
    await (delete(projects)..where((p) => p.projectId.equals(projectId))).go();
  }

  /// Get project summaries without the data blob.
  Future<List<ProjectRow>> getAllProjectRows() async {
    final query = selectOnly(projects)
      ..addColumns([
        projects.projectId,
        projects.projectName,
        projects.createdAt,
        projects.updatedAt,
      ]);
    final rows = await query.get();
    return rows
        .map((row) => ProjectRow(
              projectId: row.read(projects.projectId)!,
              projectName: row.read(projects.projectName)!,
              createdAt: row.read(projects.createdAt)!,
              updatedAt: row.read(projects.updatedAt)!,
            ))
        .toList();
  }
}
