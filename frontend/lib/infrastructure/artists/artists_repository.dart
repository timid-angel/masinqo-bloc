import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/core.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_data_source.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/infrastructure/artists/artists_failure.dart';
import 'package:masinqo/infrastructure/artists/artists_success.dart';

class ArtistsRepository implements ArtistsRepositoryInterface {
  final String token;

  ArtistsRepository({required this.token});

  @override
  Future<Either<ArtistFailure, Success>> addAlbum(
      CreateAlbumDTO albumDto) async {
    Map<String, String> body = <String, String>{};
    if (albumDto.title.isNotEmpty) {
      body["title"] = albumDto.title;
    }

    if (albumDto.genre.isNotEmpty) {
      body["genre"] = albumDto.genre;
    }

    if (albumDto.description.isNotEmpty) {
      body["description"] = albumDto.description;
    }

    if (albumDto.type.isNotEmpty) {
      body["type"] = albumDto.type;
    } else {
      body["type"] = "Album";
    }

    http.StreamedResponse response = await ArtistsDataSource(token: token).addAlbum(
      body,
      albumDto.albumArt,
    );

    if (response.statusCode != 201) {
      return Left(
          ArtistFailure(message: await response.stream.bytesToString()));
    }

    return Right(ArtistsSuccess());
  }

  @override
  Future<Either<ArtistFailure, Success>> addSong(
      CreateSongDTO songDto, String songFilePath) async {
    http.StreamedResponse response = await ArtistsDataSource(token: token)
        .addSong(songDto.albumId, songDto.songName, songFilePath);

    if (response.statusCode != 201) {
      return Left(
          ArtistFailure(message: await response.stream.bytesToString()));
    }

    return Right(ArtistsSuccess());
  }

  @override
  Future<Either<ArtistFailure, Success>> deleteAlbum(String albumId) async {
    http.Response response =
        await ArtistsDataSource(token: token).deleteAlbum(albumId);

    if (response.statusCode != 200) {
      return Left(ArtistFailure(message: response.body));
    }

    return Right(ArtistsSuccess());
  }

  @override
  Future<Either<ArtistFailure, GetAlbumsSuccess>> getAlbums() async {
    http.Response response = await ArtistsDataSource(token: token).getAlbums();

    if (response.statusCode != 200) {
      return Left(ArtistFailure(message: response.body));
    }

    return Right(GetAlbumsSuccess(albums: jsonDecode(response.body)));
  }

  @override
  Future<Either<ArtistFailure, GetSongsSuccess>> getSongs(
      String albumId) async {
    http.Response response =
        await ArtistsDataSource(token: token).getSongs(albumId);

    if (response.statusCode != 200) {
      return Left(ArtistFailure(message: response.body));
    }
    Map album = jsonDecode(response.body);
    return Right(GetSongsSuccess(songs: album["songs"]));
  }

  @override
  Future<Either<ArtistFailure, Success>> removeSong(
      String albumId, String songName) async {
    http.Response response =
        await ArtistsDataSource(token: token).deleteSong(albumId, songName);

    if (response.statusCode != 200) {
      return Left(ArtistFailure(message: response.body));
    }

    return Right(ArtistsSuccess());
  }

  @override
  Future<Either<ArtistFailure, Success>> updateAlbum(
      UpdateAlbumDTO updateDto) async {
    Map<String, String> body = <String, String>{};
    if (updateDto.title.isNotEmpty) {
      body["title"] = updateDto.title;
    }

    if (updateDto.genre.isNotEmpty) {
      body["genre"] = updateDto.genre;
    }

    if (updateDto.description.isNotEmpty) {
      body["description"] = updateDto.description;
    }

    http.Response response = await ArtistsDataSource(token: token)
        .updateAlbum(updateDto.albumId, body);

    if (response.statusCode != 200) {
      return Left(ArtistFailure(message: response.body));
    }

    return Right(ArtistsSuccess());
  }

  @override
  Future<Either<ArtistFailure, Success>> updateInformation(
      UpdateArtistInformatioDTO artist) async {
    Map<String, String> body = <String, String>{};
    if (artist.email.isNotEmpty) {
      body["email"] = artist.email;
    }

    if (artist.name.isNotEmpty) {
      body["name"] = artist.name;
    }

    if (artist.password.isNotEmpty) {
      body["password"] = artist.password;
    }

    http.StreamedResponse response =
        await ArtistsDataSource(token: token).updateArtistInfo(
      body,
      artist.profilePictureFilePath,
    );

    if (response.statusCode != 200) {
      return Left(
          ArtistFailure(message: await response.stream.bytesToString()));
    }

    return Right(ArtistsSuccess());
  }
}

// void main() async {
//   final ArtistsRepository artistRepo = ArtistsRepository(
//       token:
//           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTI5YzBmNTEwZTU4ZGRlYmJkYTk1MSIsInJvbGUiOjEsImlhdCI6MTcxNjY5OTM3MCwiZXhwIjoxNzE2Nzg1NzcwfQ.hptWAQD0UigjLi4yOtv4YpAte45If_UDNHhu1EHmyLE");

  // get albums
  // final res = await artistRepo.getAlbums();
  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r.albums);
  // });

  // add albums
  // String albumArtPath = "./transformer.png";
  // final res = await artistRepo.addAlbum(CreateAlbumDTO(
  //     type: "Album",
  //     title: "That's a lie",
  //     genre: "Punk",
  //     description: "this is a description",
  //     albumArt: albumArtPath));

  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r);
  // });

  // update albums
  // final res = await artistRepo.updateAlbum(UpdateAlbumDTO(
  //     albumId: "6652cbc78fed1d2eef050c47",
  //     title: "TRUTHTH",
  //     genre: "CULT MUSIC",
  //     description: ""));

  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r);
  // });

  // // delete albums
  // final res = await artistRepo.deleteAlbum("6652cbc78fed1d2eef050c47");

  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r);
  // });

  // 6652cdfe8fed1d2eef050c57

  // get songs
  // final res = await artistRepo.getSongs("6652cdfe8fed1d2eef050c57");
  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r.songs);
  // });

  // add songs
  // final res = await artistRepo.addSong(
  //   CreateSongDTO(
  //     songName: "The Heart Part V",
  //     albumId: "6652cdfe8fed1d2eef050c57",
  //   ),
  //   "./02. Seatbelts - Tank! (TV Edit).mp3",
  // );

  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r.toString());
  // });

  // delete songs
  // final res = await artistRepo.removeSong(
  //     "6652cdfe8fed1d2eef050c57", "Cry me a river 2");
  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r.toString());
  // });

  // update information
  // final res = await artistRepo.updateInformation(
  //     UpdateArtistInformatioDTO("", name: "", email: "", password: ""));
  // res.fold((l) {
  //   print(l.message);
  // }, (r) {
  //   print(r.toString());
  // });
// }
