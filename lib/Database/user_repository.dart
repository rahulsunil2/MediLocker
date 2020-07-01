import 'dart:async';
import 'package:med_report/apiconnection/api_connection.dart';
import 'package:med_report/bloc_login/dao/user_dao.dart';
import 'package:med_report/models/api_model.dart';
import 'package:med_report/models/user_model.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate ({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(
      username: username,
      password: password
    );
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken ({
    @required User user
    }) async {
    // write token with the user to the database
      await userDao.createUser(user);
  }

  Future <void> delteToken({
    @required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}