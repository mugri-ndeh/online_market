import 'package:flutter/material.dart';
import 'package:online_market/model/product.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';

class WishListIndex extends StatefulWidget {
  WishListIndex({Key? key}) : super(key: key);

  @override
  State<WishListIndex> createState() => _WishListIndexState();
}

class _WishListIndexState extends State<WishListIndex> {
  late UserModel user;

  List<Product> wishList = [];

  Future getWish() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getWish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wishList.isEmpty
          ? Center(child: Text('Nothing to show here'))
          : Center(child: Text(wishList.length.toString())),
    );
  }
}
