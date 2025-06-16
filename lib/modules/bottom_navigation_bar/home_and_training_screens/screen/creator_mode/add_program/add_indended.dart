import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:provider/provider.dart';

class AddIndended extends StatefulWidget {
  const AddIndended({super.key});

  @override
  State<AddIndended> createState() => _AddIndendedState();
}

class _AddIndendedState extends State<AddIndended> {
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
                  text: "This program is intended for",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),
                SizedBox(height: Sizes.s15),

                RadioListTile(
                  fillColor: WidgetStateProperty.all(
                    vm.isintendedselect ? ConstColors.red : Colors.black,
                  ),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Male",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color: Colors.black,
                  ),
                  value: "Male",
                  groupValue: vm.intendedoption,
                  onChanged: (String? value) {
                    vm.intendedSelect(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),

                RadioListTile(
                  fillColor: WidgetStateProperty.all(
                    vm.isintendedselect ? ConstColors.red : Colors.black,
                  ),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Female",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color: Colors.black,
                  ),
                  value: "Female",
                  groupValue: vm.intendedoption,
                  onChanged: (String? value) {
                    vm.intendedSelect(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),

                RadioListTile(
                  fillColor: WidgetStateProperty.all(
                    vm.isintendedselect ? ConstColors.red : Colors.black,
                  ),
                  activeColor: Colors.black,

                  title: PoppinsText(
                    text: "Both",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color: Colors.black,
                  ),
                  value: "Both",
                  groupValue: vm.intendedoption,
                  onChanged: (String? value) {
                    vm.intendedSelect(value!);
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
