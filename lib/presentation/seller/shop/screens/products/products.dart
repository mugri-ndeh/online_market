import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/util/palette.dart';

import '../../../../../routes/routing.gr.dart';
import '../../../../../services/repository/seller_repository.dart';
import '../../../widgets/seller_product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key, required this.shop}) : super(key: key);
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: const Text('My Products'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          context.router.push(AddProductsRoute(shop: shop));
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: SellerRepository.getShopProducts(shop.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Product> products = snapshot.data!.docs
                .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
                .toList();
            if (products.isEmpty) {
              return const Center(
                  child: Text('You have no products in this shop'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      itemBuilder: (c, i) => IntrinsicHeight(
                        child: GestureDetector(
                          onTap: () {},
                          child: SellerProductCard(
                              product: products[i], shop: shop),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      // : Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: GridView.builder(
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         childAspectRatio: 1,
      //         crossAxisCount: 2,
      //         crossAxisSpacing: 12,
      //         mainAxisSpacing: 12,
      //       ),
      //       scrollDirection: Axis.vertical,
      //       itemCount: products.length,
      //       itemBuilder: (c, i) => IntrinsicHeight(
      //         child: GestureDetector(
      //           onTap: () {},
      //           child: SellerProductCard(product: products[i]),
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
