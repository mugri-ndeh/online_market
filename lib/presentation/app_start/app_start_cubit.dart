import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      await locator<AuthService>().checkAuth();
      Future.delayed(const Duration(seconds: 1), () => emit(AppStartSuccess()));
    } catch (e) {
      emit(AppStartError(error: e.toString()));
    }
  }
}
