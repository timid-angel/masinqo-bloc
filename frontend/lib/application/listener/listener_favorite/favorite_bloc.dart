import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_events.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final ListenerFavCollection favoriteRepository;

  FavoriteBloc({required this.favoriteRepository}) : super(EmptyFavorite()) {
    on<FetchFavorites>((event, emit) async {
      try {
        final favorites = await favoriteRepository.getFavorites(event.token);
        if (favorites.isEmpty) {
          emit(EmptyFavorite());
        } else {
          emit(LoadedFavorite(favorites));
        }
      } catch (e) {
        emit(ErrorFavorite(e.toString()));
      }
    });

    on<AddFavorite>((event, emit) async {
      try {
        await favoriteRepository.addFavorite(event.id, event.token);
        final favorites = await favoriteRepository.getFavorites(event.token);
        emit(LoadedFavorite(favorites));
      } catch (e) {
        emit(ErrorFavorite(e.toString()));
      }
    });

    on<DeleteFavorite>((event, emit) async {
      try {
        await favoriteRepository.deleteFavorite(event.id, event.token);
        final favorites = await favoriteRepository.getFavorites(event.token);
        emit(LoadedFavorite(favorites));
      } catch (e) {
        emit(ErrorFavorite(e.toString()));
      }
    });
  }
}
