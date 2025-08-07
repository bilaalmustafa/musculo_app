import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/components/shared_appbar.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/customlisttile.dart';

import '../component/notification_switch.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> isNotify = [true, false, true, true, false, false, false, true];
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
          spacing: Sizes.s10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: 'General Notifications',
              fontSize: Sizes.s18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: Sizes.s10),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: 'Phone Notifications',
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[0],
                onChanged: (value) {
                  setState(() {
                    isNotify[0] = value;
                  });
                },
              ),
            ),

            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Email Notifications",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[1],
                onChanged: (value) {
                  setState(() {
                    isNotify[1] = value;
                  });
                },
              ),
            ),
            SizedBox(height: Sizes.s10),
            PoppinsText(
              text: 'User Notifications',
              fontSize: Sizes.s18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: Sizes.s10),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Program or Workout Name Changed",

              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[2],
                onChanged: (value) {
                  setState(() {
                    isNotify[2] = value;
                  });
                },
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Program or Workout Price Updated",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[3],
                onChanged: (value) {
                  setState(() {
                    isNotify[3] = value;
                  });
                },
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Upcoming Training Reminder",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[4],
                onChanged: (value) {
                  setState(() {
                    isNotify[4] = value;
                  });
                },
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Refund Notice Before Cancelling Program or Workout",
              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,

              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[5],
                onChanged: (value) {
                  setState(() {
                    isNotify[5] = value;
                  });
                },
              ),
            ),

            SizedBox(height: Sizes.s10),
            PoppinsText(
              text: 'Creator Notifications',
              fontSize: Sizes.s18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: Sizes.s10),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Receive Feedback via Email",

              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[6],
                onChanged: (value) {
                  setState(() {
                    isNotify[6] = value;
                  });
                },
              ),
            ),
            CustomListTile(
              padding: EdgeInsets.zero,
              title: "Notice Before Cancelling Your Program or Workout",

              titleFontweight: FontWeight.w500,
              titleFont: Sizes.s15,
              trailing: NotificationSwitch(
                useCupertino: true,
                value: isNotify[7],
                onChanged: (value) {
                  setState(() {
                    isNotify[7] = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
