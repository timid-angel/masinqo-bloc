import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';

class AdminListenersState {
  final List<AdminListener> listeners;
  String errorMessages = "";
  AdminListenersState({required this.listeners});
}

class AdminArtistsState {
  final List<AdminArtist> artists;
  String errorMessages = "";
  AdminArtistsState({required this.artists});
}
