import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';

import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../home_and_training_screens/component/congrate_container.dart';
import '../../programs_and_workout/component/customlisttile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.white,

        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 120,
                  width: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SharePicture(imagePath: Assets.groupCircle),
                      CircleAvatar(
                        maxRadius: 55,
                        backgroundColor: Colors.grey[400],
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        // left: 0,
                        child: Transform.translate(
                          offset: Offset(-100, -6),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              PoppinsText(
                text: 'Full Name',
                fontSize: Sizes.s24,
                fontWeight: FontWeight.w600,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PoppinsText(
                    text: "User",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeColor: ConstColors.white,
                      activeTrackColor: ConstColors.green4AD,

                      inactiveTrackColor: ConstColors.greyEEE,
                      inactiveThumbColor: ConstColors.white,
                      value: true,
                      onChanged: (vlue) {},
                    ),
                  ),
                ],
              ),
              CustomButton(
                buttonText: 'Become a Creator',
                buttonColor: ConstColors.sky22B,
              ),
              SizedBox(height: 5),

              Row(
                children: [
                  CongrateContainer(
                    iconData: Icons.run_circle_outlined,
                    digit: "15",
                    text: "Finished Workout",
                  ),
                  CongrateContainer(
                    iconData: Icons.alarm,
                    digit: "20",
                    text: "Minutes Spent",
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
              SizedBox(height: 10),
              CustomListTile(
                leading: SharePicture(
                  imagePath: Assets.profileIcon,
                  width: Sizes.s24,
                  height: Sizes.s24,
                ),
                title: "Account Information",
                trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                onTap: () {
                  // Add Account information code here
                  Navigator.pushNamed(context, Routes.accountInfoScreen);
                },
              ),
              CustomListTile(
                leading: SharePicture(
                  imagePath: Assets.calendarIcon,
                  width: Sizes.s24,
                  height: Sizes.s24,
                ),
                title: "My Programs/Workouts",

                trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                onTap: () {
                  Navigator.pushNamed(context, Routes.myProgramWorkout);
                  // program workout code here
                },
              ),
              CustomListTile(
                leading: SharePicture(
                  imagePath: Assets.heartIcon,
                  width: Sizes.s24,
                  height: Sizes.s24,
                ),
                title: "Favorites",

                trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                onTap: () {
                  // faverate code here
                  Navigator.pushNamed(context, Routes.favoriteScreen);
                },
              ),
              CustomListTile(
                leading: SharePicture(
                  imagePath: Assets.documentIcon,
                  width: Sizes.s24,
                  height: Sizes.s24,
                ),
                title: "Motivational Text",
                trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                onTap: () {
                  // motivvational text code here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
