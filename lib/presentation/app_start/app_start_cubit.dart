import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/model/user_model.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:provider/provider.dart';

import '../../../firebase_options.dart';
import '../../services/auth/auth_service.dart';
import '../../services/locator.dart';

part 'app_start_state.dart';

class AppStartCubit extends Cubit<AppStartState> {
  AppStartCubit() : super(AppStartInitial()) {
    initializeApp();
  }
  initializeApp() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      Provider.debugCheckInvalidValueType = null;

      locator<AuthService>().checkAuth().then((value) {
        if (value == null) {
          emit(LoggedOut());
        } else if (value.completedProfile == true) {
          emit(LoggedIn(isUser: value.accountType == 'customer'));
        } else {
          emit(CompleteProfile());
        }
      });

      // if (await locator<AuthService>().checkAuth() == null) {
      //   emit(LoggedOut());
      // } else if (await locator<AuthService>()
      //     .checkAuth()
      //     .then((value) => null)) {}
      // Future.delayed(const Duration(seconds: 1), () => emit(AppStartSuccess()));
    } catch (e, s) {
      emit(AppStartError(error: GlobalErrorData(e, stackTrace: s)));
    }
  }

  login(String accountType) {
    emit(LoggedIn(isUser: accountType == 'customer'));
  }

  logout() {
    emit(LoggedOut());
  }

  completeProfile() {
    emit(CompleteProfile());
  }
}
