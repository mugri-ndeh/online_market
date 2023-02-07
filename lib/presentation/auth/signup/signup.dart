import 'package:flutter/material.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late Authentication auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);
  }

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
                    'Sign Up',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: Constants.bigAuthSpace),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _usernameController,
                        decoration: Constants.inputDecoration('username')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _emailController,
                        decoration: Constants.inputDecoration('email')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: Constants.inputDecoration('password')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration:
                            Constants.inputDecoration('confirm password')),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Already have an account?"),
                      GestureDetector(
                          onTap: () {
                            auth.setAuthState(AuthState.login);
                          },
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.buttonColor,
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      child: const Text('Sign Up'),
                      onTap: () {
                        var emailGood = validateEmail(_emailController.text);
                        var passwordGood =
                            validatePassword(_passwordController.text);
                        var goodUsername =
                            validateName(_usernameController.text);
                        var goodConfirmPassword = validateConfirmPassword(
                            _passwordController.text,
                            _confirmPasswordController.text);
                        // auth.setAuthState(AuthState.loggedIn);
                        if (goodUsername != null) {
                          showSnackBar(context, goodUsername);
                        } else if (emailGood != null) {
                          showSnackBar(context, emailGood);
                        } else if (passwordGood != null) {
                          showSnackBar(context, passwordGood);
                        } else if (goodConfirmPassword != null) {
                          showSnackBar(context, goodConfirmPassword);
                        } else {
                          showSnackBar(context, 'Done');
                          showProgress(context, 'Creating account.....', true);
                          auth
                              .register(
                                  _emailController.text,
                                  _usernameController.text,
                                  _passwordController.text)
                              .then((value) => hideProgress());
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
