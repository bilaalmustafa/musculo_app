import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/customdropdown.dart';
import 'package:provider/provider.dart';

class CompleteDetailBelow extends StatefulWidget {
  const CompleteDetailBelow({super.key});

  @override
  State<CompleteDetailBelow> createState() => _WarmUpState();
}

class _WarmUpState extends State<CompleteDetailBelow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Consumer<AddWorkoutVeiwModel>(
          builder: (context, vm, _) {
            return Column(
              spacing: Sizes.s20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      PoppinsText(
                        text: "Complete the details below",
                        fontSize: Sizes.s24,
                        fontWeight: TextWeight.semiBold,
                      ),
                      PoppinsText(
                        text: "Workout name",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),

                      CustomTextField(
                        controller: vm.workoutNameController,
                        title: "Write it here",
                      ),
                      PoppinsText(
                        text: "Workout added to",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),

                      CustomDropdown(
                        value: vm.selectedhere,
                        items: const ['Warm up', 'Workout', 'Finisher'],
                        hint: "Select it here",
                        onChanged: (value) {
                          vm.selectHere(value);
                        },
                      ),
                      PoppinsText(
                        text: "Date",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),

                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: vm.selectedDate ?? DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary:
                                        ConstColors
                                            .black, // selected date circle background
                                    onPrimary:
                                        ConstColors
                                            .white, // selected date text color
                                    onSurface:
                                        ConstColors.black, // normal text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          ConstColors
                                              .black, // OK/Cancel button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            vm.dateSelecte(picked);
                          }
                        },

                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: vm.dateController,
                            title: "DD/MM/YYYY",
                          ),
                        ),
                      ),
                      PoppinsText(
                        text: "Workout description",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),

                      CustomTextField(
                        controller: vm.descriptionController,
                        title: "Write it here",
                      ),
                      PoppinsText(
                        text: "Workout difficulty",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Slider(
                            min: 1,
                            max: 10,
                            activeColor: ConstColors.black,
                            inactiveColor: ConstColors.secondary,
                            value: vm.difficulty,
                            onChanged: (value) {
                              vm.difficultySlider(value);
                            },
                          ),
                          PoppinsText(
                            text: vm.difficulty.round().toString(),
                            fontSize: Sizes.s12,
                          ),
                        ],
                      ),
                      PoppinsText(
                        text: "Price",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),

                      CustomTextField(
                        controller: vm.priceController,
                        title: "Write it here",
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
