import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutItems.dart';
import 'package:provider/provider.dart';

import '../../programs_and_workout/component/workout_item.dart';

class WorkOuts extends StatelessWidget {
  WorkOuts({super.key, required this.workoutModelList});
  List<WorkoutModel> workoutModelList;
  @override
  Widget build(BuildContext context) {
    // final userVm = context.read<UserViewModel>();
    final wourkList = workoutModelList;
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
                  return WorkOutItemDis(workout: workoutModelList[index]);
                },
              ),
    );
  }
}
