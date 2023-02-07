import 'dart:convert';

import 'package:online_market/model/location.dart';

enum AccountType { customer, seller, both }

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  UserLocation? location;
  bool completedProfile;
  String phoneNumber;
  String accountType;
  UserModel({
    this.uid = '',
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.location,
    this.completedProfile = false,
    this.phoneNumber = '',
    this.accountType = '',
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'password': password});
    if (location != null) {
      result.addAll({'location': location!.toMap()});
    }
    result.addAll({'completedProfile': completedProfile});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'accountType': accountType});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      location: map['location'] != null
          ? UserLocation.fromMap(map['location'])
          : null,
      completedProfile: map['completedProfile'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      accountType: map['accountType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
