import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/album/album_event.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/domain/artists/artists.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final String token;
  AlbumBloc({required this.token})
      : super(AlbumState(
            title: "",
            albumArt: "",
            songs: [],
            description: "",
            genre: "",
            date: DateTime.now(),
            artist: "",
            error: '')) {
    on<AddSongEvent>((event, emit) async {
      final createSongDto = event.songDto;

      final res = await ArtistEntity(token: token)
          .addSong(createSongDto, event.songFilePath);

      res.fold((l) {
        state.error = l.message;
        emit(state);
      }, (r) {
        state.songs.add(Song(name: createSongDto.songName));
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
      final uPD = event.updateAlbumDTO;
      final res = await ArtistEntity(token: token).updateAlbum(uPD);

      res.fold((l) {
        state.error = l.message;
        emit(state);
      }, (r) {
        emit(AlbumState(
            title: uPD.title.isNotEmpty ? uPD.title : state.title,
            albumArt: state.albumArt,
            artist: state.artist,
            date: state.date,
            description: uPD.description.isNotEmpty
                ? uPD.description
                : state.description,
            error: "",
            genre: uPD.genre.isNotEmpty ? uPD.genre : state.genre,
            songs: state.songs));
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
      });
    });
  }
}
