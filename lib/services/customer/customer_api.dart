import 'dart:convert';

import 'package:online_market/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/profile/edit_profile.dart';

class UserApi {
  static Future<List<Shop>?> getStores() async {
    final url = Uri.parse(CustomerApi.viewStores);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      final List stores = json.decode(response.body)['state'];
      List<Shop> shops = stores.map((e) => Shop.fromJson(e)).toList();

      if (stores is String) {
        return null;
      }
      return shops;
    } else {
      throw Exception();
    }
  }

  static Future<List<Product>?> getShopProducts(int id) async {
    final url = Uri.parse(CustomerApi.getShopProducts);

    final response = await http.post(url, body: {
      "id": id.toString(),
    });

    print('Rsponse is');
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      final List stores = json.decode(response.body)['state'];
      List<Product> products = stores.map((e) => Product.fromJson(e)).toList();

      if (stores is String) {
        return null;
      } else {
        return products;
      }
    } else {
      throw Exception();
    }
  }

  static Future<List<Product>?> getProducts() async {
    final url = Uri.parse(CustomerApi.getAllProducts);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);

      final List prods = json.decode(response.body)['state'];
      print(prods);

      List<Product> products = prods.map((e) => Product.fromJson(e)).toList();

      if (products is String) {
        return null;
      }
      return products;
    } else {
      throw Exception();
    }
  }

  static Future<List<Product>?> getPromo() async {
    final url = Uri.parse(CustomerApi.getPromo);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      final List promotions = json.decode(response.body)['state'];
      print(promotions);

      List<Product> products =
          promotions.map((e) => Product.fromJson(e)).toList();

      if (promotions is String) {
        return null;
      }
      return products;
    } else {
      throw Exception();
    }
  }
}
