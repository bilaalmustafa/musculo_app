import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({super.key, this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Sizes.s10,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: ConstColors.secondary,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(Assets.workout),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: "Quick Core ",
              fontSize: Sizes.s18,
              fontWeight: TextWeight.semiBold,
            ),
            Row(
              spacing: Sizes.s10,
              children: [
                CustomChip(text: "15 Mins", color: ConstColors.secondary),
                CustomChip(text: "Beginner", color: ConstColors.secondary),
              ],
            ),
          ],
        ),
        Spacer(),
        if (image == null)
          Radio(
            activeColor: ConstColors.black,
            value: false,
            groupValue: false,
            onChanged: (value) {},
          )
        else
          Image.asset(image!, height: 50, width: 50),
      ],
    );
  }
}
