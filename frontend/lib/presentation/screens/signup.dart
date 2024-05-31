import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/login_brand.dart';
import '../core/theme/app_colors.dart';
import '../widgets/signup_textfield.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_bloc.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_event.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_bloc.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_event.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class SignupWidget extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _isArtist = ValueNotifier(true);

  SignupWidget({super.key});

  void Function()? signupHandler(BuildContext context) {
    void signupH() {
      if (_isArtist.value) {
        final artistDto = ArtistSignupDTO(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
        final confirmPassword = _confirmPasswordController.text;
        final artist = artistDto.toArtist();

        BlocProvider.of<ArtistSignupBloc>(context).add(ArtistSignupEvent(
          artist: artist,
          confirmPassword: confirmPassword,
        ));
      } else {
        final listenerDto = ListenerSignupDTO(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
        final confirmPassword = _confirmPasswordController.text;
        final listener = listenerDto.toListener();

        BlocProvider.of<ListenerSignupBloc>(context).add(ListenerSignupEvent(
          listener: listener,
          confirmPassword: confirmPassword,
        ));
      }
    }

    return signupH;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArtistSignupBloc>(
          create: (context) => ArtistSignupBloc(),
        ),
        BlocProvider<ListenerSignupBloc>(
          create: (context) => ListenerSignupBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ArtistSignupBloc, ArtistSignupState>(
            listener: (context, state) {
              if (state is ArtistSignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account created succesfully!"),
                    backgroundColor: Color.fromARGB(255, 73, 158, 27),
                  ),
                );
                Future.delayed(const Duration(milliseconds: 1500))
                    .then((d) => context.go("/login"));
              } else if (state is ArtistSignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: const Color.fromARGB(255, 212, 47, 47),
                  ),
                );
                BlocProvider.of<ArtistSignupBloc>(context).add(AResetState());
              }
            },
          ),
          BlocListener<ListenerSignupBloc, ListenerSignupState>(
            listener: (context, state) {
              if (state is ListenerSignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account created succesfully!"),
                    backgroundColor: Color.fromARGB(255, 73, 158, 27),
                  ),
                );
                Future.delayed(const Duration(milliseconds: 1500))
                    .then((d) => context.go("/login"));
              } else if (state is ListenerSignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: const Color.fromARGB(255, 212, 47, 47),
                  ),
                );
                BlocProvider.of<ListenerSignupBloc>(context).add(LResetState());
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: AppColors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: ValueListenableBuilder<bool>(
              valueListenable: _isArtist,
              builder: (context, isArtist, _) {
                return Center(
                  child: Container(
                    height: deviceHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/uncle.jpg'),
                        fit: BoxFit.cover,
                        opacity: 0.2,
                        colorFilter: ColorFilter.mode(
                          isArtist
                              ? const Color.fromARGB(11, 0, 187, 212)
                              : const Color.fromARGB(11, 164, 53, 183),
                          BlendMode.color,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Brand(
                                  text: 'Masinqo',
                                  size: 50,
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  key: const Key('username_field'),
                                  hintText: "Username",
                                  controller: _usernameController,
                                  isArtist: isArtist,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: isArtist
                                        ? AppColors.artist2
                                        : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  key: const Key('email_field'),
                                  hintText: "Email",
                                  controller: _emailController,
                                  isArtist: isArtist,
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: isArtist
                                        ? AppColors.artist2
                                        : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  key: const Key('password_field'),
                                  hintText: "Password",
                                  controller: _passwordController,
                                  isArtist: isArtist,
                                  obscureText: true,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: isArtist
                                        ? AppColors.artist2
                                        : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  key: const Key('confirm_password_field'),
                                  hintText: "Confirm Password",
                                  controller: _confirmPasswordController,
                                  isArtist: isArtist,
                                  obscureText: true,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: isArtist
                                        ? AppColors.artist2
                                        : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    TextButton(
                                      key: const Key('Artist_op'),
                                      onPressed: () {
                                        _isArtist.value = true;
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.transparent),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: isArtist
                                                  ? AppColors.artist2
                                                  : Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Artist Signup',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: isArtist
                                              ? AppColors.artist2
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      key: const Key('Listener_op'),
                                      onPressed: () {
                                        _isArtist.value = false;
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.transparent),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: isArtist
                                                  ? Colors.white
                                                  : AppColors.listener4,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Listener Signup',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: isArtist
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 193, 53, 217),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  key: const Key('signup_button'),
                                  onPressed: signupHandler(context),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      isArtist
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
                                    'Signup',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
