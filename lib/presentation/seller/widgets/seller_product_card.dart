import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/palette.dart';

class SellerProductCard extends StatelessWidget {
  const SellerProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 282,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2.0,
                  spreadRadius: 0.8)
            ]),
        child: Stack(
          // alignment: Alignment.centerRight,
          children: [
            Container(
              color: AppColors.white,
              height: 130,
              width: 200,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                    fit: BoxFit.contain,
                  )),
            ),
            Positioned(
              top: 130,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: Theme.of(context).backgroundColor,
                height: 100,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shop owner',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      product.price + 'XAF',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 130,
              top: 160,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 1.0,
                          spreadRadius: 1)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
