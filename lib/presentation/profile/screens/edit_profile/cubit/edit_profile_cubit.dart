import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';
import 'package:online_market/services/locator.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial()) {
    initialize();
  }

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String initialCountry = 'CM';
  String? locale;
  final TextEditingController phoneController = TextEditingController();
  initialize() {
    emit(EditProfileLoading());
    emailController.text = locator<AuthService>().loggedUser!.email;
    usernameController.text = locator<AuthService>().loggedUser!.username;
    firstNameController.text = locator<AuthService>().loggedUser!.firstName;
    lastNameController.text = locator<AuthService>().loggedUser!.lastName;
    phoneController.text = locator<AuthService>().loggedUser!.phoneNumber;
    emit((ProfileEdited()));
  }

  editProfile() async {
    emit(EditProfileLoading());
    try {
      locator<AuthService>().loggedUser!.email = emailController.text;
      locator<AuthService>().loggedUser!.username = usernameController.text;
      locator<AuthService>().loggedUser!.firstName = firstNameController.text;
      locator<AuthService>().loggedUser!.lastName = lastNameController.text;
      locator<AuthService>().loggedUser!.phoneNumber = phoneController.text;

      CustomFirestore.userRef
          .update(locator<AuthService>().loggedUser!.toMap());

      emit(ProfileEdited());
    } catch (e) {
      emit(ProfileError(GlobalErrorData(e)));
    }
  }
}
