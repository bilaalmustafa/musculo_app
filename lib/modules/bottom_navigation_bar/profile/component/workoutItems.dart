import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class WorkoutItems extends StatelessWidget {
  const WorkoutItems({super.key, this.workoutModel, this.seleted = false});

  final WorkoutModel? workoutModel;
  final bool seleted;
  @override
  Widget build(BuildContext context) {
    String formatProgramTime(int totalTimeInSeconds) {
      int totalMinutes = totalTimeInSeconds ~/ 60;

      if (totalMinutes < 60) {
        return "$totalMinutes Mins";
      } else {
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;

        // Round up to the next hour if minutes >= 45
        if (minutes >= 45) {
          hours += 1;
        }

        return "$hours Hr";
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.s20, vertical: Sizes.s10),

      padding: EdgeInsets.all(Sizes.s20),
      decoration: BoxDecoration(
        border: seleted ? Border.all(color: ConstColors.black) : null,
        borderRadius: BorderRadius.circular(Sizes.s8),
        color: ConstColors.white,
      ),
      child: Row(
        spacing: Sizes.s10,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(Sizes.s8),
                color: ConstColors.black,
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: ConstColors.gre9E9E),
                // image: DecorationImage(
                //   image: AssetImage(Assets.workout),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Center(
                child: PoppinsText(
                  text: workoutModel?.creatorName![0].toUpperCase() ?? '?',
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: ConstColors.white,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                PoppinsText(
                  text: workoutModel?.workoutName ?? "workout name ",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.semiBold,
                ),

                Row(
                  spacing: Sizes.s5,
                  children: [
                    CustomChip(
                      text: formatProgramTime(workoutModel?.totalTime ?? 0),
                      color: ConstColors.secondary,
                    ),
                    CustomChip(
                      text: workoutModel?.levelOf ?? "unknown",
                      color: ConstColors.secondary,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "${workoutModel?.price ?? "0"} €",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),

                    CustomButton(
                      buttonText: "See details",
                      buttonHeight: Sizes.s30,
                      buttonWidth: Sizes.s110,
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            Routes.traningpreviewscreen,
                            arguments: workoutModel,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
