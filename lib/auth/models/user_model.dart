enum AccountType { customer, seller, both }

class UserModel {
  String uid;
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
    this.uid = '',
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
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      completedProfile: json['completedProfile'],
      phoneNumber: json['phoneNumber'],
      accountType: json['accountType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'location': location,
      'password': password,
      'completedProfile': completedProfile,
      'accountType': accountType,
    };
  }
}
