abstract class AdminListenerEvent {}

abstract class AdminArtistEvent {}

class GetListeners extends AdminListenerEvent {
  final String token;

  GetListeners({required this.token});
}

class GetArtists extends AdminArtistEvent {
  final String token;

  GetArtists({required this.token});
}

class DeleteListener extends AdminListenerEvent {
  final String listenerId;
  final String token;

  DeleteListener({required this.listenerId, required this.token});
}

class DeleteArtist extends AdminArtistEvent {
  final String artistId;
  final String token;

  DeleteArtist({required this.artistId, required this.token});
}

class ChangeArtistStatus extends AdminArtistEvent {
  final String artistId;
  final bool newBannedStatus;
  final String token;

  ChangeArtistStatus({
    required this.artistId,
    required this.newBannedStatus,
    required this.token,
  });
}
