import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  CalenderWidget({
    super.key,
    this.selectedDay,
    required this.focusedDay,
    required this.ondaySelected,
  });
  DateTime? selectedDay;
  DateTime focusedDay;
  final void Function(DateTime selectedDay, DateTime focusedDay) ondaySelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstColors.white,
        borderRadius: BorderRadius.circular(Sizes.s8),
        border: Border.all(color: ConstColors.dividerColor),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: ConstColors.black,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: ConstColors.black, // Black text on selected day
          ),
          selectedDecoration: BoxDecoration(
            // color: Colors.black,
            shape: BoxShape.circle,
            border: Border.all(color: ConstColors.black),
          ),
          weekendTextStyle: TextStyle(color: ConstColors.green),
          defaultTextStyle: TextStyle(color: ConstColors.black),
          outsideTextStyle: TextStyle(color: ConstColors.greyA1A1),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
            border: Border.all(color: ConstColors.dividerColor),
          ),
        ),

        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
            color: ConstColors.black,
            fontWeight: FontWeight.bold,
          ),
          weekdayStyle: TextStyle(
            color: ConstColors.black,
            fontWeight: TextWeight.medium,
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          ondaySelected(selectedDay, focusedDay);
        },
      ),
    );
  }
}
