import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/api/api.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

import 'favourites_provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
            'Favourites',
            style: TextStyle(color: AppColors.black),
          ),
          elevation: 0,
        ),
        body: SafeArea(child: Consumer<FavouritesHelper>(builder: (_, fav, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListView.builder(
              itemCount: fav.favourites.length,
              itemBuilder: ((context, index) => FavouriteCard(
                  foodItem: Product.fromJson(fav.favourites[index]))),
            ),
            // child: Column(
            //   children: [FavouriteCard(foodItem: Api().fooditems[3])],
            // ),
          );
        })));
  }
}

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({Key? key, this.onTap, required this.foodItem})
      : super(key: key);
  final Function()? onTap;
  final Product foodItem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          height: 270,
          width: size.width,
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: AppColors.white,
                    height: 200,
                    width: size.width,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: CachedNetworkImage(
                            imageUrl: Api.rootFolder + foodItem.image,
                            fit: BoxFit.contain)),
                  ),
                  Positioned(
                    top: 140,
                    left: 10,
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child:
                            Consumer<FavouritesHelper>(builder: (_, fav, __) {
                          return GestureDetector(
                            onTap: () {
                              !fav.isfavourite(foodItem)
                                  ? fav.addFavourites(foodItem)
                                  : fav.remove(foodItem);
                            },
                            child: const CustomContainer(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: size.width,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodItem.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    Text(
                      foodItem.price + 'XAF',
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CustomContainer extends StatefulWidget {
  const CustomContainer(
      {Key? key, this.height, this.width, this.child, this.padding})
      : super(key: key);
  final double? height;
  final Widget? child;
  final double? width;
  final double? padding;

  @override
  State<CustomContainer> createState() => _CustomContainer();
}

class _CustomContainer extends State<CustomContainer> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding == null
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 4),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.grey.shade200,
                blurRadius: 18),
          ],
        ),
        child: widget.child);
  }
}
