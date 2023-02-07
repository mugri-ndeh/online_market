import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';

import 'details.dart';

class ShopIndex extends StatefulWidget {
  const ShopIndex({Key? key}) : super(key: key);

  @override
  State<ShopIndex> createState() => _ShopIndexState();
}

class _ShopIndexState extends State<ShopIndex> {
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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Shops',
      //     style: Theme.of(context).textTheme.bodyText2,
      //   ),
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.bodyHorizontalpadding / 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomButton(
              //     child: Text('child'),
              //     onTap: () async {
              //       await getShops();
              //     }),
              Text(
                'Explore all Shops',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Find the right products for you',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 10),
              Constants.formBox(
                context: context,
                child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: _controller,
                    obscureText: true,
                    decoration: Constants.inputDecoration('search')),
              ),
              const SizedBox(height: 10),
              Expanded(
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
                            showProgress(context, 'Getting products', true);
                            List<Product> productts = await getShopProducts(0);
                            hideProgress();

                            push(context, ShopDetail(products: productts));
                          },
                          child: Constants.formBox(
                              child: ShopCard(
                                shop: shops[i],
                                // products: prod[i]['list'],
                              ),
                              context: context),
                        ),
                      ],
                    ),
                  ),
                ),
              )
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
    // required this.products,
  }) : super(key: key);

  final Shop shop;
  final Function()? onTap;
  // final List<Product> products;

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
