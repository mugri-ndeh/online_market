part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends GlobalAppState {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class ProfileEdited extends EditProfileState {}

class ProfileError extends EditProfileState {
  @override
  final GlobalErrorData error;

  const ProfileError(this.error);
}
