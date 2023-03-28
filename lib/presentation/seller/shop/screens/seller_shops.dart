import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/repository/seller_repository.dart';

import 'package:online_market/util/constants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

import '../../../../routes/routing.gr.dart';
import 'products/products.dart';

class SellerShopPage extends StatelessWidget {
  const SellerShopPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          context.router.push(const AddShopRoute());
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.black
              : AppColors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              HeaderWidget(size: size, noShop: 2),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot<Object?>>(
                  stream: SellerRepository.getUserShops(),
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
                      return const Center(child: Text('You have no shops yet'));
                    }
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.1,
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: shops.length,
                        itemBuilder: (c, i) => IntrinsicHeight(
                          child: GestureDetector(
                            onTap: () {
                              push(
                                  context,
                                  ProductsPage(
                                    shop: shops[i],
                                  ));
                            },
                            child: SellerShopCard(
                              shop: shops[i],
                            ),
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

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.size,
    required this.noShop,
  }) : super(key: key);

  final Size size;
  final int noShop;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ],
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.black
              : AppColors.white,
        ),
        height: 100,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Text(
              'My shops',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'You have $noShop shops',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 10),
            Text(
              'Overview of shops',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ));
  }
}

class SellerShopCard extends StatelessWidget {
  const SellerShopCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Constants.formBox(
      context: context,
      padding: 0,
      borderRadius: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: shop.shopImg!,
                        // imageUrl:
                        // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  shop.shopName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
