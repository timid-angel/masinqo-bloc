import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ListenerAuthBloc extends Bloc<ListenerAuthEvent, ListenerAuthState> {
  String token = "";
  ListenerAuthBloc() : super(ListenerAuthState()) {
    on<ListenerLoginEvent>((event, emit) async {
      final res =
          await ListenerAuthEntity(email: event.email, password: event.password)
              .loginListener();

      await res.fold((l) {
        ListenerAuthState newState = ListenerAuthState();
        newState.errors = l.messages;
        emit(newState);
      }, (r) async {
        ListenerAuthState newState = ListenerAuthState();
        await SecureStorageService().writeToken(r.token);
        token = r.token; // Store token securely
        newState.token = r.token;
        emit(newState);
      });
    });

    on<ChangeLoadingStateListener>((event, emit) async {
      ListenerAuthState newState =
          ListenerAuthState(isLoading: event.newLoadingState);
      newState.errors = state.errors;
      emit(newState);
    });

    on<ResetErrorsListeners>(
        (event, emit) => emit(ListenerAuthState(isLoading: state.isLoading)));
  }
}
