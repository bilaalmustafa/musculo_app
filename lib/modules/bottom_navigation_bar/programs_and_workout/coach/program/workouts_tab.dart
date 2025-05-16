import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/work_program_item.dart';

class ProgramWorkOutsTab extends StatefulWidget {
  const ProgramWorkOutsTab({super.key});

  @override
  State<ProgramWorkOutsTab> createState() => _ProgramWorkOutsTabState();
}

class _ProgramWorkOutsTabState extends State<ProgramWorkOutsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (contex, index) {
          return WorkProgramItem();
        },
      ),
    );
  }
}
