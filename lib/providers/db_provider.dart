import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/models.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  static Database? _database;
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      //await db.execute('ALTER TABLE ventas ADD COLUMN tasa DOUBLE');
    }
  }

  Future<String> getDBroute() async {
    final directorio = await getApplicationDocumentsDirectory();
    return '${directorio.path}/GymApp';
  }

  Future<Database> initDB() async {
    final route = await getDBroute();
    final folder = Directory(route);
    await folder.create(recursive: true);

    final folderImages = Directory('$route/Images');
    await folderImages.create(recursive: true);

    // Path de donde almacenaremos la base de datos

    final path = join(route, 'GymApp.db');

    // Crear base de datos
    return await openDatabase(path, onOpen: (db) {}, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE customers(
            id INTEGER PRIMARY KEY,
            id_card TEXT,
            name TEXT,
            second_name TEXT,
            email TEXT,
            phone TEXT,
            city TEXT,
            image TEXT,
            register_date TEXT,
            notes TEXT
          )
        ''');
    });
  }

  Future<int> insertCustomer(Customer customer) async {
    final db = await database;
    return await db.insert('customers', customer.toJson());
  }

  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final result = await db.query('customers');
    return result.map((json) => Customer.fromJson(json)).toList();
  }

  Future<int> deleteCustomer(int id) async {
    final db = await database;
    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCustomer(Customer customer) async {
    final db = await database;
    return await db.update(
      'customers',
      customer.toJson(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }
}
