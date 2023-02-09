import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';

import '../../../../../model/product.dart';
import '../../../../../services/repository/user_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {
    loadData();
  }
  final searchController = TextEditingController();
  List<Product> products = [];
  List<Product> results = [];
  String query = '';

  loadData() async {
    emit(SearchLoading());
    products = await UserRepository.getAllProducts();
    emit(const SearchLoaded(products: []));
  }

  search() {
    emit(Searching());
    results = products
        .where((element) => element.name.contains(searchController.text))
        .toList();
    emit(SearchLoaded(products: products));
  }
}
