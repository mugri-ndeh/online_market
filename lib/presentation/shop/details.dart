import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_market/presentation/home/screens/product_detail/product_detail.dart';
import 'package:online_market/util/helper.dart';

import '../../model/product.dart';
import '../../model/shop.dart';
import '../../services/repository/seller_repository.dart';
import '../seller/widgets/seller_product_card.dart';

class ShopDetail extends StatelessWidget {
  const ShopDetail({Key? key, required this.shop}) : super(key: key);
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        elevation: 0,
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
                  const SizedBox(height: 20),
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
                          onTap: () {
                            push(context,
                                ProductDetailPage(product: products[i]));
                          },
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
    );
  }
}
