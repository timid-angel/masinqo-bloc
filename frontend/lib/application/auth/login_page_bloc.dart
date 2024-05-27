import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, bool> {
  LoginPageBloc() : super(true) {
    on<SwitchRole>((event, emit) => emit(event.toValue));
  }
}
