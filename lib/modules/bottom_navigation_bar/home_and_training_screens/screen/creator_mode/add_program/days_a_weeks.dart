import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:provider/provider.dart';

class DaysAWeeks extends StatefulWidget {
  const DaysAWeeks({super.key});

  @override
  State<DaysAWeeks> createState() => _DaysAWeeksState();
}

class _DaysAWeeksState extends State<DaysAWeeks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Sizes.s20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ).copyWith(top: 20),
            child: PoppinsText(
              text: "How many days a week?",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
          ),

          Expanded(
            child: Consumer<AddProgramViewModel>(
              builder: (context, vm, _) {
                return Container(
                  color: ConstColors.secondary,
                  child: ListView.separated(
                    itemCount: 7,
                    itemBuilder: (conex, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border:
                              vm.selectedTime == index
                                  ? Border.all(color: ConstColors.black)
                                  : null,
                        ),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          checkboxShape: CircleBorder(
                            side: BorderSide(color: ConstColors.black),
                          ),
                          activeColor: ConstColors.black,
                          title: PoppinsText(
                            text: " ${index + 1} Time",
                            fontSize: Sizes.s14,
                          ),

                          value: vm.selectedTime == index,
                          onChanged: (value) {
                            setState(() {
                              vm.selectedTime = value! ? index : null;
                              log("seletedTimeee ${vm.selectedTime}");
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
