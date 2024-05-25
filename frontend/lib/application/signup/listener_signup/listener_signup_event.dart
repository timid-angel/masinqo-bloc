import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' as flutter;
import '../../../domain/signup/listener.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class ListenerSignupEvent extends SignupEvent {
  final Listeners listener;
  final String confirmPassword;

  ListenerSignupEvent({
    required this.listener,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [listener, confirmPassword];
}
