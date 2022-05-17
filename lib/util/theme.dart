import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_market/util/palette.dart';

ThemeData customLightTheme() {
  TextTheme poppins = GoogleFonts.poppinsTextTheme();
  TextTheme _customLightThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1?.copyWith(
        fontSize: 40.0,
        color: Palette.black,
      ),
      headline2: base.headline1?.copyWith(
        fontSize: 28.0,
        color: Palette.black,
      ),
      headline6: base.headline6?.copyWith(fontSize: 16.0, color: Palette.black),
      headline4: base.headline1?.copyWith(
        fontSize: 20.0,
        color: Colors.white,
      ),
      headline3: base.headline1?.copyWith(
        fontSize: 24.0,
        color: Colors.black,
      ),
      caption: base.caption?.copyWith(
        color: Palette.grey,
      ),
      bodyText2: base.bodyText2?.copyWith(color: Palette.black),
      bodyText1: base.bodyText1?.copyWith(color: Palette.black),
    );
  }

  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    hintColor: Palette.grey,
    textTheme: _customLightThemesTextTheme(poppins),
    primaryColor: Palette.primaryColor,
    indicatorColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.scaffoldBg,
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: Palette.black,
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: Colors.white,
    ),
    // buttonColor: Colors.white,
    backgroundColor: Palette.white,
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: Palette.primaryColor,
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme:
        lightTheme.buttonTheme.copyWith(buttonColor: Palette.buttonColor),
    errorColor: Colors.red,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFFF8E1)),
  );
}

ThemeData customDarkTheme() {
  TextTheme poppins = GoogleFonts.poppinsTextTheme();
  TextTheme _customDarkThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1?.copyWith(
        fontSize: 32.0,
        color: Palette.white,
      ),
      headline2: base.headline1?.copyWith(
        fontSize: 28.0,
        color: Palette.white,
      ),
      headline6: base.headline6?.copyWith(fontSize: 16.0, color: Palette.black),
      headline4: base.headline1?.copyWith(
        fontSize: 20.0,
        color: Colors.white,
      ),
      headline3: base.headline1?.copyWith(
        fontSize: 24.0,
        color: Colors.white,
      ),
      caption: base.caption?.copyWith(
        color: Palette.grey,
      ),
      bodyText2: base.bodyText2?.copyWith(color: Palette.white),
      bodyText1: base.bodyText1?.copyWith(color: Palette.white),
    );
  }

  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    textTheme: _customDarkThemesTextTheme(poppins),
    scaffoldBackgroundColor: Palette.black,
    primaryColor: Colors.black38,
    indicatorColor: Color(0xFF807A6B),
    // accentColor: Color(0xFFFFF8E1),
    primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
      color: Palette.white,
      size: 20,
    ),
    // TextSelectionThemeData.cursorColor
    cursorColor: Palette.primaryColor,
    backgroundColor: Palette.white,
    tabBarTheme: darkTheme.tabBarTheme.copyWith(
      labelColor: Palette.primaryColor,
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme:
        darkTheme.buttonTheme.copyWith(buttonColor: Palette.buttonColor),
    errorColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
        .copyWith(secondary: Color(0xFFFFF8E1)),
  );
}
