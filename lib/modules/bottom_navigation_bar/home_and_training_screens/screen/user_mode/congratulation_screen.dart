import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/congrate_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/share_to_social.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/show_rating_bottom_sheet.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/show_share_bottom_sheet.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              spacing: Sizes.s14,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SharePicture(imagePath: Assets.congrate),
                PoppinsText(
                  text: "Congratulation!",
                  fontSize: Sizes.s26,
                  fontWeight: TextWeight.semiBold,
                ),
                PoppinsText(
                  text: "You have completed your workout!",
                  fontSize: Sizes.s13,
                  fontWeight: TextWeight.regular,
                  color: ConstColors.greyA1A1,
                ),

                Row(
                  children: [
                    CongrateContainer(
                      iconData: Icons.run_circle_outlined,
                      digit: "15",
                      text: "Finished Workout",
                    ),
                    CongrateContainer(
                      iconData: Icons.timelapse,
                      digit: "20",
                      text: "Minutes Spent",
                    ),
                  ],
                ),
                CustomButton(
                  preIconData: Icons.camera_enhance,
                  buttonText: "Share Training",
                  buttonColor: ConstColors.secondary,
                  textColor: ConstColors.black,
                  onTap: () {
                    showModalBottomSheet(
                      barrierColor: ConstColors.black.withValues(alpha: 0.8),
                      constraints: BoxConstraints(maxHeight: 300),
                      backgroundColor: ConstColors.white,
                      context: context,
                      builder: (context) {
                        return ShowShareBottomSheet();
                      },
                    );
                  },
                ),
                SizedBox(height: Sizes.s54),
                Row(
                  spacing: Sizes.s12,
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: "Rate creator",
                        buttonColor: ConstColors.secondary,
                        textColor: ConstColors.black,
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            barrierColor: ConstColors.black.withValues(
                              alpha: 0.8,
                            ),
                            constraints: BoxConstraints(maxHeight: 500),
                            backgroundColor: ConstColors.white,
                            context: context,
                            builder: (context) {
                              return ShowRatingBottomSheet();
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(child: CustomButton(buttonText: "Back home")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
