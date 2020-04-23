import 'package:amuse_flutter/blocs/product_bloc/bloc.dart';
import 'package:amuse_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductMain extends StatefulWidget {
  final String _userName;
  final String _token;
  final String _avatar;

  ProductMain({
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
  State<ProductMain> createState() => _ProductMainState();
}

class _ProductMainState extends State<ProductMain> {
  String get _userName => widget._userName;

  String get _token => widget._token;

  String get _avatar => widget._avatar;

  ProductBloc _productBloc;
  List<Product> _product;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(ProductLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.isLoaded) {
          setState(() {
            _product = state.product;
          });
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoaded) {
            _product = state.product;
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.network(
                            _avatar,
                            width: 100,
                          ),
                          Text(
                            "사용자 이름 : ${_userName}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("토큰 : ${_token}"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _product != null ? _product.length : 0,
                          itemBuilder: (context, index) {
                            return Card(
                              child: InkWell(
                                splashColor: Colors.redAccent.withAlpha(30),
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    width: 300,
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${_product[index].title}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Divider(
                                          color: Colors.black38,
                                          height: 10,
                                          thickness: 0.7,
                                          indent: 0,
                                          endIndent: 0,
                                        ),
                                        Text(
                                          "${_product[index].subtitle}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            );
          }
        },
      ),
    );
  }
}
