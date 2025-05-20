import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutprograms.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/work_program_item.dart';

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
        spacing: Sizes.s10,
        children: [
          PoppinsText(
            text: "Add workouts to your program",
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
          ),
          SizedBox(height: Sizes.s10),

          CustomTextField(
            prefexicon: Icons.search,
            title: "Search workouts",
            suffexicon: Icons.filter_list_sharp,
          ),

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
