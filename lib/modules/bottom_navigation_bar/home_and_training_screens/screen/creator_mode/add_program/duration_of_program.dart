import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:provider/provider.dart';

class DurationOfProgram extends StatefulWidget {
  const DurationOfProgram({super.key});

  @override
  State<DurationOfProgram> createState() => _DurationOfProgramState();
}

class _DurationOfProgramState extends State<DurationOfProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<AddProgramViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: "What’s the duration of your program ",
                    fontSize: Sizes.s24,
                    fontWeight: TextWeight.semiBold,
                  ),
                  SizedBox(height: Sizes.s20),
                  PoppinsText(
                    text: "Program duration",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Slider(
                        min: 0,
                        max: 10,
                        activeColor: ConstColors.black,
                        inactiveColor: ConstColors.secondary,
                        value: vm.sliderValue,
                        onChanged: (value) {
                          vm.updateSlider(value);
                        },
                      ),
                      PoppinsText(
                        text: "${vm.sliderValue.round().toString()} days",
                        fontSize: Sizes.s12,
                      ),
                    ],
                  ),
                  PoppinsText(
                    text: "Add own duration",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),
                  SizedBox(height: Sizes.s10),
                  CustomTextField(
                    onChanged: (value) => vm.updateTextField(value),
                    controller: vm.addOwnDuraionController,
                    title: "write it here",
                    keyboardType: TextInputType.number,
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.black,
                    title: PoppinsText(
                      text: "Monthly program",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.medium,
                    ),
                    value: "Monthly program",
                    groupValue: vm.radioOption,
                    onChanged: (String? value) {
                      if (value != null) {
                        vm.selectRadio(value);
                      }
                    },
                  ),
                  PoppinsText(
                    text: "Price",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),
                  SizedBox(height: Sizes.s10),
                  Form(
                    key: vm.formKey,
                    child: CustomTextField(
                      controller: vm.priceController,
                      title: "write it here",
                      keyboardType: TextInputType.number,
                      validator: (value) => Validator.valueExists(value),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
