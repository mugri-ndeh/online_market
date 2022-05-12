import 'package:flutter/material.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.bodyHorizontalpadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: Constants.bigAuthSpace),
                Constants.formBox(
                  child: TextFormField(
                      decoration: Constants.inputDecoration('email')),
                ),
                const SizedBox(height: 8),
                Constants.formBox(
                  child: TextFormField(
                      obscureText: true,
                      decoration: Constants.inputDecoration('password')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
