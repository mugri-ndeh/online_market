import 'package:online_market/model/product.dart';
import 'package:online_market/services/firebase/firebase_helper.dart';

import '../../model/order.dart';
import '../../model/shop.dart';

class SellerRepository {
  Future createShop(Shop shop) async {
    await CustomFirestore.shopsRef.doc().set(shop.toMap());
  }

  deleteProduct(Product product) async {
    await CustomFirestore.shopsRef.doc(product.id).delete();
  }

  acceptOrder(Order order) {}

  Future addProductToShop(Product product) async {
    await CustomFirestore.productsRef.doc().set(product.toMap());
  }

  Future editShopDetails(Shop shop) async {
    await CustomFirestore.shopsRef.doc(shop.id).update(shop.toMap());
  }

  Future editProductDetails(Product product) async {
    await CustomFirestore.productsRef.doc(product.id).update(product.toMap());
  }
}
