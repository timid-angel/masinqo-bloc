import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

abstract class ArtistsRepositoryInterface {
  Future<Either<Failure, Success>> getAlbums();
  Future<Either<Failure, Success>> addAlbum(CreateAlbumDTO albumDto);
  Future<Either<Failure, Success>> deleteAlbum(String albumId);
  Future<Either<Failure, Success>> updateAlbum(UpdateAlbumDTO updateDto);
  Future<Either<Failure, Success>> getSongs(String albumId);
  Future<Either<Failure, Success>> addSong(
      CreateSongDTO songDto, String songFilePath);
  Future<Either<Failure, Success>> removeSong(String albumId, String songName);
  Future<Either<Failure, Success>> updateInformation(
      UpdateArtistInformatioDTO artist);
  Future<Either<Failure, Success>> getArtistInformation();
}
