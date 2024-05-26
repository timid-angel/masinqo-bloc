// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:masinqo/application/signup/artist_signup/artist_signup_event.dart';
// import 'package:masinqo/application/signup/artist_signup/artist_signup_state.dart';
// import 'package:masinqo/infrastructure/signup/artist_signup_repository.dart';

// class ArtistSignupBloc extends Bloc<ArtistSignupEvent, ArtistSignupState> {
//   final ArtistSignupRepository signupRepository;

//   ArtistSignupBloc({required this.signupRepository}) : super(SignupInitial()) {
//     on<ArtistSignupEvent>(_onArtistSignupEvent);
//   }

//   void _onArtistSignupEvent(
//       ArtistSignupEvent event, Emitter<ArtistSignupState> emit) async {
//     emit(SignupLoading());
//     try {
//       if (event.artist.password != event.confirmPassword) {
//         emit(ArtistSignupFailure('Passwords do not match'));
//         return;
//       }

//       final success = await signupRepository.signupArtist(
//           event.artist, event.confirmPassword);

//       if (success) {
//         emit(ArtistSignupSuccess());
//       } else {
//         emit(ArtistSignupFailure('Signup failed. Please try again.'));
//       }
//     } catch (e) {
//       emit(ArtistSignupFailure('An error occurred. Please try again later.'));
//     }
//   }
// }
