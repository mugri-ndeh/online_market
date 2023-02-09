import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';

import '../../model/order.dart';

class UserRepository {
  static Future<List<Product>> getAllProducts() async {
    var prods = await CustomFirestore.productsRef.get();
    return prods.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<String>> getCategories() async {
    var result = await CustomFirestore.categoriesRef.get();
    return result.docs
        .map((e) => (e.data() as Map<String, dynamic>)['category'].toString())
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

  Future<List<Product>> searchShops(String searchPaprams) async {
    // TODO finish search fnx
    var shops = await CustomFirestore.shopsRef.get();
    var shopsList = shops.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return shopsList;
  }

  static Future<List<Shop>> getAllShops() async {
    var shops = await CustomFirestore.shopsRef.get();
    return shops.docs
        .map((e) => Shop.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  static Stream<QuerySnapshot<Object?>> getAllShopsUser() {
    return CustomFirestore.shopsRef.snapshots();
  }
}
