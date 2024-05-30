import 'package:masinqo/domain/entities/profile.dart';
import 'package:masinqo/domain/listener/listener_profile_repo.dart';
import 'package:masinqo/infrastructure/listener/listener_profile/listener_profile_service.dart';

class ListenerProfileRepository implements ProfileRepository {
  final ListenerProfileService listenerProfileService;
  ListenerProfileRepository(this.listenerProfileService);

  @override
  Future<Profile> getProfile(String token) async {
    final ress = await listenerProfileService.getProfile(token);
    return ress;
  }

  @override
  Future<Profile> editProfile(
      String token, String name, String email, String password) async {
    await listenerProfileService.editProfile(token, name, email, password);
    final profile = await listenerProfileService.getProfile(token);
    return profile;
  }
}

// void main() async {
//   ListenerProfileRepository lpr =
//       ListenerProfileRepository(ListenerProfileService());
//   final res = await lpr.getProfile(
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTg5OTFkNGQ5N2RlOWI5YTllMThhZiIsInJvbGUiOjIsImlhdCI6MTcxNzA4NTQ5MCwiZXhwIjoxNzE3MTcxODkwfQ.eRDN3GtVYS1MWePQfJhGXv8va70ufVp5XOsHbY6oT5c");
//   print(res.name);
//   final edited = await lpr.editProfile(
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTg5OTFkNGQ5N2RlOWI5YTllMThhZiIsInJvbGUiOjIsImlhdCI6MTcxNzA4NTQ5MCwiZXhwIjoxNzE3MTcxODkwfQ.eRDN3GtVYS1MWePQfJhGXv8va70ufVp5XOsHbY6oT5c",
//       "name",
//       "newasdaas",
//       "password");
//   print(edited.name);

//   final ress = await lpr.getProfile(
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTg5OTFkNGQ5N2RlOWI5YTllMThhZiIsInJvbGUiOjIsImlhdCI6MTcxNzA4NTQ5MCwiZXhwIjoxNzE3MTcxODkwfQ.eRDN3GtVYS1MWePQfJhGXv8va70ufVp5XOsHbY6oT5c");
//   print(ress.name);
// }
