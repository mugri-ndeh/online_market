// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:online_market/main.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:online_market/util/widgets/custom_input.dart';

import '../../../model/user_model.dart';
import '../../../services/errors/global_error_handling/custom_consumer.dart';
import '../../app_start/app_start_cubit.dart';
import 'cubit/complete_profile_cubit.dart';

class CompleteProfilePage extends StatelessWidget {
  CompleteProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: Scaffold(
        body: CustomBlocConsumer<CompleteProfileCubit, CompleteProfileState>(
          listener: (context, state) {
            if (state is CompleteProfileSuccess) {
              context.read<AppStartCubit>().login(state.userModel.accountType);
            }
          },
          builder: (context, state) {
            if (state is CompleteProfileLoading) {
              return const LoadingScreen();
            }
            return SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.bodyHorizontalpadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Complete Profile',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.logout))
                        ],
                      ),
                      const SizedBox(height: Constants.bigAuthSpace / 2),
                      CustomInputField(
                        controller: context
                            .watch<CompleteProfileCubit>()
                            .firstNameController,
                        obscureText: false,
                        hint: 'first name',
                      ),
                      const SizedBox(height: 10),
                      CustomInputField(
                        controller: context
                            .watch<CompleteProfileCubit>()
                            .lastNameController,
                        obscureText: false,
                        hint: 'last name',
                      ),
                      const SizedBox(height: 10),
                      Constants.formBox(
                        context: context,
                        child: IntlPhoneField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: context
                              .watch<CompleteProfileCubit>()
                              .phoneNumberController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          dropdownIconPosition: IconPosition.leading,
                          initialCountryCode: context
                              .watch<CompleteProfileCubit>()
                              .initialCountry,
                          pickerDialogStyle: PickerDialogStyle(),
                          decoration: const InputDecoration(
                            // hintText: 'Phone Number',
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.05,
                              height: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            const Text(
                              'Choose account type',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                              height: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Customer',
                              style: TextStyle(fontSize: 20)),
                          Checkbox(
                              activeColor: AppColors.primaryColor,
                              value: context
                                  .read<CompleteProfileCubit>()
                                  .customerCheck,
                              onChanged: (val) {
                                context
                                    .read<CompleteProfileCubit>()
                                    .toggle(val);
                              }),
                          const Text('Seller', style: TextStyle(fontSize: 20)),
                          Checkbox(
                              activeColor: AppColors.primaryColor,
                              value: !context
                                  .read<CompleteProfileCubit>()
                                  .customerCheck,
                              onChanged: (val) {
                                context
                                    .read<CompleteProfileCubit>()
                                    .toggle(val);
                              }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomInputField(
                        controller: context
                            .watch<CompleteProfileCubit>()
                            .regionController,
                        obscureText: false,
                        hint: 'region',
                      ),
                      const SizedBox(height: 10),
                      CustomInputField(
                        controller: context
                            .watch<CompleteProfileCubit>()
                            .townController,
                        obscureText: false,
                        hint: 'town',
                      ),
                      const SizedBox(height: 10),
                      CustomInputField(
                        controller: context
                            .watch<CompleteProfileCubit>()
                            .quarterController,
                        obscureText: false,
                        hint: 'quarter',
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                          child: const Text('Finish'),
                          onTap: () {
                            context
                                .read<CompleteProfileCubit>()
                                .completeProfile();
                          })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
