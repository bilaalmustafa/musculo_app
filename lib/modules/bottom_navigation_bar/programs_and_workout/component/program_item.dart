import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_%20model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';

class ProgramItemDis extends StatelessWidget {
  const ProgramItemDis({super.key, this.tabselect, required this.program});
  final int? tabselect;
  final ProgramModel program;

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
              width: context.screenheight * 0.12,
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
                      text: program.programName ?? "unknown",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),

                    Icon(Icons.favorite),
                  ],
                ),
                PoppinsText(
                  text: program.creatorName ?? "unknown",
                  fontSize: Sizes.s12,
                  fontWeight: TextWeight.regular,
                ),
                Row(
                  spacing: Sizes.s10,
                  children: [
                    CustomChip(
                      text: formatProgramTime(program.totalTime ?? 0),
                      color: ConstColors.secondary,
                    ),
                    CustomChip(
                      text: program.levelOf ?? " unknown level",
                      color: ConstColors.secondary,
                    ),
                    if (tabselect == 1)
                      CustomChip(
                        text: "${program.dayAWeek} week",
                        color: ConstColors.secondary,
                      ),
                  ],
                ),
                Row(
                  // spacing: context.screenwidth * 0.10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: " ${program.price} £",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),

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
