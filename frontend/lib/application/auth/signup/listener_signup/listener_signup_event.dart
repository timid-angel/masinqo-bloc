import 'package:masinqo/domain/entities/listener.dart';

abstract class LSignupEvent {}

class ListenerSignupEvent extends LSignupEvent {
  final Listener listener;
  final String confirmPassword;

  ListenerSignupEvent({
    required this.listener,
    required this.confirmPassword,
  });
}

class LResetState extends LSignupEvent {}
