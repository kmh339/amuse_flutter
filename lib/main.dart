import 'package:amuse_flutter/blocs/authentication_bloc/bloc.dart';
import 'package:amuse_flutter/screens/login/login.dart';
import 'package:amuse_flutter/screens/product/product.dart';
import 'package:amuse_flutter/splash_screen.dart';
import 'package:amuse_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();

  String userName;

  String token;

  String avatar;

  @override
  void initState() {
    _userRepository.getUserName().then((userName){
      this.userName = userName;
    });

    _userRepository.getAccessToken().then((token) {
      this.token = token;
    });

    _userRepository.getAvatar().then((avatar){
      this.avatar = avatar;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmuseTravel',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
