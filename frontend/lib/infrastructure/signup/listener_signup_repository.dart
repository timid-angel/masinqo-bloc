// import 'package:masinqo/domain/signup/listener.dart';
// import 'package:masinqo/infrastructure/signup/listener_signup_datasource.dart';

// class ListenerSignupRepository {
//   final ListenerSignupDataSource dataSource;

//   ListenerSignupRepository({required this.dataSource});

//   Future<bool> signupListener(Listeners listener, String confirmPassword) async {
//     try {
//       bool success = await dataSource.signupListener(listener, confirmPassword);
//       return success;
//     } catch (e) {
//       print('Error signing up Listener: $e');
//       return false;
//     }
//   }
// }
