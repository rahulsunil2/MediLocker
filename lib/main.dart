import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/Database/user_repository.dart';
import 'package:med_report/bloc_login/bloc/authentication_bloc.dart';
import 'package:med_report/login/login_page.dart';
import 'package:med_report/splash.dart';
import 'package:med_report/Home/home.dart';
import 'package:med_report/story.dart';
import 'common/loading_indicator.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print (transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(

    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(
          userRepository: userRepository
        )..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    )
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return Story();
          }
          if (state is AuthenticationAuthenticated) {
            print('go to ur Home');
            return Home();
          }
          if (state is AuthenticationUnauthenticated) {
            return Story();
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
