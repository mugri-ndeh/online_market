import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_market/cart/cart_provider.dart';
import 'package:online_market/cart/cart_screen.dart';
import 'package:online_market/favourites/favourites.dart';
import 'package:online_market/home/home.dart';
import 'package:online_market/home/widgets/sidebar.dart';
import 'package:online_market/profile/index.dart';
import 'package:online_market/seller/home/seller_home.dart';
import 'package:online_market/seller/orders/seller_orders.dart';
import 'package:online_market/seller/profile/seller_profile.dart';
import 'package:online_market/seller/shop/seller_shops.dart';
import 'package:online_market/shop/index.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/wish_list/index.dart';
import 'package:provider/provider.dart';

class SellerBase extends StatefulWidget {
  const SellerBase({Key? key}) : super(key: key);

  @override
  State<SellerBase> createState() => _SellerBase();
}

class _SellerBase extends State<SellerBase> {
  final List<Widget> _children = [
    SellerHome(),
    SellerShop(),
    SellerOrders(),
    SellerProfile(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _children,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Palette.primaryColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 2))
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: GNav(
              tabBackgroundColor:
                  Palette.primaryColor.withOpacity(0.5).withOpacity(0.1),
              haptic: false, // haptic feedback
              tabBorderRadius: 30, // tab button border
              curve: Curves.bounceIn, // tab animation curves
              duration:
                  const Duration(milliseconds: 500), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Theme.of(context).iconTheme.color, // unselected icon color
              activeColor: Palette.primaryColor, // selected icon and text color
              iconSize: 24, // tab button icon size

              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // navigation bar padding
              tabs: [
                GButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  icon: Icons.shop_outlined,
                  text: 'Shop',
                ),
                GButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  icon: FontAwesomeIcons.bagShopping,
                  text: 'Orders',
                ),
                GButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  icon: Icons.person_outlined,
                  text: 'Profile',
                )
              ]),
        ),
      ),
    );
  }
}
