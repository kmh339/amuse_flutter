import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/authentication/bloc.dart';
import 'login.dart';
import 'bloc/bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        child: LoginMain(),
      ),
    );
  }
}
