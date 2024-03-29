import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

import '../../model/user_model.dart';
import '../firebase/firebase_helper.dart';
import '../locator.dart';

class AuthService {
  final _firestore = FirebaseFirestore.instance;

  FirebaseAuth get _auth => FirebaseAuth.instance;

  User? currentUser;

  UserModel? loggedUser;

  final _storageInstance = FirebaseStorage.instance;

  String? get uid {
    return currentUser?.uid;
  }

  Future<String> getImageUrlBy({required String path}) async {
    return await _storageInstance.ref(path).getDownloadURL();
  }

  String _getImageExtension(Uint8List byteData) {
    return lookupMimeType('', headerBytes: byteData)!.split('/').last;
  }

  // seturl(UserModel user) async {
  //   String? profilePictureLink;

  //   try {
  //     profilePictureLink = await getImageUrlBy(
  //         path: 'profilePictures/${locator<AuthService>().loggedUser!.uid}');
  //     user.profilePictureLink = profilePictureLink;
  //     await CustomFirestore.userRef.update(user.toJson());
  //   } on FirebaseException catch (e) {
  //     if (e.code != 'object-not-found') rethrow;
  //   }
  // }

  Future<bool> updateProfile({required UserModel user}) async {
    bool result = false;
    bool notFound = false;

    await CustomFirestore.userRef
        .update(user.toMap())
        .whenComplete(() => result = true)
        .onError((FirebaseException e, s) => notFound = e.code == 'not-found');

    if (notFound) {
      await CustomFirestore.userRef
          .set(user.toJson())
          .whenComplete(() => result = true);
    }

    // await seturl(user);

    return result;
  }

  Future<bool> updateProfileImage({required Uint8List profileImage}) async {
    bool result = false;

    final String fileExtension = _getImageExtension(profileImage);
    final metadata = SettableMetadata(contentType: 'image/$fileExtension');

    final UploadTask uploadTask = _storageInstance
        .ref('profilePictures/')
        .child('/${locator<AuthService>().loggedUser!.uid}')
        .putData(profileImage, metadata);

    await uploadTask.whenComplete(() {
      result = true;
    });

    return result;
  }

  Future<String> uploadFile(
      {required Uint8List data, required String path}) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadTask = ref.putData(data);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<bool> isLoggedInAsync() async {
    final user = await _auth.authStateChanges().first;
    currentUser ??= user;
    return user != null;
  }

  bool get isLoggedIn {
    return currentUser != null;
  }

  bool isMe(String userId) => uid == userId;
  // bool isMe(String uid) => true;

  Future<void> signInWithMail(String mail, String pass) async {
    debugPrint("Logging in... @ ${DateTime.now()}");
    await _auth.signInWithEmailAndPassword(email: mail, password: pass);
    debugPrint("Logged in.");
  }

  Future<void> logout() async {
    await _auth.signOut();
    currentUser = null;
    loggedUser = null;
    restartUserServices();
  }

  Future<void> requestPasswordReset(String mail) async {
    await _auth.sendPasswordResetEmail(email: mail);
  }

  signUp(String email, String username, String password) async {
    UserModel user = UserModel();
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // userCredential.user!.updateDisplayName(username);
    user.uid = userCredential.user!.uid;
    user.email = userCredential.user!.email!;
    user.username = username;
    await createUser(user);
    // await login(email, password);
    loggedUser = user;
    debugPrint("Account created");
  }

  Future<dynamic> login(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final UserModel? user = await returnUser(userCredential.user!.uid);
    loggedUser = user;
    return loggedUser;
  }

  createUser(UserModel user) async {
    await _firestore
        .collection("users")
        .doc(user.uid.toString())
        .set(user.toMap());
    await _auth.currentUser!.updateDisplayName(user.username);
  }

  Future<dynamic> completeProfile(UserModel user) async {
    await _firestore
        .collection("users")
        .doc(user.uid.toString())
        .update(user.toMap());
    final UserModel? userModel = await returnUser(user.uid.toString());
    return userModel;
  }

  Future<UserModel?> returnUser(String id) async {
    UserModel? user = UserModel();

    var userDoc = await _firestore.collection("users").doc(id).get();

    if (userDoc.data() != null) {
      user = UserModel.fromMap(userDoc.data()!);
      return user;
    } else {
      return null;
    }
  }

  Future<UserModel?> checkAuth() async {
    if (_auth.currentUser != null) {
      final UserModel? user = await returnUser(_auth.currentUser!.uid);
      loggedUser = user;
      return user;
    } else {
      return null;
    }
  }
}
