import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';
import 'package:online_market/services/repository/user_repository.dart';

import '../../../../../model/product.dart';
import '../../../../../model/shop.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(AllProductsInitial()) {
    getProducts();
  }

  List<String> categories = [];
  List<Product> products = [];
  List<Shop> shops = [];

  getProducts() async {
    emit(AllProductsLoading());
    try {
      categories = await UserRepository.getCategories();
      products = await UserRepository.getAllProducts();
      shops = await UserRepository.getAllShops();
      filterCategory('appliances');
      emit(AllProductsLoaded(products: products, categories: categories));
    } catch (e) {
      emit(AllProductsError(GlobalErrorData(e)));
    }
  }

  Shop getShop(Product product) {
    return shops
        .where((element) => element.id == product.shopId)
        .toList()
        .first;
  }

  filterCategory(String category) {
    emit(AllProductsLoading());
    var filtered =
        products.where((element) => element.category == category).toList();
    emit(AllProductsLoaded(products: filtered, categories: categories));
  }
}
