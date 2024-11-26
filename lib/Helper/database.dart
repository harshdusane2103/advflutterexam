import 'package:advflutterexam/Model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'exercise.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE exercises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            duration INTEGER,
            date INTEGER,
            type TEXT,
            intensity TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertExercise(ExerciseModel exercise) async {
    final db = await database;
    return await db.insert('exercises', exercise.toMap());
  }

  Future<List<ExerciseModel>> getExercises({String? filter, String? sortBy}) async {
    final db = await database;
    String orderBy = sortBy ?? 'date DESC';
    final result = await db.query(
      'exercises',
      orderBy: orderBy,
    );
    return result.map((map) => ExerciseModel.fromMap(map)).toList();
  }

  Future<int> updateExercise(ExerciseModel exercise) async {
    final db = await database;
    return await db.update(
      'exercises',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<int> deleteExercise(int id) async {
    final db = await database;
    return await db.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
