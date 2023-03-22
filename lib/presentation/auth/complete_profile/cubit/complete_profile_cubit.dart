import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:online_market/services/locator.dart';

import '../../../../model/location.dart';
import '../../../../model/user_model.dart';
import '../../../../util/helper.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController regionController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController quarterController = TextEditingController();

  String accountType = 'customer';
  bool customerCheck = true;

  String initialCountry = 'CM';
  toggle(val) {
    customerCheck = !customerCheck;
    accountType = customerCheck ? 'customer' : 'seller';
    log(accountType);
    emit(CompleteProfileBetween());
    emit(CompleteProfileRefresh());
  }

  String? validate() {
    var firstNameGood = validateGivenNames(firstNameController.text, true);
    var lastNameGood = validateGivenNames(firstNameController.text, false);
    var regionGood = validateLocation(regionController.text, 'region');
    var townGood = validateLocation(townController.text, 'town');
    var quarterGood = validateLocation(quarterController.text, 'quarter');
    if (firstNameGood != null) {
      return firstNameGood;
    } else if (lastNameGood != null) {
      return lastNameGood;
    } else if (regionGood != null) {
      return regionGood;
    } else if (townGood != null) {
      return townGood;
    } else if (quarterGood != null) {
      return quarterGood;
    } else {
      return null;
    }
  }

  Future completeProfile() async {
    emit(CompleteProfileLoading());
    try {
      String? error = validate();
      if (error == null) {
      } else {
        emit(CompleteProfileError(error: GlobalErrorData(error)));
      }
      UserModel userModel = locator<AuthService>().loggedUser!;
      UserLocation location = UserLocation(
          id: userModel.uid.toString(),
          region: regionController.text,
          town: townController.text,
          quarter: quarterController.text);
      userModel.firstName = firstNameController.text;
      userModel.lastName = lastNameController.text;
      userModel.phoneNumber = phoneNumberController.text;
      userModel.completedProfile = true;
      userModel.location = location;
      userModel.accountType = accountType;
      await locator<AuthService>().completeProfile(userModel);

      emit(CompleteProfileSuccess(userModel: userModel));
    } catch (e) {
      emit(CompleteProfileError(error: GlobalErrorData(e)));
    }
  }
}
