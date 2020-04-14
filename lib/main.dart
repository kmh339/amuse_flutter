import 'package:amuse_flutter/authentication/authentication_bloc.dart';
import 'package:amuse_flutter/certification/certification.dart';
import 'package:amuse_flutter/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/authentication/bloc.dart';

import 'package:http/http.dart' as http;

void main() {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return CertificationScreen();
        },
      )
    );
  }
}
