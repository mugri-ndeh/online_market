import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/seller/home/provider/homeProvider.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

class SellerHome extends StatefulWidget {
  SellerHome({Key? key}) : super(key: key);

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  late UserModel user;
  late SellerHomeProvider sellerProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sellerProvider = Provider.of<SellerHomeProvider>(context, listen: false);
    sellerProvider.init().then((value) {});
    user = sellerProvider.auth!.loggedUser!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Consumer<SellerHomeProvider>(builder: (_, seller, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                HeaderWidget(
                  size: size,
                  user: user,
                ),
                const SizedBox(height: 10),
                Text(
                  "Analytics",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AnalyticsCard(
                        color: Colors.redAccent.shade400,
                        title: 'No Shops',
                        icon: Icons.shopify,
                        iconColor: Palette.white,
                        value: sellerProvider.shops.length.toString(),
                      ),
                      AnalyticsCard(
                        color: Colors.orangeAccent.shade400,
                        title: 'Total Products',
                        icon: Icons.shopping_cart,
                        iconColor: Palette.success,
                        value: sellerProvider.products.length.toString(),
                      ),
                      AnalyticsCard(
                        color: Colors.blueAccent.shade400,
                        title: 'Rating',
                        icon: Icons.star,
                        iconColor: Colors.yellow,
                        value: "4.0",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Earnings",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                EarningCard(),
                const SizedBox(height: 10),
                Text(
                  "Invoice",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
        ),
      )),
    );
  }
}

class EarningCard extends StatelessWidget {
  const EarningCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
          )
        ],
        color: Theme.of(context).brightness == Brightness.dark
            ? Palette.black
            : Palette.white,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total earnings"),
            Text("1000XAF"),
          ],
        )
      ]),
    );
  }
}

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({
    Key? key,
    required this.color,
    required this.title,
    required this.icon,
    required this.value,
    required this.iconColor,
  }) : super(key: key);

  final Color color;
  final String title;
  final IconData icon;
  final String value;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Icon(
                  icon,
                  color: iconColor,
                  size: 50,
                ),
              ],
            )
          ],
        ),
      ),
      height: 130,
      width: 120,
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
          )
        ],
        color: Theme.of(context).brightness == Brightness.dark
            ? Palette.black
            : Palette.white,
      ),
      height: 120,
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sunday, June 12',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hi ${user.firstName} ${user.lastName}',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
              CircleAvatar(radius: 40)
            ],
          )
        ],
      ),
    );
  }
}
