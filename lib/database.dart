import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class TodoItems extends Table {
  TextColumn get title => text().withLength(min: 6, max: 32)();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

@DriftDatabase(tables: [TodoItems])
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
      print('Opening database at $dbPath');
      final file = File(dbPath);
      return NativeDatabase.createInBackground(file);
    });
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
}
