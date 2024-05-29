abstract class FavoriteEvent {}

class FetchFavorites extends FavoriteEvent {
  final String token;
  FetchFavorites({required this.token});
}

class AddFavorite extends FavoriteEvent {
  final String token;
  final String id;
  AddFavorite({required this.token, required this.id});
}

class DeleteFavorite extends FavoriteEvent {
  final String token;
  final String id;
  DeleteFavorite({required this.token, required this.id});
}
