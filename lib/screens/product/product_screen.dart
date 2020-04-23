import 'package:amuse_flutter/blocs/product_bloc/bloc.dart';
import 'package:amuse_flutter/screens/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final String _userName;
  final String _token;
  final String _avatar;

  ProductScreen({
    Key key,
    @required String userName,
    @required String token,
    @required String avatar,
  })  : assert(userName != null),
        _userName = userName,
        assert(token != null),
        _token = token,
        assert(avatar != null),
        _avatar = avatar,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => ProductBloc(),
      child: ProductMain(
        userName: _userName,
        token: _token,
        avatar: _avatar,
      ),
    ));
  }
}
