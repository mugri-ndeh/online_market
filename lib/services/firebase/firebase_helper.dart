import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';
import '../locator.dart';

class CustomFirestore {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference get usersRef =>
      _firestore.collection(USERS_COLLECTION);

  static CollectionReference get productsRef => _firestore.collection(PRODUCTS);

  static CollectionReference get shopsRef => _firestore.collection(SHOP);

  static CollectionReference get ordersRef => _firestore.collection(ORDER);

  static CollectionReference get categoriesRef =>
      _firestore.collection(CATEGORIES);

  /// Reference to the document of the current user
  static DocumentReference<dynamic> get userRef =>
      usersRef.doc(locator<AuthService>().loggedUser!.uid.toString());

  // static DocumentReference get globalConfigRef => _firestore
  //     .collection(_GLOBAL_CONFIG_COLLECTION)
  //     .doc(CoreConfig.currentConfig.globalConfigCollection);

  static const USERS_COLLECTION = 'users';
  static const PRODUCTS = 'products';
  static const SHOP = 'shops';
  static const ORDER = 'orders';
  static const REVIEW = 'review';
  static const CATEGORIES = 'categories';
}
