import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/errors/global_error_handling/global_app_state.dart';

part 'pick_profile_image_state.dart';

class PickProfileImageCubit extends Cubit<PickProfileImageState> {
  PickProfileImageCubit() : super(PickProfileImageInitial());

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      emit(const PickProfileImageFailed(
        GlobalErrorData(
          'Could not pick image.',
        ),
      ));
      return null;
    }

    final croppedimage = await ImageCropper().cropImage(
      compressQuality: 80,
      maxHeight: 512,
      maxWidth: 512,
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Profile Picture',
          hideBottomControls: true,
        ),
        IOSUiSettings(
          cancelButtonTitle: 'Cancel',
          doneButtonTitle: 'Done',
        ),
      ],
    );

    if (croppedimage == null) {
      emit(const PickProfileImageFailed(
        GlobalErrorData(
          'Could not pick image.',
        ),
      ));
      return null;
    }

    final croppedImageBytes = await croppedimage.readAsBytes();

    emit(PickProfileImageSuccess(profileImage: croppedImageBytes));
  }

  void removeImage() => emit(PickProfileImageInitial());
}
