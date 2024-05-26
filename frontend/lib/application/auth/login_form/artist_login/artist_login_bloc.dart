// artist_login_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'artist_login_event.dart';

// class ArtistLoginBloc extends Bloc<ArtistLoginEvent, ArtistLoginState> {
//   final ArtistLoginRepository loginRepository;

//   ArtistLoginBloc({required this.loginRepository})
//       : super(ArtistLoginInitial());

//   Stream<ArtistLoginState> mapEventToState(ArtistLoginEvent event) async* {
//     if (event is ArtistLoginSubmitted) {
//       yield ArtistLoginLoading();
//       try {
//         await loginRepository.login(event.email, event.password);
//         yield ArtistLoginSuccess();
//       } catch (error) {
//         yield ArtistLoginFailure(error: error.toString());
//       }
//     }
//   }
// }
