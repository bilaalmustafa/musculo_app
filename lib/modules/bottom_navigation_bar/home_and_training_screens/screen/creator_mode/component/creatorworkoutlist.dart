import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class CreatorWorkoutList extends StatelessWidget {
  const CreatorWorkoutList({super.key, required this.workoutModel});
  final WorkoutModel workoutModel;
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            height: Sizes.s80,
            width: Sizes.s100,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s10),
              image: DecorationImage(image: AssetImage(Assets.workout)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: workoutModel.workoutName ?? "Workout Name",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
                color: ConstColors.black,
              ),

              Row(
                spacing: 10,
                children: [
                  CustomChip(
                    text: formatProgramTime(workoutModel.totalTime ?? 0),
                    color: ConstColors.secondary,
                  ),
                  CustomChip(
                    text: workoutModel.levelOf ?? "Level",
                    color: ConstColors.secondary,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          SharePicture(
            imagePath: Assets.editBlack,
            width: Sizes.s20,
            height: Sizes.s20,
          ),
        ],
      ),
    );
  }
}
