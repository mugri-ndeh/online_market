import 'package:flutter/material.dart';
import 'package:online_market/api/api.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:provider/provider.dart';

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
          ? Text('Nothing to show here')
          : Text(wishList.length.toString()),
    );
  }
}
