
import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        spacing: Sizes.s20,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         QuestionText(questionText: "What is your name?",),
          PoppinsText(
            text: "Full name",
            fontSize: Sizes.s16,
            fontWeight: TextWeight.semiBold,
          ),

          Row(
            spacing: Sizes.s20,
            children: [
              Expanded(child: CustomTextField(title: "First Name")),
              Expanded(child: CustomTextField(title: "Surname")),
            ],
          ),
        ],
      ),
    );
  }
}
