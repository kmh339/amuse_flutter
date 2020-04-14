import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CertificationEvent extends Equatable {
  const CertificationEvent();

  @override
  List<Object> get props => [];
}
class CertificationLoad extends CertificationEvent {
  @override
  String toString() => 'CertificationLoad';
}

class InputDataCodeButtonPressed extends CertificationEvent {
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

class InputDataLoading extends CertificationEvent{

}

