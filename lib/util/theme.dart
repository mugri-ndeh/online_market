import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

ThemeData customLightTheme() {
  TextTheme poppins = GoogleFonts.montserratTextTheme();
  TextTheme _customLightThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1?.copyWith(
          fontSize: 32.0, color: AppColors.black, fontWeight: FontWeight.bold),
      headline2: base.headline1?.copyWith(
        fontSize: 24.0,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
      headline6: base.headline6?.copyWith(
          fontSize: 18.0, color: AppColors.black, fontWeight: FontWeight.bold),
      headline4: base.headline1?.copyWith(
          fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      headline3: base.headline1?.copyWith(
        fontSize: 22.0,
        color: Colors.white,
      ),
      headline5: base.headline6?.copyWith(
          fontSize: 20.0, color: AppColors.black, fontWeight: FontWeight.bold),
      caption: base.caption?.copyWith(
        color: AppColors.grey,
      ),
      bodyText2: base.bodyText2?.copyWith(color: AppColors.black),
      bodyText1: base.bodyText1?.copyWith(color: AppColors.primaryColor),
    );
  }

  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    // appBarTheme: lightTheme.appBarTheme.copyWith(iconTheme: ),
    brightness: Brightness.light,
    hintColor: AppColors.grey,
    textTheme: _customLightThemesTextTheme(poppins),
    primaryColor: AppColors.primaryColor,
    indicatorColor: AppColors.primaryColor,
    dividerColor: AppColors.grey.withOpacity(0.4),
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: AppColors.black,
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: AppColors.black,
    ),
    // buttonColor: Colors.white,
    backgroundColor: AppColors.white,
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.black,
    ),
    buttonTheme:
        lightTheme.buttonTheme.copyWith(buttonColor: AppColors.buttonColor),
    errorColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: AppColors.primarySwatchColor,
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
        side: const BorderSide(color: AppColors.buttonColor),
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
        color: AppColors.white,
      ),
      headline2: base.headline1?.copyWith(
        fontSize: 28.0,
        color: AppColors.white,
      ),
      headline6: base.headline6?.copyWith(
          fontSize: 18.0, color: AppColors.white, fontWeight: FontWeight.bold),
      headline4: base.headline1?.copyWith(
        fontSize: 20.0,
        color: Colors.white,
      ),
      headline3: base.headline1?.copyWith(
        fontSize: 22.0,
        color: Colors.black,
      ),
      headline5: base.headline6?.copyWith(
          fontSize: 20.0, color: AppColors.white, fontWeight: FontWeight.bold),
      caption: base.caption?.copyWith(
        color: AppColors.grey,
      ),
      bodyText2: base.bodyText2?.copyWith(color: AppColors.white),
      bodyText1: base.bodyText1?.copyWith(color: AppColors.primaryColor),
    );
  }

  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    brightness: Brightness.dark,
    textTheme: _customDarkThemesTextTheme(poppins),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: AppColors.primaryColor,
    indicatorColor: Color(0xFF807A6B),
    dividerColor: AppColors.grey.withOpacity(0.5),
    // accentColor: Color(0xFFFFF8E1),
    primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
      color: AppColors.white,
      size: 20,
    ),
    iconTheme: darkTheme.iconTheme.copyWith(color: AppColors.white),
    // TextSelectionThemeData.cursorColor
    backgroundColor: AppColors.black,
    tabBarTheme: darkTheme.tabBarTheme.copyWith(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.white,
    ),
    buttonTheme:
        darkTheme.buttonTheme.copyWith(buttonColor: AppColors.buttonColor),
    errorColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: AppColors.primarySwatchColor,
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
        side: const BorderSide(color: AppColors.primaryColor),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
  );
}
