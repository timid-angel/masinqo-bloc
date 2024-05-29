import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_events.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';
import 'package:masinqo/domain/listener/listener_album.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final ListenerAlbumCollection albumCollection;

  AlbumBloc({required this.albumCollection}) : super(EmptyAlbum()) {
    on<FetchAlbums>((event, emit) async {
      try {
        final albums = await albumCollection.getAlbums();
        if (albums.isEmpty) {
          emit(EmptyAlbum());
        } else {
          emit(LoadedAlbum(albums));
        }
      } catch (e) {
        emit(ErrorAlbum(e.toString()));
      }
    });
  }
}
