import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class CertificationLoad extends LoginEvent {
  @override
  String toString() => 'CertificationLoad';
}

class InputDataCodeButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const InputDataCodeButtonPressed({
    @required this.email,
    @required this.password,
  });


  @override
  String toString() =>
      'InputDataButtonPressed { email: $email, password: $password }';
}

class InputDataLoading extends LoginEvent{

}

