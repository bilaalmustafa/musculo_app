import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({
    super.key,
    this.image,
    this.programImage,
    this.programStatus,
    this.programTime,
    this.programTitle,
    this.creatorName,
    this.radiostatus,
  });
  final String? image;
  final String? programTitle;
  final String? programTime;
  final String? programStatus;
  final String? programImage;
  final String? creatorName;
  final bool? radiostatus;
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
              image: AssetImage(programImage ?? Assets.workout),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.s3,
          children: [
            PoppinsText(
              text: programTitle ?? "Quick Core ",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),

            if (creatorName != null)
              CustomChip(text: creatorName ?? '', color: ConstColors.secondary),

            Row(
              spacing: Sizes.s10,
              children: [
                CustomChip(
                  text: programTime ?? "15 Mins",
                  color: ConstColors.secondary,
                ),
                CustomChip(
                  text: programStatus ?? "Beginner",
                  color: ConstColors.secondary,
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        if (image == null)
          Radio(
            activeColor: ConstColors.black,
            value: radiostatus ?? false,
            groupValue: true,
            onChanged: (value) {},
          )
        else
          Image.asset(image!, height: 50, width: 50),
      ],
    );
  }
}
