import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/program_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/workout_item.dart';

class WorkOutTab extends StatelessWidget {
  const WorkOutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,

      body: StreamBuilder<List<ProgramModel>>(
        stream: instance<CreatorServices>().getWorkout(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: PoppinsText(
                text: "No Workout Found",
                fontSize: Sizes.s16,
                color: ConstColors.black,
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: PoppinsText(
                text: "List is Empty",
                fontSize: Sizes.s16,
                color: ConstColors.black,
              ),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return WorkOutItem();
            },
          );
        },
      ),
    );
  }
}
