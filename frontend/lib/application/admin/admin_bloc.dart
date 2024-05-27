import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/admin/admin_event.dart';
import 'package:masinqo/application/admin/admin_state.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';

class ListenerBloc extends Bloc<AdminListenerEvent, AdminListenersState> {
  ListenerBloc(String token) : super(AdminListenersState(listeners: [])) {
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
        AdminListenersState newState =
            AdminListenersState(listeners: state.listeners);
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        final List<AdminListener> res = [];
        for (int i = 0; i < state.listeners.length; i++) {
          if (state.listeners[i].id != event.listenerId) {
            res.add(state.listeners[i]);
          }
        }

        emit(AdminListenersState(listeners: res));
      });
    });
    add(GetListeners(token: token));
  }
}

class ArtistBloc extends Bloc<AdminArtistEvent, AdminArtistsState> {
  ArtistBloc(String token) : super(AdminArtistsState(artists: [])) {
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
        AdminArtistsState newState = AdminArtistsState(artists: state.artists);
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        final List<AdminArtist> res = [];
        for (int i = 0; i < state.artists.length; i++) {
          if (state.artists[i].id != event.artistId) {
            res.add(state.artists[i]);
          }
        }

        emit(AdminArtistsState(artists: res));
      });
    });

    on<ChangeArtistStatus>((event, emit) async {
      final res = await AdminArtistsCollection(
        adminArtistsRepository: AdminArtistsRepository(token: event.token),
      ).changeStatus(event.artistId, event.newBannedStatus);

      res.fold((l) {
        AdminArtistsState newState = AdminArtistsState(artists: state.artists);
        newState.errorMessages = l.message;
        emit(newState);
      }, (r) {
        final List<AdminArtist> res = [];
        for (int i = 0; i < state.artists.length; i++) {
          if (state.artists[i].id == event.artistId) {
            state.artists[i].isBanned = !state.artists[i].isBanned;
          }
          res.add(state.artists[i]);
        }

        emit(AdminArtistsState(artists: res));
      });
    });
    add(GetArtists(token: token));
  }
}
