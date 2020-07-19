import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/bloc_login/bloc/login_bloc.dart';
import 'package:med_report/global.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  double screenHeight;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
      CurrentUser.currentUser = _usernameController.text;
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: screenHeight / 6 - 10),
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: Form(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/undraw_Login_v483.png"),
                          ),
                        ),
                      ),
                    ),
                    // Text("Your Username",
                    //   style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 10),),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          labelText: 'Your Username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                      controller: _usernameController,
                    ),
                    SizedBox(height: 25),
                    // Text("Password",
                    //    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 10),),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.security, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.22,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: state is! LoginLoading
                              ? _onLoginButtonPressed
                              : null,
                          child: Text(
                            'LOG IN',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Colors.white,
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
          );
        },
      ),
    );
  }
}
