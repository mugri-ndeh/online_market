import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.hint})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Constants.formBox(
        context: context,
        child: TextFormField(
            obscureText: obscureText,
            style: Theme.of(context).textTheme.bodyText2,
            controller: controller,
            decoration: Constants.inputDecoration(hint)));
  }
}
