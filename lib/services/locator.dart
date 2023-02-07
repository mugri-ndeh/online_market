import 'package:get_it/get_it.dart';

import 'auth/auth_service.dart';

/// Enables easy access to single instances of services.
///
/// Usage:
/// ```dart
/// locator<ServiceClass>().serviceMethodOfThatClass
/// ```

GetIt locator = GetIt.instance;

/// Should only be called at initial app start.
void setupInitialLocator() {
  _setupAppLocator();
  setupUserDependentLocator();
}

/// Registers all services that are required by the app itself.
void _setupAppLocator() {
  // locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
}

/// Also gets called when a new user logs in
void setupUserDependentLocator() {
  // e.g. setting up a SettingsService etc.
  // locator.registerLazySingleton<CompleteProfileService>(
  //     () => CompleteProfileService());
  // locator.registerLazySingleton<SurveyService>(() => SurveyService());
}

/// Unregisters and re-registers all services, except for static ones (EmojiParser, NavService, AuthService).
///
/// Function is used after logging out so the data of the previous user won't affect the experience of the user who logs in afterwards.
void restartUserServices() {
  // You might need to unregister things like a SwipeCubit too
  locator.unregister(instance: locator<AuthService>());
  // locator.unregister(instance: locator<CompleteProfileService>());
  // locator.unregister(instance: locator<SurveyService>());
  _setupAppLocator();
  setupUserDependentLocator();
}
