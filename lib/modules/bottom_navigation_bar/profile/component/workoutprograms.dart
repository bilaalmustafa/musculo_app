import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class WorkoutPrograms extends StatelessWidget {
  const WorkoutPrograms({super.key, this.tabselect});
  final int? tabselect;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.s20, vertical: Sizes.s10),

      height: Sizes.s160,
      padding: EdgeInsets.all(Sizes.s20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.s8),
        color: ConstColors.white,
      ),
      child: Row(
        spacing: Sizes.s10,
        children: [
          Container(
            width: Sizes.s100,
            height: Sizes.s100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s8),
              color: ConstColors.amber,
              image: DecorationImage(
                image: AssetImage(Assets.workout),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              PoppinsText(
                text: "Power Lift",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.semiBold,
              ),

              Row(
                spacing: Sizes.s5,
                children: [
                  CustomChip(text: "8 weeks", color: ConstColors.secondary),
                  CustomChip(text: "Beginner", color: ConstColors.secondary),
                  if (tabselect == 1)
                    CustomChip(text: "3x week", color: ConstColors.secondary),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PoppinsText(
                    text: "60.00€",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),
                  SizedBox(width: 5),
                  CustomButton(
                    buttonText: "See details",
                    buttonHeight: Sizes.s30,
                    buttonWidth: Sizes.s110,
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          Routes.traningpreviewscreen,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
