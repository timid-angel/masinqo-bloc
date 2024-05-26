
// listener_login_event.dart
import 'package:equatable/equatable.dart';

abstract class ListenerLoginEvent extends Equatable {
  const ListenerLoginEvent();
  
  @override
  List<Object> get props => [];
}

class ListenerLoginSubmitted extends ListenerLoginEvent {
  final String email;
  final String password;

  const ListenerLoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
