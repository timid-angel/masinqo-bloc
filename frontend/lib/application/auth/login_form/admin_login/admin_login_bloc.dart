import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/login_form/admin_login_event.dart';

class EmailErrorBloc extends Bloc<EmailErrorEvent, String> {
  EmailErrorBloc() : super("") {
    on<EmailErrorChange>((event, emit) {
      emit(event.message);
    });
  }
}


class PasswordErrorBloc extends Bloc<PasswordErrorEvent, String> {
  PasswordErrorBloc() : super("") {
    on<PasswordErrorChange>((event, emit) {
      emit(event.message);
    });
  }
}

class LoginLoadingBloc extends Bloc<LoginLoadingEvent, bool> {
  LoginLoadingBloc() : super(false) {
    on<LoginSetLoading>((event, emit) => emit(true));
    on<LoginUnsetLoading>((event, emit) => emit(false));
  }
}
