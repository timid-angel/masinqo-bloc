import 'package:masinqo/application/admin/admin_state.dart';

abstract class AdminListenerEvent {}

abstract class AdminArtistEvent {}

class GetListeners extends AdminListenerEvent {}

class GetArtists extends AdminArtistEvent {}

class DeleteListener extends AdminListenerEvent {
  final String listenerId;
  final AdminListenersState? prevState;

  DeleteListener({required this.listenerId, this.prevState});
}

class DeleteArtist extends AdminArtistEvent {
  final String artistId;
  final AdminArtistsState? prevState;

  DeleteArtist({required this.artistId, this.prevState});
}

class ChangeArtistStatus extends AdminArtistEvent {
  final String artistId;
  final bool newBannedStatus;
  final AdminArtistsState? prevState;

  ChangeArtistStatus(
      {required this.artistId, required this.newBannedStatus, this.prevState});
}
