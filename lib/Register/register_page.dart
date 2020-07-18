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
      backgroundColor: Colors.white,
      
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              upperHalf(context),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: RegisterForm(),
              ),
             // pageTitle(context),
            ]
          ),
        ),
        
      
      bottomNavigationBar: FlatButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login(userRepository: userRepository,))
        );},
        child: Text("GO BACK TO LOGIN"),textColor: Colors.black,),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'JOIN US',
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 30.0
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
              color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 14),),
          )
        ],
      ), 
    );
  }

}

