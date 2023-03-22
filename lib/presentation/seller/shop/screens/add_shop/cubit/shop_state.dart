part of 'shop_cubit.dart';

abstract class ShopState extends GlobalAppState {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopSuccess extends ShopState {}

class ShopError extends ShopState {
  @override
  final GlobalErrorData error;

  const ShopError(this.error);
}

class ImagePicked extends ShopState {
  final File image;
  const ImagePicked({required this.image});
}
