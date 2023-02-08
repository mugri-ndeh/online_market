part of 'pick_profile_image_cubit.dart';

abstract class PickProfileImageState extends GlobalAppState {
  const PickProfileImageState();

  @override
  List<Object> get props => [];
}

class PickProfileImageInitial extends PickProfileImageState {}

class PickProfileImageSuccess extends PickProfileImageState {
  final Uint8List profileImage;

  const PickProfileImageSuccess({required this.profileImage});

  @override
  List<Object> get props => [profileImage];
}

class PickProfileImageFailed extends PickProfileImageState {
  @override
  final GlobalErrorData error;

  const PickProfileImageFailed(this.error);
}

// //for gender selection
// class SelectMale extends PickProfileImageState {}

// class SelectFemale extends PickProfileImageState {}

// class SelectOther extends PickProfileImageState {}
