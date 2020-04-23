import 'package:amuse_flutter/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isLoading;
  final UserData userData;
  final UserMeta userMeta;

  LoginState({
    @required this.isSuccess,
    @required this.isLoading,
    @required this.userData,
    @required this.userMeta,
  });

  factory LoginState.empty() {
    return LoginState(
      isSuccess: false,
      isLoading: false,
      userData: null,
      userMeta: null,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isSuccess: false,
      isLoading: false,
      userData: null,
      userMeta: null,
    );
  }

  factory LoginState.success({UserData userData, UserMeta userMeta}) {
    return LoginState(
      isSuccess: true,
      isLoading: false,
      userData: userData,
      userMeta: userMeta,
    );
  }
}

