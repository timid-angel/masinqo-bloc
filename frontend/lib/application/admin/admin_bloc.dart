import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/admin/admin_event.dart';
import 'package:masinqo/application/admin/admin_state.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';

class ListenerBloc extends Bloc<AdminListenerEvent, AdminListenersState> {
  ListenerBloc() : super(AdminListenersState(listeners: [])) {
    on<GetListeners>((event, emit) async {
      final res = await AdminListenerCollection(
              adminListenersRepo: AdminListenersRepository(token: event.token))
          .getListeners();
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
      final res = await AdminListenerCollection(
              adminListenersRepo: AdminListenersRepository(token: event.token))
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
        final List<AdminListener> res = [];
        for (int i = 0; i < event.prevState!.listeners.length; i++) {
          if (event.prevState!.listeners[i].id != event.listenerId) {
            res.add(event.prevState!.listeners[i]);
          }
        }

        emit(event.prevState ?? AdminListenersState(listeners: res));
      });
    });
  }
}

class ArtistBloc extends Bloc<AdminArtistEvent, AdminArtistsState> {
  ArtistBloc() : super(AdminArtistsState(artists: [])) {
    on<GetArtists>((event, emit) async {
      final res = await AdminArtistsCollection(
        adminArtistsRepository: AdminArtistsRepository(token: event.token),
      ).getArtists();
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
      final res = await AdminArtistsCollection(
        adminArtistsRepository: AdminArtistsRepository(token: event.token),
      ).deleteArtist(event.artistId);

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
        final List<AdminArtist> res = [];
        for (int i = 0; i < event.prevState!.artists.length; i++) {
          if (event.prevState!.artists[i].id != event.artistId) {
            res.add(event.prevState!.artists[i]);
          }
        }

        emit(event.prevState ?? AdminArtistsState(artists: res));
      });
    });

    on<ChangeArtistStatus>((event, emit) async {
      final res = await AdminArtistsCollection(
        adminArtistsRepository: AdminArtistsRepository(token: event.token),
      ).changeStatus(event.artistId, event.newBannedStatus);

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
        final List<AdminArtist> res = [];
        for (int i = 0; i < event.prevState!.artists.length; i++) {
          if (event.prevState!.artists[i].id == event.artistId) {
            event.prevState!.artists[i].isBanned =
                !event.prevState!.artists[i].isBanned;
          }
          res.add(event.prevState!.artists[i]);
        }

        emit(event.prevState ?? AdminArtistsState(artists: res));
      });
    });
  }
}
