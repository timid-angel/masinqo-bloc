import 'package:masinqo/application/admin/admin_state.dart';

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
  final AdminListenersState? prevState;
  final String token;

  DeleteListener(
      {required this.listenerId, this.prevState, required this.token});
}

class DeleteArtist extends AdminArtistEvent {
  final String artistId;
  final AdminArtistsState? prevState;
  final String token;

  DeleteArtist({required this.artistId, this.prevState, required this.token});
}

class ChangeArtistStatus extends AdminArtistEvent {
  final String artistId;
  final bool newBannedStatus;
  final String token;
  final AdminArtistsState? prevState;

  ChangeArtistStatus(
      {required this.artistId,
      required this.newBannedStatus,
      this.prevState,
      required this.token});
}
