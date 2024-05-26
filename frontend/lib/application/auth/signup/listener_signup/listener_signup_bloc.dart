import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/signup/listener_signup/listener_signup_event.dart';
import 'package:masinqo/application/signup/listener_signup/listener_signup_state.dart';
import 'package:masinqo/infrastructure/signup/listener_signup_repository.dart';

class ListenerSignupBloc extends Bloc<ListenerSignupEvent, ListenerSignupState> {
  final ListenerSignupRepository signupRepository;

  ListenerSignupBloc({required this.signupRepository}) : super(SignupInitial()) {
    on<ListenerSignupEvent>(_onListenerSignupEvent);
  }

  void _onListenerSignupEvent(ListenerSignupEvent event, Emitter<ListenerSignupState> emit) async {
    emit(SignupLoading());
    try {
      if (event.listener.password != event.confirmPassword) {
        emit(ListenerSignupFailure('Passwords do not match'));
        return;
      }

      final success = await signupRepository.signupListener(event.listener, event.confirmPassword);

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
