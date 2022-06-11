import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/seller/shop/products/addProducts.dart';
import 'package:online_market/seller/widgets/seller_product_card.dart';
import 'package:online_market/services/seller/seller_api.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key, required this.shop}) : super(key: key);
  final Shop shop;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List products = [];
  Future getShopProducts() async {
    products = (await SellApi.getShopProducts(widget.shop.id)) ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShopProducts().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: Text(
          'My Products',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.buttonColor,
        onPressed: () {
          push(context, AddProductsPage(shop: widget.shop));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
      body: products.isEmpty
          ? Center(
              child: Text('No products yet'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (c, i) => IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () {},
                    child: SellerProductCard(product: products[i]),
                  ),
                ),
              ),
            ),
    );
  }
}
