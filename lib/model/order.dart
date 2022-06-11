import 'dart:convert';

class Order {
  int orderId;
  List<Map<String, dynamic>>? products;
  int quantity;
  String state;
  int userId;
  int priceTotal;
  String date;

  Order(
      {this.orderId = 0,
      this.products,
      this.quantity = 0,
      this.state = '',
      this.priceTotal = 0,
      this.userId = 0,
      this.date = ''});
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['id'],
      products: jsonDecode(json['items']!),
      quantity: json['qty'],
      state: json['state'],
      userId: json['uid'],
      priceTotal: json['price_total'],
      date: json['date'],
    );
  }

  factory Order.fromBbJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['id'],
      quantity: json['qty'],
      state: json['state'],
      priceTotal: json['price_total'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': orderId,
      'food_items': products,
      'qty': quantity,
      'o_state': state,
      'user_id': userId,
      'price_total': priceTotal,
    };
  }
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
