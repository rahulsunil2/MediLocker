import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/Database/user_repository.dart';
import 'package:med_report/Home/dashboard.dart';
import 'package:med_report/Register/register_page.dart';
import 'package:med_report/bloc_login/bloc/authentication_bloc.dart';
import 'package:med_report/bloc_login/bloc/login_bloc.dart';
import 'package:med_report/login/login_form.dart';

class Login extends StatelessWidget {
  final UserRepository userRepository;

  Login({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              upperHalf(context),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LoginForm(),
              ),
              Padding(
                padding: const EdgeInsets.only(top:550.0),
                child: pageTitle(context),
              ),
            ]
          ),
        ),
      ),
      
      
      bottomNavigationBar: FlatButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home())
        );},
        child: Text("SKIP LOGGING IN"),textColor: Colors.black,),
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
            'WELCOME',
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 40.0
            ),
          )
        ],
      )
    );
  }
  
  Widget  pageTitle(BuildContext context) {
    return Container(
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: (){
              //Get.to(Register());
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Register()));
            },
            child: Text("GET INSTANT ACCESS", style: TextStyle(
              color: Colors.grey[700], fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 14),),
          )
        ],
      ), 
    );
  }

}