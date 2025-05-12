import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class WorkProgramItem extends StatelessWidget {
  const WorkProgramItem({super.key, this.tabselect});
  final int? tabselect;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.s20, vertical: Sizes.s10),

      height: Sizes.s160,
      padding: EdgeInsets.all(Sizes.s20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ConstColors.white,
      ),
      child: Row(
        spacing: Sizes.s10,
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ConstColors.amber,
              image: DecorationImage(
                image: AssetImage(Assets.workout),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PoppinsText(
                    text: "Quick Core Blaster",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),

                  Icon(Icons.favorite),
                ],
              ),
              PoppinsText(
                text: "Auther name",
                fontSize: Sizes.s12,
                fontWeight: TextWeight.regular,
              ),
              Row(
                spacing: Sizes.s10,
                children: [
                  CustomChip(text: "20 Mins", color: ConstColors.secondary),
                  CustomChip(text: "Beginner", color: ConstColors.secondary),
                  if (tabselect == 1)
                    CustomChip(text: "2x week", color: ConstColors.secondary),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PoppinsText(
                    text: "5.00 \$",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),
                  CustomButton(
                    buttonText: "See details",
                    buttonHeight: Sizes.s30,
                    buttonWidth: Sizes.s120,
                    onTap: ()=>Navigator.pushNamed(context, Routes.traningpreviewscreen),
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
