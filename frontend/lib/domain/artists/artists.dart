import 'package:dartz/dartz.dart';
import 'package:masinqo/domain/artists/artists_failure.dart';
import 'package:masinqo/domain/artists/artists_success.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/infrastructure/artists/artists_repository.dart';

class ArtistEntity {
  final String token;

  ArtistEntity({required this.token});

  Future<Either<ArtistEntityFailure, GetArtistInformationSuccess>>
      getArtistInformation() async {
    final res = await ArtistsRepository(token: token).getArtistInformation();

    return res.fold((l) {
      return Left(ArtistEntityFailure(message: l.message));
    }, (r) {
      return Right(r);
    });
  }

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> addAlbum(
      CreateAlbumDTO albumDto) async {
    if (token.isEmpty) {
      return Left(ArtistEntityFailure(message: "Invalid token"));
    }

    if (albumDto.title.isEmpty) {
      return Left(ArtistEntityFailure(message: "Title too short"));
    }

    if (albumDto.albumArt.isEmpty) {
      return Left(ArtistEntityFailure(message: "Album must have an image"));
    }

    if (albumDto.genre.isEmpty) {
      return Left(ArtistEntityFailure(message: "Genre can not be empty"));
    }

    final res = await ArtistsRepository(token: token).addAlbum(albumDto);
    return res.fold((l) {
      return Left(ArtistEntityFailure(message: l.message));
    }, (r) {
      return Right(ArtistEntitySuccess());
    });
  }

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> addSong(
      CreateSongDTO songDto, String songFilePath) async {
    if (songFilePath.isEmpty) {
      return Left(ArtistEntityFailure(message: "Song must have an audio file"));
    }

    final List<String> extensions = ["png", "jpg", "jpeg"];
    if (extensions.contains(songFilePath.split(".").last)) {
      return Left(ArtistEntityFailure(message: "Song must have an audio file"));
    }

    if (songDto.songName.isEmpty) {
      return Left(ArtistEntityFailure(message: "Song must have a name"));
    }

    final res =
        await ArtistsRepository(token: token).addSong(songDto, songFilePath);

    return res.fold((l) {
      return Left(ArtistEntityFailure(message: l.message));
    }, (r) {
      return Right(ArtistEntitySuccess());
    });
  }

  Future<Either<ArtistEntityFailure, ArtistGetAlbumsSuccess>>
      getAlbums() async {
    final res = await ArtistsRepository(token: token).getAlbums();

    return res.fold(
      (l) {
        return Left(ArtistEntityFailure(message: l.message));
      },
      (r) {
        return Right(ArtistGetAlbumsSuccess(albums: r.albums));
      },
    );
  }

  Future<Either<ArtistEntityFailure, ArtistGetSongsSuccess>> getSongs(
      String albumId) async {
    final res = await ArtistsRepository(token: token).getSongs(albumId);

    return res.fold(
      (l) {
        return Left(ArtistEntityFailure(message: l.message));
      },
      (r) {
        return Right(ArtistGetSongsSuccess(songs: r.songs));
      },
    );
  }

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> removeSong(
      String albumId, String songName) async {
    final res =
        await ArtistsRepository(token: token).removeSong(albumId, songName);

    return res.fold(
      (l) {
        return Left(ArtistEntityFailure(message: l.message));
      },
      (r) {
        return Right(ArtistEntitySuccess());
      },
    );
  }

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> removeAlbum(
      String albumId) async {
    final res = await ArtistsRepository(token: token).deleteAlbum(albumId);

    return res.fold(
      (l) {
        return Left(ArtistEntityFailure(message: l.message));
      },
      (r) {
        return Right(ArtistEntitySuccess());
      },
    );
  }

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> updateAlbum(
      UpdateAlbumDTO updateDto) async {
    final res = await ArtistsRepository(token: token).updateAlbum(updateDto);

    return res.fold(
      (l) {
        return Left(ArtistEntityFailure(message: l.message));
      },
      (r) {
        return Right(ArtistEntitySuccess());
      },
    );
  }

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> updateInformation(
      UpdateArtistInformatioDTO artist) async {
    final res = await ArtistsRepository(token: token).updateInformation(artist);

    return res.fold(
      (l) {
        return Left(ArtistEntityFailure(message: l.message));
      },
      (r) {
        return Right(ArtistEntitySuccess());
      },
    );
  }
}
