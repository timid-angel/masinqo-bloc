import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/auth/artist_auth_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
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
  final ArtistAuthBloc artistAuthBloc = ArtistAuthBloc();
  final ListenerAuthBloc listenerAuthBloc = ListenerAuthBloc();
  LoginWidget({super.key});

  void Function()? loginHandler(context) {
    void loginH() {
      if (!loginBloc.state) {
        listenerAuthBloc.add(ChangeLoadingStateListener(newLoadingState: true));

        listenerAuthBloc.add(ListenerLoginEvent(
          email: _emailController.text,
          password: _passwordController.text,
        ));
      } else {
        artistAuthBloc.add(ChangeLoadingStateArtist(newLoadingState: true));

        artistAuthBloc.add(ArtistLoginEvent(
          email: _emailController.text,
          password: _passwordController.text,
        ));
      }
    }

    return loginH;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => loginBloc),
          BlocProvider(create: (context) => artistAuthBloc),
          BlocProvider(create: (context) => listenerAuthBloc),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ArtistAuthBloc, ArtistAuthState>(
             
                listener: (context, state) {
              if (artistAuthBloc.state.errors.isEmpty &&
                  !artistAuthBloc.state.isLoading &&
                  artistAuthBloc.token.isNotEmpty) 
                  {
                context.goNamed("artist",
                pathParameters: {"token": state.token});
                  print("Artist Token: ${state.token}");
              }


              if (artistAuthBloc.state.errors.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(artistAuthBloc.state.errors[0]),
                    backgroundColor: const Color.fromARGB(255, 212, 47, 47),
                  ),
                );

                artistAuthBloc.add(ResetErrorsArtists());
              }
            }),
            BlocListener<ListenerAuthBloc, ListenerAuthState>(
                listener: (context, state) {
              if (listenerAuthBloc.state.errors.isEmpty &&
                  !listenerAuthBloc.state.isLoading &&
                  listenerAuthBloc.token.isNotEmpty) {
                context.goNamed("listener",
                    pathParameters: {"token": state.token});
                     print(" Token: ${state.token}");
                    
              }

              if (listenerAuthBloc.state.errors.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(listenerAuthBloc.state.errors[0]),
                    backgroundColor: const Color.fromARGB(255, 212, 47, 47),
                  ),
                );

                listenerAuthBloc.add(ResetErrorsListeners());
              }
            }),
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
                              context.go("/admin");
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
                                          : 'User Email',
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
                                      obscureText: true,
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                              context.go("/signup");
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
                          BlocBuilder<LoginPageBloc, bool>(
                              builder: (context, state) {
                            return ElevatedButton(
                              onPressed: loginHandler(context),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  loginBloc.state
                                      ? AppColors.artist2
                                      : AppColors.listener4,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
