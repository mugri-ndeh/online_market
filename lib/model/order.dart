import 'dart:convert';

import 'package:online_market/model/product.dart';

class Order {
  String orderId;
  List<Product> products;
  int quantity;
  String state;
  String userId;
  int priceTotal;
  DateTime date;
  Order({
    required this.orderId,
    required this.products,
    required this.quantity,
    required this.state,
    required this.userId,
    required this.priceTotal,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'orderId': orderId});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'quantity': quantity});
    result.addAll({'state': state});
    result.addAll({'userId': userId});
    result.addAll({'priceTotal': priceTotal});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] ?? '',
      products:
          List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
      quantity: map['quantity']?.toInt() ?? 0,
      state: map['state'] ?? '',
      userId: map['userId'] ?? '',
      priceTotal: map['priceTotal']?.toInt() ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

class OrderR {
  int orderId;
  List<Map<String, dynamic>>? foodItems;
  int quantity;
  String state;
  int userId;
  String priceTotal;

  OrderR(
      {this.orderId = 0,
      this.foodItems,
      this.quantity = 0,
      this.state = '',
      this.priceTotal = '0',
      this.userId = 0});
  factory OrderR.fromJson(Map<String, dynamic> json) {
    return OrderR(
      orderId: json['id'],
      foodItems: jsonDecode(json['food_items']!),
      quantity: json['qty'],
      state: json['o_state'],
      userId: json['u_id'],
      priceTotal: json['price_total'],
    );
  }
}

class OrderItem {
  int id;
  Map<String, dynamic>? foodItem;
  int quantity;

  OrderItem({
    this.id = 0,
    this.foodItem,
    this.quantity = 0,
  });
}
