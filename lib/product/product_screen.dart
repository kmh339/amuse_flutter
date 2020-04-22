import 'package:amuse_flutter/product/bloc/bloc.dart';
import 'package:amuse_flutter/product/product_main.dart';
import 'package:amuse_flutter/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductScreen extends StatelessWidget {
  final String _userName;
  final String _token;

  ProductScreen({
    Key key,
    @required String userName,
    @required String token,
  })  : assert(userName != null),
        _userName = userName,
        assert(token != null),
        _token = token,
        super(key: key);

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


