import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_market/routes/routing.gr.dart';

import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

import '../cart/cart_provider.dart';
import '../cart/cart_screen.dart';
import '../favourites/favourites.dart';
import '../profile/index.dart';
import '../shop/index.dart';
import '../home/home.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final List<Widget> _children = [
    HomePage(),
    ShopPage(),
    FavouritesPage(),
    ProfilePage(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: AutoTabsRouter(
          routes: [
            HomeRoute(),
            ShopRoute(),
            FavouritesRoute(),
            ProfileRoute(),
          ],
          builder: (ctx, child, animation) {
            TabsRouter tabsRouter = AutoTabsRouter.of(ctx);
            return Scaffold(
              floatingActionButton:
                  Consumer<CartHelper>(builder: (_, cart, __) {
                return Stack(
                  children: [
                    FloatingActionButton(
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        push(context, const CartPage());
                      },
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.white,
                      ),
                      tooltip: 'Cart',
                    ),
                    Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          child: Text(
                            '${cart.cartItems.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                );
              }),
              body: child,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.2),
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
                    tabBackgroundColor: AppColors.primaryColor
                        .withOpacity(0.5)
                        .withOpacity(0.1),
                    haptic: false, // haptic feedback
                    tabBorderRadius: 30, // tab button border
                    curve: Curves.bounceIn, // tab animation curves
                    duration: const Duration(
                        milliseconds: 500), // tab animation duration
                    gap: 8, // the tab button gap between icon and text
                    color: Theme.of(context)
                        .iconTheme
                        .color, // unselected icon color
                    activeColor:
                        AppColors.primaryColor, // selected icon and text color
                    iconSize: 24, // tab button icon size

                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5), // navigation bar padding
                    tabs: [
                      GButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            tabsRouter.setActiveIndex(0);
                          });
                        },
                        icon: Icons.home_outlined,
                        text: 'Home',
                      ),
                      GButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            tabsRouter.setActiveIndex(1);
                          });
                        },
                        icon: Icons.shop_outlined,
                        text: 'Products',
                      ),
                      GButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            tabsRouter.setActiveIndex(2);
                          });
                        },
                        icon: FontAwesomeIcons.heart,
                        text: 'Favourites',
                      ),
                      GButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            tabsRouter.setActiveIndex(3);
                          });
                        },
                        icon: Icons.person_outlined,
                        text: 'Profile',
                      )
                    ]),
              ),
            );
          }),
    );
  }
}
