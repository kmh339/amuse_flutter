import 'package:amuse_flutter/model/models.dart';
import 'package:amuse_flutter/model/user_meta.dart';
import 'package:meta/meta.dart';

@immutable
class CertificationState {
  final bool isLoaded;
  final bool isLoading;
  final bool isCheckStatus;
  final User user;
  final UserMeta userMeta;

  CertificationState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.isCheckStatus,
    @required this.user,
    @required this.userMeta,
  });

  factory CertificationState.empty() {
    return CertificationState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
      user: null,
      userMeta: null,
    );
  }

  factory CertificationState.failure() {
    return CertificationState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
      user: null,
      userMeta: null,
    );
  }

  factory CertificationState.success({User user, UserMeta userMeta}) {
    return CertificationState(
      isLoaded: true,
      isLoading: false,
      isCheckStatus: true,
      user: user,
      userMeta: userMeta,
    );
  }
}

