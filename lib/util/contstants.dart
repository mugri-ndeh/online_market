import 'package:flutter/material.dart';

import 'palette.dart';

class Assets {
  static const String logo = 'assets/images/illustration-1.png';
}

class Constants {
  static const double bodyHorizontalpadding = 16.0;
  static const double bigAuthSpace = 100.0;
  static const double authWidgetSpace = 10;
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      label: Text(label),
      // filled: true,
      // fillColor: Palette.white,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
    );
  }

  static Container formBox(
      {required Widget child,
      required BuildContext context,
      double borderRadius = 4,
      double padding = 12}) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 1)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: child,
      ),
    );
  }
}
