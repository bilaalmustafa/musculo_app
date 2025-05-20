import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/calender.dart';

class DaysAWeeksFromCalender extends StatefulWidget {
  const DaysAWeeksFromCalender({super.key});

  @override
  State<DaysAWeeksFromCalender> createState() => _DurationOfProgramState();
}

class _DurationOfProgramState extends State<DaysAWeeksFromCalender> {
    DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: Sizes.s20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: "How many day’s a week ?",
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
            ),

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
          ],
        ),
      ),
    );
  }
}
