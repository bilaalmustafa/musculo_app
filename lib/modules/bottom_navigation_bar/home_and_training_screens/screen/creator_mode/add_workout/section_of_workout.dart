import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:provider/provider.dart';

import '../../../../../auth/register/component/agreement_check.dart';

class SectionOfWork extends StatefulWidget {
  const SectionOfWork({super.key});

  @override
  State<SectionOfWork> createState() => _TypeOfWorkoutState();
}

class _TypeOfWorkoutState extends State<SectionOfWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s20),
        child: SingleChildScrollView(
          child: Consumer<AddWorkoutVeiwModel>(
            builder: (context, vm, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: "Select the sections of your workout",
                    fontSize: Sizes.s24,
                    fontWeight: TextWeight.semiBold,
                  ),
                  SizedBox(height: Sizes.s20),

                  AgreementCheck(
                    title: "Warm up",
                    isChecked: vm.sectionofWorkout[0],
                    isSelected: vm.isSectionofWorkout,
                    onChanged: (value) {
                      vm.sectionofWorkoutselct(value!, 0);
                    },
                  ),
                  AgreementCheck(
                    isSelected: vm.isSectionofWorkout,
                    title: "Extended warm up",
                    isChecked: vm.sectionofWorkout[1],
                    onChanged: (value) {
                      vm.sectionofWorkoutselct(value!, 1);
                    },
                  ),
                  AgreementCheck(
                    title: "Workout",
                    isSelected: vm.isSectionofWorkout,
                    isChecked: vm.sectionofWorkout[2],
                    onChanged: (value) {
                      vm.sectionofWorkoutselct(value!, 2);
                    },
                  ),
                  AgreementCheck(
                    title: "Finisher",
                    isSelected: vm.isSectionofWorkout,
                    isChecked: vm.sectionofWorkout[3],
                    onChanged: (value) {
                      vm.sectionofWorkoutselct(value!, 3);
                    },
                  ),
                  AgreementCheck(
                    title: "Cool down",
                    isSelected: vm.isSectionofWorkout,
                    isChecked: vm.sectionofWorkout[4],
                    onChanged: (value) {
                      vm.sectionofWorkoutselct(value!, 4);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

  
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(Sizes.s16),
  //     child: Column(
  //       // spacing: Sizes.s1_5,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         QuestionText(
  //           questionText:
  //               "By checking the box, you agree to our terms and conditions.",
  //         ),
  //         SizedBox(height: Sizes.s20),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[0],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[0] = value!;
  //             });
  //           },
  //         ),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[1],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[1] = value!;
  //             });
  //           },
  //         ),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[2],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[2] = value;
  //             });
  //           },
  //         ),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[3],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[3] = value!;
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }