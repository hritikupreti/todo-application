import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabse);
    return database;
  }

  _onCreatingDatabse(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY  NOT NULL, name TEXT, description TEXT)");

    await database.execute(
        "CREATE TABLE todo(id INTEGER PRIMARY KEY NOT NULL, title TEXT, description TEXT,category TEXT, isfilled INTEGER)");
  }
}
