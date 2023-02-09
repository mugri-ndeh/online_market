part of 'login_cubit.dart';

abstract class LoginState extends GlobalAppState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  @override
  final GlobalErrorData error;

  const LoginError(this.error);
}

class LoginSuccess extends LoginState {
  final UserModel userModel;
  const LoginSuccess({required this.userModel});
}
