import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/domain/auth/signup/signup_entities.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_repository.dart';
import './artist_signup_event.dart';
import './artist_signup_state.dart';

class ArtistSignupBloc extends Bloc<ASignupEvent, ArtistSignupState> {
  ArtistSignupBloc() : super(SignupInitial()) {
    on<ArtistSignupEvent>((event, emit) async {
      final artistDTO = ArtistSignupDTO(
        name: event.artist.name,
        email: event.artist.email,
        password: event.artist.password,
        confirmPassword: event.confirmPassword,
      );

      final res = await ArtistSignupEntity(
              artist: artistDTO,
              signupRepository:
                  ArtistSignupRepository(dataSource: ArtistSignupDataSource()))
          .signupArtist();

      res.fold((l) {
        if (l.messages.isNotEmpty) {
          emit(ArtistSignupFailure(error: l.messages[0]));
        } else {
          emit(const ArtistSignupFailure(
              error: "Signup failed. Please try again"));
        }
      }, (r) {
        emit(ArtistSignupSuccess());
      });
    });

    on<AResetState>((event, emit) => emit(SignupInitial()));
  }
}
