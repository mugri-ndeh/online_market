import 'dart:convert';

class ShoppingOrder {
  String id;
  String customerId;
  String shopId;
  List<String> productId;
  DateTime date;
  String state;
  double cost;
  ShoppingOrder({
    required this.id,
    required this.customerId,
    required this.shopId,
    required this.productId,
    required this.date,
    required this.state,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'customerId': customerId});
    result.addAll({'shopId': shopId});
    result.addAll({'productId': productId});
    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'state': state});
    result.addAll({'cost': cost});

    return result;
  }

  factory ShoppingOrder.fromMap(Map<String, dynamic> map) {
    return ShoppingOrder(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      shopId: map['shopId'] ?? '',
      productId: List<String>.from(map['productId']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      state: map['state'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingOrder.fromJson(String source) =>
      ShoppingOrder.fromMap(json.decode(source));
}
