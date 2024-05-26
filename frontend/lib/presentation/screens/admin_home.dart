import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/admin/admin_bloc.dart';
import 'package:masinqo/application/auth/admin_auth_bloc.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/presentation/widgets/admin_artist_mgt.dart';
import 'package:masinqo/presentation/widgets/admin_listener_mgt.dart';
import 'package:masinqo/presentation/widgets/admin_tabs.dart';
import 'package:masinqo/presentation/widgets/background.dart';

class AdminHome extends StatelessWidget {
  final String tk;
  const AdminHome({super.key, required this.tk});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ListenerBloc()),
        BlocProvider(create: (BuildContext context) => ArtistBloc()),
        BlocProvider(
          create: (BuildContext context) {
            final authBloc =
                AdminAuthBloc(authRepository: AdminLoginRepository());
            final token = tk.split(";")[0];
            authBloc.state.token = token;
            return authBloc;
          },
        )
      ],
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: const BackgroundGradient(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: TabBarView(
                  children: [
                    AdminArtistMGT(),
                    AdminListenerMGT(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.transparent,
                height: 55,
                child: AdminTabs(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
