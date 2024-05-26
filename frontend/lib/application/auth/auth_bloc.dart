import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/login_failure.dart';
import 'package:masinqo/domain/auth/login_success.dart';
import 'package:masinqo/domain/auth/user.dart';
import 'package:masinqo/infrastructure/auth/login_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState(role: "")) {
    on<LoginEvent>((event, emit) async {
      final User user =
          User(email: event.email, password: event.password, role: event.role);
      emit(AuthState(role: "", token: "", isLoading: true));
      Either<LoginFailure, LoginSuccess> res = await user.loginUser();
      res.fold((l) {
        AuthState newState = AuthState(role: "", token: "");
        newState.errors = l.messages;
        emit(newState);
      }, (r) {
        AuthState newState = AuthState(role: event.role, token: r.token);
        emit(newState);
      });
    });
  }
}
