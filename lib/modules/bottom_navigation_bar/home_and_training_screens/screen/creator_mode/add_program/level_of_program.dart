import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:provider/provider.dart';

class LevelOfProgram extends StatefulWidget {
  const LevelOfProgram({super.key});

  @override
  State<LevelOfProgram> createState() => _LevelOfProgramState();
}

class _LevelOfProgramState extends State<LevelOfProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<AddProgramViewModel>(
          builder: (context, vm, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PoppinsText(
                  text: "Select level of your program",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),
                SizedBox(height: Sizes.s15),
                RadioListTile(
                  fillColor: WidgetStatePropertyAll(
                    vm.isLevelofProgramslect
                        ? ConstColors.red
                        : ConstColors.black,
                  ),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Beginner",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color:
                         ConstColors.black,
                  ),
                  value: "Beginner",
                  groupValue: vm.levelofProgram,
                  onChanged: (String? value) {
                    vm.levelofProgramselct(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),
                RadioListTile(
                  fillColor: WidgetStatePropertyAll(
                    vm.isLevelofProgramslect
                        ? ConstColors.red
                        : ConstColors.black,
                  ),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Experienced",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color:
                        ConstColors.black,
                  ),
                  value: "Experienced",
                  groupValue: vm.levelofProgram,
                  onChanged: (String? value) {
                    vm.levelofProgramselct(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),

                RadioListTile(
                  fillColor: WidgetStatePropertyAll(
                    vm.isLevelofProgramslect
                        ? ConstColors.red
                        : ConstColors.black,
                  ),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Advanced",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color:
                         ConstColors.black,
                  ),
                  value: "Advanced",
                  groupValue: vm.levelofProgram,
                  onChanged: (String? value) {
                    vm.levelofProgramselct(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),
              ],
            );
          },
        ),
      ),
    );
  }
}
