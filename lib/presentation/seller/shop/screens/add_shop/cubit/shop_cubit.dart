import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/errors/global_error_handling/global_app_state.dart';
import 'package:online_market/services/locator.dart';
import 'package:online_market/services/repository/seller_repository.dart';
import 'package:online_market/util/helper.dart';

import '../../../../../../model/shop.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  SellerRepository repository = SellerRepository();
  String imageUrl = '';
  final nameController = TextEditingController();

  File? image;
  final picker = ImagePicker();

  String? validate() {
    if (nameController.text.isEmpty) {
      return 'please enter the shop name';
    } else if (image == null) {
      return 'please select an image';
    }
  }

  addShop() async {
    emit(ShopLoading());
    try {
      String? error = validate();
      if (error == null) {
        Shop shop = Shop(
            shopName: nameController.text,
            owner: locator<AuthService>().loggedUser!);
        var shopPic = await locator<AuthService>().uploadFile(
            data: image!.readAsBytesSync(),
            path: shop.shopName + shop.owner.uid);
        shop.shopImg = shopPic;
        shop.sellerId = locator<AuthService>().loggedUser!.uid;
        await SellerRepository.createShop(shop);
        emit(ShopSuccess());
      } else {
        emit(ShopError(GlobalErrorData(error)));
      }
    } catch (e) {
      emit(ShopError(GlobalErrorData(e)));
    }
  }

  pickImage() async {
    image = await chooseImage();
    emit(ImagePicked(image: image!));
  }
}
