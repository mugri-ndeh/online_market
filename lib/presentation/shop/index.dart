import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/repository/user_repository.dart';
import 'package:online_market/util/constants.dart';
import 'package:online_market/util/helper.dart';

import '../../services/repository/seller_repository.dart';
import '../seller/shop/screens/seller_shops.dart';
import 'details.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final _controller = TextEditingController();
  late List<Shop> shops = [];
  List<Map<String, dynamic>> prod = [];

  Future<List<Shop>> getShops() async {
    // shops = (await UserApi.getStores())!;
    print('OK');
    return shops;
  }

  Future<List<Product>> getShopProducts(int id) async {
    // List<Product> products = (await UserApi.getShopProducts(id))!;
    return [];
  }

  // init(){
  //   for
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShops().then((stores) async {
      setState(() {});
      // for (var store in stores) {
      //   var list = await getShopProducts(store.id);

      //   prod.add({"id": store.id, "list": list});

      //   print(prod);
      // }
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20, horizontal: Constants.bodyHorizontalpadding / 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore all Products',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 10),
              Text(
                'Find the items you have been looking for',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot<Object?>>(
                  stream: UserRepository.getAllShopsUser(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<Shop> shops = snapshot.data!.docs
                        .map((e) =>
                            Shop.fromMap(e.data() as Map<String, dynamic>))
                        .toList();
                    if (shops.isEmpty) {
                      return const Center(child: Text('No shops yet'));
                    }

                    return Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 12,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: shops.length,
                          itemBuilder: (c, i) => Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  push(
                                      context,
                                      ShopDetail(
                                        shop: shops[i],
                                      ));
                                },
                                child: SellerShopCard(
                                  shop: shops[i],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  const ShopCard({
    Key? key,
    required this.shop,
    this.onTap,
  }) : super(key: key);

  final Shop shop;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: shop.shopImg!,
                  fit: BoxFit.contain,
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.shopName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  shop.owner.username,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class SilverGridDelegateWithFixedCrossAxisCount {
//   CrossAxisAlignment;
// }
