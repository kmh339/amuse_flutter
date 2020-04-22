import 'package:amuse_flutter/authentication/authentication_bloc.dart';
import 'package:amuse_flutter/login/login.dart';
import 'package:amuse_flutter/product/product_screen.dart';
import 'package:amuse_flutter/splash_screen.dart';
import 'package:amuse_flutter/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/authentication/bloc.dart';

import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  String userName;
  String token;

  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = UserRepository();

    _userRepository.getUserName().then((userName){
      this.userName = userName;
    });

    _userRepository.getAccessToken().then((token) {
      this.token = token;
    });

    return MaterialApp(
      title: 'AmuseTravel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is Unauthenticated) {
              return LoginScreen();
          }
          if(state is Authenticated){
            return ProductScreen(userName: userName, token: token,);
          }
          return SplashScreen();
        },
      )
    );
  }
}
