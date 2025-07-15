import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class WorkoutVideoItem extends StatelessWidget {
  const WorkoutVideoItem({
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
    this.workouts,
    this.onTap,
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
  final WorkoutModel? workouts;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: ConstColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: ConstColors.black),
            // image: DecorationImage(
            //   image: AssetImage(programImage ?? Assets.workout),
            //   fit: BoxFit.fill,
            // ),
          ),
          child: Center(
            child: PoppinsText(
              text: workouts!.creatorName![0].toUpperCase(),
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: workouts?.workoutName ?? 'Unknown Program',
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            if (creatorName != null)
              CustomChip(text: creatorName ?? '', color: ConstColors.secondary),
            SizedBox(height: 5),
            Row(
              children: [
                CustomChip(
                  text: "${workouts?.totalTime ?? "0"} Mins",
                  color: ConstColors.secondary,
                ),
                const SizedBox(width: 10),
                CustomChip(
                  text: workouts?.levelOf ?? 'Unknown Level',
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
          InkWell(
            onTap: onTap,
            child: SharePicture(
              imagePath: image!,
              height: Sizes.s50,
              width: Sizes.s50,
            ),
          ),
      ],
    );
  }
}
