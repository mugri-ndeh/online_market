import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:online_market/model/cart.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import 'cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartHelper cart;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    cart = Provider.of<CartHelper>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<CartHelper>(builder: (_, cart, __) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      CartItem item = CartItem.fromJson(cart.cartItems[index]);
                      Product foodItem = Product.fromMap(item.item!);
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(24)),
                        height: 100,
                        width: size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: CachedNetworkImage(
                                    imageUrl: foodItem.image,
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      foodItem.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      foodItem.category,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${int.parse(foodItem.price) * item.qty}XAF',
                                      style: TextStyle(
                                          color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SizedBox(
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cart.remove(index);
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AppColors.primaryColor,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Quantity: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            item.qty.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Text('${'Total = ${cart.total}'}XAF'),
              const SizedBox(height: 10),
              CustomButton(
                  child: const Text('Checkout'),
                  onTap: () async {
                    List<CartItem> cartItems = cart.cartItems
                        .map((e) => CartItem.fromJson(e))
                        .toList();

                    List<Product> productss = cartItems
                        .map(
                          (e) => Product.fromMap(e.item!),
                        )
                        .toList();
                    // print(productss[0].id);
                    // UserApi.createOrder(
                    //         productss, user, total, cart.cartItems.length)
                    //     .then((value) {
                    //   cart.clearItems();
                    //   showAlertDialog(context, 'Success',
                    //       'Your Order has been placed successfully');
                    // });
                  }),
              const SizedBox(height: 10),
            ],
          );
        }),
      )),
    );
  }
}
