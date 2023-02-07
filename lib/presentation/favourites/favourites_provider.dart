import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:online_market/model/product.dart';

class FavouritesHelper with ChangeNotifier {
  final LocalStorage storage = LocalStorage('favourites');
  List favourites = [];
  bool isFavourite = false;

  init() async {
    favourites = await getFavourites();
    print('INIT FAV HELPER');
    notifyListeners();
  }

  FavouritesHelper() {
    init();
  }

  bool isfavourite(Product foodItem) {
    bool favourite = false;
    int i;
    for (i = 0; i < favourites.length; i++) {
      if (foodItem.id == Product.fromJson(favourites[i]).id) {
        favourite = true;
      }
    }
    isFavourite = favourite;
    return favourite;
  }

  addFavourites(Product foodItem) {
    favourites.add(foodItem.toJson());
    _saveToStorage();
    notifyListeners();
  }

  remove(Product food) async {
    await storage.ready;

    favourites.removeWhere((element) {
      //print(element.values);
      var val = false;
      print(food.toJson()['id']);

      if (element['id'] == food.toJson()['id']) {
        val = true;
      } else {
        val = false;
      }
      return val;

      //return element.values == song.toJson().values;
    });
    print(favourites);
    _saveToStorage();
    notifyListeners();
    //storage.deleteItem('favourite $name');
  }

  _saveToStorage() async {
    await storage.ready;
    // List existing = await getFavourites();
    // existing.add(song.toJson());
    storage.setItem('favourite', favourites);
    // print('SAVED CORRECTLY');
    notifyListeners();
  }

  clearItems() async {
    await storage.ready;
    await storage.clear();
    favourites = [];
    print('Cleared');
    notifyListeners();
  }

  getFavourites() async {
    await storage.ready;
    List fav = await storage.getItem('favourite') ?? [];
    notifyListeners();

    return fav;
  }
}
