import 'dart:async';
import 'dart:convert';

import 'package:amuse_flutter/model/models.dart';
import 'package:amuse_flutter/model/user_meta.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:amuse_flutter/authentication/bloc.dart';
import 'package:amuse_flutter/user_repository.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({
    @required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is InputDataCodeButtonPressed) {
      yield* _mapInputDataCodeButtonPressedToState(event.email, event.password);
    }
  }

  Stream<LoginState> _mapInputDataCodeButtonPressedToState(
      String email, String password) async* {
    try {
      String body = json.encode({"email": email, "password": password});
      print("$body");
      final response =
          await _authenticationBloc.postWithoutAuth('/api/login', body);

      if (response['data'] != null && response['meta'] != null) {
       User user = User.fromJson(response['data']);
       UserMeta userMeta = UserMeta.fromJson(response['meta']);

        print("name : ${user.name}");
        print("token: ${userMeta.token}");
        yield LoginState.success(user: user, userMeta: userMeta);
      }
    } catch (error) {
      yield LoginState.failure();
    }
  }
}
