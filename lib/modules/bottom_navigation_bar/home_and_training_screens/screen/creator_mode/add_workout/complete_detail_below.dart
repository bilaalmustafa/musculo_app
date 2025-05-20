import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/customdropdown.dart';

class CompleteDetailBelow extends StatefulWidget {
  const CompleteDetailBelow({super.key});

  @override
  State<CompleteDetailBelow> createState() => _WarmUpState();
}

class _WarmUpState extends State<CompleteDetailBelow> {
  double slidervalue = 5;
  String _selectedhere = "Select it here";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Column(
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

                  CustomTextField(title: "Write it here"),
                  PoppinsText(
                    text: "Workout added to",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),

                  CustomDropdown(
                    value: _selectedhere,
                    items: const ['Warm up', 'Workout', 'Finisher'],
                    onChanged: (value) {
                      setState(() {
                        _selectedhere = value;
                      });
                    },
                  ),
                  PoppinsText(
                    text: "Date",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),

                  CustomTextField(title: "Write it here"),
                  PoppinsText(
                    text: "Workout description",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),

                  CustomTextField(title: "Write it here"),
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
                        value: slidervalue,
                        onChanged: (value) {
                          setState(() {
                            slidervalue = value;
                          });
                        },
                      ),
                      PoppinsText(
                        text: slidervalue.round().toString(),
                        fontSize: Sizes.s12,
                      ),
                    ],
                  ),
                  PoppinsText(
                    text: "Price",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),

                  CustomTextField(title: "Write it here"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
