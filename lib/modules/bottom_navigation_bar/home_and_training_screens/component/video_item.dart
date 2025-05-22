import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
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
    this.index,
    this.selectedIndex,
    this.onChanged,
  });

  final String? image;
  final String? programTitle;
  final String? programTime;
  final String? programStatus;
  final String? programImage;
  final String? creatorName;
  final int? index;
  final int? selectedIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: programTitle ?? "Quick Core ",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            if (creatorName != null)
              CustomChip(text: creatorName ?? '', color: ConstColors.secondary),
            SizedBox(height: 5),
            Row(
              children: [
                CustomChip(
                  text: programTime ?? "15 Mins",
                  color: ConstColors.secondary,
                ),
                const SizedBox(width: 10),
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
            value: index,
            groupValue: selectedIndex,
            onChanged: (value) {
              if (onChanged != null) onChanged!(value!);
            },
          )
        else if (image != null)
          SharePicture(imagePath: image!, height: Sizes.s50, width: Sizes.s50),
      ],
    );
  }
}
