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
    print('CART HELPER');
    notifyListeners();
  }

  CartHelper() {
    init();
  }

  bool isCartitem(Product foodItem) {
    bool cartitem = false;
    int i;
    for (i = 0; i < cartItems.length; i++) {
      if (foodItem.id == CartItem.fromJson(cartItems[i]).item!['id']) {
        cartitem = true;
      }
    }
    isCartItem = cartitem;
    notifyListeners();
    print(cartitem);
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
    // isCartItem = shopItem
    notifyListeners();
    // print(cartitem);
    return shopItem;
  }

  addToCart(CartItem cartItem) {
    cartItems.add(cartItem.toJson());
    _saveToStorage();
    notifyListeners();
  }

  remove(int id) async {
    await storage.ready;

    // cartItems.removeWhere((element) {
    //   //print(element.values);
    //   var val = false;
    //   print(cartItem.toJson()['id']);

    //   if (element['id'] == cartItem.toJson()['id']) {
    //     val = true;
    //   } else {
    //     val = false;
    //   }
    //   return val;

    //   //return element.values == song.toJson().values;
    // });

    cartItems.removeAt(id);
    print(cartItems);
    _saveToStorage();
    notifyListeners();
    //storage.deleteItem('favourite $name');
  }

  _saveToStorage() async {
    await storage.ready;
    // List existing = await getFavourites();
    // existing.add(song.toJson());
    storage.setItem('cart', cartItems);
    print('SAVED CORRECTLY');
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
    print('Cleared');
    notifyListeners();
  }
}
