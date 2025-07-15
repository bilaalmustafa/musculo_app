import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:provider/provider.dart';

import '../../../../components/share_picture.dart';
import '../../profile/profile_view_model/profile_view_model.dart';

class ProgramItemDis extends StatelessWidget {
  const ProgramItemDis({super.key, required this.program});

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

        if (minutes >= 45) {
          hours += 1;
        }

        return "$hours Hr";
      }
    }

    String getWeeksFromDuration(int? durationInDays) {
      if (durationInDays == null || durationInDays <= 0) return "0";

      if (durationInDays < 7) return "1";

      final weeks = (durationInDays / 7).ceil();
      return weeks.toString();
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
              // width: context.screenheight * 0.12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizes.s8),
                border: Border.all(width: 0.5, color: ConstColors.black),
                // color: ConstColors.amber,
                // image: DecorationImage(
                //   image: AssetImage(Assets.workout),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Center(
                child: PoppinsText(
                  text: program.creatorName![0].toUpperCase(),
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
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

                    Consumer<ProfileProvider>(
                      builder: (context, vm, _) {
                        final isFavorite = vm.favoriteProgram.any(
                          (p) => p.programId == program.programId,
                        );
                        return InkWell(
                          onTap: () {
                            vm.addFaverateProgram(program);
                            print(
                              'print existing program in hive ${vm.favoriteProgram}',
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
                    // if (tabselect == 1)
                    CustomChip(
                      text: "${getWeeksFromDuration(program.duration)} week",
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
                        Navigator.pushNamed(
                          context,
                          Routes.programDetailPageView,
                          arguments: program,
                        );
                        // if (tabselect == 1) {

                        // } else {
                        //   Navigator.pushNamed(
                        //     context,
                        //     Routes.traningpreviewscreen,
                        //   );
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
