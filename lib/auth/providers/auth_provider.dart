import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_market/auth/models/user_model.dart';

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

    var firebaseuser = FirebaseAuth.instance.currentUser;
    // print(firebaseuser!.uid);

    if (firebaseuser != null) {
      loggedUser = await returnUser(auth.currentUser!.uid);
      print('USER LOGGED IN');
      if (!loggedUser!.completedProfile) {
        setAuthState(AuthState.incomplete);
        notifyListeners();
      } else {
        setAuthState(AuthState.loggedIn);
        notifyListeners();
      }
    } else {
      print('USER LOGGED OUT');
      setAuthState(AuthState.loggedOut);
      notifyListeners();
    }
  }

  Future<UserModel?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Success ${userCredential.user!.displayName}');
      loggedUser = await returnUser(userCredential.user!.uid);
      print(loggedUser!.completedProfile);
      if (!loggedUser!.completedProfile) {
        setAuthState(AuthState.incomplete);
        print(_loginState);
        notifyListeners();
      } else {
        setAuthState(AuthState.loggedIn);
        print(_loginState);

        notifyListeners();
      }
      return loggedUser;
    } on FirebaseAuthException catch (e) {
      print(e.message);

      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  UserModel? getUser(User? user) {
    return user == null ? null : UserModel(uid: user.uid);
  }

  Stream<UserModel?> onAuthStateChanged() {
    var auth = FirebaseAuth.instance;
    return auth.authStateChanges().map(getUser);
  }

  Future<dynamic> register(
    String email,
    String username,
    String password,
  ) async {
    try {
      UserModel _user = UserModel();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = userCredential.user!.uid;
      _user.email = userCredential.user!.email!;
      _user.username = username;
      // _loginState = AuthState.loggedIn;
      loggedUser = _user;
      createUser(_user);
      print('Success ${userCredential.user!.displayName}');
      setAuthState(AuthState.incomplete);
      notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> createUser(UserModel user) async {
    String retValue = 'error';
    try {
      await _firestore.collection("users").doc(user.uid).set(user.toJson());
      await _auth.currentUser!.updateDisplayName(user.username);

      retValue = 'success';
    } on FirebaseException catch (e) {
      print(e.message);
    }

    return Future.value(retValue);
  }

  Future<String> completeProfile(UserModel user) async {
    String retValue = 'error';
    try {
      await _firestore.collection("users").doc(user.uid).update(user.toJson());
      retValue = 'success';
      setAuthState(AuthState.loggedIn);
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e.message);
    }

    return Future.value(retValue);
  }

  Future<UserModel?> returnUser(String id) async {
    var user = UserModel();

    try {
      var userDoc = await _firestore.collection("users").doc(id).get();
      print(userDoc.data()!);
      user = UserModel.fromJson(userDoc.data()!);
      print(user.uid);
      print('USER RETURNED');
      return user;
    } catch (e) {
      print('There was an error');
      return null;
    }
  }

  void logout() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      setAuthState(AuthState.loggedOut);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
