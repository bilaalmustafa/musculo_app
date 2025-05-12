import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/components/shared_appbar.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/customlisttile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.s16,
          vertical: Sizes.s20,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: 'User Notifications',
              fontSize: Sizes.s18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: Sizes.s20),
            CustomListTile(
              padding: EdgeInsets.zero,
              title:
                  'When changing the name of the program/workout ( for user )',
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.white,
                  activeTrackColor: ConstColors.green4AD,

                  inactiveTrackColor: ConstColors.greyEEE,
                  inactiveThumbColor: ConstColors.white,
                  value: true,

                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: Sizes.s10),
            CustomListTile(
              padding: EdgeInsets.zero,
              title:
                  "When the price of the program/workout ( for user ) changes",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.white,
                  activeTrackColor: ConstColors.green4AD,

                  inactiveTrackColor: ConstColors.greyEEE,
                  inactiveThumbColor: ConstColors.white,

                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Upcoming training ( For user )",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.green10,
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: Sizes.s20),
            PoppinsText(
              text: 'General Notifications',
              fontSize: Sizes.s18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: Sizes.s10),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Warning before cancelation",

              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.green10,
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Refund warning",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.green10,
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Receive feedback to Email",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.green10,
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Phone notifications",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.green10,
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Email notifications",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: ConstColors.green10,
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
