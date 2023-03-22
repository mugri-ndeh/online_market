import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:online_market/model/product.dart';

class FavouritesHelper with ChangeNotifier {
  final LocalStorage storage = LocalStorage('favourites');
  List favourites = [];
  bool isFavourite = false;

  init() async {
    favourites = await getFavourites();
    notifyListeners();
  }

  FavouritesHelper() {
    init();
  }

  bool isfavourite(Product product) {
    bool favourite = false;
    for (int i = 0; i < favourites.length; i++) {
      if (product.name == Product.fromJson(favourites[i]).name) {
        favourite = true;
      }
    }
    isFavourite = favourite;
    return favourite;
  }

  addFavourites(Product product) {
    favourites.add(product.toJson());
    _saveToStorage();
    notifyListeners();
  }

  remove(Product product) async {
    await storage.ready;

    favourites.removeWhere((element) {
      var val = false;
      if (Product.fromJson(element).id == product.toMap()['id']) {
        val = true;
      } else {
        val = false;
      }
      return val;
    });
    _saveToStorage();
    notifyListeners();
  }

  _saveToStorage() async {
    await storage.ready;
    storage.setItem('favourite', favourites);
    notifyListeners();
  }

  clearItems() async {
    await storage.ready;
    await storage.clear();
    favourites = [];
    notifyListeners();
  }

  getFavourites() async {
    await storage.ready;
    List fav = await storage.getItem('favourite') ?? [];
    notifyListeners();

    return fav;
  }
}
