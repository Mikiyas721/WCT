import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseManager {
  Database database;
  static DataBaseManager _instance = DataBaseManager();

  static DataBaseManager get instance => _instance;

  void openDataBase() async {
    final database = await openDatabase('userData.db');
  }

  void createTable() {
    try {
      database.execute('CREATE TABLE userdata (date VARCHAR, consumed DOUBLE, remaining DOUBLE)');
    } catch (exception) {
      debugPrint(exception);
    }
  }

  void addDataIntoTable(String date, double consumed, double remaining) {
    try {
      database.execute(
          'INSERT INTO TABLE userdata (date VARCHAR, consumed DOUBLE, remaining DOUBLE) VALUES ($date, $consumed, $remaining)');
    } catch (exception) {
      debugPrint(exception);
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> data;
    try {
      data = await database.rawQuery('SELECT * FROM userdata');
    } catch (exception) {
      debugPrint(exception);
    }
    return data;
  }

  void closeDataBase() async {
    try {
      await database.close();
    } catch (exception) {
      debugPrint(exception);
    }
  }
}
