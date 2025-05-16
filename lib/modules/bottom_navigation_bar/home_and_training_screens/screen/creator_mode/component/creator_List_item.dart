import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        spacing: 10,
        children: [
          Container(
            height: 80,
            width: 100,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
          Icon(Icons.edit, size: 40),
        ],
      ),
    );
  }
}
