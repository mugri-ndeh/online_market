import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';
import '../locator.dart';

class CustomFirestore {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference get usersRef =>
      _firestore.collection(_USERS_COLLECTION);

  /// Reference to the document of the current user
  static DocumentReference<dynamic> get userRef =>
      usersRef.doc(locator<AuthService>().loggedUser!.uid.toString());

  // static DocumentReference get globalConfigRef => _firestore
  //     .collection(_GLOBAL_CONFIG_COLLECTION)
  //     .doc(CoreConfig.currentConfig.globalConfigCollection);

  static const _USERS_COLLECTION = 'users';
  static const _PRODUCTS = 'products';
  static const _SHOP = 'shops';
  static const _REVIEW = 'review';
  // static const _GLOBAL_CONFIG_COLLECTION = 'globalConfig';

  static const CHAT = 'chat';
  static const GENERAL_COLLECTION = 'general';
  static const MULTI_PREGNANCY_COLLECTION = 'multi_pregnancy';
  static const UNDER_18_COLLETION = 'under_18';
  static const OVER_35_COLLECTION = 'over_35';
  static const PRE_CLAMPSIA_COLLECTION = 'pre_clampsia';
  static const DIABETES_COLLECTION = 'diabetes';
  static const PLACENTA_PRAEVIA_COLLECTION = 'placenta_pravevia';

  static CollectionReference chatForumn(String path) =>
      _firestore.collection(CHAT).doc(path).collection(path);
}
