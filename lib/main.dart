import 'package:amuse_flutter/authentication/authentication_bloc.dart';
import 'package:amuse_flutter/screens/login/login.dart';
import 'package:amuse_flutter/screens/product/product.dart';
import 'package:amuse_flutter/splash_screen.dart';
import 'package:amuse_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/authentication/bloc.dart';

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
  String avatar;


  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = UserRepository();

    _userRepository.getUserName().then((userName){
      this.userName = userName;
    });

    _userRepository.getAccessToken().then((token) {
      this.token = token;
    });

    _userRepository.getAvatar().then((avatar){
      this.avatar = avatar;
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
            return ProductScreen(userName: userName, token: token, avatar: avatar,);
          }
          return SplashScreen();
        },
      )
    );
  }
}
