import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';
import 'package:online_market/services/repository/seller_repository.dart';

import '../../../../../../model/product.dart';
import '../../../../../../services/auth/auth_service.dart';
import '../../../../../../services/locator.dart';
import '../../../../../../util/helper.dart';

part 'shop_products_state.dart';

class ShopProductsCubit extends Cubit<ShopProductsState> {
  ShopProductsCubit() : super(ShopProductsInitial()) {
    getCategories();
  }
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  String imageUrl = '';
  String? category;
  List<String> categories = ['Farm products, Livestock'];
  File? image;

  String? validate() {
    if (nameController.text.isEmpty) {
      return 'please enter a product name';
    } else if (priceController.text.isEmpty) {
      return 'please enter a price';
    } else if (qtyController.text.isEmpty) {
      return 'please enter the quantity';
    } else if (category == null) {
      return 'please select category';
    } else if (image == null) {
      return 'please select an image';
    } else {
      return null;
    }
  }

  addProductToShop(String shopId) async {
    emit(ProductLoading());
    try {
      String? error = validate();

      if (error == null) {
        imageUrl = await locator<AuthService>().uploadFile(
            data: image!.readAsBytesSync(), path: shopId + nameController.text);
        Product product = Product(
          shopId: shopId,
          name: nameController.text,
          price: priceController.text,
          availableQuantity: int.parse(qtyController.text),
          category: category!,
          image: imageUrl,
        );
        await SellerRepository.addProductToShop(product);
        emit(ProductSuccess());
      } else {
        emit(ProductError(GlobalErrorData(error)));
      }
    } catch (e) {
      emit(ProductError(GlobalErrorData(e)));
    }
  }

  pickImage() async {
    image = await chooseImage();
    emit(ImagePicked(image: image!));
  }

  updateCategory(value) {
    emit(ProductLoading());
    category = value;
    emit(CategoryPicked(category: value));
  }

  getCategories() async {
    emit(ProductLoading());
    var data = await CustomFirestore.categoriesRef.get();
    categories = data.docs
        .map((e) => (e.data() as Map<String, dynamic>)['category'].toString())
        .toList();
    emit(const CategoryPicked(category: 'home'));
  }
}
