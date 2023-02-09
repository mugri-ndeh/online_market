part of 'shop_products_cubit.dart';

abstract class ShopProductsState extends GlobalAppState {
  const ShopProductsState();

  @override
  List<Object> get props => [];
}

class ShopProductsInitial extends ShopProductsState {}

class ProductLoading extends ShopProductsState {}

class ProductSuccess extends ShopProductsState {}

class ProductError extends ShopProductsState {
  @override
  final GlobalErrorData error;

  const ProductError(this.error);
}

class ImagePicked extends ShopProductsState {
  final File image;
  const ImagePicked({required this.image});
}

class CategoryPicked extends ShopProductsState {
  final String category;
  const CategoryPicked({required this.category});
}
