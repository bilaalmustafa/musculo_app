import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:provider/provider.dart';

class AddProgramName extends StatefulWidget {
  const AddProgramName({super.key});

  @override
  State<AddProgramName> createState() => _AddProgramNameState();
}

class _AddProgramNameState extends State<AddProgramName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.s10,
          children: [
            PoppinsText(
              text: "Name your program",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
            SizedBox(height: Sizes.s10),
            PoppinsText(
              text: "Program Name",
              fontSize: Sizes.s14,
              fontWeight: TextWeight.semiBold,
            ),
            Consumer<AddProgramViewModel>(
              builder: (context, vm, _) {
                return Form(
                  key: vm.formKey,
                  child: CustomTextField(
                    controller: vm.programNameController,
                    validator: (value) => Validator.valueExists(value),
                    title: "write it here",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
