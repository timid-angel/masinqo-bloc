import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';
import 'package:masinqo/presentation/widgets/admin_login_button.dart';
import 'package:masinqo/presentation/widgets/admin_login_textfield.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

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
                      Navigator.pushNamed(context, "/login");
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
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Brand(
                              text: 'Masinqo Admins',
                              size: 40,
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              hintText: 'Admin Email',
                              prefixIcon: Icon(Icons.mail),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/admin/home");
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
  }
}
