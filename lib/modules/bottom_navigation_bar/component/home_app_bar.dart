import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.isSwitch,
    required this.valueChange,
  });
  final bool isSwitch;

  final ValueChanged valueChange;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      elevation: 0,
      bottomOpacity: 0,
      shadowColor: Colors.black,

      backgroundColor: !isSwitch ? ConstColors.white : ConstColors.black,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PoppinsText(
            text: "Welcome Back  👋",
            fontSize: Sizes.s14,
            color: ConstColors.greyB1B1,
            fontWeight: TextWeight.semiBold,
          ),
          PoppinsText(
            text: "Full user name",
            fontSize: Sizes.s20,
            color: isSwitch ? ConstColors.white : ConstColors.black,
            fontWeight: TextWeight.semiBold,
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              activeColor: ConstColors.green10,
              value: true,
              onChanged: (vlue) {},
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingScreen);
            },
            icon: SharePicture(imagePath: Assets.settingIcon),
          ),
        ],
      ),

      actions: [
        PoppinsText(
          text: !isSwitch ? "user" : "Creator",
          fontSize: Sizes.s11,
          color: isSwitch ? ConstColors.white : ConstColors.black,
          fontWeight: TextWeight.medium,
        ),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            activeColor: ConstColors.green10,
            value: isSwitch,
            onChanged: (value) => valueChange(value),
          ),
        ),
        if (isSwitch)
          PopupMenuButton<String>(
            color: ConstColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            icon: Icon(
              Icons.add_box_rounded,

              color: isSwitch ? ConstColors.white : ConstColors.black,
            ),
            onSelected: (value) {
              if (value == "workout") {
                Navigator.pushNamed(context, Routes.addworkoutpageview);
              } else {
                Navigator.pushNamed(context, Routes.addprogrampageview);
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: 'workout',
                    child: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.run_circle, color: ConstColors.black),
                        PoppinsText(
                          text: "Add Workouts",
                          fontSize: Sizes.s12,
                          fontWeight: TextWeight.medium,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'program',
                    child: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_month, color: ConstColors.black),
                        PoppinsText(
                          text: "Add Program",
                          fontSize: Sizes.s12,
                          fontWeight: TextWeight.medium,
                        ),
                      ],
                    ),
                  ),
                ],
          ),

        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.settingScreen);
          },
          icon: Icon(
            Icons.settings,
            color: isSwitch ? ConstColors.white : ConstColors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s100);
}
