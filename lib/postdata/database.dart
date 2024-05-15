
import 'package:sqflite/sqflite.dart' as sql;
class SQLHelper {
 static Future<void> createTables(sql.Database database) async {
    await database.execute('''
          CREATE TABLE Auth (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            firstName TEXT,
            lastName TEXT,
            gender TEXT, 
            image TEXT,
            token TEXT
          )
        ''');
  }
 static Future<sql.Database> db() async {
    return sql.openDatabase(
      'auth_db.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print('...database');
        await createTables(database);
      },
    );
  }
  static Future<dynamic> createItems(
     int id, String username, String email, String firstName, String lastName,
      String gender, String image, String token,) async {
    final db = await SQLHelper.db();
    final data = {
      //  'id' : id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
      'token': token
    };
    final id = await db.insert('Auth', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('Auth', orderBy: "id");
  }
}
