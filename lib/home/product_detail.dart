import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/api/api.dart';
import 'package:online_market/cart/cart_provider.dart';
import 'package:online_market/favourites/favourites.dart';
import 'package:online_market/model/cart.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

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
                          imageUrl: Api.rootFolder + widget.product.image,
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
                    '${widget.product.price}',
                    style: TextStyle(
                        color: Palette.primaryColor,
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
                              if (qty >= widget.product.qty) {
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
              Text(widget.product.category),
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
                          item: widget.product.toJson(),
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
                            color: Palette.primaryColor,
                          ),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Palette.scaffoldBg,
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
                  border: Border.all(color: Palette.primaryColor),
                  color: Palette.scaffoldBg)
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Palette.primaryColor),
          child: Icon(
            icon,
            color: outlined ? Palette.primaryColor : Colors.white,
          )),
    );
  }
}
