import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

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
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
            ),
            SizedBox(height: Sizes.s10),
            PoppinsText(
              text: "program Name",
              fontSize: Sizes.s14,
              fontWeight: TextWeight.semiBold,
            ),
            CustomTextField(title: "write it here"),
          ],
        ),
      ),
    );
  }
}
