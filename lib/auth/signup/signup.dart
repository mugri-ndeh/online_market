import 'package:flutter/material.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

import '../../util/contstants.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                        controller: _emailController,
                        decoration: Constants.inputDecoration('email')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: Constants.inputDecoration('password')),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text('Forgot password? '),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  CustomButton(
                      child: Text('Sign up'),
                      onTap: () {
                        var emailGood = validateEmail(_emailController.text);
                        var passwordGood =
                            validatePassword(_passwordController.text);
                        // auth.setAuthState(AuthState.loggedIn);
                        if (emailGood != null) {
                          showSnackBar(context, emailGood);
                        } else if (passwordGood != null) {
                          showSnackBar(context, passwordGood);
                        } else {
                          showSnackBar(context, 'Done');
                          showProgress(context, 'Signing in', true);
                          // auth
                          //     .login(
                          //         _emailController.text, _passwordController.text)
                          //     .then((value) => hideProgress());
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
