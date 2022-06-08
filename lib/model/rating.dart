class Rating {
  int id;
  int rating;
  String review;

  Rating({this.id = 0, this.rating = 0, this.review = ''});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating();
  }

  toJson() {}
}
