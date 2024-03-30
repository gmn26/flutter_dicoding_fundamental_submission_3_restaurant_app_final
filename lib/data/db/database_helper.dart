import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/model/restaurant_favorite_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableName = 'favorite';
  static const String _fileDBName = 'restaurant.db';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/$_fileDBName',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableName (
             id VARCHAR(255) PRIMARY KEY,
             name VARCHAR(255),
             description TEXT,
             pictureId VARCHAR(255),
             city VARCHAR(255),
             rating DOUBLE(3,1)
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> addFavorite(FavoriteRestaurant favorite) async {
    final db = await database;
    await db!.insert(_tableName, favorite.toJson());
  }

  Future<List<FavoriteRestaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableName);

    return results.map((res) => FavoriteRestaurant.fromJson(res)).toList();
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> checkFavorite(String id) async {
    final db = await database;

    final result = await db!.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
