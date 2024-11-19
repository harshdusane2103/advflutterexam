import 'package:advflutterexam/Model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


      class DbHelper {
      static DbHelper dbHelper = DbHelper._();
      DbHelper._();
      Database? _db;

      Future get database async => _db ?? await initDatabase();

      Future initDatabase() async {
      final path = await getDatabasesPath();
      final dbPath = join(path, 'habit.db');

      _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
      String sql = '''CREATE TABLE habit(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        days INTEGER NOT NULL,
        progress TEXT NOT NULL
       );
        ''';
      await db.execute(sql);
      },
      );
      return _db;
      }

      Future<int>insertData(HabitModal habit)  async {
      Database? db = await database;
      String sql = '''INSERT INTO habit (id,name,days,progress)
    VALUES (?,?,?,?);
    ''';
      List args = [habit.id,habit.name,habit.days,habit.progress];
      return await db!.rawInsert(sql, args);
      }

      Future<List<Map<String, Object?>>> readData() async {
      Database? db = await database;
      String sql = '''SELECT * FROM habit''';
      return await db!.rawQuery(sql);
      }


      Future<void> updateData( habit ,int id)
      async {
      Database? db =await database;
      String sql=''' UPDATE habit SET id=?,name=?,days=?,progress=?''';
      List args=[habit.id,habit.name,habit.days,habit.progress];
      await db!.rawUpdate(sql,args);
      }

      Future deleteData(int id) async {
      Database? db = await database;
      String sql = '''DELETE FROM habit WHERE id = ?''';
      List args = [id];
      await db!.rawDelete(sql, args);
      }

      }
