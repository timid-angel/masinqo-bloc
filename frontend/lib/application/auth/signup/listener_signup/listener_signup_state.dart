import 'package:equatable/equatable.dart';

abstract class ListenerSignupState extends Equatable {
  const ListenerSignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends ListenerSignupState {}

class SignupLoading extends ListenerSignupState {}

class ListenerSignupSuccess extends ListenerSignupState {}

class ListenerSignupFailure extends ListenerSignupState {
  final String error;

  const ListenerSignupFailure(this.error);

  @override
  List<Object> get props => [error];
}
