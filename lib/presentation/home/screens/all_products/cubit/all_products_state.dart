part of 'all_products_cubit.dart';

abstract class AllProductsState extends GlobalAppState {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoaded extends AllProductsState {
  final List<Product> products;
  final List<String> categories;
  const AllProductsLoaded({required this.products, required this.categories});
}

class AllProductsError extends AllProductsState {
  @override
  final GlobalErrorData error;

  const AllProductsError(this.error);
}

class AllProductsLoading extends AllProductsState {}
