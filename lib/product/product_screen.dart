import 'dart:convert';
import 'dart:io';

import 'package:amuse_flutter/authentication/bloc.dart';
import 'package:amuse_flutter/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  AuthenticationBloc _authenticationBloc;
  UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();

    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(),
      ),
    );
  }
}
