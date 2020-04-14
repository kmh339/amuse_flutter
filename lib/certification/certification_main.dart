import 'package:amuse_flutter/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/user_repository.dart';

import 'bloc/bloc.dart';

class CertificationMain extends StatefulWidget {
  CertificationMain({
    Key key,
  }) : super(key: key);

  State<CertificationMain> createState() => _CertificationMainState();
}

class _CertificationMainState extends State<CertificationMain> {
  CertificationBloc _certificationBloc;
  final _codeController = TextEditingController();
  UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _certificationBloc = BlocProvider.of<CertificationBloc>(context);
  }

  _onInputCodeButtonPressed() {
    BlocProvider.of<CertificationBloc>(context).add(
      InputDataCodeButtonPressed(
        email: _codeController.text,
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CertificationBloc, CertificationState>(
      listener: (context, state) {
        setState(() {
          if (state.isLoaded ) {
            if (state.isCheckStatus) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return ProductScreen();
              }));
            }
          }
          else{
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('아이디 혹은 비밀번호가 틀렸습니다.'),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      },
      child: BlocBuilder<CertificationBloc, CertificationState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Padding(
                padding: const EdgeInsets.only(right:30.0,left: 30.0,top: 30.0,bottom: 50.0),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/welcome_image.png'),
                          ),
                          TextFormField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              labelText: '로그인',
                            ),
                            validator: (value) {
                              if (value.isEmpty ) {
                                return '아이디와 비밀번호를 입력해 주세요.';
                              } else if(value.length != 4){
                                return '아이디 혹은 비밀번호가 틀렸습니다.';
                              }else
                                return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1000.0,
                        height: 45.0,
                        child: RaisedButton(
                          textColor: Colors.orange,
                          color: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (state is! InputDataLoading) {
                                _onInputCodeButtonPressed();
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            '로그인',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}