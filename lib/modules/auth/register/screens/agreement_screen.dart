import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/widgets/agreement_check.dart';
import 'package:musculo_app/modules/auth/register/widgets/question_text.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        // spacing: Sizes.s1_5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionText(
            questionText:
                "By checking the box, you agree to our terms and conditions.",
          ),
          SizedBox(height: Sizes.s20),
          AgreementCheck(onChanged: (value) {}, isChecked: true),
          AgreementCheck(onChanged: (value) {}),
          AgreementCheck(onChanged: (value) {}),
          AgreementCheck(onChanged: (value) {}),
        ],
      ),
    );
  }
}
