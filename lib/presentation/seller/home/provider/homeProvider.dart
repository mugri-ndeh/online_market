import 'package:flutter/widgets.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/rating.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/seller/seller_api.dart';

import '../../../auth/providers/auth_provider.dart';

class SellerHomeProvider with ChangeNotifier {
  SellerHomeProvider({this.auth});
  Authentication? auth;

  List<Shop> shops = [];
  List<Product> products = [];
  List<Rating> rating = [];

  Future getShops() async {
    shops = (await SellApi.getStores(auth!.loggedUser!.uid))!;
    notifyListeners();
  }

  Future getProducts() async {
    products = (await SellApi.getAllProducts(auth!.loggedUser!.uid))!;
    notifyListeners();
  }

  Future getRatings() async {
    // rating = (await SellApi.getStores(1))!;
  }

  getEarnings() {}
  getInvoice() {}

  Future init() async {
    getShops();
    getProducts();
    print('USER IS');
    print(auth!.loggedUser!.username);
  }
}
