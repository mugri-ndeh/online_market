import 'dart:convert';

import 'user_model.dart';

class Shop {
  String id;
  String shopName;
  UserModel owner;
  String? shopImg;
  String sellerId;
  Shop({
    this.id = '',
    required this.shopName,
    required this.owner,
    this.shopImg,
    this.sellerId = '',
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'shopName': shopName});
    result.addAll({'owner': owner.toMap()});
    if (shopImg != null) {
      result.addAll({'shopImg': shopImg});
    }
    result.addAll({'sellerId': sellerId});

    return result;
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'] ?? '',
      shopName: map['shopName'] ?? '',
      owner: UserModel.fromMap(map['owner']),
      shopImg: map['shopImg'],
      sellerId: map['sellerId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) => Shop.fromMap(json.decode(source));
}
