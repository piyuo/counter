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

  /// delete the project temp media file in app directory, save by [saveFileToAppDirectory]
  Future<void> deleteProjectInAppDirectory(String projectId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final projectDir = Directory('${appDir.path}/$projectId');
    if (await projectDir.exists()) {
      await projectDir.delete(recursive: true);
    }
  }

  /// get all activities for a project that are older than the given date
  Future<List<Activity>> getProjectActivities(String projectId, DateTime cutOffTime) async {
    final query = select(activities)
      ..where((a) => a.projectId.equals(projectId) & a.createdAt.isBiggerOrEqualValue(cutOffTime))
      ..orderBy([(a) => OrderingTerm(expression: a.createdAt)]);
    return query.get();
  }

  /// add activity to database
  /// add activity to database
  /// add activity to database
  Future<void> addActivity(String projectId, int videoId, int zoneId, int classId, vision.Activity activity) async {
    await transaction(() async {
      // Check for an existing record with the same identifiers and createdAt timestamp.
      final existingActivity = await (select(activities)
            ..where((a) =>
                a.projectId.equals(projectId) &
                a.videoId.equals(videoId) &
                a.zoneId.equals(zoneId) &
                a.classId.equals(classId) &
                a.createdAt.equals(activity.createdAt)))
          .getSingleOrNull();

      if (existingActivity != null) {
        // If record exists, update the existing record by summing the counts.
        await (update(activities)..where((a) => a.id.equals(existingActivity.id))).write(
          ActivitiesCompanion(
            spawned: Value(existingActivity.spawned + activity.spawned),
            vanished: Value(existingActivity.vanished + activity.vanished),
            entered: Value(existingActivity.entered + activity.entered),
            exited: Value(existingActivity.exited + activity.exited),
            stagnant: Value(existingActivity.stagnant + activity.stagnant),
            reentered: Value(existingActivity.reentered + activity.reentered),
            occupied: Value(activity.occupied),
            stayDuration: Value(activity.stayDuration),
          ),
        );
      } else {
        // If no existing record is found, insert a new activity.
        await into(activities).insert(ActivitiesCompanion(
          projectId: Value(projectId),
          videoId: Value(videoId),
          zoneId: Value(zoneId),
          classId: Value(classId),
          createdAt: Value(activity.createdAt),
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
    });
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

  /// delete activities in a project
  Future<void> deleteActivitiesInProject(String projectId) async {
    await (delete(activities)..where((a) => a.projectId.equals(projectId))).go();
  }

  /// delete all activities for a project
  Future<void> deleteActivities(String projectId) {
    return (delete(activities)..where((a) => a.projectId.equals(projectId))).go();
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

    // before return data, update updatedAt
    if (rows.isNotEmpty) {
      await (update(projects)..where((p) => p.projectId.equals(projectId))).write(ProjectsCompanion(
        updatedAt: Value(DateTime.now()),
      ));
    }

    return rows.isNotEmpty ? rows.first : null;
  }

  /// delete project from database
  Future<void> deleteProject(String projectId) async {
    await transaction(() async {
      await (delete(projects)..where((p) => p.projectId.equals(projectId))).go();
      await deleteActivities(projectId);
    });
    await deleteProjectInAppDirectory(projectId);
  }

  /// Enforces a project limit to prevent exceeding system capacity.
  ///
  /// When the total number of projects exceeds [maxCount],
  /// only the oldest project is deleted to ensure efficient operation and fast startup.
  Future<void> enforceProjectLimit(int maxCount) async {
    // Fetch all projects and sort them by updatedAt in ascending order (oldest first).
    final query = select(projects)..orderBy([(t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.asc)]);

    final allProjects = await query.get();

    // If the number of projects exceeds the limit, delete the oldest project.
    if (allProjects.length > maxCount) {
      // Get the oldest project (the first one in the list).
      final oldestProject = allProjects.first;
      // Delete this oldest project.
      await deleteProject(oldestProject.projectId);
    }
  }

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
      ..orderBy([OrderingTerm(expression: projects.updatedAt, mode: OrderingMode.desc)]);
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
