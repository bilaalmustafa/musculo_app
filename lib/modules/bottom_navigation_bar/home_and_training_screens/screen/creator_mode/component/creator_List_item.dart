import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class CreatorListItems extends StatelessWidget {
  const CreatorListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            height: Sizes.s80,
            width: Sizes.s100,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s10),
              image: DecorationImage(image: AssetImage(Assets.workout)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: "Quick Core Blaster",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
                color: ConstColors.black,
              ),

              Row(
                spacing: 10,
                children: [
                  CustomChip(text: "14 Mins", color: ConstColors.secondary),
                  CustomChip(text: "Bignner", color: ConstColors.secondary),
                ],
              ),
            ],
          ),
          Spacer(),
          SharePicture(
            imagePath: Assets.editBlack,
            width: Sizes.s20,
            height: Sizes.s20,
          ),
        ],
      ),
    );
  }
}
