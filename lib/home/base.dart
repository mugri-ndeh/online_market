import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_market/favourites/index.dart';
import 'package:online_market/home/home.dart';
import 'package:online_market/home/widgets/sidebar.dart';
import 'package:online_market/profile/index.dart';
import 'package:online_market/shop/index.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/wish_list/index.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> _children = [
    Home(),
    ShopIndex(),
    WishListIndex(),
    FavouritesIndex(),
    Profile(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: const SideBar(),
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           showCustomSearch(context, size, false);
        //           // showSearch(context, size, pickup)
        //         },
        //         icon: Icon(
        //           Icons.search,
        //           color: Theme.of(context).iconTheme.color,
        //         )),
        //     const SizedBox(width: 16),
        //     Icon(
        //       Icons.camera_alt_outlined,
        //       color: Theme.of(context).iconTheme.color,
        //     ),
        //     const SizedBox(width: 16),
        //   ],
        //   elevation: 0,
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   leading: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
        //   title: Text(
        //     'AJUOZA',
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: Theme.of(context).iconTheme.color),
        //   ),
        // ),
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
                  text: 'Wish List',
                ),
                GButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  icon: FontAwesomeIcons.heart,
                  text: 'Favourites',
                ),
                GButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 4;
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
