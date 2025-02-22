import 'package:drift/drift.dart';

class Projects extends Table {
  TextColumn get projectId => text().withLength(min: 1, max: 32)();
  TextColumn get projectName => text().withLength(min: 1, max: 256)();
  BlobColumn get data => blob()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/*
class ProjectItem {
  ProjectItem({
    required this.projectId,
    required this.projectName,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });
  String projectId;
  String projectName;
  String data;
  DateTime createdAt;
  DateTime updatedAt;
}
*/
