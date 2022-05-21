import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Palette {
  static const primaryColor = Color(0XFFDB3022);
  static const buttonColor = Color(0XFFDB3022);
  static const scaffoldBg = Color(0XFFF9F9F9);
  static const white = Colors.white;
  static const success = Color(0XFF2AA952);
  static const grey = Color(0XFF9B9B9B);
  static const black = Color(0XFF000000);
  static const error = Color.fromARGB(255, 252, 0, 0);

  static const MaterialColor primarySwatchColor = MaterialColor(
    0XFFDB3022, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: const Color(0XFFDB3022), //10%
      100: const Color(0XFFDB3022), //20%
      200: const Color(0XFFDB3022), //30%
      300: const Color(0XFFDB3022), //40%
      400: const Color(0XFFDB3022), //50%
      500: const Color(0XFFDB3022), //60%
      600: const Color(0XFFDB3022), //70%
      700: const Color(0XFFDB3022), //80%
      800: const Color(0XFFDB3022), //90%
      900: const Color(0XFFDB3022), //100%
    },
  );
}
