import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class TypeOfProgram extends StatefulWidget {
  const TypeOfProgram({super.key});

  @override
  State<TypeOfProgram> createState() => _TypeOfProgramState();
}

class _TypeOfProgramState extends State<TypeOfProgram> {
  String valueoption = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: Sizes.s20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: "Select type of your program",
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
            ),
            Divider(color: ConstColors.dividerColor),
            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "With equipment",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "With equipment",
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
                text: "Without equipment",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Without equipment",
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
                text: "Stretching",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Stretching",
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
