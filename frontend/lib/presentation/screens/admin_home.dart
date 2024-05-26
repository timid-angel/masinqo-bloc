import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/admin/admin_bloc.dart';
import 'package:masinqo/application/auth/auth_bloc.dart';
import 'package:masinqo/infrastructure/auth/login_repository.dart';
import '../widgets/admin_listener_mgt.dart';
import '../widgets/admin_artist_mgt.dart';
import '../widgets/background.dart';
import '../widgets/admin_tabs.dart';

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
            final authBloc = AuthBloc(authRepository: LoginRepository());
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
