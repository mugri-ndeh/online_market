import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../palette.dart';

void showToast(String message) {
  Fluttertoast.showToast(msg: message);
}

Flushbar showCustomFlushbar(String message, BuildContext context) {
  Flushbar flush = Flushbar();
  flush = Flushbar(
    backgroundColor: AppColors.error,
    messageColor: AppColors.white,
    margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
    message: message,
    messageSize: 17,
    mainButton: Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
        height: 17,
        width: 17,
        child: InkWell(
          onTap: () {
            flush.dismiss(true); // result = true
          },
          child: const Icon(
            Icons.close,
            color: AppColors.white,
          ),
        ),
      ),
    ),
    duration: const Duration(seconds: 2),
  );
  return flush..show(context);
}
