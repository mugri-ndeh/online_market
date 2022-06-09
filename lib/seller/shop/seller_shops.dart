import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/shop/index.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';

class SellerShop extends StatefulWidget {
  SellerShop({Key? key}) : super(key: key);

  @override
  State<SellerShop> createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerShop> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            HeaderWidget(size: size),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (c, i) => IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Constants.formBox(
                            child: SellerShopCard(), context: context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
              ? Palette.black
              : Palette.white,
        ),
        height: 100,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My shops',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'You have 10 shops',
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
    // required this.shop,
    // this.onTap,
    // required this.products,
  }) : super(key: key);

  // final Shop shop;
  // final Function()? onTap;
  // final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 250,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                  fit: BoxFit.cover,
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
                  "Shop name",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "Maestro",
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
