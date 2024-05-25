import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupSuccess extends SignupState {
  final String message;

  const SignupSuccess(this.message);

  @override
  List<Object> get props => [message];
}

