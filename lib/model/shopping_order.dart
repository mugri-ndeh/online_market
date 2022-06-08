class ShoppingOrder {
  int id;
  int customerId;
  int shopId;
  int productId;
  String date;
  String state;
  List items;
  ShoppingOrder({
    this.id = 0,
    this.state = '',
    this.customerId = 0,
    this.shopId = 0,
    this.productId = 0,
    this.date = '',
    this.items = const [],
  });
}
