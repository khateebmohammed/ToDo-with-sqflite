import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'Mohammed_Ali.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("ALTER TABLE notes ADD COLUMN des TEXT");
    print("_onUpgrade=====================================");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY,type TEXT, note TEXT,des TEXT,date TEXT)');
    batch.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT,email TEXT,password TEXT)');
    await batch.commit();

    print("_onCreate=====================================");
  }

  readData(String sql) async {
    Database? myDB = await db;
    List<Map<String, Object?>> response = await myDB!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawUpdate(sql);
    return response;
  }
}
