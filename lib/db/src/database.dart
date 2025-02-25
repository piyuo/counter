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
  int get schemaVersion => 5;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      String dbPath = path.join(dbFolder.path, 'db.sqlite');
      final file = File(dbPath);
      return NativeDatabase.createInBackground(file);
    });
  }

  /// get all activities for a project that are older than the given date
  Future<List<Activity>> getProjectActivities(String projectId, DateTime cutOffTime) async {
    final query = select(activities)
      ..where((a) => a.projectId.equals(projectId) & a.createdAt.isBiggerOrEqualValue(cutOffTime));
    return query.get();
  }

  /// add activity to database
  Future<void> addActivity(String projectId, int videoId, int zoneId, int classId, vision.Activity activity) async {
    await into(activities).insert(ActivitiesCompanion(
      projectId: Value(projectId),
      videoId: Value(videoId),
      zoneId: Value(zoneId),
      classId: Value(classId),
      createdAt: Value(DateTime.now()),
      spawned: Value(activity.spawned),
      vanished: Value(activity.vanished),
      entered: Value(activity.entered),
      exited: Value(activity.exited),
      stagnant: Value(activity.stagnant),
      reentered: Value(activity.reentered),
      occupied: Value(activity.occupied),
      stayDuration: Value(activity.stayDuration),
    ));
  }

  /// delete activities older than the given date
  Future<void> deleteActivitiesOlderThan(DateTime date) async {
    // Query the records that should be deleted first.
    final recordsToDelete = await (select(activities)
          ..where((a) => a.createdAt.isSmallerThanValue(date))
          ..limit(100))
        .get();

    // If there are records to delete...
    if (recordsToDelete.isNotEmpty) {
      // Extract the IDs of these records.
      final idsToDelete = recordsToDelete.map((a) => a.id).toList();

      // Delete these records by their IDs.
      await (delete(activities)..where((a) => a.id.isIn(idsToDelete))).go();
    }
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
      ])
      ..orderBy([OrderingTerm.desc(projects.updatedAt)]);
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
