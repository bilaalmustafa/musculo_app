import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class ProgramVideoItem extends StatelessWidget {
  const ProgramVideoItem({
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
    this.program,
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
  final ProgramModel? program;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String formatProgramTime(int totalTimeInSeconds) {
      int totalMinutes = totalTimeInSeconds ~/ 60;

      if (totalMinutes < 60) {
        return "$totalMinutes Mins";
      } else {
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;

        if (minutes >= 45) {
          hours += 1;
        }

        return "$hours Hr";
      }
    }

    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: ConstColors.black,
            // borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: ConstColors.black),
            shape: BoxShape.circle,
            // image: DecorationImage(
            //   image: AssetImage(programImage ?? Assets.workout),
            //   fit: BoxFit.fill,
            // ),
          ),
          child: Center(
            child: PoppinsText(
              text: program!.creatorName![0].toUpperCase(),
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: ConstColors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: program?.programName ?? 'Unknown Program',
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            if (creatorName != null)
              CustomChip(text: creatorName ?? '', color: ConstColors.secondary),
            SizedBox(height: 5),
            Row(
              children: [
                CustomChip(
                  text: formatProgramTime(program?.duration ?? 0),
                  // text: "${program?.duration ?? "0"} Mins",
                  color: ConstColors.secondary,
                ),
                const SizedBox(width: 10),
                CustomChip(
                  text: program?.levelOf ?? 'Unknown Level',
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
