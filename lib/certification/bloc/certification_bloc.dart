import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:amuse_flutter/authentication/bloc.dart';
import 'package:amuse_flutter/user_repository.dart';

import 'bloc.dart';

class CertificationBloc extends Bloc<CertificationEvent, CertificationState> {
  final AuthenticationBloc _authenticationBloc;

  CertificationBloc({
    @required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

  @override
  CertificationState get initialState => CertificationState.empty();

  @override
  Stream<CertificationState> transformEvents(
    Stream<CertificationEvent> events,
    Stream<CertificationState> Function(CertificationEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<CertificationState> mapEventToState(CertificationEvent event) async* {
    if (event is InputDataCodeButtonPressed) {
      yield* _mapInputDataCodeButtonPressedToState(event.email, event.password);
    }
  }

  Stream<CertificationState> _mapInputDataCodeButtonPressedToState(
      String email, String password) async* {
    try {
      String body = json.encode({"email": email, "password": password});
      final response =
          await _authenticationBloc.postWithoutAuth('/api/login', body);

      if (response['data'] != null) {
        final UserRepository _userRepository = UserRepository();
        _userRepository.persistUsername(response['data']['name']);
        yield CertificationState.checkSuccess();
      } else {
        yield CertificationState.success();
      }
    } catch (error) {
      yield CertificationState.failure();
    }
  }
}
