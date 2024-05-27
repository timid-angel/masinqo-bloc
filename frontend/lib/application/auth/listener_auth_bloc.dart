import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/auth_entities.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ListenerAuthBloc extends Bloc<ListenerAuthEvent, ListenerAuthState> {
  ListenerAuthBloc() : super(ListenerAuthState()) {
    on<ListenerLoginEvent>((event, emit) async {
      final res =
          await ListenerAuthEntity(email: event.email, password: event.password)
              .loginListener();

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
