import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/artists/album/album_event.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final String token;
  final AlbumState album;
  AlbumBloc({
    required this.token,
    required this.album,
  }) : super(album) {
    on<AddSongEvent>((event, emit) async {
      final res = await ArtistEntity(token: token).addSong(
          CreateSongDTO(songName: event.songName, albumId: state.albumId),
          event.songFilePath,
          state.songs);

      res.fold((l) {
        state.error = l.message;
        emit(state);
      }, (r) {
        state.songs.add(Song(name: event.songName, filePath: ""));
        emit(state);
      });
    });

    on<DeleteSongEvent>((event, emit) async {
      final res = await ArtistEntity(token: token)
          .removeSong(event.albumId, event.songName);

      res.fold((l) {
        state.error = l.message;
        emit(state);
      }, (r) {
        List<Song> newSongs = [];
        for (int i = 0; i < state.songs.length; i++) {
          if (state.songs[i].name != event.songName) {
            newSongs.add(state.songs[i]);
          }
        }
        state.songs = newSongs;
        emit(state);
      });
    });

    on<AlbumUpdateEvent>((event, emit) async {
      final res = await ArtistEntity(token: token).updateAlbum(UpdateAlbumDTO(
        albumId: state.albumId,
        title: event.title,
        genre: event.genre,
        description: event.description,
      ));

      res.fold((l) {
        state.error = l.message;
        emit(state);
      }, (r) {
        emit(
          AlbumState(
            title: event.title,
            albumArt: state.albumArt,
            artist: state.artist,
            date: state.date,
            description: event.description,
            error: "",
            genre: event.genre,
            songs: state.songs,
            albumId: state.albumId,
          ),
        );
      });
    });

    on<DeleteAlbumEvent>((event, emit) async {
      final res = await ArtistEntity(token: token).removeAlbum(event.albumId);
      res.fold((l) {
        state.error = l.message;
        emit(state);
      }, (r) {
        state.isDeleted = true;
        emit(state);
        event.artistHomeBloc.add(RemoveDeletedAlbum(albumId: state.albumId));
        event.context.goNamed("artist",
            pathParameters: {"token": event.artistHomeBloc.token});
      });
    });

    
  }
}
