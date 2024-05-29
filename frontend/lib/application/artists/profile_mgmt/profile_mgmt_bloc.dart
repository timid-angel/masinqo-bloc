import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/application/artists/profile_mgmt/profile_mgmt_event.dart';
import 'package:masinqo/application/artists/profile_mgmt/profile_mgmt_state.dart';

class UpdateArtistBloc extends Bloc<UpdateArtistEvent, UpdateArtistState> {
  final ArtistsRepositoryInterface repository;

  UpdateArtistBloc(this.repository) : super(UpdateArtistInitial());

  Stream<UpdateArtistState> mapEventToState(UpdateArtistEvent event) async* {
    if (event is UpdateArtistInformation) {
      yield UpdateArtistLoading();

      final result = await repository.updateInformation(
        UpdateArtistInformatioDTO(
          event.profilePictureFilePath,
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      if (result.isLeft()) {
        yield UpdateArtistFailure(result.leftMap((failure) => failure.message) as String);
      } else {
        yield UpdateArtistSuccess();
      }
    }
  }
}
