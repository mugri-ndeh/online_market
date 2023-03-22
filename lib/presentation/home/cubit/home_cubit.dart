import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:online_market/services/repository/user_repository.dart';

import '../../../model/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getAllProdtucts();
  }

  List<Product> products = [];

  getAllProdtucts() async {
    emit(HomeLoading());
    try {
      products = await UserRepository.getAllProducts();
      emit(HomeLoaded(products: products));
    } catch (e) {
      emit(HomeError(error: GlobalErrorData(e)));
    }
  }

  filter(String category) {
    emit(HomeLoaded(products: products));
  }
}
