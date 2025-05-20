import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/assets.dart';

import 'package:musculo_app/modules/auth/register/component/gender_selection_button.dart';

import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

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
      padding: const EdgeInsets.all(Sizes.s24),
      child: Column(
        spacing: Sizes.s40,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          QuestionText(questionText: "What is your gender?"),
          GenderSelectionButton(
            onTap: () {
              setState(() {
                _isMale = true;
              });
            },
            gendercolor: _isMale ? ConstColors.black : ConstColors.greyE0E0,
            gendertitle: "Male",
            // gendericon: Icons.male,
            gendericonimage: Assets.male,
          ),
          GenderSelectionButton(
            onTap: () {
              setState(() {
                _isMale = false;
              });
            },
            gendercolor: _isMale ? ConstColors.greyE0E0 : ConstColors.black,
            gendertitle: "Female",
            // gendericon: Icons.female,
            gendericonimage: Assets.female,
          ),
        ],
      ),
    );
  }
}
