import 'dart:convert';

class ItemModel {
  String productname;
  String price;
  String phoneNumber;


  ItemModel({
    this.productname = '',
    this.price = '',
    this.phoneNumber = '',
    
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      price: json['price'],
      productname: json['productname'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'productname': productname,
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, dynamic> toDbJson() {
    return {
      'price': price,
      'productname': productname,
      'phoneNumber': phoneNumber,
    };
  }
}
