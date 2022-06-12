import 'dart:convert';
import 'dart:io';

import 'package:online_market/api/api.dart';
import 'package:online_market/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:online_market/model/shop.dart';

class SellApi {
  static Future<List<Product>?> getShopProducts(int id) async {
    final url = Uri.parse(SellerApi.viewProducts);

    final response = await http.post(url, body: {
      "shop_id": id.toString(),
    });

    if (response.statusCode == 200) {
      print(response.body);

      var result = json.decode(response.body)['state'];

      if (result is String) {
        return null;
      } else {
        final List prods = json.decode(response.body)['state'];
        print(prods);

        List<Product> products =
            prods.map((e) => Product.fromSellerJson(e)).toList();
        return products;
      }
    } else {
      throw Exception();
    }
  }

  static Future<List<Shop>?> getStores(int id) async {
    final url = Uri.parse(SellerApi.viewStores);

    final response = await http.post(url, body: {
      "id": id.toString(),
    });

    if (response.statusCode == 200) {
      print(response.body);
      print(id);
      final List stores = json.decode(response.body)['state'];
      List<Shop> shops = stores.map((e) => Shop.fromSellerJson(e)).toList();

      if (stores is String) {
        return null;
      }
      return shops;
    } else {
      throw Exception();
    }
  }

  static Future<List<Product>?> getAllProducts(int id) async {
    final url = Uri.parse(SellerApi.viewAllProducts);

    final response = await http.post(url, body: {
      "uid": id.toString(),
    });

    print('Rsponse is');
    // print(response.body);
    if (response.statusCode == 200) {
      print(id);
      print(response.body);

      final List stores = json.decode(response.body)['state'];
      List<Product> products =
          stores.map((e) => Product.fromSellerJson(e)).toList();

      if (stores is String) {
        return null;
      } else {
        return products;
      }
    } else {
      throw Exception();
    }
  }

  static Future addProduct(Product product, int shopId, File image) async {
    final url = Uri.parse(SellerApi.addProducts);

    var request = http.MultipartRequest('POST', url);

    request.fields['name'] = product.name;
    request.fields["category_id"] = product.category;
    request.fields["price"] = product.price;
    request.fields["image"] = product.image;
    request.fields["shop_id"] = shopId.toString();
    request.fields["quantity"] = product.qty.toString();

    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);

    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.body}");

    // final response = await http.post(url, body: {
    //   "category_id": product.category,
    //   "name": product.name,
    //   "price": product.price,
    //   "image": product.image,
    //   "shop_id": shopId.toString(),
    //   "quantity": product.qty.toString(),
    // });

    // print('Rsponse is');
    // print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      final result = json.decode(response.body)['state'];

      if (result is String) {
        return null;
      } else {
        return 'Success';
      }
    } else {
      throw Exception();
    }
  }

  static Future addShop(Shop shop, File image) async {
    final uri = Uri.parse(SellerApi.createStore);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = shop.name;
    request.fields["seller_id"] = shop.sellerName;
    request.fields["name"] = shop.name;
    request.fields["shop_img"] = shop.shopImg!;

    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);

    // var response = await request.send();

    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.body}");
    // return response.body;

    // final response = await http.

    if (response.statusCode == 200) {
      print(response.body);

      final result = json.decode(response.body)['state'];

      if (result is String) {
        return null;
      } else {
        return 'Success';
      }
    } else {
      throw Exception();
    }

    // final url = Uri.parse(SellerApi.createStore);

    // final response = await http.post(url, body: {
    //   "seller_id": shop.sellerName,
    //   "name": shop.name,
    //   "shop_img": shop.shopImg,
    // });

    // print('Rsponse is');
    // // print(response.body);
    // if (response.statusCode == 200) {
    //   print(response.body);

    //   final result = json.decode(response.body)['state'];

    //   if (result is String) {
    //     return null;
    //   } else {
    //     return 'Success';
    //   }
    // } else {
    //   throw Exception();
    // }
  }
}
