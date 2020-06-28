import 'package:flutter/material.dart';
import 'package:med_report/bloc_login/login/bloc/login_page.dart';
import 'package:med_report/bloc_login/model/user_model.dart';
import 'package:med_report/bloc_login/dao/user_dao.dart';
import 'package:med_report/repository/user_repository.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userRepository = UserRepository();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _unameController = TextEditingController();
  final _psswdController = TextEditingController(); 
  final _repsswdController = TextEditingController();
  String _username, _password;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(
                  labelText: 'Username', icon: Icon(Icons.person)),
                  controller: _unameController,
                ),
                TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                  labelText: 'Password', icon: Icon(Icons.security)),
                  obscureText: true,
                  controller: _psswdController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                  labelText: 'Re-enter Password', icon: Icon(Icons.security)),
                  obscureText: true,
                  controller: _repsswdController,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.22,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      onPressed: () {
                        var user = User(id: 0, username: _username, token: _password);
                        var db = UserDao();
                        db.saveUser(user);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => 
                            LoginPage(userRepository: userRepository,),
                          ));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.white60,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
