import 'package:amuse_flutter/model/models.dart';
import 'package:amuse_flutter/user/user_meta.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isLoaded;
  final bool isLoading;
  final bool isCheckStatus;
  final User user;
  final UserMeta userMeta;

  LoginState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.isCheckStatus,
    @required this.user,
    @required this.userMeta,
  });

  factory LoginState.empty() {
    return LoginState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
      user: null,
      userMeta: null,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
      user: null,
      userMeta: null,
    );
  }

  factory LoginState.success({User user, UserMeta userMeta}) {
    return LoginState(
      isLoaded: true,
      isLoading: false,
      isCheckStatus: true,
      user: user,
      userMeta: userMeta,
    );
  }
}

