import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/config/routes.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/notification_switch.dart';

import '../../../core/constants/assets.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.isSwitch,
    required this.valueChange,
  });
  final bool isSwitch;

  final ValueChanged valueChange;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s100);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final AuthService _authservces = instance<AuthService>();

  Future<UserModel?>? _future;
  @override
  void initState() {
    _future = context.read<UserViewModel>().getUserById(
      _authservces.currentUser!.uid,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      elevation: 0,
      bottomOpacity: 0,
      shadowColor: Colors.black,

      backgroundColor: !widget.isSwitch ? ConstColors.white : ConstColors.black,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PoppinsText(
            text: "Welcome Back  👋",
            fontSize: Sizes.s14,
            color: ConstColors.greyB1B1,
            fontWeight: TextWeight.semiBold,
          ),
          FutureBuilder<UserModel?>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomShimmer(
                  height: 30,
                  width: context.screenwidth * 0.3,
                );
              } else if (snapshot.data == null) {
                return PoppinsText(
                  text: "User name",
                  fontSize: Sizes.s20,
                  color:
                      widget.isSwitch ? ConstColors.white : ConstColors.black,
                  fontWeight: TextWeight.semiBold,
                );
              } else {
                return PoppinsText(
                  text: snapshot.data?.name ?? " User name",
                  fontSize: Sizes.s20,
                  color:
                      widget.isSwitch ? ConstColors.white : ConstColors.black,
                  fontWeight: TextWeight.semiBold,
                );
              }
            },
          ),
        ],
      ),

      actions: [
        PoppinsText(
          text: !widget.isSwitch ? "User" : "Creator",
          fontSize: Sizes.s11,
          color: widget.isSwitch ? ConstColors.white : ConstColors.black,
          fontWeight: TextWeight.medium,
        ),
        NotificationSwitch(
          useCupertino: true,
          value: widget.isSwitch,
          onChanged: (value) => widget.valueChange(value),
        ),
        // Transform.scale(
        //   scale: 0.7,
        //   child: Switch(
        //     activeColor: ConstColors.green10,
        //     value: isSwitch,
        //     onChanged: (value) => valueChange(value),
        //   ),
        // ),
        if (widget.isSwitch)
          PopupMenuButton<String>(
            color: ConstColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            icon: SharePicture(
              imagePath: Assets.plusIcon,
              width: Sizes.s24,
              height: Sizes.s24,
              colorFilter: ColorFilter.mode(
                widget.isSwitch ? ConstColors.white : ConstColors.black,
                BlendMode.srcIn,
              ),
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
                        SharePicture(imagePath: Assets.runnerIcon),
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
                        SharePicture(imagePath: Assets.calendarIcon),
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
          icon: SharePicture(
            imagePath: Assets.settingIcon,
            width: Sizes.s24,
            height: Sizes.s24,
            colorFilter: ColorFilter.mode(
              widget.isSwitch ? ConstColors.white : ConstColors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s100);
}
