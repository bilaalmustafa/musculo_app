import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';

import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../home_and_training_screens/component/congrate_container.dart';
import '../../programs_and_workout/component/customlisttile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isCreator = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.white,
        appBar: LogoTitleAppBar(title: 'Profile'),

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
                      Transform.translate(
                        offset: Offset(40, 40),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: 20,
                            height: 20,
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
                    text: isCreator ? "Creator" : "User",
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
                      value: isCreator,
                      onChanged: (value) {
                        setState(() {
                          isCreator = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              CustomButton(
                buttonText:
                    isCreator
                        ? 'Cancel creator subscription'
                        : 'Become a Creator',
                buttonColor:
                    isCreator ? ConstColors.redFF4 : ConstColors.sky22B,
                onTap: () {
                  if (!isCreator) {
                    Navigator.pushNamed(context, Routes.becomeCreatorScreen);
                  } else {
                    // here creator button logic here
                  }
                },
              ),
              SizedBox(height: 5),

              Row(
                children: [
                  CongrateContainer(
                    imagePath:
                        isCreator ? Assets.runnerIcon : Assets.runnerIcon,
                    digit: "15",
                    text: isCreator ? "Programs Sold" : "Finished Workout",
                  ),
                  CongrateContainer(
                    imagePath:
                        isCreator ? Assets.walletIcon : Assets.timeCircle,
                    digit: isCreator ? '250£' : "20",
                    text: isCreator ? "Earnings" : "Minutes Spent",
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
              SizedBox(height: 10),

              if (!isCreator) ...[
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
              ] else ...[
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.editIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Modify creator profile",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // Add modify creator profile  code here
                    Navigator.pushNamed(context, Routes.creatorProfileScreen);
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
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.calendarIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "My Programs/Workouts",

                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.myProgramWorkout);
                    // program workout code here
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.walletIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Earnings",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // motivvational text code here
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
                    // Navigator.pushNamed(context, Routes.favoriteScreen);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
