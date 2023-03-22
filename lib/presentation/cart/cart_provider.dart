import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:online_market/model/cart.dart';
import 'package:online_market/model/product.dart';

class CartHelper with ChangeNotifier {
  final LocalStorage storage = LocalStorage('cart');
  List cartItems = [];
  bool isCartItem = false;

  init() async {
    cartItems = await getCartItems();
    notifyListeners();
  }

  CartHelper() {
    init();
  }

  bool isCartitem(Product cartItem) {
    bool cartitem = false;
    int i;
    for (i = 0; i < cartItems.length; i++) {
      if (cartItem.id == CartItem.fromJson(cartItems[i]).item!['id']) {
        cartitem = true;
      }
    }
    isCartItem = cartitem;
    notifyListeners();
    return cartitem;
  }

  bool isNotFromShop(Product foodItem) {
    bool shopItem = false;
    int i;
    for (i = 0; i < cartItems.length; i++) {
      if (foodItem.shopId == CartItem.fromJson(cartItems[i]).item!['shop_id']) {
        shopItem = true;
      }
    }
    notifyListeners();
    return shopItem;
  }

  addToCart(CartItem cartItem) {
    cartItems.add(cartItem.toJson());
    _saveToStorage();
    notifyListeners();
  }

  remove(int id) async {
    await storage.ready;

    cartItems.removeAt(id);
    _saveToStorage();
    notifyListeners();
  }

  _saveToStorage() async {
    await storage.ready;
    storage.setItem('cart', cartItems);
    getTotal();
    notifyListeners();
  }

  getCartItems() async {
    await storage.ready;
    List fav = await storage.getItem('cart') ?? [];
    notifyListeners();

    return fav;
  }

  clearItems() async {
    await storage.ready;
    await storage.clear();
    cartItems = [];
    notifyListeners();
  }

  int total = 0;

  getTotal() {
    total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      CartItem item = CartItem.fromJson(cartItems[i]);
      Product foodItem = Product.fromMap(item.item!);
      total = total +
          (int.parse(foodItem.price.replaceAll('XAF', '').trim()) * item.qty);
    }
    notifyListeners();
  }
}
