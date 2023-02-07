import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/auth/auth_service.dart';
import '../../../../services/errors/global_error_handling/global_app_state.dart';
import '../../../../services/locator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _validateFields() {
    if (emailController.text.isEmpty) {
      return 'Please enter email';
    } else if (usernameController.text.isEmpty) {
      return 'Please enter a username';
    } else if (passwordController.text.isEmpty) {
      return 'Please enter a password';
    } else {
      return null;
    }
  }

  signUp() async {
    emit(SignUpLoading());
    try {
      String? error = _validateFields();
      if (error == null) {
        await locator<AuthService>().signUp(emailController.text.trim(),
            usernameController.text.trim(), passwordController.text.trim());
        emit(SignUpSuccess());
      } else {
        emit(SignUpError(GlobalErrorData(error)));
      }
    } catch (e, stacktrace) {
      emit(SignUpError(GlobalErrorData(e, stackTrace: stacktrace)));
    }
  }
}
