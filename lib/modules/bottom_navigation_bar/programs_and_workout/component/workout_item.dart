import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:provider/provider.dart';

import '../../profile/profile_view_model/profile_view_model.dart';

// this is the discover screen workout item
class WorkOutItemDis extends StatelessWidget {
  const WorkOutItemDis({super.key, required this.workout});

  final WorkoutModel workout;

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

      height: Sizes.s150,
      padding: EdgeInsets.all(Sizes.s12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.s8),
        color: ConstColors.white,
      ),
      child: Row(
        spacing: Sizes.s10,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s8),
                // color: ConstColors.amber,
                image: DecorationImage(
                  image: AssetImage(Assets.workout),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: workout.workoutName ?? "unknown",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),

                    Consumer<ProfileProvider>(
                      builder: (context, vm, _) {
                        final isFavorite = vm.favorateWorkout.any(
                          (w) => w.workoutId == workout.workoutId,
                        );
                        return InkWell(
                          onTap: () {
                            vm.addFaverateWorkout(workout);
                            print(
                              'print existing work out in hive ${vm.favorateWorkout}',
                            );
                          },
                          child: SharePicture(
                            imagePath:
                                isFavorite
                                    ? Assets.heartFill
                                    : Assets.heartIcon,
                            // colorFilter: ColorFilter.mode(
                            //   isFavorite ? ConstColors.red : ConstColors.black,
                            //   BlendMode.srcIn,
                            // ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                PoppinsText(
                  text: workout.creatorName ?? "unknown",
                  fontSize: Sizes.s12,
                  fontWeight: TextWeight.regular,
                ),
                Row(
                  spacing: Sizes.s10,
                  children: [
                    CustomChip(
                      text: formatProgramTime(workout.totalTime ?? 0),
                      color: ConstColors.secondary,
                    ),
                    CustomChip(
                      text: workout.levelOf ?? "unknown",
                      color: ConstColors.secondary,
                    ),
                    // if (tabselect == 1)
                    //   CustomChip(text: " week", color: ConstColors.secondary),
                  ],
                ),
                Row(
                  // spacing: context.screenwidth * 0.10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "${workout.price ?? 0} £",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),
                    SizedBox(width: context.screenwidth * 0.08),
                    CustomButton(
                      buttonText: "See details",
                      buttonHeight: Sizes.s30,
                      buttonWidth: Sizes.s110,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.traningpreviewscreen,
                          arguments: workout,
                        );
                        // if (tabselect == 1) {
                        //   Navigator.pushNamed(
                        //     context,
                        //     Routes.programDetailPageView,
                        //   );
                        // } else {

                        // }
                      },
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
