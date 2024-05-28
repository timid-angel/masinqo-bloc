import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import './artist_signup_event.dart';
import './artist_signup_state.dart';
import 'package:masinqo/domain/auth/interfaces/artist_signup_respository_interface.dart';

class ArtistSignupBloc extends Bloc<ArtistSignupEvent, ArtistSignupState> {
  final ArtistSignupRepositoryInterface signupRepository;

  ArtistSignupBloc({required this.signupRepository})
      : super(SignupInitial()) {
    on<ArtistSignupEvent>(_onArtistSignupEvent);
  }

  void _onArtistSignupEvent(
      ArtistSignupEvent event, Emitter<ArtistSignupState> emit) async {
    emit(SignupLoading());
    try {
      if (event.artist.password != event.confirmPassword) {
        emit(const ArtistSignupFailure('Passwords do not match'));
        return;
      }

      // Convert Artist object to ArtistSignupDTO
      final artistDTO = ArtistSignupDTO(
        name: event.artist.name,
        email: event.artist.email,
        password: event.artist.password,
      );

      final success = await signupRepository.signupArtist(artistDTO);

      if (success) {
        emit(ArtistSignupSuccess());
      } else {
        emit(const ArtistSignupFailure('Signup failed. Please try again.'));
      }
    } catch (e) {
      emit(const ArtistSignupFailure('An error occurred. Please try again later.'));
    }
  }
}
