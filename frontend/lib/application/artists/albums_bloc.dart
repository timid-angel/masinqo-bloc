import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/albums_event.dart';
import 'package:masinqo/application/artists/albums_state.dart';
import 'package:masinqo/domain/artists/artists.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  late String token;

  AlbumsBloc() : super(AlbumsState(albums: [])) {
    on<GetAlbumsArtist>((event, emit) async {
      final res = await ArtistEntity(token: token).getAlbums();
      res.fold((l) {
        final newState = AlbumsState(albums: []);
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        final newState = AlbumsState(albums: r.albums);
        emit(newState);
      });
    });
  }
}
