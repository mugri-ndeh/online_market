import 'dart:convert';

enum AccountType { customer, seller, both }

class UserModel {
  int uid;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  Map<String, dynamic>? location;
  bool completedProfile;
  String phoneNumber;
  String accountType;

  UserModel({
    this.completedProfile = false,
    this.uid = 0,
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.password = '',
    this.location,
    this.email = '',
    this.phoneNumber = '',
    this.accountType = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] is String ? int.parse(json['uid']) : json['uid'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      completedProfile: json['completedProfile'] == 1 ? true : false,
      phoneNumber: json['phoneNumber'],
      accountType: json['accountType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'uid': uid.toString(),
      'firstName': firstName,
      'lastName': lastName,
      'location': location,
      'password': password,
      'completedProfile': completedProfile,
      'accountType': accountType,
    };
  }

  Map<String, dynamic> toDbJson() {
    return {
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'location': jsonEncode(location),
      'password': password,
      'completedProfile': completedProfile,
      'accountType': accountType,
    };
  }
}
