import 'package:flutter/material.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                    'Login',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: Constants.bigAuthSpace),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Forgot password?'),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Palette.buttonColor,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      child: const Text('Login'),
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
                          auth
                              .login(_emailController.text,
                                  _passwordController.text)
                              .then((value) => hideProgress());
                        }
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account? "),
                        GestureDetector(
                          onTap: () {
                            auth.setAuthState(AuthState.signup);
                          },
                          child: Text(
                            'Sign up',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
