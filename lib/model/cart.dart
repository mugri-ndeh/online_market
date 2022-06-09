class CartItem {
  String id;
  Map<String, dynamic>? item;
  int qty;
  CartItem({
    this.id = '',
    this.item,
    this.qty = 0,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      qty: json['qty'],
      item: json['item'],
    );
  }

  toJson() {
    return {
      'item': item,
      'qty': qty,
    };
  }
}
