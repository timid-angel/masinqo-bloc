import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';

class ArtistFetchSuccess {
  final List<AdminArtist> artists;

  ArtistFetchSuccess({required this.artists});
}

class ArtistDeleteSuccess {}

class ArtistStatusChangeSuccess {}
