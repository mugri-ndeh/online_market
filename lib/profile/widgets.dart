import 'package:flutter/material.dart';

elevatedContainer({
  required BuildContext context,
  required Widget child,
}) =>
    Container(
      padding: EdgeInsets.all(16),
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
