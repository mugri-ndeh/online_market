// import 'package:flutter/widgets.dart';
// import 'package:online_market/model/product.dart';
// import 'package:online_market/model/shop.dart';
// import 'package:online_market/services/seller/seller_api.dart';

// class SellerShopProvider with ChangeNotifier {
//   SellerShopProvider({})
//   Shop? shop;
//   List<Product> products = [];
//   bool isLoading = false;
//   Future getShopProducts() async {
//     products = (await SellApi.getShopProducts(shop.id))!;
//   }

//   addToshop(int id) {}
//   removeFromShop(id) {}

//   init() {
//     getShopProducts();
//   }
// }
