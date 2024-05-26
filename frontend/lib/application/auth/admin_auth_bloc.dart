import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/auth_entities.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';

class AdminAuthBloc extends Bloc<AdminAuthEvent, AdminAuthState> {
  final AdminLoginRepository authRepository;

  AdminAuthBloc({required this.authRepository}) : super(AdminAuthState()) {
    on<AdminLoginEvent>((event, emit) async {
      final AdminAuthEntity user =
          AdminAuthEntity(email: event.email, password: event.password);
      emit(AdminAuthState(token: "", isLoading: true));

      final res = await user.loginAdmin();
      res.fold((l) {
        AdminAuthState newState = AdminAuthState(token: "");
        newState.errors = l.messages;
        emit(newState);
      }, (r) {
        AdminAuthState newState = AdminAuthState(token: r.token);
        emit(newState);
      });
    });
  }
}
