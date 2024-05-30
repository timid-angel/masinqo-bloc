import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/application/artists/home_page/artist_home_state.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class ArtistHomeBloc extends Bloc<ArtistHomeEvent, ArtistHomeState> {
  final String token;

  ArtistHomeBloc({required this.token})
      : super(ArtistHomeState(
            name: "", email: "", profilePicture: "", albums: [])) {
    on<GetArtistInformation>((event, emit) async {
      final res = await ArtistEntity(token: token).getArtistInformation();

      res.fold((l) {
        emit(ArtistHomeFailureState(
            albums: state.albums,
            email: state.email,
            errorMessage: l.message,
            name: state.name,
            profilePicture: state.profilePicture));
      }, (r) {
        emit(ArtistHomeState(
          name: r.name,
          email: r.email,
          profilePicture: r.profilePicture,
          albums: r.albums,
        ));
      });
    });

    on<UpdateArtistInformation>((event, emit) async {
      final res = await ArtistEntity(token: token).updateInformation(
        UpdateArtistInformatioDTO(
          event.profilePictureFilePath,
          name: event.name,
          email: event.email,
          password: event.password,
        ),
        event.confirmPassword,
        state.email,
      );

      res.fold((l) {
        emit(ArtistHomeFailureState(
            albums: state.albums,
            email: state.email,
            errorMessage: l.message,
            name: state.name,
            profilePicture: state.profilePicture));
      }, (r) {
        emit(
          ArtistHomeSuccessState(
              name: event.name,
              email: event.email,
              profilePicture: event.profilePictureFilePath,
              albums: state.albums),
        );
      });
    });

    on<RemoveDeletedAlbum>((event, emit) {
      List res = [];
      for (final album in state.albums) {
        if (album["_id"] != event.albumId) {
          res.add(album);
        }
      }
      state.albums = res;
      emit(state);
    });

    on<CreateNewAlbum>((event, emit) {
      state.albums.add(event.album.toJson());
      emit(state);
    });

    on<HomeAlbumUpdateEvent>((event, emit) {
      for (int i = 0; i < state.albums.length; i++) {
        if (event.albumId == state.albums[i]["_id"]) {
          state.albums[i]["title"] = event.title;
          state.albums[i]["genre"] = event.genre;
          state.albums[i]["description"] = event.description;
        }
      }

      emit(state);
    });

    on<CompletedEvent>((event, emit) {
      emit(
        ArtistHomeState(
          name: event.errorState.name,
          email: event.errorState.email,
          profilePicture: event.errorState.profilePicture,
          albums: event.errorState.albums,
        ),
      );
    });

    add(GetArtistInformation());
  }
}
