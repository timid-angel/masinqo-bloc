import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/auth_entities.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ArtistAuthBloc extends Bloc<ArtistAuthEvent, ArtistAuthState> {
  final ArtistLoginRepository loginRepository;

  ArtistAuthBloc(this.loginRepository) : super(ArtistAuthState()) {
    on<ArtistLoginEvent>((event, emit) async {
      final ArtistAuthEntity user =
          ArtistAuthEntity(email: event.email, password: event.password);

      emit(ArtistAuthState());
      final res = await user.loginArtist();
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
