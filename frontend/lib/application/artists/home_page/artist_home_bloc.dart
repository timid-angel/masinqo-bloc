import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/application/artists/home_page/artist_home_state.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class ArtistHomeBloc extends Bloc<ArtistHomeEvent, ArtistHomeState> {
  final String token;

  ArtistHomeBloc({required this.token})
      : super(const ArtistHomeState(
            name: "", email: "", profilePicture: "", albums: [])) {
    on<GetArtistInformation>((event, emit) async {
      final res = await ArtistEntity(token: token).getArtistInformation();

      res.fold((l) {
        emit(ArtistHomeFailure(
            albums: [],
            email: "",
            errorMessage: l.message,
            name: "",
            profilePicture: ""));
      }, (r) {
        // print("${r.name}, ${r.email}, ${r.profilePicture}, ${r.albums}");
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
      );

      res.fold((l) {
        emit(ArtistHomeFailure(
            albums: [],
            email: "",
            errorMessage: l.message,
            name: "",
            profilePicture: ""));
      }, (r) {
        emit(
          ArtistHomeState(
              name: event.name,
              email: event.email,
              profilePicture: event.profilePictureFilePath,
              albums: state.albums),
        );
      });
    });

    add(GetArtistInformation());
  }
}
