import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';
import 'package:online_market/services/locator.dart';

import '../../model/shop.dart';

class SellerRepository {
  static Future createShop(Shop shop) async {
    await CustomFirestore.shopsRef.add(shop.toMap()).then((value) =>
        CustomFirestore.shopsRef.doc(value.id).update({'id': value.id}));
  }

  static Future deleteProduct(Product product) async {
    await CustomFirestore.productsRef.doc(product.id).delete();
  }

  // acceptOrder(Order order) {}

  static Future addProductToShop(Product product) async {
    await CustomFirestore.productsRef.doc().set(product.toMap());
  }

  static Future editShopDetails(Shop shop) async {
    await CustomFirestore.shopsRef.doc(shop.id).update(shop.toMap());
  }

  static Future editProductDetails(Product product) async {
    await CustomFirestore.productsRef.doc(product.id).update(product.toMap());
  }

  static Stream<QuerySnapshot<Object?>> getShopProducts(String shopId) {
    return CustomFirestore.productsRef
        .where('sellerId', isEqualTo: shopId)
        .snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getUserShops() {
    return CustomFirestore.shopsRef
        .where('sellerId', isEqualTo: locator<AuthService>().loggedUser!.uid)
        .snapshots();
  }
}
