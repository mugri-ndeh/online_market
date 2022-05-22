import 'package:flutter/material.dart';

elevatedContainer({
  required BuildContext context,
  required Widget child,
  double? padding,
}) =>
    Container(
      padding: padding == null ? EdgeInsets.all(16) : EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 2),
            blurStyle: BlurStyle.outer,
            blurRadius: 3,
            spreadRadius: 1,
            color: Color.fromARGB(255, 228, 222, 222).withOpacity(0.2),
          ),
        ],
      ),
      child: child,
    );
