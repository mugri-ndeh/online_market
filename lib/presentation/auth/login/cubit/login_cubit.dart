import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';

import '../../../../model/user_model.dart';
import '../../../../services/auth/auth_service.dart';
import '../../../../services/locator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _validateFields() {
    if (emailController.text.isEmpty) {
      return 'Please enter email';
    } else if (passwordController.text.isEmpty) {
      return 'Please enter a password';
    } else {
      return null;
    }
  }

  login() async {
    emit(LoginLoading());
    try {
      String? error = _validateFields();
      if (error == null) {
        var result = await locator<AuthService>()
            .login(emailController.text.trim(), passwordController.text.trim());

        emit(LoginSuccess(
            userModel: (result as UserModel?)!));
      } else {
        emit(LoginError(GlobalErrorData(error)));
      }
    } catch (e, stacktrace) {
      emit(LoginError(GlobalErrorData(e, stackTrace: stacktrace)));
    }
  }
}
