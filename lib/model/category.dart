class Category {
  int id;
  String categoryName;
  Category({
    this.id = 0,
    this.categoryName = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["cid"] is String ? int.parse(json["cid"]) : json["cid"],
      categoryName: json["category_name"],
    );
  }
}
