import 'package:meta/meta.dart';

@immutable
class CertificationState {
  final bool isLoaded;
  final bool isLoading;
  final bool isCheckStatus;
  CertificationState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.isCheckStatus,
  });

  factory CertificationState.empty() {
    return CertificationState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
    );
  }

  factory CertificationState.failure() {
    return CertificationState(
      isLoaded: false,
      isLoading: false,
      isCheckStatus: false,
    );
  }

  factory CertificationState.success() {
    return CertificationState(
      isLoaded: true,
      isLoading: false,
      isCheckStatus: false,
    );
  }

  factory CertificationState.checkSuccess() {
    return CertificationState(
      isLoaded: true,
      isLoading: false,
      isCheckStatus: true,
    );
  }

  CertificationState copyWith({
    bool isLoaded,
    bool isLoading,
  }) {
    return CertificationState(
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

