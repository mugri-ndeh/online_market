part of 'home_cubit.dart';

abstract class HomeState extends GlobalAppState {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> products;
  const HomeLoaded({required this.products});
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  @override
  final GlobalErrorData error;
  const HomeError({required this.error});
}
