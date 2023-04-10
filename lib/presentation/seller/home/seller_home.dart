import 'package:flutter/material.dart';
import 'package:online_market/services/locator.dart';

import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

import '../../../model/user_model.dart';
import '../../../services/auth/auth_service.dart';
import 'provider/homeProvider.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({Key? key}) : super(key: key);

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              HeaderWidget(
                size: size,
                user: locator<AuthService>().loggedUser!,
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
                    const AnalyticsCard(
                      color: Color(0xFF39FF9F),
                      title: 'Shops',
                      icon: Icons.shopify,
                      iconColor: AppColors.black,
                      value: '2',
                    ),
                    AnalyticsCard(
                      color: Colors.orangeAccent.shade400,
                      title: 'Total Products',
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      value: '10',
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
              const EarningCard(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Invoice",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
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
            ? AppColors.black
            : AppColors.white,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
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
      height: 130,
      width: 120,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
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
            ? AppColors.black
            : AppColors.white,
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
              const CircleAvatar(radius: 40)
            ],
          )
        ],
      ),
    );
  }
}
