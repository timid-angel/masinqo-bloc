import 'package:equatable/equatable.dart';
import 'package:masinqo/domain/entities/listener.dart';
abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class ListenerSignupEvent extends SignupEvent {
  final Listener listener;
  final String confirmPassword;

  const ListenerSignupEvent({
    required this.listener,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [listener, confirmPassword];
}
