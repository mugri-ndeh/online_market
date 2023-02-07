import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/model/cart.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

import '../../../cart/cart_provider.dart';
import '../../../favourites/favourites.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: size.width,
                child: Stack(
                  children: [
                    CustomContainer(
                      width: size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: CistomCircularButton(
                        icon: Icons.arrow_back,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        outlined: true,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.product.price} XAF',
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CistomCircularButton(
                          icon: Icons.remove,
                          outlined: true,
                          onTap: () {
                            setState(() {
                              if (qty > 1) {
                                qty--;
                              }
                            });
                          },
                        ),
                        Text(
                          '$qty',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        CistomCircularButton(
                          icon: Icons.add,
                          outlined: false,
                          onTap: () {
                            setState(() {
                              if (qty >= widget.product.availableQuantity) {
                                showSnackBar(context,
                                    'You cannot exceed the number of products available');
                              } else {
                                qty++;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              Text('${widget.product.availableQuantity} Available'),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<CartHelper>(builder: (_, cart, __) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    onPressed: () {
                      bool onCart = cart.isCartitem(widget.product);
                      bool notInShop = cart.isNotFromShop(widget.product);

                      if (onCart) {
                        showAlertDialog(
                            context, 'Error', 'Item is already on cart');
                      } else {
                        CartItem item = CartItem(
                          item: widget.product.toMap(),
                          qty: qty,
                          id: (cart.cartItems.length + 1).toString(),
                        );
                        cart.addToCart(item);
                        // showSnackBar(context, 'Item added successfully');
                        showAlertDialog(
                            context, 'Success', 'Item added successfully');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(
                            Icons.shopping_cart,
                            color: AppColors.primaryColor,
                          ),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBg,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text('Add to cart'),
                      ],
                    ),
                  );
                }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class CistomCircularButton extends StatelessWidget {
  const CistomCircularButton({
    Key? key,
    required this.outlined,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final bool outlined;
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 30,
          width: 30,
          decoration: outlined
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.scaffoldBg)
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.primaryColor),
          child: Icon(
            icon,
            color: outlined ? AppColors.primaryColor : Colors.white,
          )),
    );
  }
}
