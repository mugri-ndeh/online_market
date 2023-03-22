part of 'app_start_cubit.dart';

abstract class AppStartState extends GlobalAppState {
  const AppStartState();

  @override
  List<Object> get props => [];
}

class AppStartInitial extends AppStartState {}

class AppStartloading extends AppStartState {}

class LoggedIn extends AppStartState {
  final bool isUser;
  const LoggedIn({required this.isUser});
}

class LoggedOut extends AppStartState {}

class CompleteProfile extends AppStartState {}

class AppStartError extends AppStartState {
  @override
  final GlobalErrorData error;
  const AppStartError({required this.error});
  @override
  List<Object> get props => [error];
}
