import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

import '../../../profile/component/workoutItems.dart';

class WorkOutTab extends StatelessWidget {
  const WorkOutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (contex, index) {
          return WorkoutItems();
        },
      ),
    );
  }
}
