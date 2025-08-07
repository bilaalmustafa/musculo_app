import 'package:flutter/material.dart';

import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/calender.dart';
import 'package:provider/provider.dart';

class DaysAWeeksFromCalender extends StatefulWidget {
  const DaysAWeeksFromCalender({super.key});

  @override
  State<DaysAWeeksFromCalender> createState() => _DurationOfProgramState();
}

class _DurationOfProgramState extends State<DaysAWeeksFromCalender> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<AddProgramViewModel>(
          builder: (context, vm, _) {
            final maxSelections = (vm.selectedTime ?? 0) + 1;
            return Column(
              spacing: Sizes.s20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PoppinsText(
                  text: "Pick $maxSelections days a week",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),

                CalenderWidget(
                  focusedDay: _focusedDay,
                  selectedDates: vm.selectedDates,
                  selectedDay:
                      vm.selectedDates.isNotEmpty
                          ? vm.selectedDates.last
                          : null,

                  ondaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                    vm.toggleSelectedDate(selectedDay);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
