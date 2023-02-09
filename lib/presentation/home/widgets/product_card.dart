import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

import '../../../model/shop.dart';
import '../../favourites/favourites_provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 282,
      child: Consumer<FavouritesHelper>(builder: (_, fav, __) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 0.8)
              ]),
          child: Stack(
            // alignment: Alignment.centerRight,
            children: [
              Container(
                color: AppColors.white,
                height: 180,
                width: 200,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                top: 180,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  color: Theme.of(context).backgroundColor,
                  height: 100,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.availableQuantity.toString() + 'Left',
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
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: GestureDetector(
                        onTap: () {
                          !fav.isfavourite(product)
                              ? fav.addFavourites(product)
                              : fav.remove(product);
                        },
                        child: Icon(
                          fav.isfavourite(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.primaryColor,
                          size: 28,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      }),
    );
  }
}
