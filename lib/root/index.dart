import 'package:flutter/material.dart';
import 'package:online_market/auth/complete_profile/complete_profile.dart';
import 'package:online_market/auth/login/login.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/auth/signup/signup.dart';
import 'package:online_market/home/base.dart';
import 'package:online_market/profile/index.dart';
import 'package:provider/provider.dart';

class AuthRoot extends StatelessWidget {
  const AuthRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(builder: (_, auth, __) {
      // ignore: avoid_print
      print('Auth state is');
      // ignore: avoid_print
      print(auth.loginState);
      switch (auth.loginState) {
        case AuthState.loggedIn:
          if (auth.loggedUser!.accountType == AccountType.customer.toString()) {
            return BaseScreen();
          } else {
            return BaseScreen();
          }
        case AuthState.loggedOut:
          return Login();
        case AuthState.incomplete:
          return CompleteProfile();
        case AuthState.signup:
          return SignUp();
        case AuthState.login:
          return Login();
        case AuthState.loading:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        default:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
      //return user != null ? HomeScreen() : Register();
    });
  }
}
