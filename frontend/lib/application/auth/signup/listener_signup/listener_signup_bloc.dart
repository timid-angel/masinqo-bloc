import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/domain/auth/signup/signup_entities.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_repository.dart';
import 'listener_signup_event.dart';
import 'listener_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class ListenerSignupBloc extends Bloc<LSignupEvent, ListenerSignupState> {
  ListenerSignupBloc() : super(SignupInitial()) {
    on<ListenerSignupEvent>((event, emit) async {
      final listenerDTO = ListenerSignupDTO(
        name: event.listener.name,
        email: event.listener.email,
        password: event.listener.password,
        confirmPassword: event.confirmPassword,
      );

      final res = await ListenerSignupEntity(
              listener: listenerDTO,
              signupRepository: ListenerSignupRepository(
                  dataSource: ListenerSignupDataSource()))
          .signupListener();

      res.fold((l) {
        if (l.messages.isNotEmpty) {
          emit(ListenerSignupFailure(error: l.messages[0]));
        } else {
          emit(const ListenerSignupFailure(
              error: "Signup failed. Please try again"));
        }
      }, (r) {
        emit(ListenerSignupSuccess());
      });
    });

    on<LResetState>((event, emit) => emit(SignupInitial()));
  }
}
