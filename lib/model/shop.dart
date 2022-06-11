class Shop {
  int id;
  String name;
  String sellerName;
  String? shopImg;

  Shop({this.id = 0, this.name = '', this.sellerName = '', this.shopImg});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      sellerName: json['seller_id'].toString(),
      shopImg: json['shop_img'],
    );
  }

  factory Shop.fromSellerJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      sellerName: json['seller_id'].toString(),
      shopImg: json['shop_img'],
    );
  }
}
