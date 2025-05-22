import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class DurationOfProgram extends StatefulWidget {
  const DurationOfProgram({super.key});

  @override
  State<DurationOfProgram> createState() => _DurationOfProgramState();
}

class _DurationOfProgramState extends State<DurationOfProgram> {
  double sliderValue = 1;
  String valueoption = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                  min: 1,
                  max: 10,
                  activeColor: ConstColors.black,
                  inactiveColor: ConstColors.secondary,
                  value: sliderValue,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),
                PoppinsText(
                  text: "${sliderValue.round().toString()} days",
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
            CustomTextField(title: "write it here"),
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Monthly program",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Monthly program",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
