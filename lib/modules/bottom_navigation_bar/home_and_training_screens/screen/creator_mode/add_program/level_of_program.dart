import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class LevelOfProgram extends StatefulWidget {
  const LevelOfProgram({super.key});

  @override
  State<LevelOfProgram> createState() => _LevelOfProgramState();
}

class _LevelOfProgramState extends State<LevelOfProgram> {
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
              text: "Select level of your program",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
            SizedBox(height: Sizes.s15),
            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Beginner",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Beginner",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
            Divider(color: ConstColors.dividerColor),
            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Experienced",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Experienced",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
            Divider(color: ConstColors.dividerColor),

            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Advanced",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Advanced",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
            Divider(color: ConstColors.dividerColor),
          ],
        ),
      ),
    );
  }
}
