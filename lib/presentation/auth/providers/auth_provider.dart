// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_market/services/common/common_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/user_model.dart';

enum AuthState {
  loggedIn,
  loggedOut,
  incomplete,
  loading,
  finishedOnboard,
  fresh,
  login,
  signup,
}

class Authentication with ChangeNotifier {
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  UserModel? loggedUser;
  String? verificationCode;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late SharedPreferences preferences;

  late AuthState _loginState;
  get loginState => _loginState;

  setAuthState(AuthState authState) {
    _loginState = authState;
    notifyListeners();
  }

  Authentication() {
    init();
  }

  Future<void> init() async {
    setAuthState(AuthState.loading);

    preferences = await SharedPreferences.getInstance();
    int uid = preferences.getInt('userId') ?? -1;
    bool complete = preferences.getBool('completed') ?? false;

    print(uid);

    if (uid == -1) {
      print('USER LOGGED OUT');
      setAuthState(AuthState.loggedOut);
      notifyListeners();
    } else {
      print('ACCOUNT IS');
      print(uid);
      loggedUser = await CommonApi.getUser(uid);
      print('USER LOGGED IN');
      setAuthState(AuthState.loggedIn);
      notifyListeners();
    }
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      loggedUser = await CommonApi.login(email, password);
      await preferences.setInt('userId', loggedUser!.uid);

      loggedUser = await returnUser(loggedUser!.uid);
      print(loggedUser!.completedProfile);
      setAuthState(AuthState.loggedIn);

      if (loggedUser!.completedProfile == true) {
        setAuthState(AuthState.loggedIn);
      } else {
        setAuthState(AuthState.incomplete);
      }
      return loggedUser;
    } catch (e) {
      print(e);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<dynamic> register(
    String email,
    String username,
    String password,
  ) async {
    try {
      UserModel _user = UserModel();
      var userid = await CommonApi.signUp(username, email, password);
      await preferences.setInt('userId', int.parse(userid));

      await preferences.setBool('completed', false);
      setAuthState(AuthState.incomplete);
      notifyListeners();
      return _user;
    } catch (e) {
      return e;
    }
  }

  Future<String> completeProfile(UserModel user) async {
    String retValue = 'error';
    try {
      await CommonApi.completeProfile(user);
      loggedUser = await CommonApi.getUser(user.uid);
      preferences.setBool('completed', true);
      setAuthState(AuthState.loggedIn);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    return Future.value(retValue);
  }

  Future<UserModel?> returnUser(int id) async {
    UserModel? user = UserModel();

    try {
      user = (await CommonApi.getUser(id));
      if (user == null) {
        return null;
      } else {
        print('USER RETURNED');
      }

      return user;
    } catch (e) {
      print('There was an error');
      return null;
    }
  }

  void logout() async {
    try {
      await preferences.clear();
      setAuthState(AuthState.loggedOut);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
