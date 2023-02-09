// ignore_for_file: unnecessary_const

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:online_market/presentation/app_start/app_start_cubit.dart';
import 'package:online_market/util/contstants.dart';

import 'package:online_market/util/palette.dart';

import 'package:provider/provider.dart';

import '../../../services/auth/auth_service.dart';
import '../../../services/locator.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SafeArea(
          child: Stack(
        children: [
          ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              decoration:
                  BoxDecoration(color: AppColors.white.withOpacity(0.4)),
            ),
          )),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryColor
                          .withOpacity(0.4)
                          .withOpacity(0.1),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good day',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '@${locator<AuthService>().loggedUser!.username}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // const CustomHorizontalDivider(padding: 8),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('User setting')),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  color: AppColors.white.withOpacity(0.3),
                  elevation: 0,
                  child: Column(
                    children: const [
                      const ListTile(
                        leading: Icon(
                          Icons.person_outlined,
                          color: AppColors.black,
                        ),
                        title: const Text(
                          'Profile',
                        ),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.card_membership_outlined,
                          color: AppColors.black,
                        ),
                        title: Text(
                          'Membership',
                        ),
                      ),
                      const ListTile(
                        leading: const Icon(
                          Icons.abc_outlined,
                          color: AppColors.black,
                        ),
                        title: Text(
                          'About',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  color: AppColors.white.withOpacity(0.3),
                  elevation: 0,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const ListTile(
                        leading: const Icon(
                          Icons.help_outline,
                          color: AppColors.black,
                        ),
                        title: const Text(
                          'Help',
                        ),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          color: AppColors.black,
                        ),
                        title: Text(
                          'Terms of use',
                        ),
                      ),
                      const ListTile(
                        leading: const Icon(
                          Icons.document_scanner_outlined,
                          color: AppColors.black,
                        ),
                        title: const Text(
                          'Privacy policy',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: size.width,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      await locator<AuthService>().logout();
                      // ignore: use_build_context_synchronously
                      context.read<AppStartCubit>().logout();
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: AppColors.white,
                    ),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
            ],
          )
        ],
      )),
    );
  }
}
