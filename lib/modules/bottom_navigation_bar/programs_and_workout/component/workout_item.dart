import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

// this is the discover screen workout item
class WorkOutItemDis extends StatelessWidget {
  const WorkOutItemDis({super.key, this.tabselect, required this.workout});
  final int? tabselect;
  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
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

                    Icon(Icons.favorite),
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
                      text: "${workout.totalTime ?? 0} Mins",
                      color: ConstColors.secondary,
                    ),
                    CustomChip(
                      text: workout.levelOf ?? "unknown",
                      color: ConstColors.secondary,
                    ),
                    if (tabselect == 1)
                      CustomChip(text: " week", color: ConstColors.secondary),
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
                        if (tabselect == 1) {
                          Navigator.pushNamed(
                            context,
                            Routes.programDetailPageView,
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            Routes.traningpreviewscreen,
                          );
                        }
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
