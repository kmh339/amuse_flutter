import 'package:amuse_flutter/screens/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/models/models.dart';

import 'package:amuse_flutter/blocs/login_bloc/bloc.dart';

class LoginMain extends StatefulWidget {
  LoginMain({
    Key key,
  }) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final UserRepository _userRepository = UserRepository();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  String userName;
  String token;
  String avatar;


  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  _onInputCodeButtonPressed() {
    _loginBloc.add(
      InputDataCodeButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        setState(() {
          if (state.isLoaded ) {
            if (state.isCheckStatus) {
              _userRepository.persistUsername(state.userData.name);
              _userRepository.persistToken(state.userMeta.token);
              _userRepository.persistAvatar(state.userData.avatar);
              userName = state.userData.name;
              token = state.userMeta.token;
              avatar = state.userData.avatar;
              print("]-----] LoginMain when pushed loginbutton [-----[ name : $userName, token : $token");
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return ProductScreen(userName: userName, token: token, avatar: avatar,);
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
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Padding(
                padding: const EdgeInsets.only(right:30.0,left: 30.0,top: 30.0,bottom: 50.0),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[

                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: '이메일',
                            ),
                            validator: (value) {
                              if (value.isEmpty ) {
                                return '이메일을 입력해 주세요.';
                              } else
                                return null;
                            },
                          ),TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: '비밀번호',

                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty ) {
                                return '비밀번호를 입력해 주세요.';
                              } else
                                return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1000.0,
                        height: 45.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.redAccent,
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
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();

  }


}
