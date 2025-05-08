import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_screens/widgets/custom_chip.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,

      decoration: BoxDecoration(
        color: ConstColors.secondary,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(Assets.bgimage),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                spacing: Sizes.s10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: "LOSE WEIGHT",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.regular,
                  ),
                  PoppinsText(
                    text: "Squat Lose Weight",
                    fontSize: Sizes.s20,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Row(
                    spacing: Sizes.s10,
                    children: [
                      CustomChip(text: "15 Mins"),
                      CustomChip(text: "Beginner"),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(Assets.discovery),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
