import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/work_program_item.dart';

class WorkOutTab extends StatelessWidget {
  const WorkOutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return WorkProgramItem();
        },
      ),
    );
  }
}
