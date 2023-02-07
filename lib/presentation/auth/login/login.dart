// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:online_market/main.dart';
import 'package:online_market/presentation/auth/login/cubit/login_cubit.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

import '../../../services/errors/global_error_handling/custom_consumer.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: CustomBlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                // pushReplacement(context)
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const LoadingScreen();
              }
              return Padding(
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
                          controller:
                              context.watch<LoginCubit>().emailController,
                          decoration: Constants.inputDecoration('email')),
                    ),
                    const SizedBox(height: 10),
                    Constants.formBox(
                      context: context,
                      child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller:
                              context.watch<LoginCubit>().passwordController,
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
                            color: AppColors.buttonColor,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomButton(child: const Text('Login'), onTap: () {}),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account? "),
                          GestureDetector(
                            onTap: () {
                              context.read<LoginCubit>().login();
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
              );
            },
          ),
        ),
      ),
    );
  }
}
