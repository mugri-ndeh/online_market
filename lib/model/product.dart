class Product {
  int id;
  String name;
  String category;
  String price;
  String image;
  int shopId;
  int qty;
  Product({
    this.id = 0,
    this.name = '',
    this.category = '',
    this.price = '',
    this.image = '',
    this.qty = 0,
    this.shopId = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category_name'],
      price: json['price'],
      image: json['image'],
      qty: json['quantity'],
      shopId: json['shop_id'],
    );
  }

  factory Product.fromSellerJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category_id'].toString(),
      price: json['price'],
      image: json['image'],
      qty: json['quantity'],
      shopId: json['shop_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category_name": category,
      "price": price,
      "image": image,
      "quantity": qty,
      "shop_id": shopId
    };
  }
}
