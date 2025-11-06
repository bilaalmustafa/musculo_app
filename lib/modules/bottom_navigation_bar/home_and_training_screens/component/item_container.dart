import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:provider/provider.dart';

import '../../../../model/programs_model.dart';
import '../../programs_and_workout/bottom_navigation_view_model.dart';

class ItemContainer extends StatelessWidget {
  final ProgramModel program;
  const ItemContainer({super.key, required this.program});

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

    return Container(
      height: Sizes.s180,
      width: 325,

      decoration: BoxDecoration(
        color: ConstColors.secondary,
        borderRadius: BorderRadius.circular(Sizes.s10),
        image: DecorationImage(
          image: AssetImage(Assets.bgimage),
          fit: BoxFit.cover,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.s20),
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
                    text: program.creatorName ?? 'unknown',
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.regular,
                  ),
                  PoppinsText(
                    text: program.programName ?? "unknown",
                    fontSize: Sizes.s20,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Row(
                    spacing: Sizes.s10,
                    children: [
                      CustomChip(
                        text: formatProgramTime(program.totalTime ?? 0),
                      ),
                      CustomChip(text: program.levelOf ?? " unknown level"),
                    ],
                  ),
                ],
              ),
            ),
            //MARK:
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Provider.of<BottomNavigationProvider>(
                      context,
                      listen: false,
                    ).setIndex(1);
                  },
                  child: SharePicture(imagePath: Assets.discovery2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
