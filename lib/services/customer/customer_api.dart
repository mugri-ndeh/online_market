import 'dart:convert';

import 'package:online_market/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/model/order.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/profile/edit_profile.dart';

class UserApi {
  static Future<List<Shop>?> getStores() async {
    final url = Uri.parse(CustomerApi.viewStores);

    final response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      // print(response.body);

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
      // print(response.body);

      var result = json.decode(response.body)['state'];
      if (result is String) {
        return [];
      } else {
        final List stores = json.decode(response.body)['state'];
        List<Product> products =
            stores.map((e) => Product.fromJson(e)).toList();
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
      print(response.body);

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
      // print(response.body);

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

  static Future createOrder(
      List<Product> products, UserModel user, int priceTotal, int qty) async {
    final url = Uri.parse(CustomerApi.createOrder);

    final response = await http.post(url, body: {
      "customer_id": user.uid.toString(),
      "shop_id": products[0].shopId.toString(),
      "date": "22/06/2022",
      "state": "pending",
      "items": jsonEncode(products.map((e) => e.id).toList()),
      "price_total": priceTotal.toString(),
      "qty": qty.toString(),
    });

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

  static Future<List<Product>?> getWishList(UserModel user) async {
    final url = Uri.parse(CustomerApi.getWishList);

    final response = await http.post(url, body: {
      "uid": user.uid.toString(),
    });

    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);

      final List wish = json.decode(response.body)['state'];
      print(wish);

      List<Product> products =
          wish.map((e) => Product.fromSellerJson(e)).toList();

      if (wish is String) {
        return [];
      }
      return products;
    } else {
      throw Exception();
    }
  }

  static Future getOrders(UserModel user) async {
    final url = Uri.parse(CustomerApi.getOrders);

    final response = await http.post(url, body: {"id": user.uid.toString()});

    if (response.statusCode == 200) {
      print(response.body);

      var result = json.decode(response.body)['state'];

      if (result is String) {
        return [];
      } else {
        final List orders = json.decode(response.body)['state'];
        List<Order> ordersReturened =
            orders.map((e) => Order.fromJson(e['order'])).toList();

        return ordersReturened;
      }
    } else {
      throw Exception();
    }
  }

  static Future<List<Product>?> searchProducts(String query) async {
    final url = Uri.parse(CustomerApi.search);

    final response = await http.post(url, body: {"query": query});

    if (response.statusCode == 200) {
      var result = json.decode(response.body)['state'];

      print(response.body);

      List<Product> products = [];

      if (result is! String) {
        final List promotions = json.decode(response.body)['state'];
        print(promotions);

        products = promotions.map((e) => Product.fromSellerJson(e)).toList();
        return products;
      } else {
        return [];
      }
    } else {
      throw Exception();
    }
  }

  static Future<List<Shop>?> searchShops(String query) async {
    final url = Uri.parse(CustomerApi.searchShops);

    final response = await http.post(url, body: {"query": query});

    if (response.statusCode == 200) {
      var result = json.decode(response.body)['state'];

      print(response.body);

      List<Shop> products = [];

      if (result is! String) {
        final List promotions = json.decode(response.body)['state'];
        print(promotions);

        products = promotions.map((e) => Shop.fromSellerJson(e)).toList();
        return products;
      } else {
        return [];
      }
    } else {
      throw Exception();
    }
  }
}
