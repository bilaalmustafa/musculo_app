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
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/calender.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/history_list_tile.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key, required this.programModel});
  final ProgramModel programModel;

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    final data = widget.programModel;
    final List<WorkoutModel> listofworkout =
        data.listOfWorkouts as List<WorkoutModel>;
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

    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Column(
          spacing: Sizes.s20,
          children: [
            CalenderWidget(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              // selectedDates:data.dayAWeek ,
              ondaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s8),
                border: Border.all(color: ConstColors.dividerColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.s10),
                child: Column(
                  children: [
                    HistoryListTile(
                      headingtext: "Overall",
                      runtext: data.listOfWorkouts?.length.toString() ?? "0",
                      timetext: data.totalTime.toString(),
                    ),
                    Divider(color: ConstColors.dividerColor),
                    HistoryListTile(
                      headingtext: (data.dayAWeek ?? []).join(","),
                      runtext: "01",
                      timetext: "20",
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: Sizes.s8),
                    //   child: Column(
                    //     spacing: Sizes.s10,
                    //     children: [
                    //       Divider(color: ConstColors.dividerColor),
                    //       SharePicture(imagePath: Assets.empty),
                    //       PoppinsText(
                    //         text: "Empty",
                    //         fontSize: Sizes.s16,
                    //         fontWeight: TextWeight.semiBold,
                    //       ),
                    //       PoppinsText(
                    //         text: "You did't exercise on this date",
                    //         fontSize: Sizes.s12,
                    //         color: ConstColors.greyA1A1,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              // color: ConstColors.secondary,
              child: ListView.separated(
                shrinkWrap: true,

                itemBuilder: (_, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Sizes.s5,
                      horizontal: Sizes.s10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tileColor: ConstColors.white,

                    leading: SharePicture(imagePath: Assets.workout),
                    title: PoppinsText(
                      text: listofworkout[index].workoutName ?? "unknown",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PoppinsText(
                        //   text: "08:20 - 08:40 AM",
                        //   fontSize: Sizes.s10,
                        // ),
                        SizedBox(height: 3),
                        Row(
                          spacing: Sizes.s10,
                          children: [
                            CustomChip(
                              text: formatProgramTime(
                                listofworkout[index].totalTime!,
                              ),
                              color: ConstColors.secondary,
                            ),
                            CustomChip(
                              text: listofworkout[index].levelOf ?? "unknown",
                              color: ConstColors.secondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, idex) {
                  return SizedBox(height: Sizes.s8);
                },
                itemCount: listofworkout.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
