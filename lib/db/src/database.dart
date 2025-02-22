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
  Future<void> saveProject(String id, String name, String data) async {
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

  /// get all project from database
  Future<List<Project>> getAllProjects() async {
    return await select(projects).get();
  }

  /// delete project from database
  Future<void> deleteProject(String projectId) async {
    await (delete(projects)..where((p) => p.projectId.equals(projectId))).go();
  }
}

//final jsonMap = projectMeta.toJson();
//final jsonString = jsonEncode(jsonMap);
/*
, TodoItems
class TodoItems extends Table {
  TextColumn get title => text().withLength(min: 6, max: 32)();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

  Future<int> insertItem(String title) {
    return into(todoItems).insert(TodoItem(
      title: title,
      createdAt: DateTime.now(),
    ));
  }

  Future<List<TodoItem>> getAllItems() {
    return select(todoItems).get();
  }

 */
