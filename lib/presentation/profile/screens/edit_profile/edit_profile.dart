import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:online_market/main.dart';
import 'package:online_market/presentation/profile/screens/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:online_market/util/constants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

import '../../../../services/errors/global_error_handling/custom_consumer.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Edit profile'),
        ),
        body: CustomBlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is ProfileEdited) {
              showSnackBar(context, 'Profile Edited');
            }
          },
          builder: (context, state) {
            if (state is EditProfileLoading) {
              return const LoadingScreen();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Constants.formBox(
                      context: context,
                      child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: context
                              .watch<EditProfileCubit>()
                              .usernameController,
                          decoration: Constants.inputDecoration('username')),
                    ),
                    const SizedBox(height: 8),
                    Constants.formBox(
                      context: context,
                      child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: context
                              .watch<EditProfileCubit>()
                              .firstNameController,
                          decoration: Constants.inputDecoration('firstname')),
                    ),
                    const SizedBox(height: 8),
                    Constants.formBox(
                      context: context,
                      child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: context
                              .watch<EditProfileCubit>()
                              .lastNameController,
                          decoration: Constants.inputDecoration('lastname')),
                    ),
                    const SizedBox(height: 8),
                    Constants.formBox(
                      context: context,
                      child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller:
                              context.watch<EditProfileCubit>().emailController,
                          decoration: Constants.inputDecoration('email')),
                    ),
                    const SizedBox(height: 20),
                    IntlPhoneField(
                      dropdownIcon: const Icon(Icons.arrow_drop_down,
                          color: AppColors.buttonColor),
                      controller:
                          context.watch<EditProfileCubit>().phoneController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      dropdownIconPosition: IconPosition.leading,
                      initialCountryCode:
                          context.watch<EditProfileCubit>().initialCountry,
                      pickerDialogStyle: PickerDialogStyle(),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: AppColors.primaryColor.withOpacity(0.3),
                                width: 2.0)),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.buttonColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (phone) {},
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: CustomButton(
                        child: const Text('Save data'),
                        onTap: () {
                          context.read<EditProfileCubit>().editProfile();
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
