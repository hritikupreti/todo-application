// ignore_for_file: unnecessary_null_comparison, await_only_futures

import 'package:sqflite/sqflite.dart';
import 'package:todo_list/repositories/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

//GETTER METHOD FOR CHECKING IF DATABASE EXIST OR NOT....
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

//INSERTING DATA TO TABLE......
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //READ DATA FROM TABLE......
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //READ DATA FORM TABLE BY ID......
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

//UPDATE DATA......
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

//DELETE DATA
  deleteData(table, id) async {
    var connection = await database;
    return await connection?.delete(table, where: 'id=?', whereArgs: [id]);
  }
}
