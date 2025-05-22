import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutprograms.dart';

import '../../../../../../core/constants/assets.dart';

class AddYourProgram extends StatefulWidget {
  const AddYourProgram({super.key});

  @override
  State<AddYourProgram> createState() => _AddProgramNameState();
}

class _AddProgramNameState extends State<AddYourProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PoppinsText(
              text: "Add workouts to your program",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
          ),
          SizedBox(height: Sizes.s20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              title: "Search workouts",
              preIcon: Assets.searchIcon,
              sufIcon: Assets.filterIcon,
            ),
          ),
          SizedBox(height: Sizes.s20),
          Expanded(
            child: Container(
              color: ConstColors.secondary,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  // their you will not print the price
                  return WorkoutPrograms();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
