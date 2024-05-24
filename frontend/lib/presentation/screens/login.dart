import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/temp/data/admin_data.dart';
import 'package:masinqo/temp/data/album_data.dart';
import 'package:masinqo/temp/data/artist_data.dart';
import 'package:masinqo/temp/data/database.dart';
import 'package:masinqo/temp/data/listener_data.dart';
import 'package:masinqo/temp/data/playlist_data.dart';
import 'package:masinqo/temp/data/songs_data.dart';
import 'package:masinqo/temp/models/route_models/listener_homepage_data.dart';
import 'package:masinqo/presentation/widgets/background.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';
import 'package:masinqo/presentation/widgets/login_options.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  bool _isArtist = true;
  Database db = Database(
    admins: adminData,
    albums: albumData,
    artists: artistData,
    listeners: listenerData,
    playlists: playlistData,
    songs: songData,
  );

  void refreshState(bool newVal) {
    setState(() {
      _isArtist = newVal;
    });
  }

  void loginHandler() {
    if (!_isArtist) {
      context.pushNamed(
        "listener",
        extra: ListenerHomePageData(
          albums: db.albums,
          favorites: db.listeners[2].favorites,
          playlists: db.playlists,
        ),
      );
    } else {
      context.pushNamed("artist");
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                          TextField(
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 15,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText:
                                  _isArtist ? 'Artist Email' : 'User email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isArtist
                                      ? AppColors.artist2
                                      : AppColors.listener4,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isArtist
                                      ? AppColors.artist2
                                      : AppColors.listener4,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: _isArtist
                                    ? AppColors.artist2
                                    : AppColors.listener4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 15,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isArtist
                                      ? AppColors.artist2
                                      : AppColors.listener4,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isArtist
                                      ? AppColors.artist2
                                      : AppColors.listener4,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: _isArtist
                                    ? AppColors.artist2
                                    : AppColors.listener4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Flexible(
                                flex: 5,
                                child: LoginOptionButton(
                                  isArtist: _isArtist,
                                  parent: this,
                                  primaryColor: AppColors.artist2,
                                  buttonText: 'Login as Artist',
                                  toValue: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                flex: 6,
                                child: LoginOptionButton(
                                  isArtist: _isArtist,
                                  parent: this,
                                  primaryColor: AppColors.listener2,
                                  buttonText: 'Login as Listener',
                                  toValue: false,
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
                      onPressed: loginHandler,
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
    );
  }
}
