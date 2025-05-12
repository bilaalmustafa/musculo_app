import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/version_chips_row.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_list.item.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int selectedbtn = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s16),
          child: SingleChildScrollView(
            child: Column(
              spacing: Sizes.s20,
              children: [
                Row(
                  spacing: Sizes.s10,
                  children: [
                    Expanded(
                      child: CustomButton(
                        preSvgPath: Assets.previous,
                        buttonText: "Previous",
                        textColor: ConstColors.black,
                        buttonColor: ConstColors.secondary,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        buttonText: "Skip",
                        textColor: ConstColors.black,
                        buttonColor: ConstColors.secondary,
                        postSvgPath: Assets.next,
                        onTap:
                            () => Navigator.pushNamed(context, Routes.congrate),
                      ),
                    ),
                  ],
                ),
                VersionChipsRow(
                  selectedindex: selectedbtn,
                  onSelected:
                      (index) => setState(() {
                        selectedbtn = index;
                      }),
                ),
                Container(
                  width: double.infinity,
                  height: 350,

                  decoration: BoxDecoration(
                    color: ConstColors.secondary,
                    borderRadius: BorderRadius.circular(Sizes.s10),
                    image: const DecorationImage(
                      image: AssetImage(Assets.workout),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return VideoListItem();
                    },
                    separatorBuilder:
                        (context, index) => SizedBox(width: Sizes.s10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Sizes.s20,
                  children: [
                    SizedBox(
                      width: Sizes.s120,
                      child: CustomButton(
                        buttonText: "PAUSE",
                        textColor: ConstColors.white,
                        buttonColor: ConstColors.black,
                        postIconData: CupertinoIcons.pause_solid,
                      ),
                    ),
                    SizedBox(
                      width: Sizes.s120,
                      child: CustomButton(
                        buttonText: "END",
                        textColor: ConstColors.white,
                        buttonColor: ConstColors.redF52,
                        preIconData: Icons.cancel_rounded,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Sizes.s10,
                  children: [
                    PoppinsText(
                      text: "Curls",
                      fontSize: Sizes.s20,
                      fontWeight: TextWeight.semiBold,
                    ),
                    SharePicture(imagePath: Assets.swap),
                  ],
                ),
                PoppinsText(
                  text: "01:49",
                  fontSize: Sizes.s40,
                  fontWeight: TextWeight.semiBold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
