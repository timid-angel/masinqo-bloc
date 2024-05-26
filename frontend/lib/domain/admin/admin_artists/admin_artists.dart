import 'package:dartz/dartz.dart';
import 'package:masinqo/domain/admin/admin_failure.dart';
import 'package:masinqo/domain/admin/admin_success.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';

class AdminArtistsCollection {
  late List<AdminArtist> listeners;
  final String token;

  AdminArtistsCollection({required this.token});
  Future<Either<AdminFailure, GetArtistsSuccess>> getArtists() async {
    if (token.isEmpty) {
      return Left(AdminFailure(message: "Invalid token"));
    }

    final res = await AdminArtistsRepository(token: token).getArtists();
    res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(GetArtistsSuccess(
          listeners: r.artists
              .map(
                (a) => AdminArtist(
                  id: a.id,
                  email: a.email,
                  name: a.name,
                  isBanned: a.isBanned,
                  profilePicture: a.profilePicture,
                ),
              )
              .toList()));
    });

    return Left(AdminFailure(message: "Unknown Error"));
  }

  Future<Either<AdminFailure, AdminSuccess>> deleteArtist(String id) async {
    if (token.isEmpty) {
      return Left(AdminFailure(message: "Invalid token"));
    }
    final res = await AdminArtistsRepository(token: token)
        .deleteArtist(ArtistID(id: id));

    res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(AdminSuccess());
    });

    return Left(AdminFailure(message: "Unknown Error"));
  }

  Future<Either<AdminFailure, AdminSuccess>> changeStatus(
      String id, bool newBannedStatus) async {
    if (token.isEmpty) {
      return Left(AdminFailure(message: "Invalid token"));
    }
    final res = await AdminArtistsRepository(token: token)
        .changeStatus(ArtistStatus(id: id, newBannedStatus: newBannedStatus));

    res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(AdminSuccess());
    });

    return Left(AdminFailure(message: "Unknown Error"));
  }
}

class AdminArtist {
  final String email;
  final String id;
  final String name;
  final bool isBanned;
  final String profilePicture;

  AdminArtist({
    required this.id,
    required this.email,
    required this.name,
    required this.isBanned,
    required this.profilePicture,
  });
}
