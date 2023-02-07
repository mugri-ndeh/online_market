import 'package:flutter/material.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:provider/provider.dart';

import '../auth/models/user_model.dart';
import '../auth/providers/auth_provider.dart';

class WishListIndex extends StatefulWidget {
  WishListIndex({Key? key}) : super(key: key);

  @override
  State<WishListIndex> createState() => _WishListIndexState();
}

class _WishListIndexState extends State<WishListIndex> {
  late UserModel user;

  List<Product> wishList = [];

  Future getWish() async {
    wishList = (await UserApi.getWishList(user)) ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = Provider.of<Authentication>(context, listen: false).loggedUser!;
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
