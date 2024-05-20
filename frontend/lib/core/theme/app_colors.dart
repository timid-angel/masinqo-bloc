import 'package:flutter/material.dart';

class AppColors {
  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const blackLight = Color.fromARGB(255, 20, 20, 20);
  static const blackLighter = Color(0xFF333333);
  static const blueish = Color.fromARGB(255, 17, 8, 52);
  static const greenish = Color.fromARGB(255, 1, 55, 71);

  static const artist1 = Color.fromRGBO(57, 220, 243, 1);
  static const artist2 = Color.fromARGB(255, 12, 144, 188);
  // static const artist3 = Color.fromRGBO(237, 129, 255, 1);
  static const artist4 = Color.fromARGB(70, 10, 100, 130);

  static const listener1 = Color.fromRGBO(237, 129, 255, 1);
  static const listener2 = Color.fromRGBO(204, 70, 228, 1);
  static const listener3 = Color.fromRGBO(74, 19, 84, 1);
  static const listener4 = Color.fromRGBO(140, 46, 156, 1);

  static const fontColor = Color(0xF3F3F3FF);

  static const grayAppbarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(200, 34, 34, 34),
      Color.fromARGB(200, 34, 34, 34),
      Color.fromARGB(200, 34, 34, 34),
      Colors.transparent,
    ],
    tileMode: TileMode.decal,
  );
  static const grayBodyGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromARGB(255, 34, 34, 34),
        Colors.transparent,
      ],
      stops: [
        0.85,
        1,
      ]);

  static const slantedPurpleGradient = LinearGradient(
    transform: GradientRotation(-0.7),
    colors: [Colors.black, Color.fromARGB(146, 62, 33, 68), Colors.black],
    stops: [0, 0.27, 1],
  );
}
