import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:vision/vision.dart' as vision;

import 'project_summary.dart';
import 'table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Projects, Activities])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      String dbPath = path.join(dbFolder.path, 'db.sqlite');
      final file = File(dbPath);
      return NativeDatabase.createInBackground(file);
    });
  }

  int addActivityCount = 0;

  /// add activity to database
  Future<void> addActivity(String projectId, int videoId, int zoneId, vision.Activity activity) async {
    await into(activities).insert(ActivitiesCompanion(
      projectId: Value(projectId),
      videoId: Value(videoId),
      zoneId: Value(zoneId),
      createdAt: Value(DateTime.now().toUtc()),
      spawned: Value(activity.spawned),
      vanished: Value(activity.vanished),
      entered: Value(activity.entered),
      exited: Value(activity.exited),
      stagnant: Value(activity.stagnant),
      reentered: Value(activity.reentered),
      occupied: Value(activity.occupied),
      stayDuration: Value(activity.stayDuration),
    ));

    addActivityCount++;
    if (addActivityCount > 60) {
      addActivityCount = 0;

      /// delete activities older than 1 day
      await deleteActivitiesOlderThan(DateTime.now().subtract(const Duration(days: 1)).toUtc());
    }
  }

  /// delete activities older than the given date
  Future<void> deleteActivitiesOlderThan(DateTime date) async {
    await customStatement(
      'DELETE FROM activities WHERE createdAt < ? LIMIT 100',
      [date.toIso8601String()],
    );
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
  Stream<List<ProjectSummary>> watchProjectSummaries() {
    final query = selectOnly(projects)
      ..addColumns([
        projects.projectId,
        projects.projectName,
        projects.createdAt,
        projects.updatedAt,
      ]);

    // Convert the query to a stream that watches for changes
    return query.watch().map((rows) => rows
        .map((row) => ProjectSummary(
              projectId: row.read(projects.projectId)!,
              projectName: row.read(projects.projectName)!,
              createdAt: row.read(projects.createdAt)!,
              updatedAt: row.read(projects.updatedAt)!,
            ))
        .toList());
  }

  /// get project summaries without the data blob.
  Future<List<ProjectSummary>> getProjectSummaries() async {
    final query = selectOnly(projects)
      ..addColumns([
        projects.projectId,
        projects.projectName,
        projects.createdAt,
        projects.updatedAt,
      ]);
    final rows = await query.get();
    return rows
        .map((row) => ProjectSummary(
              projectId: row.read(projects.projectId)!,
              projectName: row.read(projects.projectName)!,
              createdAt: row.read(projects.createdAt)!,
              updatedAt: row.read(projects.updatedAt)!,
            ))
        .toList();
  }
}
