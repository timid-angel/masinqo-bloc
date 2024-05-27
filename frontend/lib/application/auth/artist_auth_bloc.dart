import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/auth_entities.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ArtistAuthBloc extends Bloc<ArtistAuthEvent, ArtistAuthState> {
  ArtistAuthBloc() : super(ArtistAuthState()) {
    on<ArtistLoginEvent>((event, emit) async {
      final res =
          await ArtistAuthEntity(email: event.email, password: event.password)
              .loginArtist();

      res.fold((l) {
        ArtistAuthState newState = ArtistAuthState();
        newState.errors = l.messages;
        emit(newState);
      }, (r) async {
        ArtistAuthState newState = ArtistAuthState();
        await SecureStorageService().writeToken(r.token);
        emit(newState);
      });
    });
  }
}
