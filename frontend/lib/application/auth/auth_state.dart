class AdminAuthState {
  String token = "";
  List<String> errors = [];
  bool isLoading = false;

  AdminAuthState({this.token = "", this.isLoading = false});
}

class ArtistAuthState {
  List<String> errors = [];
  bool isLoading = false;

  ArtistAuthState({this.isLoading = false});
}

class ListenerAuthState {
  List<String> errors = [];
  bool isLoading = false;

  ListenerAuthState({this.isLoading = false});
}
