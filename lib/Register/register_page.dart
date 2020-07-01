import 'package:flutter/material.dart';
import 'package:med_report/Database/user_repository.dart';
import 'package:med_report/Home/dashboard.dart';
import 'package:med_report/Register/register_form.dart';
import 'package:med_report/login/login_page.dart';

class Register extends StatelessWidget {
  final userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3B5EE6),
      
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              upperHalf(context),
              pageTitle(context),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: RegisterForm(),
              ),
            ]
          ),
        ),
        
      
      bottomNavigationBar: FlatButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home())
        );},
        child: Text("SKIP LOGGING IN"),textColor: Colors.white,),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: 100,
      color: Color(0xff3B5EE6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'MEDICARE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          )
        ],
      )
    );
  }

  Widget pageTitle (BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Login(userRepository: userRepository,),));
            },
            child: Text("LOGIN", style: TextStyle(
              color: Colors.grey[700], fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 14),),
          ),
          Text(" | ", style: TextStyle(
            color: Colors.grey[700], fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 14),),
          FlatButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Register()));
            },
            child: Text("REGISTER", style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 14),),
          )
        ],
      ), 
    );
  }

}

