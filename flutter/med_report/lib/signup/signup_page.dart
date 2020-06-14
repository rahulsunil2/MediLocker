import 'package:flutter/material.dart';
import 'package:med_report/bloc_login/login/bloc/login_page.dart';
import 'package:med_report/repository/user_repository.dart';
import 'package:med_report/signup/signup_form.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register")
      ),
      body: Register(),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(color: Colors.grey),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => 
                  LoginPage(userRepository: userRepository,),
                ));
            },
            textColor: Colors.white,
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}