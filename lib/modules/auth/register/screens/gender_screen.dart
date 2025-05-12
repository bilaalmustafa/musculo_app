

import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/modules/auth/register/component/gender_selection_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<GenderScreen> {
  bool _isMale = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        spacing: Sizes.s40,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          QuestionText(questionText: "What is your gender?",),
          GenderSelectionButton(
            onTap: () {
              setState(() {
                _isMale = true;
              });
            },
            gendercolor: _isMale ? ConstColors.black : ConstColors.secondary,
            gendertitle: "Male",
            gendericon: Icons.male,
          ),
          GenderSelectionButton(
            onTap: () {
              setState(() {
                _isMale = false;
              });
            },
            gendercolor: _isMale ? ConstColors.secondary : ConstColors.black,
            gendertitle: "Female",
            gendericon: Icons.female,
          ),
        ],
      ),
    );
  }
}


