
import 'package:advflutterexam/Modal/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static final DatabaseHelper databaseHelper = DatabaseHelper._();
  factory DatabaseHelper() => databaseHelper;

  DatabaseHelper._();

  static Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await initDatabase();
    return db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'Note.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date_created TEXT,category TEXT,priority TEXT)',
    );
  }

  Future<int> insertContact(Note note) async {
    Database db = await database;
    return await db.insert('Note', note.toMap());
  }

  Future<List<Note>> getContacts({String? query}) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps;
    if (query != null && query.isNotEmpty) {
      maps = await db.query(
        'Note',
        where: 'title LIKE ?',
        whereArgs: ['%$query%'],
      );
    } else {
      maps = await db.query('Note');
    }
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        dateCreated: maps[i]['date_created'],
        category: maps[i]['category'],
        priority: maps[i]['priority'],
      );
    });
  }

  Future<int> updateContact(Note note) async {
    Database db = await database;
    return await db.update(
      'Note',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('Note', where: 'id = ?', whereArgs: [id]);
  }
Future<List<Map<String, Object?>>> selectData(String email,String category)
async {
  final db=await database;
  String sql='''
  SELECT * FROM Note WHERE email=? AND category=?;
  ''';
  List args=[email,category];
  return await db!.rawQuery(sql,args);
}

}