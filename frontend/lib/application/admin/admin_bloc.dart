import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/admin/admin_event.dart';
import 'package:masinqo/application/admin/admin_state.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';

class ListenerBloc extends Bloc<AdminListenerEvent, AdminListenersState> {
  ListenerBloc() : super(AdminListenersState(listeners: [])) {
    on<GetListeners>((event, emit) async {
      final res =
          await AdminListenerCollection(token: event.token).getListeners();
      res.fold((l) {
        final newState = AdminListenersState(listeners: []);
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        final newState = AdminListenersState(listeners: r.listeners);
        emit(newState);
      });
    });

    on<DeleteListener>((event, emit) async {
      final res = await AdminListenerCollection(token: event.token)
          .deleteListener(event.listenerId);

      res.fold((l) {
        AdminListenersState newState;
        if (event.prevState != null) {
          newState = AdminListenersState(listeners: event.prevState!.listeners);
        } else {
          newState = AdminListenersState(listeners: []);
        }
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        emit(event.prevState ?? AdminListenersState(listeners: []));
      });
    });
  }
}

class ArtistBloc extends Bloc<AdminArtistEvent, AdminArtistsState> {
  ArtistBloc() : super(AdminArtistsState(artists: [])) {
    on<GetArtists>((event, emit) async {
      final res = await AdminArtistsCollection(token: event.token).getArtists();
      res.fold((l) {
        final newState = AdminArtistsState(artists: []);
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        final newState = AdminArtistsState(artists: r.listeners);
        emit(newState);
      });
    });

    on<DeleteArtist>((event, emit) async {
      final res = await AdminArtistsCollection(token: event.token)
          .deleteArtist(event.artistId);

      res.fold((l) {
        AdminArtistsState newState;
        if (event.prevState != null) {
          newState = AdminArtistsState(artists: event.prevState!.artists);
        } else {
          newState = AdminArtistsState(artists: []);
        }
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        emit(event.prevState ?? AdminArtistsState(artists: []));
      });
    });

    on<ChangeArtistStatus>((event, emit) async {
      final res = await AdminArtistsCollection(token: event.token)
          .changeStatus(event.artistId, event.newBannedStatus);

      res.fold((l) {
        AdminArtistsState newState;
        if (event.prevState != null) {
          newState = AdminArtistsState(artists: event.prevState!.artists);
        } else {
          newState = AdminArtistsState(artists: []);
        }
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        emit(event.prevState ?? AdminArtistsState(artists: []));
      });
    });
  }
}
