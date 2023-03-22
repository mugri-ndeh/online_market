import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/main.dart';
import 'package:online_market/presentation/auth/signup/cubit/sign_up_cubit.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:online_market/util/widgets/custom_input.dart';

import '../../../routes/routing.gr.dart';
import '../../../services/errors/global_error_handling/custom_consumer.dart';
import '../../app_start/app_start_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: SafeArea(
          child: CustomBlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                context.read<AppStartCubit>().completeProfile();
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const LoadingScreen();
              }
              return SingleChildScrollView(
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
                      CustomInputField(
                          controller:
                              context.watch<SignUpCubit>().usernameController,
                          obscureText: false,
                          hint: 'username'),
                      const SizedBox(height: 10),
                      CustomInputField(
                          controller:
                              context.watch<SignUpCubit>().emailController,
                          obscureText: false,
                          hint: 'email'),
                      const SizedBox(height: 10),
                      CustomInputField(
                          controller:
                              context.watch<SignUpCubit>().passwordController,
                          obscureText: true,
                          hint: 'password'),
                      const SizedBox(height: 10),
                      CustomInputField(
                          controller: context
                              .watch<SignUpCubit>()
                              .confirmPasswordController,
                          obscureText: true,
                          hint: 'confirm password'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Already have an account?"),
                          GestureDetector(
                              onTap: () {
                                context.navigateTo(LoginRoute());
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
                            context.read<SignUpCubit>().signUp();
                          }),
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
