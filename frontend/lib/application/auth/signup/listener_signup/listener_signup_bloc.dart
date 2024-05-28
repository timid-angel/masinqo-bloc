import 'package:flutter_bloc/flutter_bloc.dart';
import 'listener_signup_event.dart';
import 'listener_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import 'package:masinqo/domain/auth/interfaces/listener_signup_respository_interface.dart';

class ListenerSignupBloc
    extends Bloc<ListenerSignupEvent, ListenerSignupState> {
  final ListenerSignupRepositoryInterface signupRepository;

  ListenerSignupBloc({required this.signupRepository})
      : super(SignupInitial()) {
    on<ListenerSignupEvent>(_onListenerSignupEvent);
  }

  void _onListenerSignupEvent(
      ListenerSignupEvent event, Emitter<ListenerSignupState> emit) async {
    emit(SignupLoading());
    try {
      if (event.listener.password != event.confirmPassword) {
        emit(ListenerSignupFailure('Passwords do not match'));
        return;
      }

      // Convert Listener object to ListenerSignupDTO
      final listenerDTO = ListenerSignupDTO(
        name: event.listener.name,
        email: event.listener.email,
        password: event.listener.password,
      );

      final success = await signupRepository.signupListener(listenerDTO);

      if (success) {
        emit(ListenerSignupSuccess());
      } else {
        emit(ListenerSignupFailure('Signup failed. Please try again.'));
      }
    } catch (e) {
      emit(ListenerSignupFailure('An error occurred. Please try again later.'));
    }
  }
}
