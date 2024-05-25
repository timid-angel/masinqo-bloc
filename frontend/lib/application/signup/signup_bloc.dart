import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/signup/signup_event.dart';
import 'package:masinqo/application/signup/signup_state.dart';
import 'package:masinqo/infrastructure/signup/signup_repository.dart';
class SignupBloc extends Bloc<ArtistSignupEvent, SignupState> {
  final SignupRepository signupRepository;

  SignupBloc({required this.signupRepository}) : super(SignupInitial()) {
    on<ArtistSignupEvent>(_onArtistSignupEvent);
  }

  void _onArtistSignupEvent(ArtistSignupEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      if (event.artist.password != event.confirmPassword) {
        emit(SignupFailure('Passwords do not match'));
        return;
      }

      final success = await signupRepository.signupArtist(event.artist, event.confirmPassword);

      if (success) {
        emit(SignupSuccess());
      } else {
        emit(SignupFailure('Signup failed. Please try again.'));
      }
    } catch (e) {
      emit(SignupFailure('An error occurred. Please try again later.'));
    }
  }
}
