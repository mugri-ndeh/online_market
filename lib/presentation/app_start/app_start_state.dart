part of 'app_start_cubit.dart';

abstract class AppStartState extends Equatable {
  const AppStartState();

  @override
  List<Object> get props => [];
}

class AppStartInitial extends AppStartState {}

class AppStartloading extends AppStartState {}

class AppStartSuccess extends AppStartState {}

class AppStartError extends AppStartState {
  @override
  final String error;
  const AppStartError({required this.error});
  @override
  List<Object> get props => [error];
}
