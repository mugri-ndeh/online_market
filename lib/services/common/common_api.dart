import 'dart:convert';

import 'package:online_market/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:online_market/auth/models/user_model.dart';

class CommonApi {
  static Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse(Api.login);

    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(response.body);

      final user = json.decode(response.body)['state'];

      if (user is String) {
        return null;
      }

      return UserModel.fromJson(user);
    } else {
      throw Exception();
    }
  }

  static Future<String> signUp(
      String username, String email, String password) async {
    final url = Uri.parse(Api.signup);

    final response = await http.post(url, body: {
      "email": email,
      "username": username,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(response.body);

      final result = json.decode(response.body)['state']['success'];

      return result;
    } else {
      throw Exception();
    }
  }

  static Future completeProfile(UserModel user) async {
    final url = Uri.parse(Api.completeProfile);

    final response = await http.post(url, body: {
      "uid": user.uid.toString(),
      "firstName": user.firstName,
      "lastName": user.lastName,
      "phoneNumber": user.phoneNumber,
      "accountType": user.accountType,
      "region": user.location!['region'],
      "town": user.location!['town'],
      "quarter": user.location!['quarter'],
    });

    if (response.statusCode == 200) {
      print(response.body);

      final result = json.decode(response.body)['state'];

      return result;
    } else {
      throw Exception();
    }

    //  $firstname = $jsonData['firstname'];
    //  $lastname = $jsonData['lastname'];
    //  $phonenumber = $jsonData['phonenumber'];
    //  $accountType = $jsonData['accountType'];
    //  $region = $jsonData['region'];
    //  $town = $jsonData['town'];
    //  $quarter = $jsonData['quarter'];
  }

  static Future<UserModel?> getUser(int id) async {
    final url = Uri.parse(Api.getUser);

    final response = await http.post(url, body: {
      "uid": id.toString(),
    });

    if (response.statusCode == 200) {
      print(response.body);

      final user = json.decode(response.body)['state'];

      if (user is String) {
        return null;
      }

      return UserModel.fromJson(user);
    } else {
      throw Exception();
    }
  }

  static Future<UserModel?> editProfile(UserModel user) async {
    final url = Uri.parse(Api.editProfile);

    final response = await http.post(url, body: {
      "uid": user.uid.toString(),
      "firstName": user.firstName,
      "lastName": user.lastName,
      "username": user.username,
      "email": user.email,
      "phoneNumber": user.phoneNumber,
    });

    if (response.statusCode == 200) {
      print(response.body);

      final Map<String, dynamic> user = json.decode(response.body)['state'];
      print(user);

      if (user is String) {
        return null;
      }
      return UserModel.fromJson(user);
    } else {
      throw Exception();
    }
  }

  static Future resetPassword(
      int id, String oldPassword, String newPassword) async {}
  static Future updatePassword(int id, String password) async {}
}
