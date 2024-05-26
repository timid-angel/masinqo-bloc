// listener_login_repository.dart
class ListenerLoginRepository {
  final ListenerLoginDataSource dataSource;

  ListenerLoginRepository({required this.dataSource});

  Future<void> login(String email, String password) async {
    return dataSource.login(email, password);
  }
}

// listener_login_datasource.dart
class ListenerLoginDataSource {
  final String baseUrl;

  ListenerLoginDataSource({required this.baseUrl});

  Future<void> login(String email, String password) async {
    // Perform the login API call here
    // Use http or dio package to make the API request
  }
}
