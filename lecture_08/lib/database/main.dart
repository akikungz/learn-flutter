import 'package:lecture_08/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = '${databasesPath}demo.db';
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        password TEXT,
        weight REAL,
        height REAL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var dbClient = await db;
    return await dbClient!.insert('users', row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    var dbClient = await db;
    return await dbClient!.query('users');
  }

  Future<int> update(Map<String, dynamic> row) async {
    var dbClient = await db;
    return await dbClient!.update(
      'users',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.delete('users');
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }

  Future<void> clear() async {
    var dbClient = await db;
    await dbClient!.delete('users');
  }

  Future<void> insertUsers(User user) async {
    var dbClient = await db;
    await dbClient!.insert('users', user.toMap());
  }

  Future<List<User>> queryAllUsers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient!.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        password: maps[i]['password'],
        weight: maps[i]['weight'],
        height: maps[i]['height'],
        createdAt: maps[i]['created_at'],
      );
    });
  }

  Future<void> updateUsers(User user) async {
    var dbClient = await db;
    await dbClient!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUsers(int id) async {
    var dbClient = await db;
    await dbClient!.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearUsers() async {
    var dbClient = await db;
    await dbClient!.delete('users');
  }
}
