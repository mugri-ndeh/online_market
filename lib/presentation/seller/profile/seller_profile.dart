// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/presentation/app_start/app_start_cubit.dart';
import 'package:online_market/services/auth/auth_service.dart';
import 'package:online_market/services/locator.dart';
import 'package:online_market/util/constants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

import '../../profile/screens/edit_profile/edit_profile.dart';
import '../../profile/screens/settings/theme_provider.dart';
import '../ratings/seller_ratings.dart';

class SellerProfilePage extends StatefulWidget {
  SellerProfilePage({Key? key}) : super(key: key);

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  @override
  void initState() {
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
                title: 'Edit profile',
                subtitle: 'Edit user details',
                destination: const EditProfile()),
            const SizedBox(height: 10),
            _profileCard(
                title: 'My reviews',
                subtitle: 'See your reviews',
                destination: SellerRating()),
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
                onTap: () async {
                  await locator<AuthService>().logout();
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
        const SizedBox(height: 15),
        Text(
          'My profile',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 15),
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
                : const TextStyle(color: AppColors.white, fontSize: 22),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: color == null ? null : AppColors.white),
          subtitle: Text(
            subtitle,
            style: color == null ? null : const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
