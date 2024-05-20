import 'package:flutter/material.dart';
import '../widgets/login_brand.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/admin_signup_textfield.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});
  @override
  ArtistSignUpPageState createState() => ArtistSignUpPageState();
}

class ArtistSignUpPageState extends State<SignupWidget> {
  bool _isArtist = true;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    Color filterColor = _isArtist
        ? const Color.fromARGB(11, 0, 187, 212)
        : const Color.fromARGB(11, 164, 53, 183);

    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: deviceHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/uncle.jpg'),
              fit: BoxFit.cover,
              opacity: 0.2,
              colorFilter: ColorFilter.mode(
                filterColor,
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
                        hintText: 'Username',
                        isArtist: _isArtist,
                        prefixIcon: Icon(
                          Icons.person,
                          color: _isArtist
                              ? AppColors.artist2
                              : AppColors.listener4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Email',
                        isArtist: _isArtist,
                        prefixIcon: Icon(
                          Icons.mail,
                          color: _isArtist
                              ? AppColors.artist2
                              : AppColors.listener4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Password',
                        isArtist: _isArtist,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: _isArtist
                              ? AppColors.artist2
                              : AppColors.listener4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Confirm Password',
                        isArtist: _isArtist,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: _isArtist
                              ? AppColors.artist2
                              : AppColors.listener4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isArtist = true;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                    color: _isArtist
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
                                color: _isArtist
                                    ? AppColors.artist2
                                    : Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isArtist = false;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                    color: _isArtist
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
                                color: _isArtist
                                    ? Colors.white
                                    : const Color.fromARGB(255, 193, 53, 217),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            _isArtist ? AppColors.artist2 : AppColors.listener4,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ),
      ),
    );
  }
}
