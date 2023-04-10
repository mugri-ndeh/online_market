import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/locator.dart';
import 'package:online_market/util/constants.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model.dart';
import '../app_start/app_start_cubit.dart';
import 'screens/settings/theme_provider.dart';
import 'screens/edit_profile/edit_profile.dart';
import 'screens/orders/orders.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                destination: const SettingsPage()),
            const SizedBox(height: 10),
             _profileCard(
                  title: 'Logout',
                  subtitle: 'Quit the application',
                  color: AppColors.buttonColor,
                  onTap: (){
                    locator<AuthService>().logout();
                    context.read<AppStartCubit>().logout();
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
        const SizedBox(height: 10),
        Text(
          'My profile',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 20),
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
                : const TextStyle(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: color == null ? null : AppColors.black),
          subtitle: Text(
            subtitle,
            style: color == null ? null : const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
