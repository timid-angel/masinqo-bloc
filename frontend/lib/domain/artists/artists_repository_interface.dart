import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

abstract class ArtistsRepositoryInterface {
  Future<Either<Failure, Success>> getAlbums();
  Future<Either<Failure, Success>> addAlbum(CreateAlbumDTO albumDto);
  Future<Either<Failure, Success>> deleteAlbum(String albumId);
  Future<Either<Failure, Success>> updateAlbum(UpdateAlbumDTO updateDto);
  Future<Either<Failure, Success>> getSong();
  Future<Either<Failure, Success>> addSong();
  Future<Either<Failure, Success>> removeSong();
}
