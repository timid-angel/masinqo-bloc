import 'package:masinqo/core.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';

class AdminSuccess implements Success {}

class GetListenersSuccess implements Success {
  final List<AdminListener> listeners;

  GetListenersSuccess({required this.listeners});
}

class GetArtistsSuccess implements Success {
  final List<AdminArtist> listeners;

  GetArtistsSuccess({required this.listeners});
}
