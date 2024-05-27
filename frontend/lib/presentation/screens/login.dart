import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/auth/artist_auth_bloc.dart';
import 'package:masinqo/application/auth/listener_auth_bloc.dart';
import 'package:masinqo/application/auth/login_page_bloc.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/main_login_textfield.dart';
import 'package:masinqo/presentation/widgets/background.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';
import 'package:masinqo/presentation/widgets/login_options.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginPageBloc loginBloc = LoginPageBloc();
  LoginWidget({super.key});

  // void loginHandler() {
  //   if (!_isArtist) {
  //     context.pushNamed(
  //       "listener",
  //       extra: ListenerHomePageData(
  //         albums: db.albums,
  //         favorites: db.listeners[2].favorites,
  //         playlists: db.playlists,
  //       ),
  //     );
  //   } else {
  //     context.pushNamed("artist");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => loginBloc),
        BlocProvider(create: (context) => ArtistAuthBloc()),
        BlocProvider(create: (context) => ListenerAuthBloc()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight,
            child: BackgroundGradient(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed("admin");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Brand(
                              text: 'Masinqo',
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<LoginPageBloc, bool>(
                              builder: (context, state) {
                                return NormalLoginTextfield(
                                  controller: _emailController,
                                  fieldText: loginBloc.state
                                      ? 'Artist Email'
                                      : 'User email',
                                  icon: Icons.mail,
                                  loginBloc: loginBloc,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<LoginPageBloc, bool>(
                              builder: (context, state) {
                                return NormalLoginTextfield(
                                  controller: _passwordController,
                                  fieldText: 'Password',
                                  icon: Icons.lock,
                                  loginBloc: loginBloc,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                  flex: 5,
                                  child: LoginOptionButton(
                                    isArtist: loginBloc.state,
                                    primaryColor: AppColors.artist2,
                                    buttonText: 'Login as Artist',
                                    toValue: true,
                                    loginBloc: loginBloc,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  flex: 6,
                                  child: LoginOptionButton(
                                    isArtist: loginBloc.state,
                                    primaryColor: AppColors.listener2,
                                    buttonText: 'Login as Listener',
                                    toValue: false,
                                    loginBloc: loginBloc,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed("signup");
                        },
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            foregroundColor: AppColors.fontColor),
                        child: const Text("Don't have an account?"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // if (loginBloc.state) {
                          //   BlocProvider.of<ListenerAuthBloc>(context).add(
                          //       ListenerLoginEvent(
                          //           email: email, password: password));
                          // } else {
                          //   BlocProvider.of<ArtistAuthBloc>(context).add(
                          //       ArtistLoginEvent(
                          //           email: email, password: password));
                          // }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            loginBloc.state
                                ? AppColors.artist2
                                : AppColors.listener4,
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
