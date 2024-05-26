import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:masinqo/application/auth/admin_auth_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/application/auth/login_form/admin_login/admin_login_bloc.dart';
import 'package:masinqo/application/auth/login_form/admin_login/admin_login_event.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';
import 'package:masinqo/presentation/widgets/admin_login_button.dart';
import 'package:masinqo/presentation/widgets/admin_login_textfield.dart';

class AdminLogin extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                AdminAuthBloc(authRepository: AdminLoginRepository())),
        BlocProvider(create: (BuildContext context) => PasswordErrorBloc()),
        BlocProvider(create: (BuildContext context) => EmailErrorBloc()),
        BlocProvider(create: (BuildContext context) => LoginLoadingBloc()),
      ],
      child: BlocListener<AdminAuthBloc, AdminAuthState>(
        listener: (context, state) {
          BlocProvider.of<LoginLoadingBloc>(context).add(LoginUnsetLoading());
          if (state.role == "admin" && state.token.length > 1) {
            context.goNamed("admin_home", pathParameters: {"tk": state.token});
          } else if (state.errors.contains("Incorrect email or password")) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Incorrect email or password"),
                backgroundColor: Color.fromARGB(255, 212, 47, 47),
              ),
            );
          } else if (state.errors.contains("Connection Error")) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Connection Error"),
                backgroundColor: Color.fromARGB(255, 150, 53, 53),
              ),
            );
          } else {
            String pwe = "The password is too short";
            String eme = "Invalid Email";
            if (state.errors.contains(pwe)) {
              BlocProvider.of<PasswordErrorBloc>(context)
                  .add(PasswordErrorChange(message: pwe));
            } else {
              BlocProvider.of<PasswordErrorBloc>(context)
                  .add(PasswordErrorChange(message: ""));
            }

            if (state.errors.contains(eme)) {
              BlocProvider.of<EmailErrorBloc>(context)
                  .add(EmailErrorChange(message: eme));
            } else {
              BlocProvider.of<EmailErrorBloc>(context)
                  .add(EmailErrorChange(message: ""));
            }
          }
        },
        child: BlocBuilder<LoginLoadingBloc, bool>(
          builder: (context, state) {
            if (state) {
              return Scaffold(
                backgroundColor: AppColors.black,
                body: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.listener3,
                    size: 200,
                  ),
                ),
              );
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  height: deviceHeight,
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.black),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50.0, right: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed("login");
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              backgroundColor: AppColors.artist4,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 19,
                                  color: AppColors.artist2,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Back to user login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Brand(
                                      text: 'Masinqo Admins',
                                      size: 40,
                                    ),
                                    const SizedBox(height: 16),
                                    BlocBuilder<EmailErrorBloc, String>(
                                      builder: (context, state) {
                                        if (state.isEmpty) {
                                          return CustomTextField(
                                            controller: _emailController,
                                            hintText: 'Admin Email',
                                            prefixIcon: const Icon(Icons.mail),
                                          );
                                        } else {
                                          return CustomTextFieldError(
                                            controller: _emailController,
                                            hintText: 'Admin Email',
                                            prefixIcon: const Icon(Icons.mail),
                                            errorMessage: state,
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    BlocBuilder<PasswordErrorBloc, String>(
                                      builder: (context, state) {
                                        if (state.isEmpty) {
                                          return CustomTextField(
                                            controller: _passwordController,
                                            hintText: 'Password',
                                            prefixIcon: const Icon(Icons.lock),
                                            isPassword: true,
                                          );
                                        } else {
                                          return CustomTextFieldError(
                                            controller: _passwordController,
                                            hintText: 'Password',
                                            prefixIcon: const Icon(Icons.lock),
                                            errorMessage: state,
                                            isPassword: true,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomElevatedButton(
                                onPressed: () async {
                                  BlocProvider.of<LoginLoadingBloc>(context)
                                      .add(LoginSetLoading());
                                  await Future.delayed(
                                      const Duration(milliseconds: 1500));
                                  BlocProvider.of<AdminAuthBloc>(context).add(
                                    AdminLoginEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        role: "admin"),
                                  );
                                },
                                buttonText: 'Login'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
