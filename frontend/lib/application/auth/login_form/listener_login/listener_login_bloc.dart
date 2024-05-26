// listener_login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'listener_login_event.dart';
import 'listener_login_state.dart';
import '../../../../infrastructure/auth/listener/listener_login_repository.dart';

class ListenerLoginBloc extends Bloc<ListenerLoginEvent, ListenerLoginState> {
  final ListenerLoginRepository loginRepository;

  ListenerLoginBloc({required this.loginRepository}) : super(ListenerLoginInitial());


  Stream<ListenerLoginState> mapEventToState(ListenerLoginEvent event) async* {
    if (event is ListenerLoginSubmitted) {
      yield ListenerLoginLoading();
      try {
        await loginRepository.login(event.email, event.password);
        yield ListenerLoginSuccess();
      } catch (error) {
        yield ListenerLoginFailure(error: error.toString());
      }
    }
  }
}
