import 'package:flutter/material.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/locator.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import 'screens/settings/theme_provider.dart';
import 'screens/edit_profile/edit_profile.dart';
import 'screens/orders/orders.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                title: 'My orders',
                subtitle: 'See all orders',
                destination: Orders()),
            const SizedBox(height: 10),
            _profileCard(
                title: 'Edit profile',
                subtitle: 'Edit user details',
                destination: const EditProfile()),
            const SizedBox(height: 10),
            _profileCard(
                title: 'Settings',
                subtitle: 'Change theme',
                destination: SettingsPage()),
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
                  locator<AuthService>().loggedUser!.username,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '${locator<AuthService>().loggedUser!.firstName} ${locator<AuthService>().loggedUser!.lastName}',
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
      {required String title, required String subtitle, Widget? destination}) {
    return GestureDetector(
      onTap: () {
        push(context, destination!);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
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
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
