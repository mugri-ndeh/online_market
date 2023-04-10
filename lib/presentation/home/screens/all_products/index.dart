import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/main.dart';
import 'package:online_market/model/category.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

import '../../../../model/shop.dart';
import '../../../../services/errors/global_error_handling/custom_consumer.dart';
import '../../../favorites/favorites_provider.dart';
import 'cubit/all_products_cubit.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllProductsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          title: Text(
            'All Products',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: CustomBlocConsumer<AllProductsCubit, AllProductsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is AllProductsLoading) {
              return const LoadingScreen();
            }
            if (state is AllProductsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (c, i) =>
                              _topTab(c, i, state.categories[i])),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: state.products.length,
                        itemBuilder: (c, i) {
                          return ProductCardExtended(
                            product: state.products[i],
                            shop: context
                                .read<AllProductsCubit>()
                                .getShop(state.products[i]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center();
          },
        ),
      ),
    );
  }

  GestureDetector _topTab(BuildContext context, int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          context.read<AllProductsCubit>().filterCategory(
              context.read<AllProductsCubit>().categories[_selectedIndex]);
        });
      },
      child: Container(
        decoration: _selectedIndex == index
            ? BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.black
                    : AppColors.scaffoldBg,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: const Color.fromARGB(255, 228, 222, 222)
                        .withOpacity(0.2),
                  ),
                ],
              )
            : BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.scaffoldBg
                    : AppColors.black,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: const Color.fromARGB(255, 228, 222, 222)
                        .withOpacity(0.2),
                  ),
                ],
              ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: _selectedIndex == index
                ? TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.white
                        : AppColors.black,
                  )
                : TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.black
                        : AppColors.white,
                  ),
          ),
        ),
      ),
    );
  }
}

class ProductCardExtended extends StatelessWidget {
  const ProductCardExtended(
      {Key? key, required this.product, required this.shop})
      : super(key: key);
  final Product product;
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Consumer<FavouritesHelper>(builder: (_, fav, __) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.white,
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
          child: Row(
            // alignment: Alignment.centerRight,
            children: [
              Container(
                color: AppColors.white,
                height: 150,
                width: 200,
                child: ClipRRect(
                    child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                )),
              ),
              Container(
                width: 1,
                height: 150,
                color: Colors.grey,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      color: Theme.of(context).backgroundColor,
                      height: 100,
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${shop.owner.firstName} ${shop.owner.lastName}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            '${product.price}XAF',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
