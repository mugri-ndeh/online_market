class Product {
  int id;
  String name;
  String category;
  String price;
  String image;
  int qty;
  Product({
    this.id = 0,
    this.name = '',
    this.category = '',
    this.price = '',
    this.image = '',
    this.qty = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category_name'],
      price: json['price'],
      image: json['image'],
      qty: json['quantity'],
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
    };
  }
}
