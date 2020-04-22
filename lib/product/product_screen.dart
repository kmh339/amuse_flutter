import 'dart:convert';
import 'dart:io';

import 'package:amuse_flutter/authentication/bloc.dart';
import 'package:amuse_flutter/login/bloc/bloc.dart';
import 'package:amuse_flutter/product/bloc/bloc.dart';
import 'package:amuse_flutter/product/product_main.dart';
import 'package:amuse_flutter/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductScreen extends StatefulWidget {
  final String _userName;
  final String _token;

  ProductScreen({
   Key key,
   @required String userName,
    @required String token,
}) : assert(userName != null),
  _userName = userName,
  assert(token != null),
  _token =token,
  super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String get _userName => widget._userName;
  String get _token => widget._token;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: BlocProvider(
          create: (context) => ProductBloc(),
          child: ProductMain(userName: _userName, token: _token,),
        )
      );

  }
}
