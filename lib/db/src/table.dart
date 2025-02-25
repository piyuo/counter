import 'package:drift/drift.dart';

/// This is the table that stores project data.
@TableIndex(name: 'idx_projects_project_id', columns: {#projectId})
@TableIndex(name: 'idx_projects_created_at', columns: {#createdAt})
class Projects extends Table {
  TextColumn get projectId => text().withLength(min: 1, max: 22)();
  TextColumn get projectName => text().withLength(min: 1, max: 256)();
  BlobColumn get data => blob()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {projectId}; // set projectId as PRIMARY KEY
}

/// This is the table that stores activity data.
@TableIndex(name: 'idx_activities_project_created_at', columns: {#projectId, #createdAt})
@TableIndex(name: 'idx_activities_created_at', columns: {#createdAt})
class Activities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectId => text().withLength(min: 1, max: 22)();
  IntColumn get videoId => integer()();
  IntColumn get zoneId => integer()();
  IntColumn get classId => integer()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get spawned => integer()();
  IntColumn get vanished => integer()();
  IntColumn get entered => integer()();
  IntColumn get exited => integer()();
  IntColumn get stagnant => integer()();
  IntColumn get reentered => integer()();
  IntColumn get occupied => integer()();
  IntColumn get stayDuration => integer()();
}
