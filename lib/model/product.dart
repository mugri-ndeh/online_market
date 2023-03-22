import 'dart:convert';

class Product {
  String id;
  String name;
  String category;
  String price;
  String image;
  int availableQuantity;
  String shopId;
  Product({
    this.id = '',
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.availableQuantity,
    required this.shopId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'category': category});
    result.addAll({'price': price});
    result.addAll({'image': image});
    result.addAll({'availableQuantity': availableQuantity});
    result.addAll({'sellerId': shopId});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      price: map['price'] ?? '',
      image: map['image'] ?? '',
      availableQuantity: map['availableQuantity']?.toInt() ?? 0,
      shopId: map['sellerId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
