import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/customlisttile.dart';

import '../component/bottomsheet.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.s0,
          vertical: Sizes.s10,
        ),

        child: Column(
          children: [
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.addUser,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Add Account",
              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () {
                // Add Account Related code here
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.switchUser,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Switch Account",

              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () {
                // switch Account related code here
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.notification,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Notifications",
              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () {
                Navigator.pushNamed(context, Routes.notificationScreen);
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.condition,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Conditions Of Use",
              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () {
                // condition of use realated code here
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.logout,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Logout",
              titleColor: ConstColors.red,

              onTap: () {
                LogoutBottomSheet.show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
