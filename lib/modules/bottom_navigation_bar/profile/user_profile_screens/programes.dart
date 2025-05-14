import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutprograms.dart';

class Programs extends StatelessWidget {
  const Programs({super.key, required this.tabselect});
  final int tabselect;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return WorkoutPrograms(tabselect: tabselect);
        },
      ),
    );
  }
}
