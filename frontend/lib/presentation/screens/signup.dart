import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/login_brand.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_signup_textfield.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_datasource.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_bloc.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_event.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_bloc.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_event.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class SignupWidget extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> _isArtist = ValueNotifier(true);

  SignupWidget({Key? key}) : super(key: key);

  void Function()? signupHandler(BuildContext context) {
    void signupH() {
      if (_isArtist.value) {
        final artistDto = ArtistSignupDTO(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        final confirmPassword = _confirmPasswordController.text;
        final artist = artistDto.toArtist();

        print("Artist signup event dispatched");
        BlocProvider.of<ArtistSignupBloc>(context).add(ArtistSignupEvent(
          artist: artist,
          confirmPassword: confirmPassword,
        ));
      } else {
        final listenerDto = ListenerSignupDTO(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        final confirmPassword = _confirmPasswordController.text;
        final listener = listenerDto.toListener();

        print("Listener signup event dispatched");
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
          create: (context) => ArtistSignupBloc(
            signupRepository: ArtistSignupRepository(
              dataSource: ArtistSignupDataSource(),
            ),
          ),
        ),
        BlocProvider<ListenerSignupBloc>(
          create: (context) => ListenerSignupBloc(
            signupRepository: ListenerSignupRepository(
              dataSource: ListenerSignupDataSource(),
            ),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ArtistSignupBloc, ArtistSignupState>(
            listener: (context, state) {
              print("ArtistSignupBloc state: $state");
              if (state is ArtistSignupSuccess) {
                context.go("/artist");
              } else if (state is ArtistSignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: const Color.fromARGB(255, 212, 47, 47),
                  ),
                );
              }
            },
          ),
          BlocListener<ListenerSignupBloc, ListenerSignupState>(
            listener: (context, state) {
              print("ListenerSignupBloc state: $state");
              if (state is ListenerSignupSuccess) {
                context.go("/listener");
              } else if (state is ListenerSignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: const Color.fromARGB(255, 212, 47, 47),
                  ),
                );
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: ValueListenableBuilder<bool>(
                valueListenable: _isArtist,
                builder: (context, isArtist, _) {
                  return Container(
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
                            padding: const EdgeInsets.all(22.0),
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
                                  hintText: "Username",
                                  controller: _usernameController,
                                  isArtist: isArtist,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: isArtist ? AppColors.artist2 : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  hintText: "Email",
                                  controller: _emailController,
                                  isArtist: isArtist,
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: isArtist ? AppColors.artist2 : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  hintText: "Password",
                                  controller: _passwordController,
                                  isArtist: isArtist,
                                
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: isArtist ? AppColors.artist2 : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  hintText: "Confirm Password",
                                  controller: _confirmPasswordController,
                                  isArtist: isArtist,
                                  
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: isArtist ? AppColors.artist2 : AppColors.listener4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        _isArtist.value = true;
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: isArtist ? AppColors.artist2 : Colors.white,
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
                                          color: isArtist ? AppColors.artist2 : Colors.white,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _isArtist.value = false;
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: isArtist ? Colors.white : AppColors.listener4,
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
                                          color: isArtist ? Colors.white : const Color.fromARGB(255, 193, 53, 217),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: signupHandler(context),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      isArtist ? AppColors.artist2 : AppColors.listener4,
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Signup',
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ),
  );
}
