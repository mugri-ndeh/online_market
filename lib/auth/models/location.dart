class UserLocation {
  String id;
  String town;
  String region;
  String quarter;

  UserLocation({
    this.region = '',
    this.id = '',
    this.town = '',
    this.quarter = '',
  });
  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
        region: json['region'],
        id: json['id'],
        town: json['town'],
        quarter: json['quarter']);
  }

  Map<String, String> toJson() {
    return {
      'region': region,
      'id': id,
      'town': town,
      'quarter': quarter,
    };
  }
}
