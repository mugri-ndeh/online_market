import 'dart:convert';

class UserLocation {
  String id;
  String town;
  String region;
  String quarter;

  UserLocation({
    this.id = '',
    this.town = '',
    this.region = '',
    this.quarter = '',
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'town': town});
    result.addAll({'region': region});
    result.addAll({'quarter': quarter});

    return result;
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      id: map['id'] ?? '',
      town: map['town'] ?? '',
      region: map['region'] ?? '',
      quarter: map['quarter'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocation.fromJson(String source) =>
      UserLocation.fromMap(json.decode(source));
}
