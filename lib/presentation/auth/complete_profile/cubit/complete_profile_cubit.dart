import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());
}
