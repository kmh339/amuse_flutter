import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/blocs/login_bloc/bloc.dart';

import 'login.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginMain(),
      ),
    );

//    return Scaffold(
//      body: BlocProvider<LoginBloc>(
//        create: (context) => LoginBloc(),
//        child: LoginMain(),
//      ),
//    );

  }
}