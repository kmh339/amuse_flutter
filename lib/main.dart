import 'package:amuse_flutter/authentication/authentication_bloc.dart';
import 'package:amuse_flutter/certification/certification.dart';
import 'package:amuse_flutter/product/product_screen.dart';
import 'package:amuse_flutter/splash_screen.dart';
import 'package:amuse_flutter/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/authentication/bloc.dart';

import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(
      userRepository: userRepository,
      httpClient: http.Client(),
    )..add(AppStarted()),
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  bool _signIn;
  String userName;
  String token;

  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = UserRepository();
    _userRepository.isSignedIn().then((signIn) {
      this._signIn = signIn;
    });

    _userRepository.getUser().then((userName){
      this.userName = userName;
    });

    _userRepository.getAccessToken().then((token) {
      this.token = token;
    });

    return MaterialApp(
      title: 'Amusetravel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is Unauthenticated) {
              return CertificationScreen();
          }
          else if(state is Authenticated){
            return ProductScreen(userName: userName, token: token,);
          }
          return SplashScreen();
        },
      )
    );
  }
}
