import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutItems.dart';
import 'package:provider/provider.dart';

class WorkOuts extends StatelessWidget {
  const WorkOuts({super.key});

  @override
  Widget build(BuildContext context) {
    final userVm = context.read<UserViewModel>();
    final wourkList = userVm.userModel?.listOfWorkouts ?? [];
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body:
          wourkList.isEmpty
              ? Center(
                child: PoppinsText(
                  text: "No Workouts",
                  fontSize: 16,
                  color: ConstColors.black,
                ),
              )
              : ListView.builder(
                itemCount: wourkList.length,
                itemBuilder: (context, index) {
                  return WorkoutItems(workoutModel: wourkList[index]);
                },
              ),
    );
  }
}
