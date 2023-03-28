// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/main.dart';
import 'package:online_market/presentation/app_start/app_start_cubit.dart';
import 'package:online_market/presentation/auth/login/cubit/login_cubit.dart';
import 'package:online_market/routes/routing.gr.dart';
import 'package:online_market/util/constants.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:online_market/util/widgets/custom_input.dart';

import '../../../services/errors/global_error_handling/custom_consumer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: SafeArea(
          child: CustomBlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                if (state.userModel.completedProfile) {
                  context
                      .read<AppStartCubit>()
                      .login(state.userModel.accountType);
                } else {
                  context.read<AppStartCubit>().completeProfile();
                }
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const LoadingScreen();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.bodyHorizontalpadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: Constants.bigAuthSpace),
                      CustomInputField(
                          controller:
                              context.watch<LoginCubit>().emailController,
                          obscureText: false,
                          hint: 'Email'),
                      const SizedBox(height: 10),
                      CustomInputField(
                          controller:
                              context.watch<LoginCubit>().passwordController,
                          obscureText: true,
                          hint: 'Password'),
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
                      const SizedBox(height: 20),
                      CustomButton(
                          child: const Text('Login'),
                          onTap: () {
                            context.read<LoginCubit>().login();
                          }),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account? "),
                            GestureDetector(
                              onTap: () {
                                context.navigateTo(const SignUpRoute());
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
              );
            },
          ),
        ),
      ),
    );
  }
}
