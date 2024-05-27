import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/auth_entities.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ArtistAuthBloc extends Bloc<ArtistAuthEvent, ArtistAuthState> {
  String token = "";
  ArtistAuthBloc() : super(ArtistAuthState()) {
    on<ArtistLoginEvent>((event, emit) async {
      final res =
          await ArtistAuthEntity(email: event.email, password: event.password)
              .loginArtist();

      await res.fold((l) {
        ArtistAuthState newState = ArtistAuthState();
        newState.errors = l.messages;
        emit(newState);
      }, (r) async {
        ArtistAuthState newState = ArtistAuthState();
        token = r.token;
        await SecureStorageService().writeToken(r.token);
        emit(newState);
      });
    });

    on<ChangeLoadingStateArtist>((event, emit) async {
      ArtistAuthState newState =
          ArtistAuthState(isLoading: event.newLoadingState);
      newState.errors = state.errors;
      emit(newState);
    });

    on<ResetErrorsArtists>(
        (event, emit) => emit(ArtistAuthState(isLoading: state.isLoading)));
  }
}
