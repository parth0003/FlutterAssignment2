import 'package:flutter/material.dart';
import 'package:flutter_assignment2/data/model/employee_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseConnection {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        employee_name TEXT,
        employee_role TEXT,
        start_date TIMESTAMP,
        end_date TIMESTAMP
        )
        """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbemployee.db',
      version: 1,
      onCreate: (db, version) async {
        await createTable(db);
      },
    );
  }

  static Future<int> createEmployee(EmployeeModel employeeModel) async {
    final db = await DatabaseConnection.db();

    final data = employeeModel.toMap();
    final id = await db.insert("employees", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getEmployees() async {
    final db = await DatabaseConnection.db();
    return db.query("employees", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getEmployee(int id) async {
    final db = await DatabaseConnection.db();
    return db.query("employees", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateEmployee(EmployeeModel employeeModel) async {
    final db = await DatabaseConnection.db();

    final data = employeeModel.toMap();
    final result = await db.update("employees", data, where: "id = ?", whereArgs: [(employeeModel.id ?? 0)]);

    return result;
  }

  static Future<void> deleteEmployee (int id) async{
    final db = await DatabaseConnection.db();

    try{
      await db.delete("employees", where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("DataBase Error ---> $e");
    }
  }
}
