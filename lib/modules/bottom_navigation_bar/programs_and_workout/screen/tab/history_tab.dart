import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/calender.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/history_list_tile.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Column(
          spacing: Sizes.s20,
          children: [
            CalenderWidget(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
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
                      runtext: "07",
                      timetext: "100",
                    ),
                    Divider(color: ConstColors.dividerColor),
                    HistoryListTile(
                      headingtext: "Tue, Dec 05",
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
            Container(
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

                    leading: Container(
                      child: SharePicture(imagePath: Assets.workout),
                    ),
                    title: PoppinsText(
                      text: "Leg day work",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),
                    subtitle: Column(
                      spacing: Sizes.s10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PoppinsText(
                          text: "08:20 - 08:40 AM",
                          fontSize: Sizes.s10,
                        ),
                        Row(
                          spacing: Sizes.s10,
                          children: [
                            CustomChip(
                              text: "20 Mins",
                              color: ConstColors.secondary,
                            ),
                            CustomChip(
                              text: "beginner",
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
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
