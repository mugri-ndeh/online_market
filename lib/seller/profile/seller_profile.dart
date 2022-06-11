import 'package:flutter/material.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/profile/edit_profile.dart';
import 'package:online_market/seller/ratings/seller_ratings.dart';
import 'package:online_market/settings/theme_provider.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

class SellerProfile extends StatefulWidget {
  SellerProfile({Key? key}) : super(key: key);

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  late Authentication auth;
  late UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);
    userModel = auth.loggedUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.bodyHorizontalpadding),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _profileHead(),
            const SizedBox(height: 20),
            _profileCard(
                title: 'Edit profile',
                subtitle: 'Edit user details',
                destination: EditProfile()),
            const SizedBox(height: 10),
            _profileCard(
                title: 'My reviews',
                subtitle: 'See your reviews',
                destination: SellerRating()),
            const SizedBox(height: 10),
            _profileCard(
                title: 'Settings',
                subtitle: 'Change theme',
                destination: SettingsPage()),
            const SizedBox(height: 10),
            _profileCard(
                title: 'Logout',
                subtitle: 'Quit the application',
                color: Palette.buttonColor,
                onTap: () {
                  auth.logout();
                }),
          ],
        )),
      ),
    );
  }

  Widget _profileHead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My profile',
          style: Theme.of(context).textTheme.headline1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 30),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.username,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  userModel.firstName + ' ' + userModel.lastName,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _profileCard(
      {required String title,
      required String subtitle,
      Widget? destination,
      Function()? onTap,
      Color? color}) {
    return GestureDetector(
      onTap: onTap ??
          () {
            push(context, destination!);
          },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 2),
              blurStyle: BlurStyle.outer,
              blurRadius: 3,
              spreadRadius: 1,
              color: const Color.fromARGB(255, 228, 222, 222).withOpacity(0.2),
            ),
          ],
        ),
        child: ListTile(
          selectedTileColor: Colors.white,
          title: Text(
            title,
            style: color == null
                ? Theme.of(context).textTheme.headline6
                : const TextStyle(color: Palette.white, fontSize: 22),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: color == null ? null : Palette.white),
          subtitle: Text(
            subtitle,
            style: color == null ? null : TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
