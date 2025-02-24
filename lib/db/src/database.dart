import 'dart:convert';
import 'dart:io';

import 'package:counter/app/app.dart' as app;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/// This is the table that stores project data.
class Projects extends Table {
  TextColumn get projectId => text().withLength(min: 1, max: 32)();
  TextColumn get projectName => text().withLength(min: 1, max: 256)();
  BlobColumn get data => blob()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

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
          projectName: Value(name),
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
  Future<Project?> getProjectById(String projectId) async {
    final query = select(projects)..where((p) => p.projectId.equals(projectId));
    final rows = await query.get();
    return rows.isNotEmpty ? rows.first : null;
  }

  /// delete project from database
  Future<void> deleteProject(String projectId) async {
    await (delete(projects)..where((p) => p.projectId.equals(projectId))).go();
  }

  // Returns a stream of project summaries that updates whenever the projects table changes.
  Stream<List<app.ProjectSummary>> watchProjectSummaries() {
    final query = selectOnly(projects)
      ..addColumns([
        projects.projectId,
        projects.projectName,
        projects.createdAt,
        projects.updatedAt,
      ]);

    // Convert the query to a stream that watches for changes
    return query.watch().map((rows) => rows
        .map((row) => app.ProjectSummary(
              projectId: row.read(projects.projectId)!,
              projectName: row.read(projects.projectName)!,
              createdAt: row.read(projects.createdAt)!,
              updatedAt: row.read(projects.updatedAt)!,
            ))
        .toList());
  }

  /// get project summaries without the data blob.
  Future<List<app.ProjectSummary>> getProjectSummaries() async {
    final query = selectOnly(projects)
      ..addColumns([
        projects.projectId,
        projects.projectName,
        projects.createdAt,
        projects.updatedAt,
      ]);
    final rows = await query.get();
    return rows
        .map((row) => app.ProjectSummary(
              projectId: row.read(projects.projectId)!,
              projectName: row.read(projects.projectName)!,
              createdAt: row.read(projects.createdAt)!,
              updatedAt: row.read(projects.updatedAt)!,
            ))
        .toList();
  }
}
