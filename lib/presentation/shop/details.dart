import 'package:flutter/material.dart';
import 'package:online_market/util/helper.dart';

import '../home/screens/product_detail/product_detail.dart';
import '../home/widgets/product_card.dart';

class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key, required this.products}) : super(key: key);
  final List products;

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 12,
                ),
                scrollDirection: Axis.vertical,
                itemCount: widget.products.length,
                itemBuilder: (c, i) => IntrinsicHeight(
                    child: GestureDetector(
                  onTap: () {
                    push(context, ProductDetail(product: widget.products[i]));
                  },
                  child: ProductCard(
                    product: widget.products[i],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
