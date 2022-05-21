import 'package:flutter/material.dart';

import 'palette.dart';

class Assets {
  static const String logo = '';
}

class Constants {
  static const double bodyHorizontalpadding = 16.0;
  static const double bigAuthSpace = 100.0;
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

  static Container formBox({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 1)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: child,
      ),
    );
  }
}
