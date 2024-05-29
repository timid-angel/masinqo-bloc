import 'package:masinqo/domain/entities/albums.dart';

abstract class FavoriteState {}

class EmptyFavorite extends FavoriteState {}

class LoadedFavorite extends FavoriteState {
  final List<Album> favorites;

  LoadedFavorite(this.favorites);
}

class ErrorFavorite extends FavoriteState {
  final String error;

  ErrorFavorite(this.error);
}
