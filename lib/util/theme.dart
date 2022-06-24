import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

ThemeData customLightTheme() {
  TextTheme poppins = GoogleFonts.montserratTextTheme();
  TextTheme _customLightThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1?.copyWith(
          fontSize: 32.0, color: Palette.black, fontWeight: FontWeight.bold),
      headline2: base.headline1?.copyWith(
        fontSize: 24.0,
        color: Palette.black,
        fontWeight: FontWeight.bold,
      ),
      headline6: base.headline6?.copyWith(
          fontSize: 18.0, color: Palette.black, fontWeight: FontWeight.bold),
      headline4: base.headline1?.copyWith(
          fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      headline3: base.headline1?.copyWith(
        fontSize: 22.0,
        color: Colors.white,
      ),
      headline5: base.headline6?.copyWith(
          fontSize: 20.0, color: Palette.black, fontWeight: FontWeight.bold),
      caption: base.caption?.copyWith(
        color: Palette.grey,
      ),
      bodyText2: base.bodyText2?.copyWith(color: Palette.black),
      bodyText1: base.bodyText1?.copyWith(color: Palette.primaryColor),
    );
  }

  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    // appBarTheme: lightTheme.appBarTheme.copyWith(iconTheme: ),
    brightness: Brightness.light,
    hintColor: Palette.grey,
    textTheme: _customLightThemesTextTheme(poppins),
    primaryColor: Palette.primaryColor,
    indicatorColor: Palette.primaryColor,
    dividerColor: Palette.grey.withOpacity(0.4),
    scaffoldBackgroundColor: Palette.scaffoldBg,
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: Palette.black,
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: Palette.black,
    ),
    // buttonColor: Colors.white,
    backgroundColor: Palette.white,
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: Palette.primaryColor,
      unselectedLabelColor: Palette.black,
    ),
    buttonTheme:
        lightTheme.buttonTheme.copyWith(buttonColor: Palette.buttonColor),
    errorColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Palette.primarySwatchColor,
            brightness: Brightness.light)
        .copyWith(secondary: const Color(0xFFFFF8E1)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // backgroundColor: Palette.primaryColor,
        side: const BorderSide(color: Palette.buttonColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
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
      headline6: base.headline6?.copyWith(
          fontSize: 18.0, color: Palette.white, fontWeight: FontWeight.bold),
      headline4: base.headline1?.copyWith(
        fontSize: 20.0,
        color: Colors.white,
      ),
      headline3: base.headline1?.copyWith(
        fontSize: 22.0,
        color: Colors.black,
      ),
      headline5: base.headline6?.copyWith(
          fontSize: 20.0, color: Palette.white, fontWeight: FontWeight.bold),
      caption: base.caption?.copyWith(
        color: Palette.grey,
      ),
      bodyText2: base.bodyText2?.copyWith(color: Palette.white),
      bodyText1: base.bodyText1?.copyWith(color: Palette.primaryColor),
    );
  }

  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    brightness: Brightness.dark,
    textTheme: _customDarkThemesTextTheme(poppins),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Palette.primaryColor,
    indicatorColor: Color(0xFF807A6B),
    dividerColor: Palette.grey.withOpacity(0.5),
    // accentColor: Color(0xFFFFF8E1),
    primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
      color: Palette.white,
      size: 20,
    ),
    iconTheme: darkTheme.iconTheme.copyWith(color: Palette.white),
    // TextSelectionThemeData.cursorColor
    cursorColor: Palette.primaryColor,
    backgroundColor: Palette.black,
    tabBarTheme: darkTheme.tabBarTheme.copyWith(
      labelColor: Palette.primaryColor,
      unselectedLabelColor: Palette.white,
    ),
    buttonTheme:
        darkTheme.buttonTheme.copyWith(buttonColor: Palette.buttonColor),
    errorColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Palette.primarySwatchColor,
            brightness: Brightness.dark)
        .copyWith(secondary: Color(0xFFFFF8E1)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Palette.primaryColor),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
  );
}
