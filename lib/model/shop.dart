class Shop {
  int id;
  String name;
  String sellerName;

  Shop({
    this.id = 0,
    this.name = '',
    this.sellerName = '',
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      sellerName: json['username'],
    );
  }
}
