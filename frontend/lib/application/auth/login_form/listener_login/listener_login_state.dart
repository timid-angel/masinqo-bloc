
// listener_login_state.dart
import 'package:equatable/equatable.dart';

abstract class ListenerLoginState extends Equatable {
  const ListenerLoginState();
  
  @override
  List<Object> get props => [];
}

class ListenerLoginInitial extends ListenerLoginState {}
class ListenerLoginLoading extends ListenerLoginState {}
class ListenerLoginSuccess extends ListenerLoginState {}
class ListenerLoginFailure extends ListenerLoginState {
  final String error;

  const ListenerLoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
