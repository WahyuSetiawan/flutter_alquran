import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/bookmark.dart';

class DatabaseBookmark {
  DatabaseBookmark._();

  static final DatabaseBookmark db = DatabaseBookmark._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "database_bookmark.db"),
      onCreate: (db, version) async {
        return await db.execute('''
            CREATE TABLE bookmark(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                jsonChapter TEXT NOT NULL,
                jsonVerses TEXT NOT NULL, 
                numberVerse INTEGER NOT NULL
            )
          ''');
      },
      version: 1,
    );
  }

  Future<List<BookmarkModel>> get allBookmark async {
    Database db = await database;

    List<BookmarkModel> bookmarkModels = [];

    var dataQuery = await db.query("bookmark");

    if (dataQuery.isNotEmpty) {
      bookmarkModels = dataQuery.map((e) => BookmarkModel.fromMap(e)).toList();
    }

    return bookmarkModels;
  }

  Future<int> insertBookmark(BookmarkModel bookmarkModel) async {
    var db = await database;

    return await db.insert("bookmark", bookmarkModel.toMap());
  }

  Future<int> deleteBookmark(int id) async {
    var db = await database;

    return await db
        .delete("bookmark", where: "id = ?", whereArgs: [id.toString()]);
  }
}
