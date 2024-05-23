import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_failures.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_success.dart';

abstract class AdminArtistRepository {
  Future<Either<ArtistFetchFailure, ArtistFetchSuccess>> getArtists();
  Future<Either<ArtistDeleteFailure, ArtistDeleteSuccess>> deleteArtist(
      ArtistID artist);
  Future<Either<ArtistStatusChangeFailure, ArtistStatusChangeSuccess>>
      changeStatus(ArtistStatus artist);
}
