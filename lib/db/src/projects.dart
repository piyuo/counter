import 'package:drift/drift.dart';

class Projects extends Table {
  TextColumn get projectId => text().withLength(min: 1, max: 32)();
  TextColumn get projectName => text().withLength(min: 1, max: 256)();
  BlobColumn get data => blob()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class ProjectRow {
  ProjectRow({
    required this.projectId,
    required this.projectName,
    required this.createdAt,
    required this.updatedAt,
  });
  String projectId;
  String projectName;
  DateTime createdAt;
  DateTime updatedAt;
}
