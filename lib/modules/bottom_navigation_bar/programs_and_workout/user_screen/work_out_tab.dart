import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/workout_item.dart';

class WorkOutTabDisScreen extends StatefulWidget {
  const WorkOutTabDisScreen({super.key});

  @override
  State<WorkOutTabDisScreen> createState() => _WorkOutTabDisScreenState();
}

class _WorkOutTabDisScreenState extends State<WorkOutTabDisScreen> {
  Stream<List<WorkoutModel>>? stream;

 
  @override
  void initState() {

    stream = instance<WorkoutServices>().getWorkout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,

      body: StreamBuilder<List<WorkoutModel>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: PoppinsText(
                text: "An error occurred: ${snapshot.error}",
                fontSize: Sizes.s16,
                color: ConstColors.black,
              ),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return Center(
              child: PoppinsText(
                text: "No Workout Found",
                fontSize: Sizes.s16,
                color: ConstColors.black,
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return WorkOutItemDis(workout: data[index]);
            },
          );
        },
      ),
    );
  }
}
