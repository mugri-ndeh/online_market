import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:online_market/shop/details.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

class ShopIndex extends StatefulWidget {
  ShopIndex({Key? key}) : super(key: key);

  @override
  State<ShopIndex> createState() => _ShopIndexState();
}

class _ShopIndexState extends State<ShopIndex> {
  final _controller = TextEditingController();
  late List<Shop> shops = [];
  List<Map<String, dynamic>> prod = [];

  Future<List<Shop>> getShops() async {
    shops = (await UserApi.getStores())!;
    print('OK');
    return shops;
  }

  Future<List<Product>> getShopProducts(int id) async {
    List<Product> products = (await UserApi.getShopProducts(id))!;
    return products;
  }

  // init(){
  //   for
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShops().then((stores) {
      setState(() {});
      for (var store in stores) {
        var list = getShopProducts(store.id);

        prod.add({"id": store.id, "list": list});
      }
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
                    itemBuilder: (c, i) => IntrinsicHeight(
                      child: Column(
                        children: [
                          Constants.formBox(
                              child: ShopCard(
                                shop: shops[i],
                                products: prod[i]['list'],
                                onTap: () {
                                  getShopProducts(shops[i].id);
                                  push(
                                      context,
                                      ShopDetail(
                                          products: prod[i]["products"]));
                                },
                              ),
                              context: context),
                        ],
                      ),
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
    required this.products,
  }) : super(key: key);

  final Shop shop;
  final Function()? onTap;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  imageUrl: '',
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10 Products',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  shop.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  shop.sellerName,
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
