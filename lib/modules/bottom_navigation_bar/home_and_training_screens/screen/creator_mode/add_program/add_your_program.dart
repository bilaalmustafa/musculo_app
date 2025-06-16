import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/programItems.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/workoutItems.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/assets.dart';

class AddYourProgram extends StatefulWidget {
  const AddYourProgram({super.key});

  @override
  State<AddYourProgram> createState() => _AddProgramNameState();
}

class _AddProgramNameState extends State<AddYourProgram> {
  Stream<List<WorkoutModel>>? stream;
  late AuthViewModel authViewModel;
  @override
  void initState() {
    authViewModel = context.read<AuthViewModel>();
    final uid = authViewModel.currentUser!.uid;
    stream = instance<WorkoutServices>().getCreatorWorkout(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PoppinsText(
              text: "Add workouts to your program",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
          ),
          SizedBox(height: Sizes.s20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              title: "Search workouts",
              preIcon: Assets.searchIcon,
              sufIcon: Assets.filterIcon,
            ),
          ),
          SizedBox(height: Sizes.s20),
          Expanded(
            child: Container(
              color: ConstColors.secondary,
              child: StreamBuilder<List<WorkoutModel>>(
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
                  return Consumer<AddProgramViewModel>(
                    builder: (context, vm, _) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          // their you will not print the price
                          return InkWell(
                            onTap: () {
                              vm.workoutSelected(data[index]);
                            },
                            child: WorkoutItems(
                              workoutModel: data[index],

                              seleted: vm.workoutList.contains(data[index]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: data.length,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
