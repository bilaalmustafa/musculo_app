import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutprograms.dart';

class WorkOuts extends StatelessWidget {
  const WorkOuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return WorkoutPrograms();
        },
      ),
    );
  }
}
