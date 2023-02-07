part of 'sign_up_cubit.dart';

abstract class SignUpState extends GlobalAppState {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {
  @override
  final GlobalErrorData error;

  const SignUpError(this.error);
}

class SignUpSuccess extends SignUpState {}
