part of 'complete_profile_cubit.dart';

abstract class CompleteProfileState extends GlobalAppState {
  const CompleteProfileState();

  @override
  List<Object> get props => [];
}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileRefresh extends CompleteProfileState {}

class CompleteProfileBetween extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {
  final UserModel userModel;
  const CompleteProfileSuccess({required this.userModel});
}

class CompleteProfileError extends CompleteProfileState {
  @override
  final GlobalErrorData error;
  const CompleteProfileError({required this.error});
}
