import 'package:amuse_flutter/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isLoaded;
  final bool isLoading;
  final bool isCheckStatus;
  final UserData userData;
  final UserMeta userMeta;

  LoginState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.isCheckStatus,
    @required this.userData,
    @required this.userMeta,
  });

  factory LoginState.empty() {
    return LoginState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
      userData: null,
      userMeta: null,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
      userData: null,
      userMeta: null,
    );
  }

  factory LoginState.success({UserData userData, UserMeta userMeta}) {
    return LoginState(
      isLoaded: true,
      isLoading: false,
      isCheckStatus: true,
      userData: userData,
      userMeta: userMeta,
    );
  }
}

