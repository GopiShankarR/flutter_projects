import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// DBHelper is a Singleton class (only one instance)
class DBHelper {
  static const String _databaseName = 'airplane.db1';
  static const int _databaseVersion = 1;

  DBHelper._();

  static final DBHelper _singleton = DBHelper._();

  factory DBHelper() => _singleton;

  Database? _database;

  get db async {
    _database ??= await _initDatabase();
    
    return _database;
  }

  Future<Database> _initDatabase() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      print(appDocumentsDir.path);
      final dbPath = path.join(appDocumentsDir.path, "databases", "airplanes.db");
          // await deleteDatabase(dbPath);

      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
              CREATE TABLE user_data(
                id INTEGER PRIMARY KEY,
                email TEXT,
                username TEXT,
                password_hash TEXT,
                airline TEXT,
                isLoggedIn INTEGER
              )
            ''');
          },
        ),
      );
      return winLinuxDB;
    } else {
      var dbDir = await getApplicationDocumentsDirectory();

      var dbPath = path.join(dbDir.path, _databaseName);

      // await deleteDatabase(dbPath);

      // open the database
      var db = await openDatabase(
        dbPath, 
        version: _databaseVersion, 

        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE user_data(
              id INTEGER PRIMARY KEY,
              email TEXT,
              username TEXT,
              password_hash TEXT,
              airline TEXT,
              isLoggedIn INTEGER
            )
      ''');
        }
      );

      return db;
    }
  }

  Future<List<Map<String, dynamic>>> query(String table, {String? where}) async {
    final db = await this.db;
    return where == null ? db.query(table)
                         : db.query(table, where: where);
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await this.db;
    int id = await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<void> update(String table, Map<String, dynamic> data, int id) async {
    final db = await this.db;
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    final db = await this.db;
    int userId = await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return userId;
  }

  Future<void> updateData(String table, Map<String, dynamic> data, int userId) async {
    final db = await this.db;
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> delete(String table, int id) async {
    final db = await this.db;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}