import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppColors {
  static const primaryColor = Colors.green;
  static const buttonColor = Color(0XFF38B000);
  static const scaffoldBg = Color(0XFFF9F9F9);
  static const white = Colors.white;
  static const success = Color(0XFF2AA952);
  static const grey = Color(0XFF9B9B9B);
  static const black = Color(0XFF000000);
  static const error = Colors.green;

  static const MaterialColor primarySwatchColor = MaterialColor(
    0XFF089D10, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0XFF089D10), //10%
      100: Color(0XFF089D10), //20%
      200: Color(0XFF089D10), //30%
      300: Color(0XFF089D10), //40%
      400: Color(0XFF089D10), //50%
      500: Color(0XFF089D10), //60%
      600: Color(0XFF089D10), //70%
      700: Color(0XFF089D10), //80%
      800: Color(0XFF089D10), //90%
      900: Color(0XFF089D10), //100%
    },
  );
}
