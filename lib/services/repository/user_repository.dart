import 'package:online_market/model/product.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';

import '../../model/order.dart';
import '../../model/shop.dart';

class UserRepository {
  Future<List<Product>> getAllProducts() async {
    var prods = await CustomFirestore.productsRef.get();
    return prods.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Product>> getShopProducts(String shopId) async {
    var prods = await CustomFirestore.productsRef
        .where('shopId', isEqualTo: shopId)
        .get();
    return prods.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Product>> searchProducts(String searchParams) async {
    // TODO finish search fnx
    var prods = await CustomFirestore.productsRef.get();
    var products = prods.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return products;
  }

  Future<List<Shop>> searchShops(String searchPaprams) async {
    // TODO finish search fnx
    var shops = await CustomFirestore.shopsRef.get();
    var shopsList = shops.docs
        .map((e) => Shop.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return shopsList;
  }

  Future<List<Shop>> getAllShops() async {
    var shops = await CustomFirestore.shopsRef.get();
    return shops.docs
        .map((e) => Shop.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  Future placeOrder(Order order) async {
    await CustomFirestore.ordersRef.doc().set(order.toMap());
  }
}
