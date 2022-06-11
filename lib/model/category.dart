class Category {
  int id;
  String categoryName;
  Category({
    this.id = 0,
    this.categoryName = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      categoryName: json["category_name"],
    );
  }
}
