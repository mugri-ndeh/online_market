import 'package:flutter/widgets.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/rating.dart';
import 'package:online_market/model/shop.dart';

class SellerHomeProvider with ChangeNotifier {
  SellerHomeProvider();

  List<Shop> shops = [];
  List<Product> products = [];
  List<Rating> rating = [];

  Future getShops() async {
    // shops = (await SellApi.getStores(0))!;
    notifyListeners();
  }

  Future getProducts() async {
    // products = (await SellApi.getAllProducts(0))!;
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
  }
}
