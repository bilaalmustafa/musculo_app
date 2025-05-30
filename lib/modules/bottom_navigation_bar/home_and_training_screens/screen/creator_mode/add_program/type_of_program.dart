import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:provider/provider.dart';

class TypeOfProgram extends StatefulWidget {
  const TypeOfProgram({super.key});

  @override
  State<TypeOfProgram> createState() => _TypeOfProgramState();
}

class _TypeOfProgramState extends State<TypeOfProgram> {
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
                  text: "Select type of your program",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),
                SizedBox(height: Sizes.s15),
                RadioListTile(
                  fillColor: WidgetStateProperty.all(
                    vm.isTypeofProgramSelect
                        ? ConstColors.red
                        : ConstColors.black,
                  ),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "With equipment",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color:
                        vm.isTypeofProgramSelect
                            ? ConstColors.red
                            : ConstColors.black,
                  ),
                  value: "With equipment",
                  groupValue: vm.typeofProgram,
                  onChanged: (String? value) {
                    vm.typeofProgrmslect(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),
                RadioListTile(
                  fillColor: WidgetStateProperty.all(
                    vm.isTypeofProgramSelect
                        ? ConstColors.red
                        : ConstColors.black,
                  ),

                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Without equipment",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color:
                        vm.isTypeofProgramSelect
                            ? ConstColors.red
                            : ConstColors.black,
                  ),
                  value: "Without equipment",
                  groupValue: vm.typeofProgram,
                  onChanged: (String? value) {
                    vm.typeofProgrmslect(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),

                RadioListTile(
                  fillColor: WidgetStateProperty.all(
                    vm.isTypeofProgramSelect
                        ? ConstColors.red
                        : ConstColors.black,
                  ),

                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Stretching",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color:
                        vm.isTypeofProgramSelect
                            ? ConstColors.red
                            : ConstColors.black,
                  ),
                  value: "Stretching",
                  groupValue: vm.typeofProgram,
                  onChanged: (String? value) {
                    vm.typeofProgrmslect(value!);
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
