import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_market/routes/routing.gr.dart';

import 'package:online_market/util/palette.dart';

class SellerBasePage extends StatefulWidget {
  const SellerBasePage({Key? key}) : super(key: key);

  @override
  State<SellerBasePage> createState() => _SellerBase();
}

class _SellerBase extends State<SellerBasePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: AutoTabsRouter(
          routes: [
            SellerHomeRoute(),
            const SellerShopRoute(),
            SellerOrdersRoute(),
            SellerProfileRoute(),
          ],
          builder: (ctx, child, animation) {
            TabsRouter tabsRouter = AutoTabsRouter.of(ctx);

            return Scaffold(
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
                            // _selectedIndex = 0;
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
                            // _selectedIndex = 1;
                            tabsRouter.setActiveIndex(1);
                          });
                        },
                        icon: Icons.shop_outlined,
                        text: 'Shop',
                      ),
                      GButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            tabsRouter.setActiveIndex(2);
                          });
                        },
                        icon: FontAwesomeIcons.bagShopping,
                        text: 'Orders',
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
