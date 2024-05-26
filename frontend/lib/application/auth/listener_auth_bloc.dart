import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/auth_entities.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ListenerAuthBloc extends Bloc<ListenerAuthEvent, ListenerAuthState> {
  final ListenerLoginRepository loginRepository;

  ListenerAuthBloc(this.loginRepository) : super(ListenerAuthState()) {
    on<ListenerLoginEvent>((event, emit) async {
      final ListenerAuthEntity user =
          ListenerAuthEntity(email: event.email, password: event.password);
      emit(ListenerAuthState());

      final res = await user.loginListener();
      res.fold((l) {
        ListenerAuthState newState = ListenerAuthState();
        newState.errors = l.messages;
        emit(newState);
      }, (r) async {
        ListenerAuthState newState = ListenerAuthState();
        await SecureStorageService()
            .writeToken(r.token); // Store token securely
        emit(newState);
      });
    });
  }
}
