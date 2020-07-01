import 'dart:async';
import 'package:flutter/material.dart';
import 'package:med_report/Database/user_repository.dart';
import 'package:med_report/login/login_page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Login(userRepository: UserRepository(),)));
    //Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override

Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Image.network('https://i.pinimg.com/564x/64/3e/7c/643e7c3202049a38add322358aedd45f.jpg')
    ),
  );
  }
}