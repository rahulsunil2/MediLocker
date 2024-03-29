import 'package:med_report/bloc_directory/directory/user_database.dart';
import 'package:med_report/bloc_login/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }
  Future<int> saveUser(User user) async {
    final db = await dbProvider.database;
    print(user.username);
    int result = await db.insert("User", user.toDatabaseJson());
    List<Map> list = await db.rawQuery('SELECT * FROM User');
    print(list);
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db
          .query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}